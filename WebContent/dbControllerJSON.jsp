<%@ page import="Java.dbcontroller" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	//JSON 형태로 쿼리결과를 반환합니다.
	System.out.println("json : " + request.getParameter("q"));
	String result[][] = new dbcontroller().sqlQuery(request.getParameter("q"));
	if(result == null) return; //INSERT, UPDATE, DELETE 는 값 반환이 없음
%>

{
	"Count":"<%= result.length %>",
	"Data":
	[
	
<%
	if(result != null) {
		for (int Rows = 0; Rows < result.length; Rows++) {
			if(Rows != 0) 
				out.print(",");
			out.println("{");
			for (int Columns = 0; Columns < result[0].length; Columns++) {
				if(Columns != 0) 
					out.println(",");
				out.print(String.format("\"c%s\": \"%s\"", Columns, result[Rows][Columns]));
			}
			out.println("}");
		}
	}
%>
	]
}
    