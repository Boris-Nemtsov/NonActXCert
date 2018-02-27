<%@page import="java.util.Date"%>
<%@page import="Java.dbcontroller"%>
<%@page import="Java.Settings"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
{
	"Result":"<%
		String DToken = request.getParameter("DToken");
		String userName = request.getParameter("userName");
		String userBirth = request.getParameter("userBirth");
		userBirth = userBirth.substring(0,4) + "-" + userBirth.substring(4,6) + "-" + userBirth.substring(6,8);
		
		String[][] result = new dbcontroller().sqlQuery("SELECT no FROM member WHERE name='" + userName + "' AND birth='" + userBirth + "'");
		String no = result[0][0];
		
		if(Settings.getDToken(userName, userBirth, 0).equals(DToken)) {
			new dbcontroller().sqlQuery("UPDATE member SET lastDToken=" + new Date().getTime() + ", DToken='" + DToken + "'"
					+ " WHERE name='" + userName + "' AND birth='" + userBirth + "'");
			
			new dbcontroller().sqlQuery("INSERT INTO warden VALUES (NULL, '2', '" + no + "', '" + new Date().getTime() + "')");
			out.print("OK");
		} else 
			out.print("FAIL");
	%>"
}