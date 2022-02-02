<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!-- 공지사항 리스트 -->

<link rel="stylesheet" type="text/css" href="/css/notice.css">

<!-- 공지사항 타이틀 -->
<div class="Notices_SettingTitle">
	<div class="Container__ContainerComponent">
		<span class="fnt-lt">공지사항</span>
	</div>
	<div class="Container__TabContainerComponent">
		<div class="TabContainer">
		</div>
	</div>
</div>
<!-- /공지사항 타이틀 -->
<!-- 리스트 -->
<div class="Container_list">
	<div class="list-wrapper">
		<ul class="List_StyledList">
		<c:if test="${totalCount == 0}">
		<li style="margin-right:100px; text-align: center;">
		<span class="title-box">
		<span class="title" style="text-decoration: none; margin-top: 30px;">
		등록된 공지사항이 없습니다
		</span>
		</span>
		</li>
		</c:if>
		<c:if test="${totalCount >0}">
			<c:forEach var="n" items="${noticeList }">
			<li class="">
				<a href="/notice/detail?num=${n.num }&currentPage=${currentPage}&key=noticeList">
					<span class="title-box">
						<span class="group">
							공지사항<em class="empty"></em>
						</span>
						<span class="title">
							${n.subject }
						</span>
						<span class="date">
							<fmt:formatDate value="${n.writeday }" pattern="yyyy-MM-dd"/></span>
					</span>
				</a>
			</li>
			</c:forEach>
		</c:if>
		</ul>
	</div>
	<div class="btn-wrap" style="float: right;">
		<c:if test="${sessionScope.loginok == 'yes' and sessionScope.id == 'admin' }">
			<button type="button" onclick="location.href='/notice/wrtieform'" class="notice-write">글쓰기</button>
		</c:if>
	</div>
		<!-- 페이징  -->
	<div class="pagination-wrap" style="margin: 25px auto;">
	<c:if test="${totalCount>0 }">
		<nav aria-label="Page navigation example">
			<ul class="pagination justify-content-center">
				<!-- 이전 -->
				<c:if test="${startPage>1 }">
					<li class="page-item"><a class="page-link" href="notice?currentPage=${startPage-1}"
						aria-label="Previous"> <span aria-hidden="true">&laquo;</span></a>
					</li>
				</c:if>

				<c:forEach var="pp" begin="${startPage}" end="${endPage}">
					<c:if test="${currentPage==pp}">
						<li class="page-item active"><a class="page-link"
							href="notice?currentPage=${pp}">${pp}</a></li>
					</c:if>
					<c:if test="${currentPage!=pp}">
						<li class="page-item"><a class="page-link"
							href="notice?currentPage=${pp}">${pp}</a></li>
					</c:if>
				</c:forEach>
				
				<!-- 다음 -->
				<c:if test="${endPage<totalPage }">
					<li class="page-item"><a class="page-link"
						href="notice?currentPage=${endPage+1}"
						aria-label="Next"> <span aria-hidden="true">&raquo;</span>
					</a></li>
				</c:if>
			</ul>
		</nav>
	</c:if>
	</div>
	<!-- /페이징 -->

</div>
<!-- /리스트 -->
