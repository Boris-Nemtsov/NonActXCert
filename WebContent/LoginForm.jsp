<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <% request.setCharacterEncoding("UTF-8"); %>

<!DOCTYPE html>

<%@include file="header.jsp"%>
<%@include file="menu.jsp"%>




<style>
#layerBg {
	position: absolute;
	left: 0;
	top: 0;
	z-index: 100;
	background-color: rgba(0,0,0,1);
	display: none;
}

#layerIframe {
	display: none;
	position: absolute;
}
</style>

<div id="page-content" class="clearfix" style="min-height: 552px;">
			<div class="content-header" style="background: url('개발자 가이드_files/bg010.jpg') repeat scroll 0 0; background-size:cover">
				<div class="header-section container">
					<h1>
												Membership													<br>
							<small>로그인</small>
											</h1>
				</div>
				
								
			</div>						<div class="container">
				<div class="row clearfix">
					<!-- content -->
					<div class="col-xs-12">
						<div id="content-container">
														<section class="xm">
	<div class="signin" style="margin: 45px 35%;">
	<div class="login-xe">
		<div class="login-header">
			<h2><img src="./개발자 가이드_로그인_files/@log.png" width="70" height="70" alt="로그인"></h2>
		</div>
		<div class="login-body">
			<form onsubmit="return false;" id="fo_member_login"><input type="hidden" name="error_return_url" value="/index.php?mid=dev_guide&amp;act=dispMemberLoginForm"><input type="hidden" name="mid" value="dev_guide"><input type="hidden" name="vid" value=""><input type="hidden" name="ruleset" value="@login">
				<fieldset>
				<div class="control-group">
					<input type="text" name="userName" id="userName" required="" placeholder="이름" title="이름" class="qwer">					<input type="password" name="userBirth" id="userBirth" required="" placeholder="생년월일 (예.19940101)" title="생년월일" class="qpass">
				</div>
				<div class="control-group">
					<input type="submit" value="로그인" class="continu" onclick="login();">
				</div>
				<div class="control-other">
					<a class="other-member" href="AgreementForm.jsp">인증서 발급/등록</a>
				</div>
				</fieldset>
			</form>
		</div>
	</div>
</div>
<script>
function login_process(name, birth, token) {
	$.getJSON("DToken_Check.jsp", 
	{
		userName: name,
		userBirth: birth,
		DToken: token
	})
	.done(function() {
		location.href = "Personal.jsp?t=" + token;
	});
}

function login() {
	DN = $("#userName").val();
	Birth = $("#userBirth").val();
	iframeLayer("SelectForm.jsp?userName=" + DN + "&userBirth=" + Birth , 459, 500);
}

function register() {
	location.href = "AgreementForm.jsp";
}

function layerClose() {
	$("body").find("#layerIframe").remove();
	$("body").find("#layerBg").css({"display":"none"});
}

function iframeLayer(url, width, height) {
	if($("body").find("#layerIframe").length == 0 || $("body").find("#layerBg").length == 0) {
		$("body").prepend('<div id="layerIframe"></div>');
		$("body").prepend('<div id="layerBg"></div>');
		$("#layerIframe").prepend("<iframe name='layerfrm' style='background: #FFFFFF;' width='100%' height='100%' frameborder='0' src='" + url + "' />");
	}
	
	var maskHeight;
	var maskWidth;

	$("#layerBg").css({'position':'absolute','width':'100%','height':$(document).height()});  
     
	$("#layerBg").fadeTo(500,0.8);
	
	$(window).resize(
		function() {
			if($("#layerBg").css("display") != 'none') {
				maskHeight = $(document).height(); 
				maskWidth = $(window).width(); 
				$("#layerIframe").css({'position':'absolute','z-index':'1000', 'top':'150px', 'left':(maskWidth-width)/2, 'width':width,'height':height, 'display':'block'});
				$("#close").css({'position':'absolute', 'top':'20px', 'left':maskWidth*0.5});
				$("#layerBg").css({'height':maskHeight});
			}
		}
	).resize();
}

jQuery(function($){
	var keep_msg = $('#warning');
	keep_msg.hide();
	$('#keepid').change(function(){
		if($(this).is(':checked')){
			keep_msg.slideDown(200);
		} else {
			keep_msg.slideUp(200);
		}
	});
});
</script>
</section>
													</div>
					</div>
					<!-- LNB -->
										<!-- //LNB -->
				</div>
			</div>		</div>
			
<%@include file="footer.jsp"%>