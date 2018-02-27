<%@page import="java.util.Date"%>
<%@page import="Java.SendOTP"%>
<%@page import="Java.dbcontroller"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>

{
	"Result":"<%
	String userName = request.getParameter("userName");
	String userBirth = request.getParameter("userBirth");
	userBirth = userBirth.substring(0,4) + "-" + userBirth.substring(4,6) + "-" + userBirth.substring(6,8);
	String[][] oResult = new dbcontroller().sqlQuery("SELECT no, phone FROM member WHERE name='" + userName + "' AND birth='" + userBirth + "'");
	String no = oResult[0][0];
	String phone = oResult[0][1];
	
	if(oResult[0][0] == null) {
		out.print("등록된 정보가 없습니다.");
	} else {
		oResult = new dbcontroller().sqlQuery("SELECT * FROM warden WHERE Arg1='" + no + "'");
		if(oResult.length != 0) {
			out.print("60초 후 발급할 수 있습니다.");
		} else {
			new dbcontroller().sqlQuery("INSERT INTO warden VALUES (NULL, '1', '" + no + "', '" + new Date().getTime() + "')");
			new dbcontroller().sqlQuery("UPDATE member SET lastOTP='" + new Date().getTime() + "' WHERE name='" + userName + "' AND birth='" + userBirth + "'");
			new SendOTP(userName, userBirth, phone);
			out.print("OTP를 등록된 번호로 발송하였습니다.");
		}
	}
%>"
}