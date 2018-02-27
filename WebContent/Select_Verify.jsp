<%@page import="Java.Settings"%>
<%@page import="Java.DelCert"%>
<%@page import="Java.CreateToken"%>
<%@page import="Java.VerCert"%>
<%@page import="java.util.Date"%>
<%@page import="Java.dbcontroller"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
{
	"Result":"<%
	String userName = request.getParameter("userName");
	String userBirth = request.getParameter("userBirth");
	String userPass = request.getParameter("userPass");
	String isRemove = request.getParameter("isRemove");
	
	userBirth = userBirth.substring(0,4) + "-" + userBirth.substring(4,6) + "-" + userBirth.substring(6,8);
	String query = "SELECT lastOTP FROM member WHERE name='" + userName + "' AND birth='" + userBirth + "'";
	String lastOTP = new dbcontroller().sqlQuery(query)[0][0];
	
	if((new Date().getTime() - Long.parseLong(lastOTP)) >= 60000) {
		out.print("OTP 값이 만료됐습니다.");
	} else {
		System.out.println("userPass : " + userPass);
		if(new VerCert(userName, userBirth).CheckPassword(userPass)) {
			out.print("인증 되었습니다.\",");
			out.print("\n	\"Token\":\"");
			if(isRemove.equals("true")) {
				new DelCert(userName, userBirth, userPass);
				out.print("refresh");
			}
			
			query = "SELECT lastOTP FROM member WHERE name='" + userName + "' AND birth='" + userBirth + "' AND Token='" 
				+ Settings.getToken(userName, userBirth) + "'";
			if(new dbcontroller().sqlQuery(query).length == 1) {
				out.print(Settings.getDToken(userName, userBirth, 0));
			} else {
				out.print("fail");
			}
		} else {
			out.print("OTP 값을 다시 확인해주세요.");
		}
	} 
%>"
}