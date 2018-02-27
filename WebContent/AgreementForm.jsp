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
							<div class="panel panel-default"><div class="panel-body">							<div class="path">
	<a href="https://www.xpressengine.com/" class="home"><span>Home</span></a> 
	&gt; <strong>회원가입</strong>
</div>
<div class="join">
	<h1><img src="./개발자 가이드-동의_files/h1.join.gif" width="87" height="23" alt="회원가입"></h1>
		<p class="step"><img src="./개발자 가이드-동의_files/step1.gif" width="905" height="56" alt="Step1:약관동의(현재위치). Step2:기본정보 입력. Step3:가입완료."></p>
	<h2><img src="./개발자 가이드-동의_files/h2.agreement.gif" width="191" height="15" alt="회원 가입을 위한 약관 동의 절차"></h2>
	<form action="https://www.xpressengine.com/index.php?mid=dev_guide&amp;act=dispMemberSignUpForm" method="post" onsubmit="return false" class="member_join_extend"><input type="hidden" name="error_return_url" value="/index.php?mid=dev_guide&amp;act=dispMemberSignUpForm"><input type="hidden" name="act" value="dispMemberSignUpForm"><input type="hidden" name="mid" value="dev_guide"><input type="hidden" name="vid" value="">
		<fieldset>
<textarea style="width: 1010px; height: 432px">
개인정보의 수집 및 이용에 대한 동의

1. 수집하는 개인정보의 항목 및 수집방법 
회사는 회원가입, 원활한 고객상담, 각종 서비스의 제공을 위해 최초 회원가입 당시 아래와 같은 개인정보를 수집하고 있습니다.
- 필수사항: 이름, 비밀번호, 닉네임, 이메일 주소, 비밀번호찾기 질문/답변
- 선택사항: 홈페이지 주소, 블로그 주소, 프로필 사진

또한 서비스 이용과정이나 사업처리 과정에서 아래와 같은 정보들이 자동으로 생성되어 수집될 수 있습니다.
- IP Address, 쿠키, 접속로그, 서비스 이용 기록, 불량 이용 기록

2. 개인정보의 수집 및 이용목적 
가. 회원관리
회원제 서비스 이용에 따른 본인확인, 개인식별, 불량회원의 부정 이용방지와 비인가 사용방지, 가입의사 확인, 가입 및 가입횟수 제한, 만14세 미만 아동 개인정보 수집 시 법정 대리인 동의여부 확인, 추후 법정 대리인 본인확인, 분쟁 조정을 위한 기록보존, 불만처리 등 민원처리, 고지사항 전달

나. 서비스 제공 및 마케팅•광고에의 활용
콘텐츠 제공, 신규 서비스 개발 및 맞춤 서비스 제공, 인구 통계학적 특성에 따른 서비스 제공 및 광고 게재, 접속빈도 파악, 회원의 서비스이용에 대한 통계, 이벤트 등 광고성 정보 전달

3. 개인정보의 보유 및 이용기간
이용자의 개인정보는 원칙적으로 개인정보의 수집 및 이용목적이 달성되면 지체 없이 파기합니다. 단, 다음의 정보에 대해서는 아래의 이유로 명시한 기간 동안 보존합니다.

가. 회사 내부 방침에 의한 정보보유 사유: 부정이용기록
- 보존 이유 : 부정 이용 방지
- 보존 기간 : 6개월

나. 관련 법령에 의한 정보보유 사유: 방문에 관한 기록
- 보존 이유 : 통신비밀보호법
- 보존 기간 : 3개월
</textarea>
							<p class="checkAgreement"><input name="" type="checkbox" id="checkPrivateAgreement"><label for="checkPrivateAgreement">   개인정보 수집 및 이용에 동의합니다</label></p>
						<div class="btnArea">
						    <input type="button" value="가입" class="btn" style="background-color: #e0dfdf" onclick="chkAgreement();">
						    
						</div>
		</fieldset>
	</form>
</div>
							</div></div>						</div>
					</div>
					<!-- LNB -->
										<!-- //LNB -->
				</div>
			</div>		</div>
<script>
function chkAgreement() {
	if($("#checkPrivateAgreement").prop("checked") == false) {
		alert("약관에 동의해주세요.");
	} else {
		location.href = "RegisterForm.jsp";
	}
}
</script>
<%@include file="footer.jsp"%>