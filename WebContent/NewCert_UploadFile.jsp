<%@page import="java.net.URLDecoder"%>
<%@page import="java.io.File"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="Java.Settings"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="Java.UploadCert"%>
<%@page import="com.sun.xml.internal.messaging.saaj.util.ByteOutputStream"%>
<%@page import="java.io.InputStream"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>

{
	"Result":"<% 
	String PATH = Settings.getPath();
	String OUTPUT_FILENAME = Settings.getOutputFileName();
	
	int size = 1024*1024*15;
	
	MultipartRequest fileBinary = new MultipartRequest(request, PATH, size, new DefaultFileRenamePolicy());
	
	String userName = URLDecoder.decode(fileBinary.getParameter("userName"));
	String userBirth = fileBinary.getParameter("userBirth");
	String userPass = fileBinary.getParameter("uploadedCertPass");
	String SUBJECT_DN = Settings.getSubjectDN(userName, userBirth);
	
	if(userName.equals(null) || userBirth.equals(null)) {
		out.print("정보가 올바르지 않습니다.");
		return;
	}
	
	System.out.println("이름 : " + userName);
	System.out.println("생일 : " + userBirth);
	System.out.println("비밀번호 : " + userPass);
	
	String fileNameDer = fileBinary.getFilesystemName("derFile");
	String fileNameKey = fileBinary.getFilesystemName("keyFile");
	
	File fileDer = new File(PATH + fileNameDer);
	File fileKey = new File(PATH + fileNameKey);
	
	int rtrnCode = new UploadCert(userName, userBirth, userPass).UploadFile(fileDer, fileKey);
	if(rtrnCode == -1) {
		out.print("기존 공인인증서를 폐기해주세요.");
	} else if(rtrnCode == -2) {
		out.print("파일이 올바르지 않습니다.");
	} else if(rtrnCode == -3){
		out.print("암호가 틀립니다.");
	} else {
		out.print("업로드 성공\",");
		out.print("\n	\"Token\":\"" + Settings.getToken(userName, userBirth));
	}
%>"
}