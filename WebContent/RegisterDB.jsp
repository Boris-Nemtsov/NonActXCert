<%@page import="Java.Settings"%>
<%@page import="Java.dbcontroller"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>

<%
	String userName = request.getParameter("userName");
	String userBirth = request.getParameter("userBirth");
	String userPhone = request.getParameter("userPhone");
	String isReg = request.getParameter("isReg");
	String token = Settings.getToken(userName, userBirth);
	String q = null;
	if(isReg.equals("0")) {
		q = "SELECT * FROM member WHERE (name='" + userName + "' AND birth='" + userBirth + "') OR phone='" + userPhone + "'";
	} else if(isReg.equals("1")) {
		q = "INSERT INTO member VALUES (NULL, '" + userName + "', '" + userBirth + "', '" + userPhone + "', '0', '" + token + "', '0', '');";
	}
%>
<jsp:include page="dbControllerJSON.jsp" flush="true">
	<jsp:param name="q" value="<%=q%>" />
</jsp:include>