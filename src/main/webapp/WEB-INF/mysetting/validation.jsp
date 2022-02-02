<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
<!--===============================================================================================-->	
	<link rel="icon" type="image/png" href="images/icons/favicon.ico"/>
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="/css/vendor/bootstrap/css/bootstrap.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="/css/fonts/font-awesome-4.7.0/css/font-awesome.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="/css/fonts/iconic/css/material-design-iconic-font.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="/css/vendor/animate/animate.css">
<!--===============================================================================================-->	
	<link rel="stylesheet" type="text/css" href="/css/vendor/css-hamburgers/hamburgers.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="/css/vendor/animsition/css/animsition.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="/css/vendor/select2/select2.min.css">
<!--===============================================================================================-->	
	<link rel="stylesheet" type="text/css" href="/css/vendor/daterangepicker/daterangepicker.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="/css/loginutil.css">
	<link rel="stylesheet" type="text/css" href="/css/login.css">
<!--===============================================================================================-->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
	



<script type="text/javascript">

function lastcheck2()
{
	var num = $("#num").val();
	var pass=$("#pass").val();
	
	var rs = "";
	
	$.ajax({
		type:"get",
		dataType:"json",
		data:{"num":num,"pass":pass},
		url:"../member/passcheck",
		async: false,
		success:function(data){
			if(data.check==1){
				$("b.passmsg").html("");
				rs = true;
			}else{
				$("b.passmsg").html("<font color='red'>비밀번호가 일치하지 않습니다.</font>");
				$("#pass").val("");
				$("#pass").focus();
				rs = false;
			}
		}
	});
	
	return rs;
	
}



</script>
<br>
<div class="container" style="margin-bottom:50px;">
<h2 style="color:gray;">회원 탈퇴</h2>
</div>
<hr>

	<div class="limiter">
		<div class="container-login100">
			<div class="wrap-login100">
					<span class="login100-form-title p-b-26">
						본인인증
					</span>
				<form action="../member/memberdelete" method="post" onsubmit="return lastcheck2();">
					<input type="text" class="form-control" readonly="readonly" style="width: 100%;" value="${dto.id }"><br>
					<input type="hidden" id="num" name="num" value="${dto.num}">
					<div class="form-group">
					<input id="passcheck" type="hidden" name="passcheck" value="${dto.pass}">
					<input type="password" style="width: 100%;"
				class="form-control" id="pass" name="pass" maxlength="20"
				placeholder="현재 비밀번호" required="required">
				<b class="passmsg"></b>
				<button type="submit" style="margin-top:30px; width:100%; height:50px;"  class="btn btn-danger">
                            <b>탈퇴하기</b>
                  </button>
				
				<br><hr><br>
					<div style="color:blue; cursor:pointer; text-align:center;" class="txt2" onclick="location.href='../member/findpass'">
							<u>혹시 비밀번호를 잊으셨나요?</u>
						</div>
					</div>
				</form>
			</div>
		<div class="style__FooterCopyright-sc-7of8vt-21 kpnzcM"
			style="text-align: center;">© 2021 Bunddeuk Inc.</div>
			
		</div>
		</div>

















	
<!--===============================================================================================-->
	<script src="/css/vendor/jquery/jquery-3.2.1.min.js"></script>
<!--===============================================================================================-->
	<script src="/css/vendor/animsition/js/animsition.min.js"></script>
<!--===============================================================================================-->
	<script src="/css/vendor/bootstrap/js/popper.js"></script>
	<script src="/css/vendor/bootstrap/js/bootstrap.min.js"></script>
<!--===============================================================================================-->
	<script src="/css/vendor/select2/select2.min.js"></script>
<!--===============================================================================================-->
	<script src="/css/vendor/daterangepicker/moment.min.js"></script>
	<script src="/css/vendor/daterangepicker/daterangepicker.js"></script>
<!--===============================================================================================-->
	<script src="/css/vendor/countdowntime/countdowntime.js"></script>
<!--===============================================================================================-->
	<script src="/css/js/main.js"></script>


