<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri = "http://java.sun.com/jsp/jstl/core" %>


<style>
.update-save2{
	width: 110px;
	height: 35px;
	border: none;
	border-radius: 5px;
	background-color: #1e90ff;
	margin-top: 10px;
	color: white;
	font-weight: bold;
}

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

<!-- 이메일 -->
<div class="profileemail">
	<span class="title"><b>이메일</b></span>
	<span class="updateEmail">
	<span class="updatespan">변경</span>
	<br></span><br>
	<div style="margin-top: 10px;">${dto.email}</div>
	
	<c:if test="${dto.auth_status == 0 }">
	<div class="CommonStyled__CheckedSynced-bpcmiq-31 cIhcRD">
		<div name="error-1" class="Icon__SVGICON-sc-1xkf9cp-01 ccxeYs baseline">
			<svg viewBox="0 0 48 48">
				<path fill-rule="evenodd" clip-rule="evenodd"
					d="M24 43.8C13 43.8 4.2 35 4.2 24C4.2 13 13 4.2 24 4.2C35 4.2 43.8 13 43.8 24C43.8 35 35 43.8 24 43.8ZM24 2C11.9 2 2 11.9 2 24C2 36.1 11.9 46 24 46C36.1 46 46 36.1 46 24C46 11.9 36.1 2 24 2ZM24 32.3C22.7 32.3 21.8 33.401 21.8 34.6C21.8 35.8 22.9 36.8 24.1 36.8C25.4 36.8 26.3 35.7 26.3 34.5C26.3 33.3 25.3 32.3 24 32.3ZM24.1 29.0998H24C23.3 28.9998 22.7 28.4008 22.9 27.7008C22.8825 27.1051 22.8619 26.3713 22.8388 25.5474C22.7299 21.6673 22.565 15.7867 22.4 12.8998V12.7998C22.3 11.8998 23.1 11.2998 24.2 11.2998C25.3 11.2998 26 11.8998 26 12.7998V12.9998C25.8994 14.7101 25.8241 17.5591 25.7486 20.414C25.6741 23.2344 25.5994 26.0604 25.5 27.7998V27.9008C25.4 28.5998 24.8 29.0998 24.1 29.0998Z"></path></svg>
		</div>
		미인증 이메일입니다.
	</div>
	</c:if>
	
	<c:if test="${dto.auth_status == 1 }">
	<div class="CommonStyled__CheckedSynced-bpcmiq-3 eYgKHf">
		<div name="check" class="Icon__SVGICON-sc-1xkf9cp-0 ccxeYs baseline">
			<svg viewBox="0 0 48 48">
				<path fill-rule="evenodd" clip-rule="evenodd"
					d="M41.6 8L18.9 30.8L6.2 19L2 23.5L19.1 39.4L46 12.4L41.6 8Z"></path> </svg>
		</div>
		인증된 이메일입니다.
	</div>
	</c:if>
	<hr>
</div>

<div class="ptofileemailupdate">
	<span class="title"><b>이메일</b></span>
	<span class="close6">
		<span class="updatespan">취소</span>
<br>	</span><br>
<!--  	<form action="mail" method="post" onsubmit="return emailcheck()"> -->
		<input type="hidden" name="auth_status" id="auth_status" value="${dto.auth_status}">
		<input type="hidden" name="num" id="num" value="${dto.num}">
		<input type="text" class="form-control" style="height:39px; margin-top:10px;" id="emailupdate" name="email" maxlength="50"
			style="width: 100%; margin-top: 10px;" required="required" value="${dto.email}">
		<b class="emailmsg"></b><br>
		<button type="submit" class="update-save2 emailupdatebtn" style="margin-top: 10px;">인증메일 전송</button>
<!--	</form> -->
	<hr>
</div>

<div class="Email__EmailNeedConfirm-p3qd8f-0 duKYnV" id="Email_div">
	<span class="title"><b>이메일</b></span>
	<span class="close6">
		<span class="updatespan_email">취소</span>
	<br></span><br>
	<div style="margin-top:20px; margin-bottom:20px;">
	신청하신 이메일로 인증메일이 발송되었습니다. 이메일 확인 후 인증 링크를 클릭하시면
	이메일 변경이 완료되며, 변경하신 이메일로 로그인하실 수 있습니다.
	</div>
	<hr>
</div>

<script>

$("button.emailupdatebtn").click(function(){
	
	
	var mbrEmail = $("#emailupdate").val();   // email 값 입력
	var regExp = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i.test(mbrEmail); // email체크
	
	var email=$("#emailupdate").val().trim();//입력값
	if(email.trim().length==0){
		$("b.emailmsg").html("<font color='red'>이메일을 입력해주세요</font>");
		return false;
	}
	
	if(!(regExp)){
		$("b.emailmsg").html("<font color='red'>이메일 형식으로 작성해주세요</font>");
		$("#emailupdate").val("");
		$("#emailupdate").focus();
		return false;
	}else{
		$("b.emailmsg").html("");
	}
	
	
	var num = $("#num").val();
	var rs = "";
	
	$.ajax({
		type:"get",
		dataType:"json",
		data:{"email":email},
		url:"../member/emailcheck",
		async: false,
		success:function(data){
			if(data.check==1){
				$("b.emailmsg").html("<font color='red'>이미 인증된 이메일입니다.</font>");
			}else{
				$("b.emailmsg").html("");
				$.ajax({
					type:"post",
					dataType:"json",
					data:{"num":num,"email":email},
					url:"mail",
					success:function(data){
					},error:function(error){
						//$("#d_content").load('/setting/main #d_content');
						$("#Email_div").show();
						$("div.ptofileemailupdate").hide();
					}
				});
			}
		}
	});
	
	
});





/*

//수정 버튼 이벤트
$("button.emailupdatebtn").click(function(){
	
	var auth_status = $("#auth_status").val();
	var num = $("#num").val();
	var email = $("#emailupdate").val();
	
	if(auth_status == 1){
		$("b.emailmsg").html("<font color='red'>이미 인증된 이메일입니다.</font>");
		return;
	}else{
	$.ajax({
		type:"post",
		dataType:"json",
		data:{"num":num,"email":email},
		url:"mail",
		success:function(data){
		},error:function(error){
			//$("#d_content").load('/setting/main #d_content');
			$("#Email_div").show();
			$("div.ptofileemailupdate").hide();
		}
	});
	}
});*/
</script>
<c:if test="${empty dto.oauth}">
<!-- 비밀번호 -->
<div class="password">
	<span class="title"><b>비밀번호</b></span> 
	<span class="updatePass">
	<span class="updatespan">변경</span>
	<br></span><br>
	<hr>
</div>

<div class="passupdate">
	<span class="title"><b>비밀번호</b></span> 
	<span class="close7">
		<span class="updatespan">취소</span>
<br>	</span><br>
	<form action="updatepass" method="post" onsubmit="return lastcheck(this)">
		<input type="hidden" name="num" value="${dto.num}">
		<div class="form-group">
			<div style="margin-top:10px;">현재 비밀번호</div>
			<input id="passcheck" type="hidden" name="passcheck" value="${dto.pass}">
			<input type="password" style="height:39px; margin-top:10px;"
				class="form-control" id="pass1" name="pass1" maxlength="20"
				placeholder="현재 비밀번호" required="required">
				<b class="pass1msg"></b>
				<div style=" margin-top:10px;"></div>
					비밀번호가 기억나지 않나요?
					<span style="cursor:pointer;" onclick="location.href='../member/findpass'">
						&nbsp;<b>임시 비밀번호 받기</b>
					</span>
				
		</div>
	<br>
		<div class="form-group">
			<div>변경할 비밀번호</div>
			<input type="password" style="height:39px; margin-top:10px;"
				class="form-control" id="pass" name="pass" maxlength="20"
				placeholder="변경할 비밀번호" required="required">
				<b class="passmsg"></b>
		</div>
		<div class="form-group">
			<div>비밀번호 확인</div> <input style="height:39px; margin-top:10px;"
				type="password" class="form-control" name="pass2" id="pass2"
				maxlength="20" placeholder="변경할 비밀번호 확인"
				required="required">
				<b class="passmsg2"></b>
		</div>

		<button type="submit" class="update-save" style="margin-top: 10px;">저장</button>
	</form>
	<hr>
</div>
</c:if>
<c:if test="${not empty dto.oauth}">
<span class="title"><b>카카오 계정 연동</b></span><br>
	<div class="CommonStyled__C kbzLam" style="margin-top:10px;">
		<div name="check" class="Icon__SVGICON-sc ccxeYs baseline">
			<svg viewBox="0 0 48 48">
				<path fill-rule="evenodd" clip-rule="evenodd"
					d="M41.6 8L18.9 30.8L6.2 19L2 23.5L19.1 39.4L46 12.4L41.6 8Z"></path></svg>
		</div>
		<span style="color:gray;">연동 중입니다.</span>
	</div>
<hr>
</c:if>

   	<!--  연락처 -->
    	<div class="hp">
    		<span class="title"><b>연락처</b></span>
    		<span class="updateHp">
    			<span class="updatespan">변경</span>
    	<br>	</span><br>
    		<div style="margin-top:10px; color:gray;">
		    	<c:if test="${dto.hp == null}">
		    		<span style="margin-top:10px;">등록된 연락처가 없습니다.</span>
		    	</c:if>
		    	<c:if test="${dto.hp != null}">
		    		<div style="margin-top:10px;">${dto.hp}</div>
		    	</c:if>
	    	</div>
    		<hr>
    	</div>
    	
    	<div class="hpupdate">
    		<span class="title"><b>연락처</b></span>
    		<span class="close8">
    			<span class="updatespan">취소</span>
    	<br>	</span><br>
			<form action="updatehp" method="post">
				<input type="hidden" name="num" value="${dto.num}">
				<input type="text" required="required" class="form-control phoneNumber" id="hp" name="hp" maxlength="13" style="height:39px; margin-top:10px;" placeholder="휴대폰 번호를 입력해주세요." value="${dto.hp}">
				<b class="hpmsg"></b><br>
				<button type="submit" class="update-save" style="margin-top:10px;">저장</button>
			</form>
			<hr>
    	</div>
    	

<!-- 회원탈퇴 -->
<div class="memberdelete">
	<span class="title"><b>회원탈퇴</b></span> <span class="memberDelete">
	<span class="updatespan">탈퇴</span>
<br>	</span><br>
	<hr>
</div>




























