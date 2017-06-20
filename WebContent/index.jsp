<%@page import="org.cert.CertLoad"%>
<%@page import="java.security.cert.*"%>
<%@ page import="java.util.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		//List<X509Certificate> list = CertTesting.loadCertificateLocal();
	
	CertLoad cl = new CertLoad(request, "local");
	
	out.println(cl.getPrincipalValues("CN").get(1));
		//out.println(clsCert.loadCertificateLocal().get(0).getIssuerDN().getName());
		//out.println(
		//		CertTesting.getPrincipalMap(
		//				list.get(0).getIssuerX500Principal().getName()).get("CN"));
	%>
</body>
</html>
