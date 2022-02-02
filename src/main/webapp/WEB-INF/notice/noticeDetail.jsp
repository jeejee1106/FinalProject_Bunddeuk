<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!-- 공지사항 디테일 -->

<link rel="stylesheet" type="text/css" href="/css/notice.css">

<script type="text/javascript">
$(function(){
	$(".delete").click(function() {
		var a = confirm("공지사항을 삭제하시겠습니까?");
		if(a == true) {
			location.href='/notice/delete?num='+${ndto.num}+'&currentPage='+${currentPage};
		}
	});
});
</script>

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

<!-- 디테일 -->
<div class="Detail_Container">
	<div class="Detail-notice">
		<header>
			<span class="group">공지사항</span>
			<h3>${ndto.subject }</h3>
			<span class="date"><fmt:formatDate value="${ndto.writeday }" pattern="yyyy-MM-dd HH:mm:ss"/></span>
		</header>
		<div class="content">
			${ndto.content }
		</div>
	</div>
	<ul class="Detail_SubNav">
	<c:if test="${before.num != null}">
		<li>
			<b>이전글</b>
			<button type="button" onclick="location.href='/notice/detail?num=${before.num }'">
					<em>공지사항</em>${before.subject }
			</button>
		</li>
	</c:if>
	<c:if test="${after != null}">
		<li>
			<b>다음글</b>
			<button type="button" onclick="location.href='/notice/detail?num=${after.num }'">
				<em>공지사항</em>${after.subject }
			</button>
		</li>
	</c:if>
	</ul>
	<div class="btn-wrap">
		<button class="list_back" onclick="location.href='/notice?currentPage=${currentPage}'">목록으로 돌아가기</button>
		<c:if test="${sessionScope.loginok == 'yes' and sessionScope.id == 'admin' }">
			<button class="update" onclick="location.href='/notice/updateform?num=${ndto.num}&currentPage=${currentPage}'">수정하기</button>
			<button class="delete">삭제하기</button>
		</c:if>
	</div>
</div>