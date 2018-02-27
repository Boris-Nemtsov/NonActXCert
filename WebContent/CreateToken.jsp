<%@page import="Java.CreateToken"%>
<%@page import="Java.ByteUtils"%>
<%@page import="Java.SHA1Utils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
    //사용자 Token을 생성합니다.
	System.out.println("token : " + request.getParameter("a"));
	
	String[] args = {request.getParameter("a"), request.getParameter("b"), request.getParameter("c")
			,request.getParameter("d"), request.getParameter("e")};
%>

{
	"Token":"<%=CreateToken.getHash(args) %>"
}