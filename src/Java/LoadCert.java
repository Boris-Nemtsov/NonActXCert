package Java;
import java.io.IOException;
import java.security.cert.X509Certificate;
import java.text.SimpleDateFormat;

import sun.security.x509.X509CertImpl;

import java.io.ByteArrayOutputStream;
import java.io.FileInputStream;

public class LoadCert {
	//서버에 저장된 공인인증서 정보를 반환합니다.
	
	String SUBJECT_DN;
	String OUTPUT_FILENAME;
	String PATH;
	
	public LoadCert(String CN, String Birth) {
		SUBJECT_DN = Settings.getSubjectDN(CN, Birth);
		OUTPUT_FILENAME = Settings.getOutputFileName();
		PATH = Settings.getPath();
	}
	
	public String[] LoadCertInfo() throws Exception {
		FileInputStream is = new FileInputStream(PATH + SUBJECT_DN + "/" + OUTPUT_FILENAME + ".der");
		ByteArrayOutputStream baos = new ByteArrayOutputStream();
		
		int data = -1;
		while((data = is.read()) != -1) {
			baos.write(data);
		}
		is.close();
		
		X509CertImpl cert = new X509CertImpl(baos.toByteArray());
		try {
			cert.checkValidity();
		} catch (Exception ex) {
			return null;
		}
		String[] oReturn = {cert.getSubjectDN().getName(), new SimpleDateFormat("yyyy-MM-dd").format(cert.getNotAfter())
				, cert.getIssuerDN().getName()};
		return oReturn;
	}
}
