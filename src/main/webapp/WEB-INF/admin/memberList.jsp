<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!-- admin 회원관리 리스트 페이지 -->

<link rel="stylesheet" type="text/css" href="/css/profile.css">
<link rel="stylesheet" type="text/css" href="/css/admin.css">

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
			<!-- 관리자 -->
			<c:if test="${sessionScope.id == 'admin' && sessionScope.loginok == 'yes'}">
				<div class="tab-warpper-in">
					<span class="tab current">
						<div class="link-wrapper">
							<a href="/admin/member_management" class="select">회원목록</a>
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

<!-- 회원리스트 -->
<div class="WarrantyFilterHeader">
	<div class="resultCounter1">
		<span>${totalCount }</span>&nbsp;명의 회원이 있습니다.
	</div>
</div>
<div class="table-container">
	<table class="table table-hover table-bordered">
		<thead>
			<tr>
				<th>아이디</th>
				<th>닉네임</th>
				<th>가입일</th>
				<th>편집</th>
			</tr>
		</thead>
		<tbody>
 			<c:if test="${totalCount == 0}">
				<tr>
				<td colspan="4">회원이 없습니다</td>
				</tr>
			</c:if>
			<c:if test="${totalCount > 0}">
				<c:forEach var="m" items="${mlist }">
						<tr>
							<td class="meminfo" a="${m.id }">${m.id }</td>
							<td class="meminfo" a="${m.id }">${m.name }</td>
							<td><fmt:formatDate value="${m.join_date }" pattern="yyyy-MM-dd"/> </td>
							<td><button type="button" class="btn btn-danger remove" num="${m.num }" myid="${m.id }">삭제</button></td>
						</tr>
				</c:forEach>
			</c:if>
		</tbody>
	</table>
	
	<!-- 페이징  -->
	<div class="pagination-wrap" style="margin: 20px auto;">
	<c:if test="${totalCount>0 }">
		<nav aria-label="Page navigation example">
			<ul class="pagination justify-content-center">
				<!-- 이전 -->
				<c:if test="${startPage>1 }">
					<li class="page-item"><a class="page-link" href="member_management?currentPage=${startPage-1}"
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
							href="member_management?currentPage=${pp}">${pp}</a></li>
					</c:if>
				</c:forEach>
				
				<!-- 다음 -->
				<c:if test="${endPage<totalPage }">
					<li class="page-item"><a class="page-link"
						href="member_management?currentPage=${endPage+1}"
						aria-label="Next"> <span aria-hidden="true">&raquo;</span>
					</a></li>
				</c:if>
			</ul>
		</nav>
	</c:if>
	</div>
	<!-- /페이징 -->
	
</div>

<script type="text/javascript">
	$(".meminfo").click(function() {
		var id = $(this).attr("a");
		//alert(id);
		location.href = "/admin/member_info?id=" + id + "&currentPage=" + ${currentPage}+"&key=memberList";
	});

	$(".remove")
			.click(
					function() {
						var num = $(this).attr("num");
						var myid = $(this).attr("myid");
						//alert(num);
						if (myid == 'admin') {
							alert("관리자는 삭제할수 없습니다.")
						} else {
							var a = confirm("회원을 삭제하시겠습니까?");
							if (a == true) {
								var quary = {"num" : num};

								$.ajax ({
									type : "get",
									url : "member_info_delete",
									data : quary,
									dataType : "text",
									success : function(data) {
										//alert("회원삭제 성공!");
										location.href = "/admin/member_management?currentPage=" + ${currentPage} +"&key=memberList";
									}, error : function() {
										alert("code = "+ request.status+ " message="+ request.responseText+ " error = " + error); // 실패 시 처리
										}
									});
							}
						}
					});
</script>
