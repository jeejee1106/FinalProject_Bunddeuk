<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<link rel="stylesheet" type="text/css" href="/css/project-book-detail.css">

<!-- start project main -->
<div class="totalLayout">
	<div class="book-project">
		<div class="project-intro">
			<span class="project-intro-category">${dto.category }</span>
			<h2 class="project-intro-title">${dto.title } </h2>
			<div class="creator-info">
				<span class="profile-img">
					<img alt="프로필" src="../profile_image/${creatorImage}" class="creator-image" id=${dto.id }>
				</span>
				<span class="project-intro-creator-name">${dto.name}</span>
			</div>
			<div class="creator-intro">
				${creatorIntro}
			</div>
			<div class="start-date">
				<i class="fa fa-calendar-check-o"></i><fmt:formatDate value="${dto.start_date }" pattern="yyyy년 MM월 dd일"/>
				<c:set var="time_start" value="${dto.time_start}"/>
				${fn:substring(time_start,0,2) }시 ${fn:substring(time_start,3,5) }분 공개예정
			</div>
			<div class="present-info">
				<i class="fa fa-gift" aria-hidden="true"></i>얼리버드 선물 제공
			</div>
		</div>
		<div class="project-main">
			<div class="project-main-img">
				<img alt="프로젝트 커버 이미지" src="/thumbnail_image/${dto.thumbnail}" style="width: 650px; height: 500px">
			</div>
		</div>
	</div>
</div>
<!-- end project main -->