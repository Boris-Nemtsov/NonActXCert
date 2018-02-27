package Java;

import java.util.Date;

public class WardenFunction implements Runnable {
	//워든 실제 기능을 설정합니다.
	
	@Override
	public void run() {
		while(true) {
			try {
				/* 워든의 기능(24시간 동작)
				 * case 1 : OTP가 만료되면 기존 공인인증서 기본 비밀번호로 복구합니다.
				 * case 2 : DToken 을 확인하여 5분간 동작이 없는 사용자의 토큰을 만료시킵니다.
				*/ 
				
				System.out.println("워든 동작");
				String[][] oResult = new dbcontroller().sqlQuery("SELECT * FROM warden");
				
				if(oResult.length != 0) {
					String wardenNo = oResult[0][0];
					String type = oResult[0][1];
					switch(type) {
					case "1":
						String no = oResult[0][2];
						long lastOTP = Long.parseLong(oResult[0][3]);
						
						oResult = new dbcontroller().sqlQuery("SELECT name, birth FROM member WHERE no='" + no + "'");
						String CN = oResult[0][0];
						String Birth = oResult[0][1];
						
						if((new Date().getTime() - lastOTP) >= 60000) {
							new ModCert(CN, Birth, "HiWarden", Settings.getDefaultPW(CN, Birth));
							System.out.println(" 워든 작업 처리 완료 ");
							new dbcontroller().sqlQuery("DELETE FROM warden WHERE no='" + wardenNo + "'");
						}
						break;
					case "2":
						String userNo = oResult[0][2];
						long lastDToken = Long.parseLong(oResult[0][3]);
						
						if((new Date().getTime() - lastDToken) >= 300000) {
							oResult = new dbcontroller().sqlQuery("UPDATE member SET DToken='' AND lastDToken=0 WHERE no='" + userNo + "'");
							System.out.println(" 워든 작업 처리 완료 ");
							new dbcontroller().sqlQuery("DELETE FROM warden WHERE no='" + wardenNo + "'");
						}
						break;
					}
				}
				
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				try {
					Thread.sleep(10000);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
	}
}
