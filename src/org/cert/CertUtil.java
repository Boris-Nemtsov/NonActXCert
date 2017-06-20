package org.cert;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.nio.file.Files;
import java.security.Key;
import java.security.KeyFactory;
import java.security.MessageDigest;
import java.security.PrivateKey;
import java.security.Signature;
import java.security.cert.CertPath;
import java.security.cert.CertPathValidator;
import java.security.cert.CertificateFactory;
import java.security.cert.PKIXCertPathValidatorResult;
import java.security.cert.PKIXParameters;
import java.security.cert.TrustAnchor;
import java.security.cert.X509CRL;
import java.security.cert.X509Certificate;
import java.security.interfaces.RSAPrivateCrtKey;
import java.security.spec.PKCS8EncodedKeySpec;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Properties;

import javax.crypto.Cipher;
import javax.crypto.EncryptedPrivateKeyInfo;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;

import org.bouncycastle.jce.provider.BouncyCastleProvider;

public class CertUtil {
	public static X509Certificate mkCertificate(File certFile) throws Exception {
		CertificateFactory certificateFactory = CertificateFactory.getInstance("X.509");
		return (X509Certificate) certificateFactory.generateCertificate(
				new BufferedInputStream(new FileInputStream(certFile)));
	}
	
	public static HashMap<String, String> getPrincipalMap(String principal) {
		HashMap<String, String> resultMap = new HashMap<String, String>();
		for(String splitedStr : principal.split(",")) {
			resultMap.put(splitedStr.split("=")[0], splitedStr.split("=")[1]);
		}
		return resultMap;
	}
	
	public static int toInt(byte[] source) {
		int returnValue = 0;
		for (int i = 0; i < 4; i++) {
			returnValue = (returnValue << 8) + (source[i] & 0xFF);
		}
		return returnValue;
	}
	
	public static byte[] getHash(byte[] source) throws Exception { 
			MessageDigest md = MessageDigest.getInstance("SHA1"); 
			return md.digest(source); 
	}
	
	public static byte[] getBytes(byte[] source, int offset, int length, int ... dstOffset) {
		if(dstOffset.length == 0) 
			dstOffset = new int[1];
		
		byte[] returnByte = new byte[length + dstOffset[0]];
		System.arraycopy(source, offset, returnByte, dstOffset[0], length);
		return returnByte;
	}
	
	public static byte[] doSign(PrivateKey privateKey, byte[] plainData) throws Exception {
		Signature signature = Signature.getInstance("SHA256withRSA");
		signature.initSign(privateKey);
		signature.update(plainData);
		return signature.sign();
	}
	
	public static boolean doVerify2(X509Certificate publicKey, byte[] signatureData, byte[] plainData) throws Exception {
		Signature signature = Signature.getInstance("SHA256withRSA");
		signature.initVerify(publicKey);
		signature.update(plainData);
		return signature.verify(signatureData);
	}
	
	public static boolean doVerify(File mDerFile) throws Exception {
		CertificateFactory certificateFactory = CertificateFactory.getInstance("X.509");
		Properties CA_CERT_PATH = new Properties();
		CA_CERT_PATH.load(new FileInputStream("PROPERTIES/CA_CERT_PATH.properties"));
		
		X509Certificate cert = mkCertificate(mDerFile);
		String IssuerName = getPrincipalMap(cert.getIssuerDN().getName()).get("CN").replace(" ", "");
		X509Certificate Issuer = mkCertificate(new File(CA_CERT_PATH.getProperty(IssuerName)));
		X509Certificate kisa4 = mkCertificate(new File(CA_CERT_PATH.getProperty("kisa4")));
		
		//유효기간 검증
		cert.checkValidity();
		
		//CA기관 검증(최상위기관[KISA], 발급기관)
		List<X509Certificate> certificates = new ArrayList<X509Certificate>();
		certificates.add(cert);
		certificates.add(Issuer);
		CertPath certPath = certificateFactory.generateCertPath(certificates);
		TrustAnchor anchor = new TrustAnchor(kisa4, null);
		PKIXParameters params = new PKIXParameters(Collections.singleton(anchor));
		
		params.setRevocationEnabled(false);
		CertPathValidator cpv = CertPathValidator.getInstance("PKIX", "BC");
		PKIXCertPathValidatorResult result;
		
		//CRL 검증
		X509CRL xrl = (X509CRL) CertificateFactory.getInstance("X.509").generateCRL(
				new FileInputStream("CRL/dp5p7398.bin"));

		try {
			if(xrl.isRevoked(cert))
				throw new Exception();
			
			result = (PKIXCertPathValidatorResult) cpv.validate(certPath, params);
			System.out.println("유효");
			return true;
		} catch (Exception e) {
			System.out.println("오류");
			e.printStackTrace();
		} finally {
			return false;
		}
	}
	
	public static RSAPrivateCrtKey getPrivateKey(File mKeyFile, String mPasswordStr) throws Exception {
		byte[] keyFile = Files.readAllBytes(mKeyFile.toPath());
		byte[] mDk, mPassword, mSalt;
		int mIterationCount;
		EncryptedPrivateKeyInfo encryptedPrivateKeyInfo = 
				new EncryptedPrivateKeyInfo(keyFile);

		//Password, Salt, IterationCount, 추출키(DK) 생성
		mSalt = getBytes(keyFile, 20, 8);
		mPassword = mPasswordStr.getBytes();
		mIterationCount = toInt(getBytes(keyFile, 30, 2, 2));
		mDk = calcDK(mPassword, mSalt, mIterationCount);
		
		//비밀키(keySecret), 초기벡터(mIv)  생성
		Key keySecret = new SecretKeySpec(getBytes(mDk, 0, 16), "SEED");
		byte[] mIv =  getBytes(getHash(getBytes(mDk, 16, 4)), 0, 16);
		
		//개인키 복호화
		BouncyCastleProvider provider = new BouncyCastleProvider();
		Cipher cipher = Cipher.getInstance("SEED/CBC/PKCS5Padding", provider);
		
		cipher.init(cipher.DECRYPT_MODE, keySecret, new IvParameterSpec(mIv));
		byte[] output = cipher.doFinal(encryptedPrivateKeyInfo.getEncryptedData());
		
		PKCS8EncodedKeySpec keySpec = new PKCS8EncodedKeySpec(output);
		KeyFactory keyFactory = KeyFactory.getInstance("RSA");;
		
		return (RSAPrivateCrtKey) keyFactory.generatePrivate(keySpec);
	}

	private static byte[] calcDK(byte[] mPassword, byte[] mSalt, int mIterationCount) throws Exception {
		MessageDigest msg = MessageDigest.getInstance("SHA1");
		byte[] returnKey = new byte[20];
		msg.update(mPassword);
		msg.update(mSalt);
		returnKey = msg.digest();
		
		for(int i = 1; i < mIterationCount; i++) {
			returnKey = msg.digest(returnKey);
		}
		
		return returnKey;
	}
}
