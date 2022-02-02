<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- 프로젝트 승인 관리 페이지 -->
<!-- 메뉴스타일 -->
<link rel="stylesheet" type="text/css" href="/css/profile.css">
<!-- /메뉴스타일 -->
<style>
.resultCounter1 {
    -webkit-text-size-adjust: 100%;
    -webkit-font-smoothing: antialiased;
    -webkit-box-direction: normal;
    font-family: 'SF Pro Text', 'Helvetica Neue', 'Segoe UI', Arial, 'NotoSansKR', sans-serif;
    font-weight: 400;
    color: #3d3d3d;
    font-size: 16px;
    letter-spacing: -0.02em;
    box-sizing: inherit;
    word-break: break-all;
    text-decoration: none;
    -webkit-tap-highlight-color: rgba(0,0,0,.1);
    -webkit-box-flex: 1;
    flex-grow: 1;
    line-height: 44px;
    display: flex;
    -webkit-box-align: center;
    align-items: center;
    order: 1;
    width: 57%;
    margin-top: 25px;
    margin-left: 28px;
}
.resultCounter1>span {
	-webkit-text-size-adjust: 100%;
    -webkit-font-smoothing: antialiased;
    -webkit-box-direction: normal;
    font-family: 'SF Pro Text', 'Helvetica Neue', 'Segoe UI', Arial, 'NotoSansKR', sans-serif;
    font-weight: 400;
    font-size: 16px;
    letter-spacing: -0.02em;
    word-break: break-all;
    -webkit-tap-highlight-color: rgba(0,0,0,.1);
    line-height: 44px;
    box-sizing: inherit;
    color: rgb(255, 87, 87);
}
.title, .aprvl, .refusal {
	cursor: pointer;
}
.table-container {
    -webkit-text-size-adjust: 100%;
    -webkit-font-smoothing: antialiased;
    -webkit-box-direction: normal;
    font-family: 'SF Pro Text', 'Helvetica Neue', 'Segoe UI', Arial, 'NotoSansKR', sans-serif;
    font-weight: 400;
    color: #3d3d3d;
    font-size: 16px;
    line-height: 27px;
    letter-spacing: -0.02em;
    box-sizing: inherit;
    word-break: break-all;
    text-decoration: none;
    -webkit-tap-highlight-color: rgba(0,0,0,.1);
    width: 1080px;
    margin: 0px auto;
    overflow-x: hidden;
    padding: 14px 24px 24px;
    display: flex;
    flex-wrap: wrap;
}
.wait {
	color: #FF523B;
}
.pagination .page-item:first-child {
	margin-right: 0px;
}
.pagination .page-item:last-child {
    margin-left: 0px;
}
</style>

<!-- 스크립트 -->
<script type="text/javascript">
$(function(){
	
	$(".aprvl").click(function() {
		var idx = $(this).attr("idx");
		//alert(idx);
		var a = confirm("승인 하시겠습니까?");
 		if (a == true) {
			var quary = {"idx": idx};
			
			$.ajax ({
				type: "get",
				url: "project_aprvl",
				data: quary,
				dataType: "text",
				success: function(data) {
					//alert("승인");
					location.reload();
				},
				error: function(){
					alert("code = "+ request.status + " message = " + request.responseText + " error = " + error); // 실패 시 처리
				}
			});
		}
	});

	$(".refusal").click(function() {
		var idx = $(this).attr("idx");
		//alert(idx);
		var a = confirm("승인거부 하시겠습니까?");
 		if (a == true) {
			var quary = {"idx": idx};
			
			$.ajax ({
				type: "get",
				url: "project_refusal",
				data: quary,
				dataType: "text",
				success: function(data) {
					//alert("반려됨");
					location.reload();
				},
				error: function(){
					alert("code = "+ request.status + " message = " + request.responseText + " error = " + error); // 실패 시 처리
				}
			});
		}
	});
	
});

$(document).on("click", "td.title", function() {
	var idx = $(this).attr("idx");
	//alert(idx);
	$.ajax ({
		type: "get",
		dataType: "text",
		data: {"idx": idx},
		url: "audit_detail",
		success: function(data) {
			//alert(idx+" 디테일로 이동");
			location.href="/admin/audit_detail?idx=" + idx + "&currentPage=" + ${currentPage} + "&key=projectList";
		}
	});
});

</script>

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
						<c:if test="${sessionScope.id == id }">
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
							<a href="/admin/project_management" class="select">프로젝트 </a>
						</div>
					</span>
				</div>
			</c:if>
			</div>
		</div>
	</div>
							<form name="popForm">
							<input type="hidden" name="id" value="${id}" />
						</form>

</div>

<!-- 리스트 -->
	<div class="WarrantyFilterHeader">
		<div class="resultCounter1">
			총&nbsp;${totalCount}&nbsp;개 중&nbsp;<span>${count }</span>&nbsp;건의 대기중인 프로젝트가 있습니다.
		</div>
	</div>
	<div class="table-container">
		<table class="table table-hover">
			<thead>
				<tr>
					<th>번호</th>
					<th>카테고리</th>
					<th>프로젝트명</th>
					<th>창작자명</th>
					<th>시작일</th>
					<th colspan="2">심사여부</th>
				</tr>
			</thead>
			<tbody>
			<c:if test="${totalCount == 0 }">
				<td colspan="6" style="text-align: center;">등록된 프로젝트가 없습니다.</td>
			</c:if>
				<c:forEach var="p" items="${list }">
					<c:if test="${totalCount > 0}">
					<tr>
						<td idx="${p.idx }">${p.idx }</td>
						<td>${p.category }</td>
						<td class="title" idx="${p.idx }">${p.title }</td>
						<td>${p.name }</td>
						<td>${p.start_date }</td>
						<td>
							<c:choose>
								<c:when test="${p.audit == 1}">
									<b class="wait">대기</b>
								</c:when>
								<c:when test="${p.audit == 2}">
									반려
								</c:when>
								<c:when test="${p.audit == 3}">
									승인
								</c:when>
							</c:choose>
						<td>
							<c:if test="${p.audit == 1}">
							<div class="btn-group">
								<button type="button" class="btn btn-success dropdown-toggle btn-xs" data-toggle="dropdown">
									승인/반려 <span class="caret"></span>
								</button>
								<ul class="dropdown-menu" role="menu">
									<li class="aprvl" idx="${p.idx }">승인</li>
									<li class="refusal" idx="${p.idx }">반려</li>
								</ul>
							</div>
							</c:if>
						</td>
					</tr>
					</c:if>
				</c:forEach>
			</tbody>
		</table>
			<!-- 페이징  -->
	<div class="pagination-wrap" style="margin: 20px auto;">
	<c:if test="${totalCount>0 }">
		<nav aria-label="Page navigation example">
			<ul class="pagination justify-content-center">
				<!-- 이전 -->
				<c:if test="${startPage>1 }">
					<li class="page-item"><a class="page-link" href="project_management?currentPage=${startPage-1}"
						aria-label="Previous"> <span aria-hidden="true">&laquo;</span></a>
					</li>
				</c:if>

				<c:forEach var="pp" begin="${startPage}" end="${endPage}">
					<c:if test="${currentPage==pp}">
						<li class="page-item active"><a class="page-link"
							href="project_management?currentPage=${pp}">${pp}</a></li>
					</c:if>
					<c:if test="${currentPage!=pp}">
						<li class="page-item"><a class="page-link"
							href="project_management?currentPage=${pp}">${pp}</a></li>
					</c:if>
				</c:forEach>
				
				<!-- 다음 -->
				<c:if test="${endPage<totalPage }">
					<li class="page-item"><a class="page-link"
						href="project_management?currentPage=${endPage+1}"
						aria-label="Next"> <span aria-hidden="true">&raquo;</span>
					</a></li>
				</c:if>
			</ul>
		</nav>
	</c:if>
	</div>
	<!-- /페이징 -->
	</div>
