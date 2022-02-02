<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!-- 후원자 디테일 -->

<link rel="stylesheet" type="text/css" href="/css/support-profile.css">

<script type="text/javascript">
$(function(){
	$(".intro").click(function() {
		location.href='/project/detail?idx=' + ${dto.idx };
	});
});
</script>

<!-- 후원자 정보 -->
<div class="Page">
	<section class="ProjectIntroWrapper">
		<div class="inner" style="align-items: start;">
			<div class="ImgArea">
				<a href="/project/detail?idx=${dto.idx }">
					<img src="../../thumbnail_image/${dto.thumbnail }">
				</a>
			</div>
			<div class="ProjectInfo">
				<span class="intro">${dto.category } | ${dto.title }</span>
				<h3 class="title">
					<a>후원자 id : ${dto.id }</a>
				</h3>
			</div>
		</div>
	</section>
	<div class="Container_WarrantyDetailWrapper">
		<div class="CardWrapper">
			<div class="SettingForm">
				<div class="FormHeader">
					<p class="FormTitle">후원자 정보</p>
				</div>
				<div class="RoundedWrapper">
					<table>
						<tbody>
							<tr>
								<th>후원 날짜</th>
								<td>${dto.support_date }</td>
							</tr>
							<tr>
								<th>후원 번호</th>
								<td>${dto.num }</td>
							</tr>
							<tr>
								<th>펀딩 마감일</th>
								<td>${dto.end_date }</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
		</div>
		<div class="CardWrapper">
			<div class="SettingForm">
				<div class="FormHeader">
					<p class="FormTitle">후원한 선물 정보</p>
				</div>
				<div class="RoundedWrapper">
					<table>
						<tbody>
							<tr>
								<th>선물 구성</th>
								<td>${dto.present_name }</td>
							</tr>
							<tr>
								<th>후원 금액</th>
								<td><fmt:formatNumber value="${dto.price }"/>원</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
		</div>
		<div class="CardWrapper">
			<div class="SettingForm">
				<div class="FormHeader">
					<p class="FormTitle">결제 정보</p>
				</div>
				<div class="RoundedWrapper">
					<table>
						<tbody>
							<tr>
								<th>결제 수단</th>
								<td>${dto.payment_method }</td>
							</tr>
							<tr>
								<th>결제 금액</th>
								<td><fmt:formatNumber value="${dto.price }"/>원</td>
							</tr>
							<tr>
								<th>결제 상태</th>
								<td>
								<c:if test="${dto.payment_status == 0}">
									결제예약
								</c:if>
								<c:if test="${dto.payment_status == 1}">
									결제완료
								</c:if>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
		</div>
		<div class="CardWrapper">
			<div class="SettingForm">
				<div class="FormHeader">
					<p class="FormTitle">후원자 배송 정보</p>
				</div>
				<div class="RoundedWrapper">
					<table>
						<tbody>
							<tr>
								<th>받는 사람</th>
								<td>${dto.id }</td>
							</tr>
							<tr>
								<th>연락처</th>
								<td>${dto.hp }</td>
							</tr>
							<tr>
								<th>주소</th>
								<td>${dto.addr }</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
		</div>
		<div class="btn-wrap">
			<button type="button" class="GoToWarrantyListButton"
				onclick="location.href='/profile/${sessionScope.url}/created_sponsorlist?idx=${dto.idx }&currentPage=${currentPage}'">
				후원자 목록 보기</button>
		</div>
	</div>
</div>

