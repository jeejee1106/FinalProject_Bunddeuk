<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<script>
$(document).ready(function(){
	 
    var topBar = $("#topBar").offset();
 
    $(window).scroll(function(){
        
        var docScrollY = $(document).scrollTop()
        var barThis = $("#topBar")
        var fixNext = $("#fixNextTag")
 
        if( docScrollY > topBar.top ) {
            barThis.addClass("top_bar_fix");
            fixNext.addClass("pd_top_80");
        }else{
            barThis.removeClass("top_bar_fix");
            fixNext.removeClass("pd_top_80");
        }
 
    });
    
    
     $(".kWZlUb").hover(function () {
    	$(this).css({
    		'color':'orange',
    		'font-color':'orange'
    	});
    	
    }, function() {
    	$(this).css({
    		'color':'black'
    	})
    	
    });
    $(".test4").hide();
    
  	$(".Categort").hover(function () {
	   	$(this).css({'color':'orange'	});
	   	$(".test4").slideDown(200); 
   	}, function() {
   	   	$(this).css({'color':'black'})
   	});
  	
  	$(".jxLqaO").hover(function () {
	   	$(".test4").slideUp(200); 
   	});
  		
  	$(".test4").hover(function () {
	   	$(this).css({'color':'orange'	});
	   	$(".test4").show(); 
   	}, function() {
   	$(this).css({'color':'black'})
   	$(".test4").slideUp(200); 
   });  
    
 
});
$(function() {
	$(".chat").click(function() {
	      var win = window.open("${root}/chat/list", "PopupWin", "width=480,height=765  , left = 400px, top = 100px");
	});
})
</script>

<header class="wrap">
 <div class="style__HeaderUpperLayout-zxsodr-2 jxLqaO">      
    <div class="top_bn_zone">
        <div class="style__LogoWrapper-zxsodr-3 dtkXPY">
		<a class="main-logo" href="/">
		<img class="bunddeuk" alt="" src="${root }/img/core-img/bunddeuk.png"
		style="width: 150px;">
		</a>
		
		</div>
	<!-- end 제목부분 -->
	
		<div class="style__StatusWrapper-zxsodr-4 bgpTeU">
		<c:if test="${sessionScope.loginok != null && sessionScope.id != 'admin'}">
			<div class="style__ProjectEditorButton-zxsodr-5 cfcgIZ">
				<span onclick="location.href='/project/start'">
				프로젝트 올리기
				</span>
			</div>
			<!-- 채팅 -->
			<div class="style__ButtonWrapper-zxsodr-6 hwZyFc">
				<div class="style__IconWrapper-zxsodr-30 fDDqDt">
					<span class="fa fa-comments-o chat">
					</span>
				</div>
			</div>
		</c:if>
		<c:if test="${sessionScope.loginok != null}">
			<!-- 로그아웃  -->
			<div class="style__ButtonWrapper-zxsodr-6 hwZyFc">
				<div class="lo_layout">
					<span class="fa fa-sign-out logoutLa" onclick="location.href='${root}/login/logoutprocess'">
					</span ><p onclick="location.href='${root}/login/logoutprocess'">로그아웃</p>
				</div>
			</div>
		</c:if>	
			<div class="style__UserButtonWrapper-zxsodr-9 idLbRv">
				<div class="style__UserButton-zxsodr-10 csOHNF">
					<div class="style__UserText-zxsodr-11 fXtfpK">
					<c:if test="${sessionScope.loginok != null && sessionScope.id != 'admin' }">
						<!-- 프로필 -->
						<div class="style__UserAvatar-zxsodr-8 eAeocm">
						<span onclick="location.href='/profile'">
							<c:if test="${sessionScope.profileImage == null}">
				    			<img class="pofiimg3" src="../../profile_image/basic.jpg"/>
				    		</c:if>
				    		<c:if test="${sessionScope.profileImage != null}">
				    			<img class="pofiimg3" src="../../profile_image/${sessionScope.profileImage }"/>
				    		</c:if>
						</span>
						</div>
										
			           	<div class="style__UserText-zxsodr-11 fXtfpK">				
						<span onclick="location.href='/profile'">
							<c:choose>
								<c:when test="${fn:length(sessionScope.nickName) > 12}">
								${fn:substring(sessionScope.nickName, 0, 10)}...
								</c:when>
								<c:otherwise>
								${sessionScope.nickName}
								</c:otherwise>
							</c:choose>
			           	</span>
			           	</div>
			        </c:if>
					<c:if test="${sessionScope.id == 'admin'}">
						<!-- 프로필 -->
						<div class="style__UserAvatar-zxsodr-8 eAeocm">
						<span onclick="location.href='/admin/member_management'">
							<img class="pofiimg3" src="../../profile_image/basic.jpg"/>
						</span>
						</div>
										
			           	<div class="style__UserText-zxsodr-11 fXtfpK1">				
						<span onclick="location.href='/admin/member_management'">
			           	${sessionScope.id}
			           	</span>
			           	</div>
			        </c:if>
			      		
			      	<c:if test="${sessionScope.loginok == null}">
						<div class="style__UserAvatar-zxsodr-8 eAeocm">
						<span onclick="location.href='/profile'">
						<svg class="style__AvatarIcon-zxsodr-38 hSMslH" width="48" height="48" viewBox="0 0 48 48" fill="none" xmlns="http://www.w3.org/2000/svg">
						<path d="M41.8081 40.2C40.6938 32.1539 34.8597 26 27.852 26H20.1498C13.1405 26 7.30625 32.1539 6.19186 40.2C6.06567 41.1111 6 42.0465 6 43H42C42 42.0465 41.9343 41.1111 41.8081 40.2Z" fill="#0D0D0D">
						</path>
						<path d="M24 23C28.9639 23 33 18.9626 33 14C33 9.0374 28.9639 5 24 5C19.0379 5 15 9.0374 15 14C15 18.9626 19.0379 23 24 23Z" fill="#0D0D0D">
						</path>
						</svg>
						</span>
						</div>
						<div class="style__UserText-zxsodr-11 fXtfpK">
						<span style="cursor:pointer" onclick="location.href='${root}/login/logoutprocess'">
						로그인/회원가입
						  </span>
						</div>
			        </c:if>
					</div>
			        	
				</div>
			</div>
		</div>
    </div>
 </div>
 <!-- 상단고정  -->
    <div class="top_fix_zone" id="topBar">
		<!--카테고리부분  -->
		<div class="style__HeaderContentLayout-zxsodr-12 elXgTt">
			<div class="style__SearchBar-zxsodr-14 bwVjLt">
				<div class="style__CategorySection-zxsodr-13 fAzCXd">
					<div class="style__CategoryWrapper-zxsodr-18 kWZlUb Categort">
						<div style="margin:0px 8px" class="style__IconWrapper-zxsodr-30 fDDqDt">
							<svg class="style__MenuIcon-zxsodr-31 brKdPY" width="48" height="48" viewBox="0 0 48 48" fill="none" xmlns="http://www.w3.org/2000/svg">
								<rect x="9" y="11" width="30" height="4" fill="#1C1C1C">
								</rect>
								<rect x="9" y="22" width="30" height="4" fill="#1C1C1C">
								</rect>
								<rect x="9" y="33" width="30" height="4" fill="#1C1C1C">
								</rect>
							</svg>
						</div>
					카테고리
					</div>
					
					<div class="style__CategoryWrapper-zxsodr-18 kWZlUb effect_hover">
					<span onclick="location.href='/'">
					홈
					</span>
					</div>
					
					<div class="style__CategoryWrapper-zxsodr-18 kWZlUb effect_hover">
					<span onclick="location.href='/listchul/listChul?state=pop&category=no'">
					인기
					</span>
					</div>
					
					<div class="style__CategoryWrapper-zxsodr-18 kWZlUb effect_hover">
					<span onclick="location.href='/listchul/listChul?state=new&category=no'">
					신규
					</span>
					</div>
					<div class="style__CategoryWrapper-zxsodr-18 kWZlUb effect_hover">
					<span onclick="location.href='/listchul/listChul?state=endsoon&category=no'">
					마감임박
					</span>
					</div>
					
					<div class="style__CategoryWrapper-zxsodr-18 kWZlUb effect_hover">
					<span onclick="location.href='/listchul/listChul?state=book&category=no'">
					공개예정
					</span>
					
					</div>
				</div>
				
				<!-- 검색기능 -->
				<div class="style__SearchInputWrapper-zxsodr-15 hbYMFx">
					<input placeholder="검색어를 입력해주세요." class="style__SearchInput-zxsodr-16 jPMsmJ" id="searchMain">
					<div class="style__SearchButton-zxsodr-17 bolWec">
						<span id="searchBtnMain">
							<svg class="search-btn style__SearchIcon-zxsodr-36 cjgtxq" width="48" height="48" viewBox="0 0 48 48" fill="none" xmlns="http://www.w3.org/2000/svg">
								<path fill-rule="evenodd" clip-rule="evenodd" 
									d="M29.9979 32.9819C27.3165 34.9694 23.9582 36.0788 20.3642 35.9089C12.0892 35.5176 5.69811 28.4922 6.08938 20.2171C6.48064 11.9421 13.5061 5.55107 21.7811 5.94234C30.0561 6.33361 36.4472 13.359 36.0559 21.6341C35.889 25.1636 34.5152 28.3505 32.3522 30.8144L39.4908 38.6856L37.1205 40.8353L29.9979 32.9819ZM32.6597 21.4735C32.3571 27.8728 26.9241 32.8152 20.5248 32.5127C14.1254 32.2101 9.183 26.7771 9.48558 20.3777C9.78816 13.9784 15.2212 9.03597 21.6205 9.33855C28.0199 9.64113 32.9623 15.0741 32.6597 21.4735Z" 
									fill="black">
								</path>
							</svg>	
						</span>
					</div>
				</div>
				<script type="text/javascript">
					$(".search-btn").click(function() {
						let search = $("#searchMain").val()
						if(search.trim() == ''){
							alert("검색할 내용을 입력해주세요")
							return;
						}
						location.href = "/listchul/listChul?category=no&state=no&percent=no&search="+search
					})
				</script>
<!-- 				<script type="text/javascript">
					$("#searchBtnMain").click(function() {
						let keyword = $("#searchMain").val();
						$.ajax({
							type : "get",
							url : "../keyword/insert",
							data:{keyword:keyword},
							success : function() {
							location.href='/listchul/listChul?state=no&category=no'
								list();
							}
						});
					})
				</script>
				 -->
				
			</div>
			<!-- hover -->
			<div class="style__ExtendedCategorySection-zxsodr-19 dDWncX test4">
				<div class="style__SwiperContainer-zxsodr-20 bqNNIR test3">
					<div class="style__SwiperWrapper-zxsodr-21 keNBax swiper-container test2">
						<div class="style__Depth1CategoryWrapper-zxsodr-25 hNuCTH header-swiper-wrapper test1">
							
							<!-- 전체 -->
							<span onclick="location.href='/listchul/listChul?state=no&category=no'">
							<div class="style__Depth1Category-zxsodr-26 EyrIo header-swiper-slide">
								<div class="style__Depth1CategoryIcon-zxsodr-27 eHXkLB">
									<svg width="48" height="48" viewBox="0 0 48 48" fill="none" xmlns="http://www.w3.org/2000/svg">
										<path fill-rule="evenodd" clip-rule="evenodd" 
											d="M20.7158 12.1263H12.1263V20.7158H20.7158V12.1263ZM10.1052 10.1053V22.7369H22.7368V10.1053H10.1052Z" fill="#0D0D0D">
										</path>
										<path fill-rule="evenodd" clip-rule="evenodd" 
											d="M35.8736 12.1263H27.2842V20.7158H35.8736V12.1263ZM25.2631 10.1053V22.7369H37.8947V10.1053H25.2631Z" fill="#0D0D0D">
										</path>
										<path fill-rule="evenodd" clip-rule="evenodd" 
											d="M20.7158 27.2842H12.1263V35.8737H20.7158V27.2842ZM10.1052 25.2632V37.8948H22.7368V25.2632H10.1052Z" fill="#0D0D0D">
										</path>
										<path d="M25.2632 25.2632H37.8948V37.8948H25.2632V25.2632Z" fill="#FF5757">
										</path>
									</svg>
								</div>
								<div class="style__Depth1CategoryText-zxsodr-29 eubFxh">전체</div>
							</div>
							</span>
							
							<!-- 게임 -->
							<span onclick="location.href='/listchul/listChul?state=no&category=게임'">
							<div class="style__Depth1Category-zxsodr-26 EyrIo header-swiper-slide">
								<div class="style__Depth1CategoryIcon-zxsodr-27 eHXkLB">
									<svg width="48" height="48" viewBox="0 0 48 48" fill="none" xmlns="http://www.w3.org/2000/svg">
										<ellipse cx="31.5789" cy="21.4737" rx="3.78947" ry="3.78947" fill="#FF5757">
										</ellipse>
										<path d="M16.6736 24.6316V21.8527L13.8946 21.8527V19.8317H16.6736V17.0527H18.6947V19.8317H21.4736V21.8527H18.6947V24.6316H16.6736Z" 
											fill="black">
										</path>
										<path fill-rule="evenodd" clip-rule="evenodd" 
											d="M25.6419 8.84216V12.0001H38.9133C39.5521 12.0001 40.0903 12.4769 40.1673 13.1109L42.9301 35.8585C42.9393 35.9338 42.8806 36.0001 42.8047 36.0001H32.1167C32.066 36.0001 32.0201 35.9696 32.0004 35.9229L29.5008 30.0001H18.4991L15.9996 35.9229C15.9798 35.9696 15.934 36.0001 15.8832 36.0001H5.19518C5.11938 36.0001 5.06065 35.9338 5.06979 35.8585L7.83265 13.1109C7.90966 12.4769 8.44787 12.0001 9.08659 12.0001H23.6209V8.84216H25.6419ZM17.1584 27.979H30.8415L33.3737 33.979H40.666L38.2419 14.0211H9.75801L7.33397 33.979H14.6263L17.1584 27.979Z" 
											fill="black">
										</path>
									</svg>
								</div>
								<div class="style__Depth1CategoryText-zxsodr-29 eubFxh">게임</div>
							</div>
							</span>
							
							<!-- 공연 -->
							<span onclick="location.href='/listchul/listChul?state=no&category=공연'">
							<div class="style__Depth1Category-zxsodr-26 EyrIo header-swiper-slide">
								<div class="style__Depth1CategoryIcon-zxsodr-27 eHXkLB">
									<svg width="48" height="48" viewBox="0 0 48 48" fill="none" xmlns="http://www.w3.org/2000/svg">
										<path d="M13.8948 26.9265C14.6239 29.6914 15.7895 32.6614 20.8421 31.8548C26.1931 31.0006 26.0024 28.1205 25.8948 25.2632C25.8948 25.2632 20.3672 26.0533 19.579 26.1706C16.0027 26.7029 13.8948 26.9265 13.8948 26.9265Z" 
											fill="#FF5757">
										</path>
										<path d="M28.9332 37.2399C29.4462 37.5042 29.993 37.7208 30.5692 37.8825C35.0159 39.1307 39.6613 36.6776 41.1377 32.3014L45.2966 19.9748L34.3933 16.9142L34.5498 19.0573L42.7012 21.3454L39.2227 31.6553C38.0901 35.0124 34.5266 36.8942 31.1155 35.9367C30.997 35.9034 30.8802 35.8672 30.7651 35.828C30.1993 36.349 29.5868 36.8221 28.9332 37.2399Z" 
											fill="#040404">
										</path>
										<path fill-rule="evenodd" clip-rule="evenodd" 
										d="M4.52161 13.2739L7.51393 28.1066C8.87956 34.8759 15.2816 39.4101 22.1204 38.4515C28.9593 37.4929 33.868 31.3733 33.3199 24.4894L32.1189 9.40564L4.52161 13.2739ZM6.92707 14.9775L9.49507 27.7069C10.6492 33.4281 16.06 37.2602 21.8399 36.45C27.6198 35.6399 31.7685 30.4678 31.3052 24.6498L30.2745 11.705L6.92707 14.9775Z" 
											fill="#040404">
										</path>
										<path d="M20.2105 19.4905L22.6778 18.9474L23.2209 21.4147L20.7536 21.9577L20.2105 19.4905Z" fill="#040404">
										</path>
										<path d="M13.8948 20.7604L16.3605 20.2105L16.9104 22.6763L14.4447 23.2262L13.8948 20.7604Z" fill="#040404">
										</path>
									</svg>
								</div>
								<div class="style__Depth1CategoryText-zxsodr-29 eubFxh">공연</div>
								</div>
								</span>
								
								<!-- 디자인 -->
								<span onclick="location.href='/listchul/listChul?state=no&category=디자인'">
								<div class="style__Depth1Category-zxsodr-26 EyrIo header-swiper-slide">
									<div class="style__Depth1CategoryIcon-zxsodr-27 eHXkLB">
										<svg width="48" height="48" viewBox="0 0 48 48" fill="none"
											xmlns="http://www.w3.org/2000/svg">
											<path d="M22.7369 7.57898L22.7369 15.1579H20.7158V7.57898H22.7369Z"
												fill="black"></path>
											<path
												d="M9.97819 10.1951L17.5571 17.774L18.9862 16.3449L11.4073 8.76597L9.97819 10.1951Z"
												fill="black"></path>
											<path
												d="M33.6717 10.6285L26.5262 17.774L25.0971 16.3449L32.2426 9.1994L33.6717 10.6285Z"
												fill="black"></path>
											<path
												d="M18.4502 25.0727L8.84207 34.1053L7.45776 32.6327L17.0659 23.6002L18.4502 25.0727Z"
												fill="black"></path>
											<path d="M22.7369 36.6316V26.5263H20.7158V36.6316H22.7369Z"
												fill="black"></path>
											<path
												d="M7.57896 21.4737H16.4211V19.4527L7.57896 19.4527L7.57896 21.4737Z"
												fill="black"></path>
											<path d="M34.1053 21.4737H27.7895V19.4527H34.1053V21.4737Z"
												fill="black"></path>
											<path fill-rule="evenodd" clip-rule="evenodd"
												d="M31.8292 26.3292L24.7686 23.3684L27.2285 30.6562L35.6965 39.6595L40.2971 35.3324L31.8292 26.3292ZM28.1151 26.9633L30.6513 28.0268L37.4402 35.2449L35.784 36.8026L29.0026 29.5925L28.1151 26.9633Z"
												fill="black"></path>
											<path
												d="M25.2632 20.8421C25.2632 22.5862 23.8493 24 22.1053 24C20.3612 24 18.9474 22.5862 18.9474 20.8421C18.9474 19.098 20.3612 17.6842 22.1053 17.6842C23.8493 17.6842 25.2632 19.098 25.2632 20.8421Z"
												fill="#FF5757"></path>
										</svg>
									</div>
									<div class="style__Depth1CategoryText-zxsodr-29 eubFxh">디자인</div>
								</div>
								</span>
								
								
								<!-- 사진 -->
								<span onclick="location.href='/listchul/listChul?state=no&category=사진'">
								<div class="style__Depth1Category-zxsodr-26 EyrIo header-swiper-slide">
									<div class="style__Depth1CategoryIcon-zxsodr-27 eHXkLB">
										<svg width="48" height="48" viewBox="0 0 48 48" fill="none"
											xmlns="http://www.w3.org/2000/svg">
											<path fill-rule="evenodd" clip-rule="evenodd"
												d="M17.0195 16.2054H8.33685V34.9053H39.6632V16.2054H30.9805L28.4446 11.8316H19.5555L17.0195 16.2054ZM18.3911 9.81055H29.6089L32.1449 14.1843H41.6842V36.9263H6.3158V14.1843H15.8551L18.3911 9.81055Z"
												fill="black"></path>
											<path fill-rule="evenodd" clip-rule="evenodd"
												d="M23.9999 29.0106C26.1393 29.0106 27.8736 27.2762 27.8736 25.1369C27.8736 22.9975 26.1393 21.2632 23.9999 21.2632C21.8605 21.2632 20.1262 22.9975 20.1262 25.1369C20.1262 27.2762 21.8605 29.0106 23.9999 29.0106ZM23.9999 31.0316C27.2555 31.0316 29.8946 28.3924 29.8946 25.1369C29.8946 21.8813 27.2555 19.2421 23.9999 19.2421C20.7443 19.2421 18.1052 21.8813 18.1052 25.1369C18.1052 28.3924 20.7443 31.0316 23.9999 31.0316Z"
												fill="black"></path>
											<rect x="31.579" y="18.9474" width="5.05263" height="3.78947"
												fill="#FF5757"></rect>
										</svg>
									</div>
									<div class="style__Depth1CategoryText-zxsodr-29 eubFxh">사진</div>
								</div>
								</span>
								
								<!-- 영화비디오 -->
								<span onclick="location.href='/listchul/listChul?state=no&category=영화·비디오'">
								<div class="style__Depth1Category-zxsodr-26 EyrIo header-swiper-slide">
									<div class="style__Depth1CategoryIcon-zxsodr-27 eHXkLB">
										<svg width="48" height="48" viewBox="0 0 48 48" fill="none"
											xmlns="http://www.w3.org/2000/svg">
											<path fill-rule="evenodd" clip-rule="evenodd"
												d="M36.6316 31.1459V36.5053C36.6316 36.575 36.575 36.6316 36.5053 36.6316H6.44211C6.37235 36.6316 6.3158 36.575 6.3158 36.5053V12.7579C6.3158 12.6881 6.37235 12.6316 6.44211 12.6316H36.5053C36.575 12.6316 36.6316 12.6881 36.6316 12.7579V18.6225L43.4525 16.6737V33.0948L36.6316 31.1459ZM8.33685 34.6105V14.6526H34.6105V34.6105H8.33685ZM36.6316 29.044L41.4315 30.4154V19.3531L36.6316 20.7245V29.044Z"
												fill="black">
												</path>
											<path d="M26.5264 24.7578L18.9474 29.8105L18.9474 19.7052L26.5264 24.7578Z" fill="#FF5757">
												</path>
										</svg>
									</div>
									<div class="style__Depth1CategoryText-zxsodr-29 eubFxh">영화 · 비디오</div>
								</div>
								</span>
								
								<!-- 푸드 -->
								<span onclick="location.href='/listchul/listChul?state=no&category=푸드'">
								<div class="style__Depth1Category-zxsodr-26 EyrIo header-swiper-slide">
									<div class="style__Depth1CategoryIcon-zxsodr-27 eHXkLB">
										<svg width="48" height="48" viewBox="0 0 48 48" fill="none"
											xmlns="http://www.w3.org/2000/svg">
											<path fill-rule="evenodd" clip-rule="evenodd"
												d="M33.4737 8.8421C29.288 8.8421 25.8948 12.2353 25.8948 16.4211V18.9474C25.8948 22.7027 28.626 25.8201 32.2104 26.4215V31.5789H34.2314V26.4889C38.0614 26.1087 41.0527 22.8774 41.0527 18.9474V16.4211C41.0527 12.2353 37.6595 8.8421 33.4737 8.8421ZM39.0316 18.9474V16.4211C39.0316 13.3515 36.5433 10.8632 33.4737 10.8632C30.4042 10.8632 27.9158 13.3515 27.9158 16.4211V18.9474C27.9158 22.0169 30.4042 24.5053 33.4737 24.5053C36.5433 24.5053 39.0316 22.0169 39.0316 18.9474Z"
												fill="black">
											</path>
											<path
												d="M10.4842 18.9474V10.1053H8.46313V18.9474C8.46313 22.5628 11.082 25.5666 14.5262 26.1652V31.5789H16.5472V26.235C20.2374 25.8558 23.1158 22.7377 23.1158 18.9474V10.1053H21.0947V18.9474C21.0947 21.8774 18.7195 24.2526 15.7895 24.2526C12.8594 24.2526 10.4842 21.8774 10.4842 18.9474Z"
												fill="black">
											</path>
											<path d="M14.5262 10.1053V18.9474H16.5472V10.1053H14.5262Z"
												fill="black">
											</path>
											<path d="M31.0737 31.5789H35.2421V41.6842H31.0737V31.5789Z"
												fill="#FF5757">
											</path>
											<path d="M13.3895 31.5789H17.5579V41.6842H13.3895V31.5789Z"
												fill="#FF5757">
												</path>
										</svg>
									</div>
									<div class="style__Depth1CategoryText-zxsodr-29 eubFxh">푸드</div>
								</div>
								</span>
								
								<!-- 음악 -->
								<span onclick="location.href='/listchul/listChul?state=no&category=음악'">
								<div class="style__Depth1Category-zxsodr-26 EyrIo header-swiper-slide">
									<div class="style__Depth1CategoryIcon-zxsodr-27 eHXkLB">
										<svg width="48" height="48" viewBox="0 0 48 48" fill="none"
											xmlns="http://www.w3.org/2000/svg">
											<path fill-rule="evenodd" clip-rule="evenodd"
												d="M36.3788 27.1579V7.55701L15.4104 12.6461V28.6539C13.8937 27.7992 11.8658 27.7062 10.0081 28.5724C7.13869 29.9105 5.76168 33.0305 6.93245 35.5412C8.10321 38.0519 11.3784 39.0026 14.2478 37.6646C17.0221 36.3709 18.4013 33.4114 17.4315 30.9474V14.2353L34.3578 10.1272V24.6151C32.8286 23.6927 30.739 23.5693 28.8291 24.4599C25.9597 25.7979 24.5827 28.9179 25.7535 31.4286C26.9243 33.9394 30.1995 34.89 33.0688 33.552C35.7229 32.3144 37.1001 29.5523 36.3655 27.1579H36.3788ZM32.2147 31.7203C34.3099 30.7433 34.9083 28.7144 34.3128 27.4374C33.7173 26.1604 31.7784 25.3146 29.6833 26.2916C27.5881 27.2686 26.9897 29.2975 27.5852 30.5745C28.1807 31.8515 30.1195 32.6973 32.2147 31.7203ZM13.3937 35.8329C15.4888 34.8559 16.0872 32.8269 15.4917 31.5499C14.8963 30.2729 12.9574 29.4271 10.8622 30.4041C8.76704 31.3811 8.16867 33.4101 8.76414 34.6871C9.35962 35.9641 11.2985 36.8099 13.3937 35.8329Z"
												fill="black"></path>
											<path
												d="M34.3576 15.2489L17.4313 19.3111V14.2353L34.3576 10.1273V15.2489Z"
												fill="#FF5757"></path>
											</svg>
									</div>
									<div class="style__Depth1CategoryText-zxsodr-29 eubFxh">음악</div>
								</div>
								</span>
								
								<!-- 테크 -->
								<span onclick="location.href='/listchul/listChul?state=no&category=테크'">
								<div class="style__Depth1Category-zxsodr-26 EyrIo header-swiper-slide">
									<div class="style__Depth1CategoryIcon-zxsodr-27 eHXkLB">
										<svg width="48" height="48" viewBox="0 0 48 48" fill="none"
											xmlns="http://www.w3.org/2000/svg">
											<path fill-rule="evenodd" clip-rule="evenodd"
												d="M38.4 10.8632H8.33685V29.5579H31.579V31.5789H26.6206L27.3785 34.6105H30.3158V36.6316H15.1579V34.6105H18.0952L18.8531 31.5789H6.3158V8.8421H40.4211V20.2105H38.4V10.8632ZM24.5373 31.5789L25.2952 34.6105L20.1785 34.6105L20.9364 31.5789H24.5373Z"
												fill="black"></path>
											<path fill-rule="evenodd" clip-rule="evenodd"
												d="M42.3157 22.1053H33.4736V36.6316H42.3157V22.1053ZM37.8946 32.8421C37.3365 32.8421 36.8841 33.2946 36.8841 33.8527C36.8841 34.4108 37.3365 34.8632 37.8946 34.8632C38.4527 34.8632 38.9052 34.4108 38.9052 33.8527C38.9052 33.2946 38.4527 32.8421 37.8946 32.8421Z"
												fill="#FF5757"></path>
										</svg>
									</div>
									<div class="style__Depth1CategoryText-zxsodr-29 eubFxh">테크</div>
								</div>
								</span>
								
								<!-- 패션 -->
								<span onclick="location.href='/listchul/listChul?state=no&category=패션'">
								<div class="style__Depth1Category-zxsodr-26 EyrIo header-swiper-slide">
									<div class="style__Depth1CategoryIcon-zxsodr-27 eHXkLB">
										<svg width="48" height="48" viewBox="0 0 48 48" fill="none"
											xmlns="http://www.w3.org/2000/svg">
											<circle cx="24.6316" cy="24.6316" r="1.89474" fill="#FF5757"></circle>
											<ellipse cx="24.6316" cy="30.9473" rx="1.89474" ry="1.89474"
												fill="#FF5757">
											</ellipse>
											<path fill-rule="evenodd" clip-rule="evenodd"
												d="M18.2776 7.40594L24.6315 12.5151L30.9853 7.40594L34.9845 12.6316H40.4211L39.0608 39.1579H10.2025L8.84216 12.6316H14.2784L18.2776 7.40594ZM14.4415 14.6526H10.9695L12.1226 37.1368H37.1407L38.2938 14.6526H34.8215L29.3153 21.2141L24.6315 14.8352L19.9477 21.2141L14.4415 14.6526ZM18.6244 10.2782L16.1368 13.5288L19.8416 17.9437L22.9288 13.7393L18.6244 10.2782ZM30.6385 10.2782L33.1262 13.5288L29.4213 17.9437L26.3342 13.7393L30.6385 10.2782Z"
												fill="black"></path>
										</svg>
									</div>
									<div class="style__Depth1CategoryText-zxsodr-29 eubFxh">패션</div>
								</div>
								</span>
						</div>
					</div>
				</div>
		</div>
	<!-- end카테고리부분  -->
	</div>
    </div>
</header>


