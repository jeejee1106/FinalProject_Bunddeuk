<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<link rel="stylesheet" type="text/css" href="/css/project-community.css">
<div class="container2">
	<c:choose>
		<c:when test="${sessionScope.loginok == 'yes'}">
			<div class="comment-container">
				<form id="comment" action="../comment/insert" method="post">
					<textarea name="content" class="comment" placeholder="커뮤니티가 더 훈훈해지는 댓글을 남겨주세요."></textarea>
					<div class="btn-container">
						<span class="count-content countLength">0</span><span class="countLength">/500</span>
						<button type="button" class="base-btn btn-loc send-btn">등록</button>
					</div>
				</form>
			</div>
		</c:when>
		<c:otherwise>
			<div class="comment-container logout-comment" style="color:gray; padding-top:25px;">
				따뜻한 댓글 작성을 위해 <a id='loginLink' href='../login/main'>로그인</a>을 해주세요 <span class='heart'><i class="fa fa-heart"></i></span>
			</div>
		</c:otherwise>
	</c:choose>
	<div id = 'option-container'>
		<span class ='cnt-comment'><i class="fa fa-commenting-o" aria-hidden="true"></i>  댓글 <span class="cnt-comment commentCount">0</span>개 </span>
		<span class ='order-asc'>등록순</span>
		<span class = 'order-desc'>최신순</span>
		<input type="hidden" class='comment-order' value='1'>
	</div>
	<div class = "comment-list"></div>
	<form class="to-profile" action="/profile2" method = "post">
		<input id="profileId" type="hidden" name="id">
	</form>
</div>
<input type="hidden" id="loginUser"name="writer" value="${sessionScope.sessionId}">
<input type="hidden" id="sessionScope" value="${sessionScope.loginok}">
<input type="hidden" name="pnum" id="pnum" value="${projectDto.idx}"> 
<input type="hidden" id="creator-id" value="${projectDto.id}">