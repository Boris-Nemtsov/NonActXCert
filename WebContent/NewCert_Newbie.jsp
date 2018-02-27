<%@page import="Java.NewbieCert"%>
<%@page import="Java.Settings"%>
<%@page import="java.net.URLDecoder"%>
<%@page import="Java.NewCert"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>

{
	"Result":"<%
	String userName = URLDecoder.decode(request.getParameter("userName"));
	String userBirth = request.getParameter("userBirth");
	
	int rtrnCode = new NewbieCert(userName, userBirth).NewCert();
	
	if(rtrnCode == -1) {
		out.print("기존 공인인증서를 폐기해주세요.");
	} else {
		out.print("업로드 성공\",");
		out.print("\n	\"Token\":\"" + Settings.getToken(userName, userBirth));
	}
%>"
}