package Java;

import java.io.File;
import java.io.FileOutputStream;

import javax.servlet.http.HttpServletRequest;

public class UploadCert {
	//사용자가 업로드한 공인인증서 파일을 분석합니다.
	
	String SUBJECT_DN;
	String OUTPUT_FILENAME;
	String PATH;
	String PW;
	String CN;
	String Birth;
	
	public UploadCert(String CN, String Birth, String Pass) {
		this.CN = CN;
		this.Birth = Birth;
		PATH = Settings.getPath();
		SUBJECT_DN = Settings.getSubjectDN(CN, Birth);
		OUTPUT_FILENAME = Settings.getOutputFileName();
		PW = Pass;
	}
	
	public int UploadFile(File fileDer, File fileKey) throws Exception {
		if(new VerCertFromFile().CheckPassword(PW, fileKey) == false) {
			return -3;
		}
		
		if(new File(PATH + SUBJECT_DN).exists() == false) {
			new File(PATH + SUBJECT_DN).mkdir();
		} else if(new File(PATH + SUBJECT_DN).listFiles().length != 0){
			fileDer.delete();
			fileKey.delete();
			return -1;
		}
		
		if(fileDer.getName().indexOf(".der") != -1) {
			fileDer.renameTo(new File(PATH + SUBJECT_DN + "/" + OUTPUT_FILENAME + ".der"));
		} else {
			fileDer.delete();
			return -2;
		}
		if(fileKey.getName().indexOf(".key") != -1) {
			fileKey.renameTo(new File(PATH + SUBJECT_DN + "/" + OUTPUT_FILENAME + ".key"));
		} else {
			fileKey.delete();
			return -2;
		}
		
		new ModCert(CN, Birth, PW, Settings.getDefaultPW(CN, Birth));
		return 1;
	}
}
