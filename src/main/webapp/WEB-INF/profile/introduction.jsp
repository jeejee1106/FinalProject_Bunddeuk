<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 소개 -->

<link rel="stylesheet" type="text/css" href="/css/profile.css">

<!-- 메뉴 -->
<div class="container">

	<div class="header-profile">
	
		<div class="container-user">
 				<div class="user-photo" style="width: 100px; height: 100px;">
					<c:if test="${dto.photo == null}">
		    			<img class="img1" src="../../profile_image/basic.jpg"/>
		    		</c:if>
		    		<c:if test="${dto.photo != null}">
		    			<img class="img1" src="../../profile_image/${dto.photo }"/>
		    		</c:if>
	    		</div>
				<div class="a">
					<div class="user-name">
							<span>${dto.name }</span>
						<c:if test="${sessionScope.id == dto.id }">
							<a class="user-info" href="/setting/main">
								<div name="setting">
									<img src="${root }/image/settings.png">
								</div>
							</a>
						</c:if>
					</div>
				</div>
		</div>
		
		<div class="container-tab">
			<div class="tab-warpper">
			<c:if test="${ sessionScope.id != 'admin'}">
				<div class="tab-warpper-in">
					<span class="tab current">
						<div class="link-wrapper">
							<a href="/profile" class="select">소개</a>
						</div>
					</span>
					<span class="tab">
						<div class="link-wrapper">
							<a href="/profile/${sessionScope.url}/backed">후원한 프로젝트 </a>
						</div>
					</span>
					<span class="tab">
						<div class="link-wrapper">
							<a href="/profile/${sessionScope.url}/created">올린 프로젝트
							</a>
						</div>
					</span>
					<span class="tab">
						<div class="link-wrapper">
							<a href="/profile/${sessionScope.url}/liked">관심프로젝트 </a>
						</div>
					</span>
					<c:if test="${sessionScope.id == dto.id }">
						<span class="tab">
							<div class="link-wrapper">
								<a href="/message/receivedMessage">문의 메세지 </a>
							</div>
						</span>
						</c:if>
						<c:if test="${sessionScope.loginok == 'yes'}">
						<c:if test="${dto.id != sessionScope.id}">
							<span class="tab">
								<div class="link-wrapper">
									<a class='personal-chat'>채팅 </a>
								</div>
							</span>
						</c:if>
						</c:if>
					</div>
			</c:if>
			<!-- 관리자 -->
			<c:if test="${sessionScope.id == 'admin' && sessionScope.loginok == 'yes'}">
				<div class="tab-warpper-in">
					<span class="tab current">
						<div class="link-wrapper">
							<a href="/admin/member_management">회원목록</a>
						</div>
					</span>
					<span class="tab">
						<div class="link-wrapper">
							<a href="/admin/project_management">프로젝트 </a>
						</div>
					</span>
				</div>
			</c:if>
			</div>
		</div>
	</div>
							<form name="popForm">
							<input type="hidden" name="id" value="${dto.id}" />
						</form>

</div>

<!-- 스크립트 -->
<script type="text/javascript">
$(function () {
   $(".personal-chat").click(function() {
      /* let num = ${num}; */
      /* var win = window.open("../chat/personalChat?num="+num, "PopupWin", "width=480,height=765 , left = 400px, top = 100px");  */
      onSubmit()
   })
})   

function onSubmit(){
 var myForm = document.popForm;
 var url = "/chat/personalChat";
 window.open("" ,"popForm","width=480,height=765 , left = 400px, top = 100px");
 myForm.action =url;
 myForm.method="post";
 myForm.target="popForm";
 myForm.submit();
}
</script>

<!-- 소개 -->
<div class="container">
	<div class="container-introduction">
	<c:choose>
		<c:when test="${sessionScope.id == id and dto.introduce == null}">
			<div class="introduction1">등록된 소개가 없습니다.</div>
		</c:when>
		<c:when test="${sessionScope.id == id and dto.introduce != null}">
			<div class="introduction2">${dto.introduce }</div>
		</c:when>
		<c:otherwise>
			<div class="introduction2">${movedto.introduce }</div>
		</c:otherwise>
	</c:choose>
<%-- 			<c:if test="${sessionScope.id == id && dto.introduce != null}">
		</c:if>
		<c:if test="${sessionScope.id != id && dto.introduce != null}">
		</c:if> --%>

	</div>

</div>