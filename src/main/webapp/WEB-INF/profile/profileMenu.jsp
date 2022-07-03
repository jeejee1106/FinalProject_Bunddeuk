<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- profile menu --> 
<link rel="stylesheet" type="text/css" href="/css/profile.css">

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
			<div class="a">
				<div class="user-name">
					<span>${name }</span>
					<c:if test="${sessionScope.sessionId == id }">
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
				<c:if test="${ sessionScope.sessionId != 'admin'}">
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
						<c:if test="${sessionScope.sessionId == id }">
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
				<c:if test="${sessionScope.sessionId == 'admin'}">
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