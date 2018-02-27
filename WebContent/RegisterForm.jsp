<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <% request.setCharacterEncoding("UTF-8"); %>

<!DOCTYPE html>

<%@include file="header.jsp"%>
<%@include file="menu.jsp"%>


		<div id="page-content" class="clearfix" style="min-height: 552px;">
			<div class="content-header" style="background: url('개발자 가이드_files/bg010.jpg') repeat scroll 0 0; background-size:cover">
				<div class="header-section container">
					<h1>
												Membership													<br>
							<small>회원가입</small>
											</h1>
				</div>
				
								
			</div>						<div class="container">
				<div class="row clearfix">
					<!-- content -->
					<div class="col-xs-12">
						<div id="content-container">
							<div class="panel panel-default"><div class="panel-body">							<!--#JSPLUGIN:ui--><!--#JSPLUGIN:ui.datepicker--><section class="xm">
	    <h1 style="border-bottom:1px solid #ccc">회원가입</h1>
	    <form id="uploadCertFrm" class="form-horizontal"><input type="hidden" name="error_return_url" value="/index.php?mid=dev_guide&amp;act=dispMemberSignUpForm"><input type="hidden" name="mid" value="dev_guide"><input type="hidden" name="vid" value=""><input type="hidden" name="ruleset" value="@insertMember">
		<input type="hidden" name="act" value="procMemberInsert">
		<input type="hidden" name="xe_validator_id" value="modules/member/skins">
		<input type="hidden" name="success_return_url" value="https://www.xpressengine.com/index.php?mid=dev_guide&amp;act=dispMemberInfo">
		<div class="control-group">
			<label for="userName" class="control-label"><em style="color:red">*</em> 이름</label>
			<div class="controls"><input type="text" name="userNameOri" id="userNameOri" value=""></div>
		</div>
		<div class="control-group">
			<label for="userBirth1" class="control-label"><em style="color:red">*</em> 생년월일</label>
			<div class="controls"><input type="text" name="userBirth1" id="userBirth1" value="" style="width: 50px"> - <input type="text" name="userBirth2" id="userBirth2" value="" style="width: 50px"> - <input type="text" name="userBirth3" id="userBirth3" value="" style="width: 50px">
			(예. 1999-01-01)</div>
		</div>
		<div class="control-group">
			<div class="control-label"><em style="color:red">*</em> 성별</div>
			<div class="controls" style="padding-top:5px">
				<label for="userGender"><input type="radio" name="userGender" id="userGender" value="남성" checked="checked"> 남</label>
				<label for="userGender"><input type="radio" name="userGender" id="userGender" value="여성"> 여</label>
			</div>
		</div>
		<div class="control-group">
			<label for="userTelecom" class="control-label"><em style="color:red">*</em> 통신사</label>
			<div class="controls"><select name="userTelecom" id="userTelecom" style="display:block;margin:0 0 8px 0"><option value="SKT">SKT</option><option value="KT">KT</option><option value="LG">LG U+</option><option value="ASKT">SKT 알뜰폰</option><option value="AKT">KT 알뜰폰</option><option value="ALG">LG U+ 알뜰폰</option></select></div>
		</div>
		<div class="control-group">
			<label for="userPhone1" class="control-label"><em style="color:red">*</em> 휴대폰 번호</label>
			<div class="controls"><input type="text" name="userPhone1" id="userPhone1" value="" style="width: 50px"> - <input type="text" name="userPhone2" id="userPhone2" value="" style="width: 50px"> - <input type="text" name="userPhone3" id="userPhone3" value="" style="width: 50px">
			<input type="button" value="인증" class="btn btn-inverse" onclick="sendAuth();"></div>
		</div>
		<div class="control-group">
			<label for="homepage" class="control-label"><em style="color:red">*</em> 인증번호</label>
			<div class="controls">
				<input type="urlb" name="userAuth" id="userAuth" value="" disabled="disabled" />
				<input type="hidden" name="userAuthToken" id="userAuthToken" />
			</div>
		</div>
		<div class="control-group">
			<label for="profile_image" class="control-label"><em style="color:red">*</em> 새로운 공인인증서 발급</label>
			<div class="controls">
				<input type="button" value="새로 발급받기" class="btn btn-inverse" onclick="genCert(1);" disabled="disabled">
			</div>
		</div>
		<div class="control-group">
			<label for="profile_image" class="control-label"><em style="color:red">*</em> 기존 공인인증서 업로드</label>
			<div class="controls">
				<input type="file" name="derFile" id="derFile" value="">*.der 파일<br /> 
				<input type="file" name="keyFile" id="keyFile" value="">*.key 파일<br />
				기존 비밀번호 : <input type="password" id="uploadedCertPass" name="uploadedCertPass" /> <br />
				<input type="button" value="파일 업로드" class="btn btn-inverse" onclick="genCert(0);" disabled="disabled">
			</div>
		</div>
		<div class="btnArea" style="border-top:1px solid #ccc;padding-top:10px">
			<input type="button" value="등록" class="btn btn-inverse pull-right" onclick="chkAuth();" disabled="disabled">
			<a href="javascript:history.go(-1);" class="btn pull-left">취소</a>
		</div>
		<input type="hidden" name="userName" id="userName" />
    	<input type="hidden" name="userBirth" id="userBirth" />
    	<input type="hidden" name="token" id="token" />
    	<input type="hidden" name="certDone" id="certDone" />
	</form>
<script>
function genCert(isNewbie) {
	$("#userBirth").val($("#userBirth1").val() + $("#userBirth2").val() + $("#userBirth3").val());
	$("#userName").val(encodeURIComponent($("#userNameOri").val()));
	if(isNewbie == 0) {
		var Data = new FormData($("#uploadCertFrm")[0]);
		$.ajax({
			url: "./NewCert_UploadFile.jsp",
			enctype: "multipart/form-data",
			processData: false,
	        contentType: false,
			type: "POST",
			data: Data
		})
		.done(function (d){
			d = JSON.parse(d);
			alert(d.Result);
			if(d.Result.indexOf("완료") != -1) {
				$("#token").val(d.Result.Token);
				$("input[type='button']").attr("disabled","disabled");
				$("input[type='password']").attr("disabled","disabled");
				$(".pull-right").removeAttr("disabled");
				$("#certDone").val("1");
			}
		});
	} else {
		$.post("./NewCert_Newbie.jsp",
		{
			userName: $("#userName").val(),
			userBirth: $("#userBirth").val()
		})
		.done(function (d){
			d = JSON.parse(d);
			alert(d.Result);
			if(d.Result.indexOf("완료") != -1) {
				$("#token").val(d.Result.Token);
				$("input[type='button']").attr("disabled","disabled");
				$("input[type='password']").attr("disabled","disabled");
				$(".pull-right").removeAttr("disabled");
				$("#certDone").val("1");
			}
		});
	}
}

function sendAuth() {
	userName = $("#userNameOri").val();
	userPhone =  $("#userPhone1").val() + $("#userPhone2").val() + $("#userPhone3").val();
	userBirth = $("#userBirth1").val() + "-" + $("#userBirth2").val() + "-" + $("#userBirth3").val();
	$.ajax("https://query.yahooapis.com/v1/public/yql?q=use%20%22https%3A%2F%2Fraw.githubusercontent.com%2Fyql%2Fyql-tables%2Fmaster%2Fdata%2Fjsonpost.xml%22%20as%20jsonpost%3B%20%20%0Aselect%20*%20from%20jsonpost%0A%20%20%20where%20url%3D%22http%3A%2F%2Fapp.chakanphone.co.kr%2Fuser_auth.html%22%0A%20%20%20and%20postdata%3D%22"
			+ "mobileNumber%3D" + userPhone + "%26"
			+ "userCarrier%3D" + $("#userTelecom").val() + "%26"
			+ "userName%3D" + $("#userNameOri").val() + "%26"
			+ "userBirthDay%3D" + userBirth + "%26"
			+ "userSex%3D" + encodeURIComponent($("#userGender").val()) + "%26userForeign%3D%25EB%2582%25B4%25EA%25B5%25AD%25EC%259D%25B8%22&format=json&diagnostics=true"
	)
	.done(function(d) {
		d = d.query.results.postresult.json.retMsg;
		if(d.indexOf("실패") != -1 || d.indexOf("not found") != -1) 
			alert("정보가 올바르지 않습니다.");
		else {
			userName = $("#userNameOri").val();
			userPhone =  $("#userPhone1").val() + $("#userPhone2").val() + $("#userPhone3").val();
			userBirth = $("#userBirth1").val() + "-" + $("#userBirth2").val() + "-" + $("#userBirth3").val();
			
			alert("인증번호가 전송됐습니다.");
			$('input[type="text"]').attr("disabled","disabled");
			$("#userAuth").removeAttr("disabled");
			$('input[type="button"]').removeAttr("disabled");
		}
	});
}

function chkAuth() {
	$.ajax("https://query.yahooapis.com/v1/public/yql?q=use%20%22https%3A%2F%2Fraw.githubusercontent.com%2Fyql%2Fyql-tables%2Fmaster%2Fdata%2Fjsonpost.xml%22%20as%20jsonpost%3B%20%20%0Aselect%20*%20from%20jsonpost%0A%20%20%20where%20url%3D%22http%3A%2F%2Fapp.chakanphone.co.kr%2Fuser_register.html%22%0A%20%20%20and%20postdata%3D%22"
		+ "mobileNumber%3D" + userPhone + "%26"
		+ "userName%3D" + $("#userNameOri").val() + "%26"
		+ "userBirthDay%3D" + userBirth + "%26"
		+ "userSex%3D" + encodeURIComponent($("#userGender").val()) + "%26"
		+ "userCarrier%3D" + $("#userTelecom").val() + "%26userForeign%3D%25EB%2582%25B4%25EA%25B5%25AD%25EC%259D%25B8%26" 
		+ "userCertNum%3D" + $("#userAuth").val() +"%26deviceModel%3DSHV-E250S%26deviceId%3D333333333333333%26deviceCarrier%3DLG%2BU%252B%26usimId%3D8888888888888888888%26osType%3DA%26osVersion%3D7.0%26appVersion%3D1.2.0%26pushId%3D1%26reqNum%3Dchakan111111111111111111111111%22&format=json&diagnostics=true"
	)
	.done(function(d) {
		d = d.query.results.postresult.json.retCode;
		if(d.indexOf("37") != -1) 
			registerFinish("0");
		else {
			alert("인증번호가 올바르지 않습니다.");
		}
	});
}

function registerFinish(isRegFlag) {
	if(isRegFlag == "1" && $("#certDone").val() == "1") {
		alert("가입이 완료됐습니다.");
	} else if($("#certDone").val() != "1"){
		alert("공인인증서를 발급하거나 업로드해주세요.")
	}
	
	$.getJSON("./RegisterDB.jsp", 
		{
			userName: userName,
			userBirth: userBirth,
			userPhone: userPhone,
			isReg: isRegFlag
		}		
	)
	.done(function(d) {
		if(d.Count >= 1 && isRegFlag == "0") {
			alert("정보 수정이 완료됐습니다.");
			location.href = "LoginForm.jsp";
		} else if(d.Count == 0 && isRegFlag == "0") {
			registerFinish("1");
		}
	});
}

jQuery(function($){
	// label for setup
	$('.control-label[for]').each(function(){
		var $this = $(this);
		if($this.attr('for') == ''){
			$this.attr('for', $this.next().children(':visible:first').attr('id'));
		}
	});
});
(function($){
	$(function(){
		var option = { changeMonth: true, changeYear: true, gotoCurrent: false,yearRange:'-100:+10', dateFormat:'yy-mm-dd', onSelect:function(){
			$(this).prev('input[type="hidden"]').val(this.value.replace(/-/g,""))}
		};
		$.extend(option,$.datepicker.regional['ko']);
		$(".inputDate").datepicker(option);
		$(".dateRemover").click(function() {
			$(this).parent().prevAll('input').val('');
			return false;});
	});
})(jQuery);
</script>
</section>
							</div></div>						</div>
					</div>
					<!-- LNB -->
										<!-- //LNB -->
				</div>
			</div>		</div>

<%@include file="footer.jsp"%>
