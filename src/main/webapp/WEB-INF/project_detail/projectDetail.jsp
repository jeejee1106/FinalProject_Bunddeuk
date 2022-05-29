<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<link rel="stylesheet" type="text/css" href="/css/project-detail.css">

<input type="hidden" id="id" value="${sessionScope.sessionId}">
<input type="hidden" id="loginok" value="${sessionScope.loginok}">
<input type="hidden" id="likeCheck" value="${likeCheck}">
<input type="hidden" id="supportCheck" value="${supportCheck}">

<!-- start project main -->
<div class="container">
	<div class="project-intro">
		<span class="project-intro-category">${projectDto.category }</span>
		<h1 class="project-intro-title">${projectDto.title } </h1>
		<span class="profile-img">
			<img alt="프로필" src="../profile_image/${creatorImage}" class="creator-image" id=${projectDto.id }>
		</span>
		<span class="project-intro-creator-name">${projectDto.name}</span>
		<input type="hidden" id="creatorId" value="${projectDto.id }">
	</div>
	<div class="project-main">
		<div class="project-main-img">
			<img alt="프로젝트 커버 이미지" src="/thumbnail_image/${projectDto.thumbnail}" style="width: 650px; height: 500px">
		</div>
	</div>
	<div class="project-sub-aside">
		<div class="project-sub">
			<div class="project-sub-title">모인금액</div>
			<div>
				<span class="project-sub-value">
					<fmt:formatNumber value="${projectDto.total_amount }"/>
				</span>
				<span>원</span>
				<span class="project-sub-per">${percentageAchieved }%</span>
			</div>
		</div>
		<div class="project-sub">
			<div class="project-sub-title">남은시간</div>
			<div>
				<span class="project-sub-value">
					<fmt:parseDate value="${today}" var="strPlanDate" pattern="yyyy-MM-dd"/>
					<fmt:parseNumber value="${strPlanDate.time / (1000*60*60*24)}" integerOnly="true" var="strDate" />
					<fmt:parseDate value="${projectDto.end_date}" var="endPlanDate" pattern="yyyy-MM-dd"/>
					<fmt:parseNumber value="${endPlanDate.time / (1000*60*60*24)}" integerOnly="true" var="endDate" />
					${endDate - strDate }
				</span>
				<span>일</span>
			</div>
		</div>

		<div class="project-sub">
			<div class="project-sub-title">후원자</div>
			<div>
				<span class="project-sub-value">${projectDto.number_support }</span>
				<span>명</span>
			</div>
		</div>
		<div class="funding-info" style="background-color: #f0ffff">
			<div class="funding-info-title" style="font-weight: bold;">펀딩 진행중</div>
			<span class="funding-info-content">
				목표금액인 <fmt:formatNumber value="${projectDto.target_amount}"/> 원이 모여야만 결제됩니다.
				<br>
				결제는 ${pymDate}에 다함께 진행됩니다.
			</span>
		</div>
		<div class="project-sub">
			<span class="project-sub-heart"><i class="fa fa-heart-o"></i></span>
			<button class="btn-support">프로젝트 후원하기</button>
		</div>
	</div>
</div>
<!-- end project main -->

<!-- start project navigation -->
<nav class="content-navigation-container">
	<div class="container">
		<div class="content-navigation">
			<a class="scroll_move btn-project-plan">프로젝트 계획</a>
			<a class="scroll_move btn-project-community">커뮤니티</a>
		</div>
	</div>
</nav>
<!-- end project navigation -->

<!-- start project content -->
<div class="container project-content">
	<div class="content-main">
		<div class="project-plan">
			<jsp:include page="projectPlan.jsp" flush="false" />
		</div>
		<div class="project-community">
			<jsp:include page="projectCommunity.jsp" flush="false" />
		</div>
	</div>
	<div class="content-sub">
		<div class="sub-creator">
			<div class="sub-title creator-title">
				창작자 소개
			</div>
			<div class="creator-profile">
				<span class="profile-img">
					<img alt="프로필" src="../profile_image/${creatorImage}" class="creator-image" id=${projectDto.id }>
				</span>
				<span class="creator-name">
					${projectDto.name }
				</span>
			</div>
			<div class="creator-intro">
				${memberDto.introduce}
			</div>
			<div class="creator-message">
				<button type="button" class="btn-creator-message">
					<i class="fa fa-envelope-o"></i>창작자에게 문의
				</button>
			</div>
		</div>
		<div class="sub-present">
			<div class="sub-title present-title">
				선물 선택
			</div>
			<div class="present-option">
			<form action="payment" method="post" onsubmit="return paycheck();">
				<input type="hidden" name="idx" value="${projectDto.idx }" id="dto-idx">
				<div class="present-price">
					1,000원+
				</div>
				<div class="present-name">
					> 선물 없이 후원하기
				</div>
				<button type="submit" class="btn-present-support">
					1,000원 후원하기
				</button>
			</form>
			</div>
			<c:forEach var="presentDto" items="${presentList}">
			<form action="payment" method="post" onsubmit="return paycheck();">
				<div class="present-option">
					<input type="hidden" name="idx" value="${projectDto.idx }">
					<input type="hidden" name="pstN" value="${presentDto.present_name }">
					<input type="hidden" name="pstP" value="${presentDto.price }">
					<div class="present-price" >
						<fmt:formatNumber value="${presentDto.price }"/>원+
					</div>
					<div>
						<span class="present-name" data-pstName="${presentDto.present_name }">
							> ${presentDto.present_name }
						</span>
						<span class="present-description" >
							<c:choose>
								<c:when test="${presentDto.present_option == null}">
								</c:when>
								<c:otherwise>
									<b style="margin-left:20px; font-size:8pt; color:gray">옵션선택</b>
									<select name="pstO" id="" class="pstOption" style="width:150px;">
										<c:set var="present_option" value="${presentDto.present_option}" />
										<c:set var="splitStr" value="${fn:split(present_option, ',') }" />
										<c:forEach var="option" items="${splitStr }">
											<option value="${option}">${option}</option>
										</c:forEach>
									</select>
								</c:otherwise>
							</c:choose>
						</span>
					</div>
					<button type="submit" class="btn-present-support" data-price="${presentDto.price }">
						<fmt:formatNumber value="${presentDto.price }"/>원 후원하기
					</button>
				</div>
				</form>
			</c:forEach>
		</div>
	</div>
</div>
<!-- end project content -->

<!-- start message modal -->
<div class="container">
	<div class="message-modal">
		<div class="modal-content">
			<div class="message-title">
				<span class="message-title1">
					창작자에게 문의
				</span>
				<span class="message-title2">
					<i class="fa fa-times"></i>
				</span>
			</div>
			<div class="message-main">
				<input type="hidden" id="send_name" value="${name }">
				<table class= "table table-bordered">
					<tr>
						<td>
							받는사람
						</td>
						<td>
							<input type="text" readonly="readonly" id="recv_name" value="${projectDto.name}">
						</td>
					</tr>
					<tr>
						<td>
							문의 내용
						</td>
						<td>
							<select name="inquiry_type" id="inquiry_type">
								<option value="문의유형" selected="selected" disabled="disabled">문의유형</option>
								<option value="프로젝트">프로젝트</option>
								<option value="교환/환불">교환/환불</option>
								<option value="배송">배송</option>
								<option value="기타">기타</option>
							</select>
						</td>
					</tr>
				</table>
				<textarea style="width: 540px; height: 200px;" placeholder="프로젝트 진행자에게 문의하고 싶은 내용을 적어주세요." id="message-content" required="required"></textarea>
				<span class="word-count">0/1000</span>
				<button type="button" id="btn-send">전송</button>
			</div>
		</div>
	</div>
</div>
<!-- end message modal -->

<!-- 작가의 프로필 페이지로 이동 하기 위한 form -->
<form class="sub-profile" action="/profile2" method = "post">
	<input id="creator-id" type="hidden" name="id">
</form>

<script src="/js/project-detail.js"></script>