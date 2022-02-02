<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link rel="stylesheet" type="text/css" href="/css/project-create.css">
<script type="text/javascript">
	$(function() {
		$(".top_fix_zone").hide();
		projectData();
		var key = "#" + $("#key").val();
		var class_key = "." + $("#key").val();
		$(".page").hide();
		$(key).show();
		$(".menu").css({"color" : "#dcdcdc"});
		$(class_key).css({"color" : "black"});
		$(".menu").click(function() {
			if($("button#save0").prop("disabled") == false || $("button#save2").prop("disabled") == false){
				return
			}else{
			//alert("dd");
			$(".menu").css({"color" : "#dcdcdc"});
			$(this).css({"color" : "black"});
			}
			
		});
	
		$(".menu").click(function() {
			if($("button#save0").prop("disabled") == false || $("button#save2").prop("disabled") == false || 
					$("button#save3").prop("disabled") == false){
				alert("저장 후 페이지를 이동하세요");
				return
			}else{
			$(".page").hide();
			var page = $(this).attr("data_page");
			$(page).show();
			$('html').scrollTop(0);
			}
		});
		
	});


</script>
<div style="background-color: rgb(252, 252, 252);">
<div style="height: 100px;">
</div>
<div id="default" class="page">
	<jsp:include page="default.jsp?idx=${idx }"></jsp:include>
</div>
<div id="funding" class="page">
	<jsp:include page="funding.jsp?idx=${idx }"></jsp:include>
</div>
<div id="reward" class="page">
	<jsp:include page="reward.jsp?idx=${idx }"></jsp:include>
</div>
<div id="story" class="page">
	<jsp:include page="story.jsp?idx=${idx }"></jsp:include>
</div>
<div id="policy" class="page">
	<jsp:include page="policy.jsp?idx=${idx }"></jsp:include>
</div>
</div>


<div class="header_area" style="margin-top: 60px;">

	
	<div class="backColor">
		<!-- Classy Menu -->
		<nav class="classy-navbar" id="essenceNav">

				
			<!-- Menu -->
			<div class="classy-menu">
				<!-- close btn -->
				<div class="classycloseIcon">
					<div class="cross-wrap">
						<span class="top"></span><span class="bottom"></span>
					</div>
				</div>
				<div style="width: 30px;"></div>
				<!-- Nav Start -->
				<div class="classynav">
					<ul class="list">
						<li><span class="menu default" style="color: black;" data_page="#default">기본정보</span></li>
						<li><span class="menu funding" data_page="#funding">펀딩계획</span></li>
						<li><span class="menu reward" data_page="#reward">선물구성</span></li>
						<li><span class="menu story" data_page="#story">프로젝트계획</span></li>
						<li><span class="menu policy" data_page="#policy">신뢰와 안전</span></li>
					</ul>
				</div>
				<!-- Nav End -->
			</div>
		</nav>
	</div>
</div>   
<input type="hidden" id="key" value="${key }">