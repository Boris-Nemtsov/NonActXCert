<%@page import="Java.LoadCert"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>전자 서명 작성</title>
</head>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script type="text/javascript">
  $(document).ready(function(){
      $('#bottomtable').on('click', 'tbody tr', function(event) {
          $(this).addClass('selected').siblings().removeClass('selected');
      });
      $('#bottomtable').find("tr").eq(0).click();
  });

</script>

<style type="text/css">
  body {
  	margin: 0px;
  }
  
  div {
    border: 1px solid white;
  }
  .container {
    background-image: url('background.png');
    background-size: auto;
    width: 450px;
    height: 490px;
    padding: 0px;
    border: 4px solid #E0E0F8;
  }

  #logo {
    width: 420px;
    margin-top: 12px;
    margin-left: 10px;
  }

  #exit {
    width: 25px;
    height: 22px;
  }

  #tablecontents {
    margin-top: 50px;
    margin-left: 11px;
    margin-right: 11px;
    height: 100px;
    overflow-y: hidden;
  }

  #bottomtable {
  }

  tr {
    height: 17px;
  }

  tr.selected {
    background-color: #E0E0F8;;
  }

  .button {
    float: right;
    padding-top: 2px;
  }

  button {
    background-color: #FFFFFF;
    border: 1px solid #DFDFDF;
    color: black;
    padding: 6px 18px;
    text-align: center;
    text-decoration: none;
    display: inline-block;
    font-size: 12px;
    margin-right: 5px;
  }

  a { text-decoration:none }

  .divotp {
    margin-top: 43px;
    height: 29px;
    margin-left: 50px;
    border: none;
  }

  #inputOTP {
    padding-top: 8px;
    width: 255px;
    margin-right: 0px;
    padding-bottom: 2px;
  }

  #divotpbtn {
    margin-right: 35px;
    margin-top: -3px;
    border: none;
  }

  .divsubmit {
    height: 50px;
    margin-top: 27px;
    padding-top: 1px;
    padding-left: 115px;
    border: none;
  }

  #submit {
    background-color: #1D79D3;
    border: 1px solid #DFDFDF;
    color: white;
    padding: 10px 32px;
    text-align: center;
    text-decoration: none;
    display: inline-block;
    font-size: 16px;
    margin-right: 30px;
    border-radius: 2px;
  }

  #cancle {
    background-color: #FFFFFF;
    border: 1px solid #DFDFDF;
    color: black;
    padding: 10px 32px;
    text-align: center;
    text-decoration: none;
    display: inline-block;
    font-size: 16px;
    margin-right: 30px;
    border-radius: 2px;
  }
  
  td {
    height: 20px;
  	font-size: 15px;
    float: left;
    text-overflow: ellipsis; 
    white-space: nowrap;
    overflow: hidden;
    border: 0px;
    border-right: solid 1px #d8d6d6;
  }
</style>

<body>
  <div class="container">

    <div style="float: right;"  id="exit">
      <a href="javascript:parent.layerClose();">&nbsp;&nbsp;&nbsp;&nbsp;</a>
    </div>

    <img src="hexacodelogo.png" id="logo"/>

    <div id="tablecontents">
    <table id="bottomtable" cellpadding="1" cellspacing="0" border="1" align="left" style="height:102px; border-collapse:collapse; border:1px gray solid;">
      <tr>
        <td width="76"> </td>
        <td width="180"> </td>
        <td width="85"> </td>
        <td width="71"> </td>
      </tr>
      <tr>
        <td width="76"> </td>
        <td width="180"> </td>
        <td width="85"> </td>
        <td width="71"> </td>
      </tr>
      <tr>
        <td width="76"> </td>
        <td width="180"> </td>
        <td width="85"> </td>
        <td width="71"> </td>
      </tr>
      <tr>
        <td width="76"> </td>
        <td width="180"> </td>
        <td width="85"> </td>
        <td width="71"> </td>
      </tr>
    </table>
    </div>

    <div style="height: 30px; padding-right: 2px; margin-top: 1px; margin-bottom: -4px;">
      <div class="button"><button type="button" onclick="certRemove();">인증서 폐기</button><input id="isRemove" name="isRemove" type="checkbox" style="display:none;"disabled /></div>
      <div class="button"><button type="button" onclick="certDetail();">인증서 보기</button></div>
      <div class="button"><button type="button" onclick="certGen();">인증서 발급</button></div>
    </div>

    <div class="divotp">
      <input type="password" id="userPass" style="font-size: 18px" disabled/> <div class="button" id="divotpbtn"><button type="button" onclick="genOTP();">OTP 발급</button></div>
    </div>

    <div class="divsubmit">
      <button id="submit" type="submit" onclick="verify();">확인</button><button id="cancle" type="button" onclick="javascript:parent.layerClose();">취소</button>
    </div>

	<input type="hidden" name="userName" id="userName" value="<%= request.getParameter("userName")%>"/>
	<input type="hidden" name="userBirth" id="userBirth" value="<%= request.getParameter("userBirth")%>"/>
	
  </div>
</body>
</html>
<script>
function certGen() {
	parent.register();
	parent.layerClose();
}

function certRemove() {
	if($("#isRemove").prop("checked") == false) { 
		if(confirm("정말로 폐기 하시겠습니까? 복구할 수 없습니다.")) {
			$("#isRemove").prop("checked", true);
			alert("폐기모드로 동작합니다. 인증 절차를 계속 진행하십시오.");
		}
	} else {
		$("#isRemove").prop("checked", false);
		alert("일반모드로 동작합니다. 인증 절차를 계속 진행하십시오.");
	}
}
function verify() {
	var userNameOri = $("#userName").val();
	var userBirthOri = $("#userBirth").val();
	$.getJSON("Select_Verify.jsp",
		{
			userName: userNameOri,
			userBirth: userBirthOri,
			userPass: $("#userPass").val(),
			isRemove: $("#isRemove").prop("checked")
		})
		.done(function(d) {
			alert(d.Result);
			if(d.Token == "refresh") {
				parent.layerClose();
			} else if(d.Result.indexOf("OTP") == -1) {
				parent.login_process(userNameOri, userBirthOri, d.Token);
				parent.layerClose();
			}
		});
}

function genOTP() {
	$.getJSON("Select_OTPgenerate.jsp",
		{
			userName: $("#userName").val(),
			userBirth: $("#userBirth").val()
		})
		.done(function(d) {
			d = d.Result;
			alert(d);
			if(d.indexOf("OTP") != -1)
				$("#userPass").removeAttr("disabled","disabled");
		});
}

function certDetail() {
	alert("공인인증서 상세정보" 
			+ "\n구분 : " + $("tr").find("td").eq(0).html()
			+ "\n사용자 : " + $("tr").find("td").eq(1).html()
			+ "\n만료일 : " + $("tr").find("td").eq(2).html()
			+ "\n발급자 : " + $("tr").find("td").eq(3).html()
		 );
}
</script>
<%
out.println("<script>");
out.println("$(document).ready(function() {");
if(request.getParameter("userName") != null 
		&& request.getParameter("userBirth") != null) {
	String[] Info = null;
	try {
		Info = 
			new LoadCert(
					request.getParameter("userName"),
					request.getParameter("userBirth")).LoadCertInfo();
	
		out.println("var obj = $(\"tr\").find(\"td\");");
		out.println("if(obj.eq(0).html() == \" \") {");
		out.println("obj.eq(0).html(\"금융(개인)\");");
		out.println("obj.eq(1).html(\"" + Info[0] + "\");");
		out.println("obj.eq(2).html(\"" + Info[1] + "\");");
		out.println("obj.eq(3).html(\"" + Info[2] + "\");");
		out.println("}");
	} catch (Exception e) {
		out.println("alert(\" 사용자 정보가 없습니다. \");");
		out.println("parent.layerClose();");
	}
} else {
	out.println("alert(\" 올바른 값을 입력해주세요. \");");
	out.println("parent.layerClose();");
}
out.println("}); </script>");
%>
