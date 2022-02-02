<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<link rel="stylesheet" type="text/css" href="/css/project-detail.css">

<script type="text/javascript">
	$(document).ready(function(){
	    var topBar = $("#topBar").offset();
	    
	    $(window).scroll(function(){
	        var docScrollY = $(document).scrollTop()
	        var barThis = $("#topBar")
	        var fixNext = $("#fixNextTag")
	 
	        if( docScrollY == topBar.top ) {
	            barThis.addClass("top_bar_fix");
	            fixNext.addClass("pd_top_80");
	        }else{
	            barThis.removeClass("top_bar_fix");
	            fixNext.removeClass("pd_top_80");
	        }
	    });
	});
	
	$(function(){
		loginok="${sessionScope.loginok}";
		loginId = "${sessionScope.id}"
		var likeCheck = "${likeCheck}";
		
		if(likeCheck == 1){
			$(".project-sub-heart").html("<i class='fa fa-heart' style='color: red;'></i>");
		}
		
		//본인이 만든 프로젝트는 찜, 메세지, 후원 못하게 설정
		var creatorId = $("#creatorId").val();
		if(loginId == creatorId){
			$(".project-sub-heart").css({"pointer-events" : "none", "color" : "gray"});
			$(".btn-support").css({"pointer-events" : "none", "backgroundColor" : "#cbcbcb"});
			$(".btn-present-support").css({"pointer-events" : "none", "backgroundColor" : "#cbcbcb"});
			$(".btn-creator-message").css({"pointer-events" : "none", "backgroundColor" : "#cbcbcb", "color" : "white"});
		}
		
		//프로필 이미지 클릭 시 해당 작가의 프로필 페이지로 이동
		$(document).on("click",".creator-image", function() {
			if($(this).attr("id") == 'admin'){
				alert("관리자 페이지로는 이동이 불가능합니다.");
				return;
			}
			
			let check = confirm("프로필 페이지로 이동하시 겠습니까?");
			if(check == true){
				$("#creator-id").val("");
				$("#creator-id").val($(this).attr("id"));
				$(".sub-profile").submit();
			}
		});
		
		$(".project-community").hide();
		$(".btn-project-community").css("color", "gray");
		
		$(".btn-project-plan").click(function(){
			$(this).css("color", "black");
			$(".btn-project-community").css("color", "gray");
			$(".project-community").hide();
			$(".project-plan").show();
		});

		$(".btn-project-community").click(function(){
			$(this).css("color", "black");
			$(".btn-project-plan").css("color", "gray");
			$(".project-plan").hide();
			$(".project-community").show();
		});
		
		$(".scroll_move").click(function(event){
            event.preventDefault();
            $('html,body').animate({scrollTop:$(".content-navigation-container").offset().top}, 500);
    	});

		$(".btn-support").click(function(event){
            event.preventDefault();
            $('html,body').animate({scrollTop:$(".present-title").offset().top}, 500);
    	});
		$(".btn-creator-message").click(function(){
			if(loginok==''){
				alert("로그인이 필요한 페이지 입니다.")
				location.href = "/login/main";
			}else{
				$(".message-modal").fadeIn();
				$("#inquiry_type").val("문의유형");
				$("#message-content").val("");
			}
		});
		
		$(".message-title2").click(function(){
			$(".message-modal").fadeOut();
		});
		
		$("#message-content").keyup(function(){
			var content = $(this).val();
			$('.word-count').html(content.length+" / 1000");
			if (content.length > 1000){
		        alert("최대 1000자까지 입력 가능합니다.");
		        $(this).val(content.substring(0, 1000));
		        $('.word-count').html("1000 / 1000");
		    }
		});
		
		$(".project-sub-heart").click(function(){
			if(loginok==''){
				alert("로그인이 필요한 서비스 입니다.")
				return;
			}
			
			var id = "${sessionScope.id}";
			var idx = "${dto.idx}";
			
			$.ajax({
				type : "post",
				url : "/liked/check",
				data : {"idx":idx, "id":id},
				success : function(data){
					if(data == 0){
						$(".project-sub-heart").html("<i class='fa fa-heart' style='color: red;'></i>");
						alert("관심 프로젝트에 등록되었습니다.");
					}else{
						$(".project-sub-heart").html("<i class='fa fa-heart-o'></i>");
						alert("관심 프로젝트에서 삭제되었습니다.");
					}
				},
				error : function(request,status,error){
			        alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			    }
			});
		});
		
	});
	
	$(document).on("click","#btn-send",function(){
		var content = $("#message-content").val();
		var inquiry_type = $("#inquiry_type").val();
		var recv_name= $("#recv_name").val(); // 상대방 name
		var send_name = $("#send_name").val(); // 나의 name
		if(content==""){
			alert("메세지 내용을 입력하세요.");
			return;
		}
		if(inquiry_type==null){
			alert("문의유형을 선택해주세요.");
			return;
		}
		
		$.ajax ({
			type: "post",
			dataType: "text",
			url: "/message/messageReply",
			data: {"content":content,"inquiry_type":inquiry_type,"recv_name":recv_name},
			success: function (data) {
				alert("메세지가 전송되었습니다.");
				$(".message-modal").fadeOut();
			},error:function(request,status,error){
		        alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		       }
		});
	});
	
	function paycheck() {
		var rs = "";
		var supportCheck = "${supportCheck}";
		if(supportCheck==1 && loginok!=''){
			alert("이미 후원한 프로젝트 입니다.")
			rs = false;
		}
		
		/* var pstName = $(this).siblings().children(".present-name").attr("data-pstName");
		var pstOption = $(this).siblings().children().children(".pstOption").val();
		var pstPrice = $(this).attr("data-price"); */
		if(loginok==''){
			alert("로그인이 필요한 페이지 입니다.")
			location.href = "/login/main";
			rs = false;
		}
		return rs;
	}
</script>

<!-- start project main -->
<div class="container">
	<div class="project-intro">
		<span class="project-intro-category">${dto.category }</span>
		<h1 class="project-intro-title">${dto.title } </h1>
		<span class="profile-img">
			<img alt="프로필" src="../profile_image/${creatorImage}" class="creator-image" id=${dto.id }>
		</span>
		<span class="project-intro-creator-name">${dto.name}</span>
		<input type="hidden" id="creatorId" value="${dto.id }">
	</div>
	<div class="project-main">
		<div class="project-main-img">
			<img alt="프로젝트 커버 이미지" src="/thumbnail_image/${dto.thumbnail}" style="width: 650px; height: 500px">
		</div>
	</div>
	<div class="project-sub-aside">
		<div class="project-sub">
			<div class="project-sub-title">모인금액</div>
			<div>
				<span class="project-sub-value">
					<fmt:formatNumber value="${dto.total_amount }"/>
				</span>
				<span>원</span>
				<span class="project-sub-per">${percentageAchieved }%</span>
			</div>
		</div>
		<div class="project-sub">
			<div class="project-sub-title">남은시간 ${pstdto.present_name }</div>
			<div>
				<span class="project-sub-value">
					<fmt:parseDate value="${today }" var="strPlanDate" pattern="yyyy-MM-dd"/>
					<fmt:parseNumber value="${strPlanDate.time / (1000*60*60*24)}" integerOnly="true" var="strDate" />
					<fmt:parseDate value="${dto.end_date }" var="endPlanDate" pattern="yyyy-MM-dd"/>
					<fmt:parseNumber value="${endPlanDate.time / (1000*60*60*24)}" integerOnly="true" var="endDate" />
					${endDate - strDate }
				</span>
				<span>일</span>
			</div>
		</div>

		<div class="project-sub">
			<div class="project-sub-title">후원자</div>
			<div>
				<span class="project-sub-value">${dto.number_support }</span>
				<span>명</span>
			</div>
		</div>
		<div class="funding-info" style="background-color: #f0ffff">
			<div class="funding-info-title" style="font-weight: bold;">펀딩 진행중</div>
			<span class="funding-info-content">
				목표금액인 <fmt:formatNumber value="${dto.target_amount}"/> 원이 모여야만 결제됩니다.
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
					<img alt="프로필" src="../profile_image/${creatorImage}" class="creator-image" id=${dto.id }>
				</span>
				<span class="creator-name">
					${dto.name }
				</span>
			</div>
			<div class="creator-intro">
				${creatorIntro }
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
				<input type="hidden" name="idx" value="${dto.idx }">
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
			<c:forEach var="pstdto" items="${pstList}">
			<form action="payment" method="post" onsubmit="return paycheck();">
				<div class="present-option">
					<input type="hidden" name="idx" value="${dto.idx }">
					<input type="hidden" name="pstN" value="${pstdto.present_name }">
					<input type="hidden" name="pstP" value="${pstdto.price }">
					<div class="present-price" >
						<fmt:formatNumber value="${pstdto.price }"/>원+
					</div>
					<div>
						<span class="present-name" data-pstName="${pstdto.present_name }">
							> ${pstdto.present_name }
						</span>
						<span class="present-description" >
							<c:choose>
								<c:when test="${pstdto.present_option == null}">
								</c:when>
								<c:otherwise>
									<b style="margin-left:20px; font-size:8pt; color:gray">옵션선택</b>
									<select name="pstO" id="" class="pstOption" style="width:150px;">
										<c:set var="present_option" value="${pstdto.present_option}" />
										<c:set var="splitStr" value="${fn:split(present_option, ',') }" />
										<c:forEach var="option" items="${splitStr }">
											<option value="${option}">${option}</option>
										</c:forEach>
									</select>
								</c:otherwise>
							</c:choose>
						</span>
					</div>
					<button type="submit" class="btn-present-support" data-price="${pstdto.price }">
						<fmt:formatNumber value="${pstdto.price }"/>원 후원하기
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
				<input type="hidden" id="id" value="${sessionScope.id}">
				<table class= "table table-bordered">
					<tr>
						<td>
							받는사람
						</td>
						<td>
							<input type="text" readonly="readonly" id="recv_name" value="${dto.name}">
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