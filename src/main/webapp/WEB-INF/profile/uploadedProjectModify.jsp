<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!-- 올린 프로젝트 관리 -->
<link rel="stylesheet" type="text/css" href="/css/project-modify.css">

<!--  -->
<div class="TopContents">
	<div class="Header">
		<div class="HeaderWrap">
			<a class="HeaderLeft" href="/profile/${sessionScope.url }/created">
				<div name="arrow3-left" class="Icon__SVGICON-sc-1xkf9cp-0 ccxeYs style__icon-sc-1dvdb02-3 ggMYrs">
					<svg viewBox="0 0 48 48">
						<path fill-rule="evenodd" clip-rule="evenodd" d="M43.7014 21.7189L10.1221 21.7189L25.2128 7.06878C26.1112 6.15946 26.2122 4.64393 25.3127 3.73461C24.4133 2.82529 22.9142 2.72425 22.0148 3.63357L2.72663 22.4262C1.82719 23.3355 1.72725 24.75 2.62669 25.7604H2.72663L22.0148 44.4519C22.9142 45.2602 24.4133 45.1592 25.2128 44.2499C26.0123 43.3405 26.0123 41.926 25.1119 41.0167L10.0221 26.4676L43.7014 26.4676C45.0006 26.4676 46 25.4572 46 24.1438C46 22.8303 45.0006 21.7189 43.7014 21.7189Z"></path>
					</svg>
				</div>
				<span>내가 만든 프로젝트</span>
			</a>
		</div>
	</div>


	<div class="TopContentsWrap">
		<div class="TopContentsCenter">
			<div class="ButtonsWrap">
			</div>
			<div class="ProjectContents">
			<c:if test="${pdto.thumbnail == null}">
				<div class="ProjectThumbnail"></div>
			</c:if>
			<c:if test="${pdto.thumbnail != null}">
				<div class="ProjectThumbnail">
					<img src="../../thumbnail_image/${pdto.thumbnail }"/>
				</div>
			</c:if>
				<div>
					<p class="ProjectTitle">
						<strong>${pdto.name}의 프로젝트</strong>
					</p>
					<p class="ProjectCategory">
						${pdto.category} · ${pdto.name}
					</p>
				</div>
			</div>
		</div>
	</div>
	
	
	
	<!-- button -->
	<div class="PlanTabs">
		<div class="PlanTabsWrap" width="81">
			<ul>
				<li class="TabItem kzulTK">
					<a class="plan" href="/profile/${sessionScope.url }/created_management?idx=${pdto.idx }">프로젝트 기획</a>
				</li>
				<li class="TabItem dQomJa">
					<a class="" >공개예정
						<div name="beta-line" class="Icon__SVGICON-sc-1xkf9cp-0 ccxeYs betaIcon">
							<svg viewBox="0 0 48 48">
								<path d="M7.55325 15C8.57454 15 9.47526 15.1616 10.2554 15.4848C11.0497 15.7934 11.6739 16.2635 12.1278 16.8953C12.5817 17.5123 12.8086 18.291 12.8086 19.2313C12.8086 20.2891 12.5391 21.1339 12.0001 21.7657C11.4753 22.3828 10.7306 22.7721 9.76605 22.9337V22.9998C10.9717 23.1468 11.915 23.5508 12.5959 24.2119C13.2909 24.8731 13.6384 25.8721 13.6384 27.2091C13.6384 28.7518 13.1774 29.9492 12.2554 30.8013C11.3334 31.6535 10.0994 32.0795 8.55327 32.0795C7.17736 32.0795 6.04969 31.8518 5.17025 31.3964V34H2V20.0688C2 18.8787 2.24114 17.9164 2.72341 17.1818C3.21987 16.4325 3.88655 15.8815 4.72344 15.5289C5.56032 15.1763 6.5036 15 7.55325 15ZM7.46815 17.5564C7.0568 17.5564 6.67381 17.6372 6.3192 17.7988C5.96458 17.9605 5.68089 18.2469 5.46812 18.6583C5.26954 19.055 5.17025 19.628 5.17025 20.3773V28.7077C5.52486 28.9428 5.94331 29.1264 6.42558 29.2587C6.90786 29.3909 7.34758 29.457 7.74475 29.457C8.62419 29.457 9.27668 29.2366 9.70222 28.7959C10.1419 28.3404 10.3618 27.716 10.3618 26.9226C10.3618 26.0117 10.0994 25.3799 9.57455 25.0273C9.04973 24.6747 8.41142 24.4984 7.65964 24.4984H6.91495V21.8979H7.46815C8.21993 21.8979 8.76604 21.6922 9.10646 21.2809C9.46108 20.8548 9.63838 20.3038 9.63838 19.628C9.63838 18.9375 9.4398 18.4233 9.04263 18.0853C8.64547 17.7327 8.12064 17.5564 7.46815 17.5564Z"></path>
								<path d="M21.2376 32.1677C22.727 32.1677 24.2376 31.6388 25.4078 30.8013L24.344 28.8179C23.4929 29.3688 22.6419 29.6774 21.6631 29.6774C19.8971 29.6774 18.6205 28.6196 18.3652 26.592H25.7057C25.7908 26.3056 25.8547 25.7105 25.8547 25.1155C25.8547 21.6996 24.1525 19.2093 20.8759 19.2093C18.0248 19.2093 15.3226 21.6996 15.3226 25.7105C15.3226 29.7655 17.9184 32.1677 21.2376 32.1677ZM18.3227 24.4543C18.5567 22.6472 19.6631 21.7216 20.9184 21.7216C22.4504 21.7216 23.1738 22.7795 23.1738 24.4543H18.3227Z"></path>
								<path d="M32.5427 32.1677C33.5853 32.1677 34.4151 31.9253 35.0534 31.7049L34.5428 29.3468C34.2236 29.479 33.7555 29.6113 33.3725 29.6113C32.3087 29.6113 31.7555 28.9501 31.7555 27.5397V22.0742H34.6917V19.5178H31.7555V16.2121H29.1384L28.7767 19.5178L26.9469 19.6721V22.0742H28.6278V27.5397C28.6278 30.3165 29.7129 32.1677 32.5427 32.1677Z"></path>
								<path d="M39.5531 32.1677C40.9148 32.1677 42.1063 31.4625 43.1489 30.5369H43.2127L43.4468 31.8592H46V24.6527C46 21.0825 44.4468 19.2093 41.4255 19.2093C39.5531 19.2093 37.851 19.9365 36.4467 20.8401L37.5744 22.9778C38.6808 22.3167 39.7446 21.8098 40.851 21.8098C42.3191 21.8098 42.8298 22.7354 42.8723 23.9475C38.085 24.4764 36.0212 25.8648 36.0212 28.5094C36.0212 30.603 37.4254 32.1677 39.5531 32.1677ZM40.5744 29.6333C39.6595 29.6333 38.9999 29.2146 38.9999 28.2449C38.9999 27.143 39.9787 26.3276 42.8723 25.9309V28.4212C42.1276 29.1925 41.468 29.6333 40.5744 29.6333Z"></path></svg>
						</div>
					</a>
				</li>
				<li class="TabItem dQomJa">
					<a target="_blank" class="disabled">대시보드
						<div name="locked-solid" class="Icon__SVGICON-sc-1xkf9cp-0 ccxeYs">
							<svg viewBox="0 0 48 48">
								<path fill-rule="evenodd" clip-rule="evenodd" d="M15 17H9.2C9.08954 17 9 17.0895 9 17.2V40.8C9 40.8 9.08954 41 9.2 41H38.8C38.9105 41 39 40.9105 39 40.8V17.2C39 17.0895 38.9105 17 38.8 17H33V13C33 8.02944 28.9706 4 24 4C19.0294 4 15 8.02943 15 13V17ZM20.6 17H27.4V13C27.4 11.1222 25.8778 9.6 24 9.6C22.1222 9.6 20.6 11.1222 20.6 13V17Z"></path></svg>
						</div>
					</a>
				</li>
				<li class="TabItem dQomJa">
					<a target="_blank" class="disabled">서베이
						<div name="locked-solid" class="Icon__SVGICON-sc-1xkf9cp-0 ccxeYs">
							<svg viewBox="0 0 48 48">
								<path fill-rule="evenodd" clip-rule="evenodd" d="M15 17H9.2C9.08954 17 9 17.0895 9 17.2V40.8C9 40.8 9.08954 41 9.2 41H38.8C38.9105 41 39 40.9105 39 40.8V17.2C39 17.0895 38.9105 17 38.8 17H33V13C33 8.02944 28.9706 4 24 4C19.0294 4 15 8.02943 15 13V17ZM20.6 17H27.4V13C27.4 11.1222 25.8778 9.6 24 9.6C22.1222 9.6 20.6 11.1222 20.6 13V17Z"></path></svg>
						</div>
					</a>
				</li>
				<li class="TabItem dQomJa">
				<c:if test="${pdto.audit == 3}">
					<a class="disabled sponsor" href="/profile/${sessionScope.url }/created_sponsorlist?idx=${pdto.idx }">후원자 관리
						<div name="locked-solid" class="Icon__SVGICON-sc-1xkf9cp-0 ccxeYs">
						</div>
					</a>
				</c:if>
				<c:if test="${pdto.audit != 3}">
					<a class="disabled sponsor">후원자 관리
						<div name="locked-solid" class="Icon__SVGICON-sc-1xkf9cp-0 ccxeYs">
							<svg viewBox="0 0 48 48">
								<path fill-rule="evenodd" clip-rule="evenodd" d="M15 17H9.2C9.08954 17 9 17.0895 9 17.2V40.8C9 40.8 9.08954 41 9.2 41H38.8C38.9105 41 39 40.9105 39 40.8V17.2C39 17.0895 38.9105 17 38.8 17H33V13C33 8.02944 28.9706 4 24 4C19.0294 4 15 8.02943 15 13V17ZM20.6 17H27.4V13C27.4 11.1222 25.8778 9.6 24 9.6C22.1222 9.6 20.6 11.1222 20.6 13V17Z"></path></svg>
						</div>
					</a>
				</c:if>
				</li>
				<li class="TabItem dQomJa">
					<a target="_blank" class="disabled">모금액 명세
						<div name="locked-solid" class="Icon__SVGICON-sc-1xkf9cp-0 ccxeYs">
							<svg viewBox="0 0 48 48">
								<path fill-rule="evenodd" clip-rule="evenodd" d="M15 17H9.2C9.08954 17 9 17.0895 9 17.2V40.8C9 40.8 9.08954 41 9.2 41H38.8C38.9105 41 39 40.9105 39 40.8V17.2C39 17.0895 38.9105 17 38.8 17H33V13C33 8.02944 28.9706 4 24 4C19.0294 4 15 8.02943 15 13V17ZM20.6 17H27.4V13C27.4 11.1222 25.8778 9.6 24 9.6C22.1222 9.6 20.6 11.1222 20.6 13V17Z"></path></svg>
						</div>
					</a>
				</li>
			</ul>
		</div>
	</div>
</div>

<div class="common-Layer"></div>

<jsp:include page="uploadedProjectModify2.jsp"/>
