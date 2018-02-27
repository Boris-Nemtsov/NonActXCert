package Java;
import java.io.File;
import java.io.FileOutputStream;

public class DelCert {
	//공인인증서를 서버에서 삭제합니다.
	
	String SUBJECT_DN;
	String OUTPUT_FILENAME;
	String PATH;
	
	public DelCert(String CN, String Birth, String PW) throws Exception {
		PATH = Settings.getPath();
		SUBJECT_DN = Settings.getSubjectDN(CN, Birth);
		OUTPUT_FILENAME = Settings.getOutputFileName();
		
		DeleteFile(CN, Birth, PW);
	}
	
	private void DeleteFile(String CN, String Birth, String PW) throws Exception {
		if(new VerCert(CN, Birth).CheckPassword(PW) == false) {
			System.out.println("FAIL");
			return;
		}
		
		new File(PATH + SUBJECT_DN).delete();
		new File(PATH + SUBJECT_DN + "/" + OUTPUT_FILENAME + ".der").delete();
		new File(PATH + SUBJECT_DN + "/" + OUTPUT_FILENAME + ".key").delete();
	}
}
