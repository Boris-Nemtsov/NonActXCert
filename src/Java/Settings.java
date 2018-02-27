package Java;

import java.sql.Connection;
import java.sql.DriverManager;
import java.text.SimpleDateFormat;
import java.util.Date;

public class Settings {
	//기본 설정 값을 반환합니다.
	
	public static Connection getDBConnection() throws Exception {
		String dbHost = "localhost";
		String dbDataBase = "test";
		String dbID = "root";
		String dbPW = "autoset";
		
		Class.forName("com.mysql.jdbc.Driver").newInstance();
		return DriverManager.getConnection(
				"jdbc:mysql://" + dbHost + "/" + dbDataBase, dbID, dbPW);
	}
	
	public static String getSubjectDN(String CN, String Birth) {
		Birth = Birth.replaceAll("-", "");
		
		byte[] serial = SHA1Utils.getHash((CN + "_" + Birth).getBytes());
		return "CN=" + CN + ByteUtils.toHexString(serial) + ", OU=HNB, OU=personal4IB, O=H3X4C0D3, C=kr";
	}
	
	public static String getOutputFileName() {
		return "signPri";
	}
	
	public static String getIssuerDN() {
		return "CN=H3X4C0D3 Team, OU=AccreditedCA, O=H3X4C0D3, C=kr";
	}
	
	public static String getPath() {
		return "C:/H3X4C0D3/";
	}
	
	public static int getOTPLength() {
		return 6;
	}
	
	public static String getDefaultPW(String CN, String Birth) {
		String[] args = {CN, Birth.replaceAll("-", "")};
		return CreateToken.getHash(args);
	}
	
	public static String getToken(String CN, String Birth) {
		String[] args = {CN, Birth.replaceAll("-", ""), "verified"};
		return CreateToken.getHash(args);
	}
	
	public static String getDToken(String CN, String Birth, int flag) {
		String Period; 
		if(flag == 1) {
			Period = String.valueOf((new Date().getMinutes() / 10) - 1);
		} else {
			Period = String.valueOf(new Date().getMinutes() / 10);
		}
		
		String[] args = {CN, Birth.replaceAll("-", ""), new SimpleDateFormat("yyyy-MM-dd").format(new Date()), 
				String.valueOf(new Date().getHours()), Period, "verified"};
		return CreateToken.getHash(args);
	}
}
