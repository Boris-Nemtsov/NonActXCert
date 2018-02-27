<%@page import="java.util.Date"%>
<%@page import="Java.dbcontroller"%>
<%@page import="Java.Settings"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String q = request.getQueryString();
	String DToken = q.substring(q.indexOf("t=") + 2);

	String[][] result = new dbcontroller().sqlQuery("SELECT no, name, birth FROM member WHERE DToken='" + DToken + "'");
	String userName = "";
	String userBirth = "";
	String no = "";
	
	
	if(result.length != 0) {
		no = result[0][0];
		userName = result[0][1];
		userBirth = result[0][2];
		
		DToken = Settings.getDToken(userName, userBirth, 0);
		new dbcontroller().sqlQuery("UPDATE member SET lastDToken='" + new Date().getTime() + "', DToken='" + DToken + "'"
				+ " WHERE name='" + userName + "' AND birth='" + userBirth + "'");
		new dbcontroller().sqlQuery("UPDATE warden SET Arg2='" + new Date().getTime() + "' WHERE Arg1='" + no + "' AND Type='2'");
		
	} else {
		out.print("<script>alert('5분 간 반응이 없어 종료합니다.');location.href='LoginForm.jsp';</script>");
		out.close();
	}
%>