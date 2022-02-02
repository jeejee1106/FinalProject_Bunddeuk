<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!-- 회원관리 정보디테일 -->

<link rel="stylesheet" type="text/css" href="/css/admin.css">

<script type="text/javascript">
$(function(){
	$(".aprvlButton").click(function() {
		var num = $(this).attr("num");
		var myid = $(this).attr("myid");
		//alert(num);
		if(myid == 'admin') {
			alert("관리자는 삭제할수 없습니다.");
		} else {
			var a = confirm("회원을 삭제하시겠습니까?");
			if(a == true) {
				var quary = {"num" : num};
				
				$.ajax ({
					type: "get",
					url: "member_info_delete",
					data: quary,
					dataType: "text",
					success: function(data) {
						//alert("회원삭제 성공!");
						location.href="/admin/member_management?currentPage=" + ${currentPage};
					},
					error: function(){
						alert("code = "+ request.status + " message = " + request.responseText + " error = " + error); // 실패 시 처리
					}
				});
			}
		}
	});
});
</script>

<!-- detail -->
	<div class="Header">
		<div class="HeaderWrap">
			<a class="HeaderLeft" href="/admin/member_management?currentPage=${currentPage}">
				<div name="arrow3-left" class="Icon__SVGICON-sc-1xkf9cp-0 ccxeYs style__icon-sc-1dvdb02-3 ggMYrs">
					<img src="../../image/icon-backwards.png" class="backwards">
				</div>
				<span>목록</span>
			</a>
		</div>
	</div>

<div class="Container">
	<section class="ProjectIntroWrapper">
		<div class="inner" style="align-items: start;">
			<div class="ImgArea">
					<c:if test="${mdto.photo == null}">
		    			<img class="img1" src="../../profile_image/basic.jpg"/>
		    		</c:if>
		    		<c:if test="${mdto.photo != null}">
		    			<img class="img1" src="../../profile_image/${mdto.photo }"/>
		    		</c:if>
			</div>
			<div class="ProjectInfo">
				<span class="intro">회원번호 : ${mdto.num }</span>
				<h3 class="title">${mdto.name }</h3>
					<button class="aprvlButton" num="${mdto.num }" myid="${mdto.id }">
						<div class="text">삭제</div>
					</button>
				<div class="auditWrap">
				</div>						
			</div>
		</div>
	</section>
	<div class="ProjectContents">
		<div class="StoryWrap">
			<div id="purpose" class="StorySection">
				<div class="StorySectionTitle">아이디</div>
				<div class="storyContent">
					<p>${mdto.id }</p>
				</div>
			</div>
			<div id="budget" class="StorySection">
				<div class="StorySectionTitle">이름</div>
				<div class="storyContent">
					<p>${mdto.name }</p>
				</div>
			</div>
			<div id="schedule" class="StorySection">
				<div class="StorySectionTitle">사용자(URL)</div>
				<div class="storyContent">
					<p>${mdto.url }</p>
				</div>
			</div>
			<div id="introducation" class="StorySection">
				<div class="StorySectionTitle">이메일</div>
				<div class="storyContent">
					<p>${mdto.email }</p>
				</div>
			</div>
			<div id="rewardDescription" class="StorySection">
				<div class="StorySectionTitle">연락처</div>
				<div class="storyContent">
					<p>${mdto.hp }</p>
				</div>
			</div>
			<div id="refundExchangePolicy" class="StorySection">
				<div class="StorySectionTitle">가입일</div>
				<div class="storyContent">
					<p><fmt:formatDate value="${mdto.join_date }" pattern="yyyy-MM-dd"/></p>
				</div>
			</div>
		</div>
	</div>
</div>