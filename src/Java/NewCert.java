package Java;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.math.BigInteger;
import java.security.Key;
import java.security.KeyPair;
import java.security.KeyPairGenerator;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.security.cert.X509Certificate;
import java.util.Date;

import javax.crypto.Cipher;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;

import org.bouncycastle.jce.provider.BouncyCastleProvider;

import sun.security.x509.AlgorithmId;
import sun.security.x509.CertificateAlgorithmId;
import sun.security.x509.CertificateSerialNumber;
import sun.security.x509.CertificateValidity;
import sun.security.x509.CertificateVersion;
import sun.security.x509.CertificateX509Key;
import sun.security.x509.X500Name;
import sun.security.x509.X509CertImpl;
import sun.security.x509.X509CertInfo;

public class NewCert {
	String ISSUER_DN;
	String SUBJECT_DN;
	String OUTPUT_FILENAME;
	String PATH;
	
	KeyPair oKeyPair = null;
	X509Certificate oCert = null;
	byte[] oEncryptedKey = null;

	//CN(Common Name), WantPassword required
	public NewCert(String CN, String Birth, String PW, int isCert) throws Exception {
		SUBJECT_DN = Settings.getSubjectDN(CN, Birth);
		OUTPUT_FILENAME = Settings.getOutputFileName();
		ISSUER_DN = Settings.getIssuerDN();
		PATH = Settings.getPath();

		if (PW == null) {
			PW = Settings.getDefaultPW(CN, Birth);
		}
		oKeyPair = GenKeyPair(); 
		if(isCert == 1) 
			oCert = GenCert();
		
		oEncryptedKey = SetKey(PW);
		OutputFile();
	}
	
	//Make keyPair
	private KeyPair GenKeyPair() throws Exception {
		KeyPairGenerator keyPairGen = KeyPairGenerator.getInstance("RSA");
		keyPairGen.initialize(2048);

		oKeyPair = keyPairGen.generateKeyPair();
		
		return oKeyPair;
	}
	
	//Make *.der
	private X509Certificate GenCert() throws Exception {
		X509CertInfo oCertInfo = new X509CertInfo();
		
		BigInteger RndSerial = new BigInteger(64, new SecureRandom());
		CertificateValidity interval = 
				new CertificateValidity(new Date(),	
						new Date(new Date().getTime() + 365 * 86400000l));
		
		oCertInfo.set(X509CertInfo.VALIDITY, interval);
		oCertInfo.set(X509CertInfo.SERIAL_NUMBER, new CertificateSerialNumber(RndSerial));
		oCertInfo.set(X509CertInfo.SUBJECT, new X500Name(SUBJECT_DN));
		oCertInfo.set(X509CertInfo.ISSUER, new X500Name(ISSUER_DN));
		oCertInfo.set(X509CertInfo.KEY, new CertificateX509Key(oKeyPair.getPublic()));
		oCertInfo.set(X509CertInfo.VERSION, new CertificateVersion(CertificateVersion.V3));
		oCertInfo.set(X509CertInfo.ALGORITHM_ID, 
				new CertificateAlgorithmId(new AlgorithmId(AlgorithmId.sha256WithRSAEncryption_oid)));
		
		X509CertImpl oCert = new X509CertImpl(oCertInfo);
		oCert.sign(oKeyPair.getPrivate(), "SHA256withRSA");
		
		return oCert; 
	}
	
	//New KeyGenerate
	private byte[] SetKey(String PW) throws Exception {
		/* ASN.1(Der) 헤더구조
		 * 0~35 : Header (20~27 : Customized Salt, 30~31 : pbkdf1 Iteration)
		 * 36 ~ : Encoded Private Key(RSA encoded SEED CBC Mode)
		 * SEED Ref. : https://www.rootca.or.kr/kcac/down/TechSpec/2.3-KCAC.TS.ENC.pdf
		 */
		
		//yessign Common Header, RSA keypair
		byte[] header = {(byte) 0x30,(byte) 0x82,(byte) 0x05,(byte) 0x10,(byte) 0x30,(byte) 0x1a,(byte) 0x06,(byte) 0x08,(byte) 0x2a,(byte) 0x83,(byte) 0x1a,(byte) 0x8c,(byte) 0x9a,(byte) 0x44,(byte) 0x01,(byte) 0x0f,(byte) 0x30,(byte) 0x0e,(byte) 0x04,(byte) 0x08,(byte) 0x8d,(byte) 0x53,(byte) 0xa2,(byte) 0xa1,(byte) 0x54,(byte) 0x73,(byte) 0x5c,(byte) 0xf5,(byte) 0x02,(byte) 0x02,(byte) 0x08,(byte) 0x00,(byte) 0x04,(byte) 0x82,(byte) 0x04,(byte) 0xf0};
		byte[] keyData = oKeyPair.getPrivate().getEncoded();
		
		//Set salt, Iteration into the header
		byte[] salt = new byte[8];
		System.arraycopy(header, 20, salt, 0, 8);
		byte[] bIteration = new byte[4];
		System.arraycopy(header, 30, bIteration, 2, 2);
		int iIteration = ByteUtils.toInt(bIteration);
		
		//pbkdf1 Generate(0~15 : Key for Encoding, SHA1(16~19) : pre-Initial Vector)
		byte[] dk = pbkdf1(PW, salt, iIteration); 
		byte[] keyData1 = new byte[16]; 
		System.arraycopy(dk, 0, keyData1, 0, 16);
		byte[] div = new byte[20]; 
		byte[] tmp4Bytes = new byte[4]; 
		System.arraycopy(dk, 16, tmp4Bytes, 0, 4); 
		div = SHA1Utils.getHash(tmp4Bytes); 
		
		//Initial Vector(0~15 Of pre-Initial Vector)
		byte[] iv = new byte[16]; 
		System.arraycopy(div, 0, iv, 0, 16); 
		
		//Set SEED Padding into a Generated Private Key using Cipher and BouncyCastle Library
		Cipher cp = Cipher.getInstance("SEED/CBC/PKCS5Padding", new BouncyCastleProvider());
		Key key = new SecretKeySpec(keyData1, "SEED");
		
		//Encrypt Private Key
		cp.init(Cipher.ENCRYPT_MODE, key, new IvParameterSpec(iv));
		keyData = cp.update(keyData);
		
		//Concat Header and Encoded Private Key
		ByteArrayOutputStream baos = new ByteArrayOutputStream();
		baos.write(header);
		baos.write(keyData);
		return baos.toByteArray();
	}
	
	private static byte[] pbkdf1(String password, byte[] salt, int iterationCount) throws NoSuchAlgorithmException { 
		byte[] dk = new byte[20]; 
		MessageDigest md = MessageDigest.getInstance("SHA1"); 
		md.update(password.getBytes()); 
		md.update(salt); 
		dk = md.digest(); 
		for (int i = 1; i < iterationCount; i++) { 
			dk = md.digest(dk); 
		} 
		return dk; 
	}
	
	//Output Files
	private void OutputFile() throws Exception {
		if(new File(PATH + SUBJECT_DN + "/").exists() == false) {
			new File(PATH + SUBJECT_DN + "/").mkdirs();
		}
		
		FileOutputStream KeyFileIO = new FileOutputStream(new File(PATH + SUBJECT_DN + "/" + OUTPUT_FILENAME + ".key"));
		
		KeyFileIO.write(oEncryptedKey);
		KeyFileIO.close();
		if(oCert != null) {
			FileOutputStream CertFileIO = new FileOutputStream(new File(PATH + SUBJECT_DN + "/" + OUTPUT_FILENAME + ".der"));
			CertFileIO.write(oCert.getEncoded());
			CertFileIO.close();
		}
	}
}
