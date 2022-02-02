<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri = "http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript">

function memberCheck(f)
{
	var check = $("#check").is(":checked");
	if(!check){
		$("b.msg").html("<font color='red'>탈퇴 유의사항을 확인해주세요.</font>");
		$("#check").focus();
		return;
	}
	
	location.href="validation";

}

function kakaoCheck(f)
{
	alert("정말 탈퇴하시겠습니까?");
	var check1 = $("#check").is(":checked");
	if(!check1){
		$("b.msg").html("<font color='red'>탈퇴 유의사항을 확인해주세요.</font>");
		$("#check").focus();
		return false;
	}
	return true;

}
</script>
<br>
<div class="container" style="margin-bottom:50px;">
<h2 style="color:gray;">회원 탈퇴</h2>
</div>
<hr>
<div class="container">
<h5>서비스 이용에<br>불편함이 있으신가요?</h5>
<ul>
	<li>• 기타 불편한 사항이 있다면 언제든 번뜩에 알려주세요.</li>
</ul>
<hr>
<h5>탈퇴 전, 유의사항을<br>확인해주시기 바랍니다.</h5>
<br>
<h6>계정 및 알림</h6>
<ul>
	<li>• 계정이 페이스북,네이버,구글 계정과 연동돼 있었다면 연동이 모두 해제됩니다.</li>
	<li>• 수신하던 모든 알림(이메일, 카카오 알림톡, 앱 푸시)가 해제됩니다 뉴스레터 구독은 이메일 하단에서 취소할 수 있습니다.</li>
</ul>
<hr>

<h6>후원 및 결제</h6>
<ul>
	<li><b>• 이미 결제된 후원은 취소되지 않습니다.</b></li>
	<li>• 결제 완료 후 탈퇴하더라도, 선물 전달이 완료될 때까지 창작자가 배송정보를 열람할 수 있습니다.</li>
	<li><b>• 아직 선물을 받지 못했다면, 선물 전달 과정에서 불이익이 발생할 수 있습니다.</b>배송 정보를 변경할 수 없으며
	전달에 관한 커뮤니티 공지,메세지 등을 확인할 수 없습니다.</li>
	<li>• 관련 법령에 따라 후원 및 후원취소에 관한 기록, 결제 및 선물 전달에 관한 기록은 5년 동안 보관됩니다.</li>
</ul>

<hr>

<h6>프로젝트</h6>
<ul>
	<li>• 작성중,제출,반려 및 승인된 프로젝트는 모두 삭제되고 공개예정,펀딩 진행중인 프로젝트는 모두 중단됩니다.</li>
	<li><b>• 펀딩이 종료된 프로젝트는 삭제되지 않습니다.</b></li>
	<li>• 탈퇴하더라도, 이미 펀딩이 종료된 프로젝트에 관한 <b>창작자의 의무와 책임 조항은 그 효력을 유지합니다.</b></li>
</ul>
<hr>
<label>
	<input type="checkbox"  name="check" id="check"> 탈퇴 유의사항을 확인했습니다.<br>
</label>
<b class="msg"></b><br>
<c:if test="${empty dto.oauth}">
	<button type="button" style="margin-top:30px; margin-bottom:30px; width:100px;" class="btn btn-danger" onclick="memberCheck(this)">다음</button>
</c:if>

<c:if test="${not empty dto.oauth}">
	<form action="../member/kakaodelete" method="post" onsubmit="return kakaoCheck(this)">
		<input type="hidden" name="num" value="${dto.num }">
		<button type="submit" style="margin-top:30px; margin-bottom:30px; width:100px;" class="btn btn-danger">탈퇴</button>
	</form>
</c:if>

</div>






















