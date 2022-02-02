<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<link rel="stylesheet" type="text/css" href="/css/loginutil.css">
<link rel="stylesheet" type="text/css" href="/css/login.css">

<style>
.update-save{
	width: 55px;
	height: 35px;
	border: none;
	border-radius: 5px;
	background-color: #1e90ff;
	margin-top: 10px;
	color: white;
	font-weight: bold;
}
</style>

<div class="limiter">
	<div class="container-login100">
		<div class="wrap-login100">
			<form class="login100-form validate-form" action="loginprocess" method="post">
				<span class="login100-form-title p-b-48">
					<div>
						<h2>로그인</h2>
					</div>
				</span>
				
				<div class="wrap-input100 validate-input" data-validate="Valid email">
					<input type="text"  placeholder="아이디 입력" name="id" class = "input100" autofocus="autofocus" required="required" 
						style = "width: 120px" value="${sessionScope.saveok==null?"":sessionScope.checkid}">
				</div>
				
				<div class="wrap-input100 validate-input" data-validate="Enter password">
					<input type = "password" name="pass" class = "input100" required="required" placeholder="비밀번호 입력" style = "width: 120px">
				</div>
				
				<div>
					<label>
						<input type = "checkbox" name = "cbsave" ${sessionScope.saveok == null?"":"checked"}>&nbsp;아이디저장
					</label>
				</div>
				
				<button type="submit" style="margin-top:30px; width:100%; height:50px;"  class="update-save">
					<b>로그인</b>
				</button><br><br>
				<span class="login100-form-title p-b-26">
					<a href="https://kauth.kakao.com/oauth/authorize?client_id=1439861063a7d822757160ad213d4a33&redirect_uri=http://localhost:9002/login/kakao&response_type=code">
						<img src="../profile_image/kakao_login_medium_wide.png" style="height:50px;">
					</a>
				</span>
				
				<div class="text-center login-sub-manu">
					<span onclick="location.href='../member/main'">
						회원가입
					</span>
					<span onclick="location.href='../member/findpass'">
						비밀번호 찾기
					</span>
				</div>
			</form>
		</div>
		<div class="style__FooterCopyright-sc-7of8vt-21 kpnzcM" style="text-align: center;">
			© 2021 Bunddeuk Inc.
		</div>
	</div>
</div>