package Java;


import java.sql.*;
import java.util.ArrayList;

public class dbcontroller {
	//db 쿼리를 처리합니다. 
	
	Connection dbcon = null;
	Statement dbstmt = null;
	
	public dbcontroller() {
		try {
			Class.forName("com.mysql.jdbc.Driver").newInstance();
			dbcon = Settings.getDBConnection();
			dbstmt = dbcon.createStatement();
		} catch (Exception e) {
			System.out.println(e.getMessage());
			e.printStackTrace();
			System.exit(-1);
		}
	}
	
	public String[][] sqlQuery(String sQuery) {
		System.out.println("a : " + sQuery);
		String[][] sResult = null;
		ArrayList<String[]> aResult = new ArrayList<String[]>();
		try {
			if(sQuery.indexOf("INSERT INTO") != -1 || sQuery.indexOf("UPDATE") != -1 ||
					sQuery.indexOf("DELETE") != -1) {
				dbstmt.executeUpdate(sQuery);
				return null;
			}
			ResultSet oResultSet = dbstmt.executeQuery(sQuery);
			System.out.println(sQuery);
			int iCountColumns = oResultSet.getMetaData().getColumnCount();
			while(oResultSet.next()) {
				String[] m_Data = new String[iCountColumns];
				
				for(int i = 1; i <= iCountColumns; i++) {
					System.out.println("sResult[" + (oResultSet.getRow() - 1) + "][" + (i - 1) + "] = " + oResultSet.getString(i) + " 대입");
					m_Data[i - 1] = oResultSet.getString(i);
				}
				aResult.add(m_Data);
			}
			System.out.println("sResult 대입완료");
			
			sResult = aResult.toArray(new String[0][0]);
			dbcon.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
			return sResult;
	}
}
