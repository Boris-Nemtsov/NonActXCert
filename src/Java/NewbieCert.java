package Java;

import java.io.File;

public class NewbieCert {
	//사용자의 새로운 공인인증서를 생성합니다. 
	
	String ISSUER_DN;
	String SUBJECT_DN;
	String OUTPUT_FILENAME;
	String PATH;
	String CN;
	String Birth;
	
	public NewbieCert(String CN, String Birth) {
		this.CN = CN;
		this.Birth = Birth;
		SUBJECT_DN = Settings.getSubjectDN(CN, Birth);
		OUTPUT_FILENAME = Settings.getOutputFileName();
		ISSUER_DN = Settings.getIssuerDN();
		PATH = Settings.getPath();
	}
	
	public int NewCert() throws Exception {
		if(new File(PATH + SUBJECT_DN).exists()) {
			return -1;
		}
		System.out.println("1123123123 : " + Settings.getSubjectDN(CN, Birth));
		new NewCert(CN, Birth, null, 1);
		return 1;
	}
}
