<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!-- 후원한 프로젝트 -->

<link rel="stylesheet" type="text/css" href="/css/profile.css">

<!-- 스크립트 -->
<script type="text/javascript">
$(function () {
   $(".personal-chat").click(function() {
      /* let num = ${num}; */
      /* var win = window.open("../chat/personalChat?num="+num, "PopupWin", "width=480,height=765 , left = 400px, top = 100px");  */
      onSubmit()
      
      
   });
});

function onSubmit(){
 var myForm = document.popForm;
 var url = "/chat/personalChat";
 window.open("" ,"popForm","width=480,height=765 , left = 400px, top = 100px");
 myForm.action =url;
 myForm.method="post";
 myForm.target="popForm";
 myForm.submit();
}
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
			<c:if test="${ sessionScope.id != 'admin'}">
				<div class="tab-warpper-in">
					<span class="tab current">
						<div class="link-wrapper">
							<a href="/profile/${sessionScope.url}">소개</a>
						</div>
					</span>
					<span class="tab">
						<div class="link-wrapper">
							<a href="/profile/${sessionScope.url}/backed" class="select">후원한 프로젝트 </a>
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
					<c:if test="${sessionScope.id == dto.id }">
						<span class="tab">
							<div class="link-wrapper">
								<a href="/message/receivedMessage">문의 메세지 </a>
							</div>
						</span>
						</c:if>
					<c:if test="${sessionScope.loginok == 'yes'}">
						<c:if test="${dto.id != sessionScope.id}">
							<span class="tab">
								<div class="link-wrapper">
									<a class='personal-chat'>채팅 </a>
								</div>
							</span>
						</c:if>
					</c:if>
					</div>
			</c:if>
			<!-- 관리자 -->
<%-- 			<c:if test="${sessionScope.id == 'admin'}">
				<div class="tab-warpper-in">
					<span class="tab current">
						<div class="link-wrapper">
							<a href="#">회원목록</a>
						</div>
					</span>
					<span class="tab">
						<div class="link-wrapper">
							<a href="/profile/${sessionScope.url}/admin/project_management">프로젝트 </a>
						</div>
					</span>
				</div>
			</c:if> --%>
			</div>
		</div>
	</div>
							<form name="popForm">
							<input type="hidden" name="id" value="${dto.id}" />
						</form>

</div>

<!-- 후원한 리스트 없을때 -->
<c:if test="${count == 0 || dto.privacy == 1 }">
	<div class="ProjectListWithCard">
		<div class="Container__ContainerComponent">
			<div class="NoResultWrapper">
				<div name="like-line" class="Icon__SVGICON-sc-1xkf9cp-0 ccxeYs Liked__StyledSVGIcon-sc-1ie8qjp-6 fUVLV">
 					<svg viewBox="0 0 48 48">
						<path fill-rule="evenodd" clip-rule="evenodd" d="M23.8992 40.8274L23.6243 40.5553C22.7996 39.7389 21.8834 39.0133 21.0587 38.2876C20.4173 37.7434 19.7759 37.1991 19.1345 36.6549L19.0429 36.5642C15.0112 33.2987 11.5294 29.8518 8.41399 26.4049C6.21491 23.9558 4.93211 20.781 4.84048 17.5155C4.84048 14.7035 5.84839 11.9823 7.58933 9.89602C9.23864 8.08186 11.621 6.99336 14.1866 6.99336C16.1108 6.99336 17.8517 7.53761 19.2261 8.71681C20.234 9.62389 20.8754 10.3496 21.4252 11.0752C21.975 11.8916 22.8913 12.3451 23.8992 12.3451C24.9071 12.3451 25.8234 11.8009 26.3731 10.9845C26.8313 10.2588 27.5643 9.53319 28.389 8.89823C29.9467 7.71903 31.7792 7.08407 33.6118 7.08407C36.0858 7.08407 38.5597 8.17257 40.209 9.98673C42.1332 12.073 43.0495 14.7035 42.8663 17.6062C42.7746 20.781 41.4918 23.9558 39.2011 26.4956C35.9025 30.3053 32.4206 33.5708 28.7555 36.6549L28.6639 36.7456C28.2057 37.1991 27.6559 37.6527 27.0145 38.1969C26.1899 38.9226 25.182 39.7389 24.2657 40.646L23.8992 40.8274ZM30.6797 38.9226C34.6197 35.7478 38.1932 32.2102 41.5835 28.4004C44.3323 25.4071 45.89 21.5973 45.9816 17.6062C46.1649 13.9779 44.9737 10.6217 42.5914 7.90044C40.3923 5.36062 37.0937 4 33.795 4C31.3211 4 28.7555 4.90708 26.7397 6.35841C25.7317 7.17478 24.7238 8.17257 23.9908 9.26106C23.1662 8.17257 22.2499 7.26549 21.242 6.35841C19.2261 4.72566 16.8438 4 14.1866 4C10.888 4.09071 7.68096 5.45133 5.48188 7.99115C3.19117 10.7124 2 14.0686 2 17.6062C2.09163 21.5973 3.55768 25.4978 6.30653 28.4911C9.60515 32.3009 13.3619 35.7478 17.2103 39.0133C18.4931 40.1925 20.1424 41.5531 21.6085 42.9137L23.8992 45L26.1899 42.9137C27.8392 41.281 29.3969 40.0111 30.6797 38.9226Z"></path>
					</svg>
				</div>
				<div class="TextWrapper">
					후원한 프로젝트가 없습니다.
				</div>
			</div>
		</div>
	</div>
</c:if>
<!-- /후원한 리스트 없을때 -->


<!-- 후원한 리스트 있을때 -->
<c:if test="${count>0 && dto.privacy != 1 }">
<div class="ContainerComponent">
	<div class="WarrantyFilterHeader">
		<div class="resultCounter">
			<span class="s_count">${count }</span>건의 후원 내역이 있습니다.
		</div>
	</div>
	<div class="ResultWrapper">
		<div class="ListWrapper">
			<div class="RoundedWrapper">
			<c:forEach var="s" items="${supportLsit }">
				<div class="WarrantyCard">
					<div class="DescWrapper">
						<div class="ImageWrapper">
						<c:if test="${sessionScope.id == dto.id }">
							<a href="support_success?num=${s.num }">
								<img src="../../thumbnail_image/${s.thumbnail }" style="">
							</a>
						</c:if>
						<c:if test="${sessionScope.id != dto.id }">
							<a>
								<img src="../../thumbnail_image/${s.thumbnail }">
							</a>
						</c:if>
						</div>
						<div class="DateWithWarrantyNumber">
							후원일 ${s.support_date }<span>|</span>후원번호 ${s.num }
						</div>
						<div class="WarrantyCard-Title">
							<c:if test="${sessionScope.id == dto.id }">
							<a href="support_success?num=${s.num }">${s.title }</a>
							</c:if>
							<c:if test="${sessionScope.id != dto.id }">
							<a>${s.title }</a>
							</c:if>
						</div>
						<div class="WarrantyCard-Desc">${s.present_name }</div>
						<div class="WarrantyState">
							<p class="money"><fmt:formatNumber value="${s.price }"/> 원</p>
							<p class="point date">
								<c:if test="${s.payment_status == 0}">
									결제예약
								</c:if>
								<c:if test="${s.payment_status == 1}">
									결제완료
								</c:if>
							</p> 
						</div>
					</div>
				</div>
			</c:forEach>
			</div>
		</div>
	</div>
</c:if>
<!-- /후원한 리스트 있을때 -->