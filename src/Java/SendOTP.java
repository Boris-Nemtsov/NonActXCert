package Java;

import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLConnection;
import java.util.Date;

public class SendOTP {
	//OTP를 생성하고 사용자에게 전송합니다.
	
	public SendOTP(String CN, String Birth, String Phone) throws Exception {
		Birth = Birth.replaceAll("-", "");
		System.out.println(CN + " " + Birth);
		String[] args = {CN, Birth};
		String OTP = genOTP(CN, Birth).substring(0, Settings.getOTPLength());
		
		System.out.println("토큰 : " + CreateToken.getHash(args));
		new ModCert(CN, Birth, Settings.getDefaultPW(CN, Birth), OTP);
		
		sendSMS(OTP, Phone);
	}
	
	private String genOTP(String CN, String Birth) {
		String[] args = {CN, Birth, new Date().toGMTString()};
		
		return CreateToken.getHash(args);
	}
	
	private void sendSMS(String OTP, String Phone) throws Exception {
		URL url = new URL("http://sms.bpscal.com/sendSMS_Final.php?dst=" + Phone + "&con=" + OTP);
		HttpURLConnection urlCon = (HttpURLConnection) url.openConnection();
		urlCon.setRequestMethod("GET");
		urlCon.getInputStream();
	}
}
