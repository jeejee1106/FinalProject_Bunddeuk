<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- profile menu --> 

<link rel="stylesheet" type="text/css" href="/css/profile.css">

<!--  -->
<div class="container">

	<div class="header-profile">
	
		<div class="container-user">
 				<div class="user-photo">
					<c:if test="${dto.photo == null}">
		    			<img class="img1" src="../profile_image/basic.jpg"/>
		    		</c:if>
		    		<c:if test="${dto.photo != null}">
		    			<img class="img1" src="../../profile_image/${dto.photo }"/>
		    		</c:if>
	    		</div>
<%--  				<div class="user-photo" style="width: 100px; height: 100%;">
					<img src="${root }/img/core-img/user.svg">
				</div> --%>
				<div class="a">
					<div class="user-name">
						<span>${name }</span>
						<c:if test="${sessionScope.id == id }">
							<a class="user-info" href="/setting/main">
								<div name="setting">
									<img src="${root }/img/core-img/settings.png">
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
							<a href="/profile/${sessionScope.url}">소개</a>
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
					<c:if test="${sessionScope.id == id }">
						<span class="tab">
							<div class="link-wrapper">
								<a href="/receivedMessage">메세지 </a>
							</div>
						</span>
						<span class="tab">
							<div class="link-wrapper">
								<a href="#">채팅 </a>
							</div>
						</span>
					</c:if>
				</div>
			</c:if>
			<!-- 관리자 -->
			<c:if test="${sessionScope.id == 'admin'}">
				<div class="tab-warpper-in">
					<span class="tab current">
						<div class="link-wrapper">
							<a href="#">회원목록</a>
						</div>
					</span>
					<span class="tab">
						<div class="link-wrapper">
							<a href="#">프로젝트 </a>
						</div>
					</span>
				</div>
			</c:if>
			</div>
		</div>
	</div>

</div>
<%-- 
<div class="content introduction">
	<jsp:include page="/profile/introduction"/>
</div>
<div class="content sponsor">
	<jsp:include page="sponsoredProject.jsp"/>
</div>
<div class="content upload">
	<jsp:include page="uploadedProject.jsp"/>
</div>
<div class="content like">
	<jsp:include page="projectInterest.jsp"/>
</div>
<div class="content receiv-msg">
	<jsp:include page="receivedMessageList.jsp"/>
</div>
<div class="content sent-msg">
	<jsp:include page="sentMessageList.jsp"/>
</div> --%>