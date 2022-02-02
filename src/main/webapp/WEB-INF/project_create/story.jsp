<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script>
	$(function() {
		let dataNumber1 = 0;
		let dataNumber2 = 0;
		let dataNumber3 = 0;
		let dataNumber4 = 0;
		let dataNumber5 = 0;
		$("button#save4").css({"backgroundColor":"#cbcbcb","cursor":"auto","color":"white"});
		$('#project_goal').summernote({
		    placeholder: '막연하다면 아래의 질문에 대한 답이 내용에 포함되도록 작성해보세요.<br><br>Q.무엇을 만들기 위한 프로젝트인가요?<br><br>Q.프로젝트를 간단히 소개한다면?<br><br>Q.이 프로젝트가 왜 의미있나요?<br><br>Q.이 프로젝트를 시작하게 된 배경이 무엇인가요?<br><br>Q.현재 어느 정도 진행되었고, 진행 과정은 어땠나요?',
		    height: 400,
		    minHeight: null,             // set minimum height of ditor
		    maxHeight: null,             // set maximum height of editor
		    callbacks: {
			    onKeyup: function(e) {
			      setTimeout(function(){
			        $("#sumdata1").val($('#project_goal').val().length);
			      },200);
			        dataNumber1 += 1;
			    }
			  }
		  });
		  $('#project_budget').summernote({
		    placeholder: '예산의 합이 펀딩 목표 금액과 일치해야 합니다. 이번 프로젝트와 무관한 계획을 넣지 마십시오. (기부, 다음 프로젝트에 사용, 목표 금액 초과 시 활용 계획 등)<br><br>아래의 양식을 참고하여 작성해보세요.<br><br>( 예시 )<br><br>제작비용<br>·인건비: 00만원<br>·원재료 구입비: 00만원<br>·디자인 의뢰비: 00만원<br>·인쇄비: 00만원<br>·제품 발주비(생산비): 00만원<br><br>배송 비용<br>·배송비: 00만원<br>·포장재 구매비: 00만원<br><br>기타<br>·예비비: 00만원<br>·수수료: 00만원',
		    height: 500,
		    minHeight: null,             // set minimum height of editor
		    maxHeight: null,             // set maximum height of editor
		    callbacks: {
			    onKeyup: function(e) {
			      setTimeout(function(){
			        $("#sumdata2").val($('#project_budget').val().length);
			      },200);
			        dataNumber2 += 1;
			    }
			  }
		  });
		  $('#project_schedule').summernote({
		    placeholder: '아래의 양식을 참고하여 작성해보세요.<br><br>( 예시 )<br><br>·0월 0일: 현재 제품 시안 및 1차 샘플 제작<br>·0월 0일: 펀딩 시작일<br>·0월 0일: 샘플 작업 보완<br>·0월 0일: 펀딩 종료일<br>·0월 0일: 2차 샘플 제작<br>·0월 0일: 제품 디테일 보완<br>·0월 0일: 제품 발주 시작<br>·0월 0일: 후가공 처리 및 포장 작업<br>·0월 0일: 선물 예상 전달일',
		    height: 400,
		    minHeight: null,             // set minimum height of editor
		    maxHeight: null,             // set maximum height of editor
		    callbacks: {
			    onKeyup: function(e) {
			      setTimeout(function(){
			        $("#sumdata3").val($('#project_schedule').val().length);
			      },200);
			        dataNumber3 += 1;
			    }
			  }
		  });
		  $('#project_team_intro').summernote({
		    height: 400,
		    minHeight: null,             // set minimum height of editor
		    maxHeight: null,             // set maximum height of editor
		    callbacks: {
			    onKeyup: function(e) {
			      setTimeout(function(){
			        $("#sumdata4").val($('#project_team_intro').val().length);
			      },200);
			        dataNumber4 += 1;
			    }
			  }
		  });
		  $('#project_present_intro').summernote({
		    height: 400,
		    minHeight: null,             // set minimum height of editor
		    maxHeight: null,             // set maximum height of editor
		    callbacks: {
			    onKeyup: function(e) {
			      setTimeout(function(){
			        $("#sumdata5").val($('#project_present_intro').val().length);
			      },200);
			        dataNumber5 += 1;
			    }
			  }
		  });
		  $("#project_goal").on("summernote.enter", function(we, e) {
		      $(this).summernote("pasteHTML", "<br><br>");
		      e.preventDefault();
			});
		  $("#project_budget").on("summernote.enter", function(we, e) {
		      $(this).summernote("pasteHTML", "<br><br>");
		      e.preventDefault();
			});
		  $("#project_schedule").on("summernote.enter", function(we, e) {
		      $(this).summernote("pasteHTML", "<br><br>");
		      e.preventDefault();
			});
		  $("#project_team_intro").on("summernote.enter", function(we, e) {
		      $(this).summernote("pasteHTML", "<br><br>");
		      e.preventDefault();
			});
		  $("#project_present_intro").on("summernote.enter", function(we, e) {
		      $(this).summernote("pasteHTML", "<br><br>");
		      e.preventDefault();
			});
		  
		  
		  survey('#sumdata1', function(){ 

			  if (dataNumber5 != 0 && dataNumber1 != 0 && dataNumber2 != 0 && dataNumber3 != 0 && dataNumber4 != 0 && $("#audit").val() == 0) {
				  $("button#save4").css({"backgroundColor":"#d2201d","cursor":"pointer","color":"#fff"}).prop("disabled",false);
			  } else {
				  $("button#save4").css({"backgroundColor":"#cbcbcb","cursor":"auto","color":"white"}).prop("disabled",true);
			  }
			    
		   }); 
		  survey('#sumdata2', function(){ 

			  if (dataNumber5 != 0 && dataNumber1 != 0 && dataNumber2 != 0 && dataNumber3 != 0 && dataNumber4 != 0 && $("#audit").val() == 0) {
				  $("button#save4").css({"backgroundColor":"#d2201d","cursor":"pointer","color":"#fff"}).prop("disabled",false);
			  } else {
				  $("button#save4").css({"backgroundColor":"#cbcbcb","cursor":"auto","color":"white"}).prop("disabled",true);
			  }
			    
		   }); 
		  survey('#sumdata3', function(){ 

			  if (dataNumber5 != 0 && dataNumber1 != 0 && dataNumber2 != 0 && dataNumber3 != 0 && dataNumber4 != 0 && $("#audit").val() == 0) {
				  $("button#save4").css({"backgroundColor":"#d2201d","cursor":"pointer","color":"#fff"}).prop("disabled",false);
			  } else {
				  $("button#save4").css({"backgroundColor":"#cbcbcb","cursor":"auto","color":"white"}).prop("disabled",true);
			  }
			    
		   }); 
		  survey('#sumdata4', function(){ 

			  if (dataNumber5 != 0 && dataNumber1 != 0 && dataNumber2 != 0 && dataNumber3 != 0 && dataNumber4 != 0 && $("#audit").val() == 0) {
				  $("button#save4").css({"backgroundColor":"#d2201d","cursor":"pointer","color":"#fff"}).prop("disabled",false);
			  } else {
				  $("button#save4").css({"backgroundColor":"#cbcbcb","cursor":"auto","color":"white"}).prop("disabled",true);
			  }
			    
		   }); 
		  survey('#sumdata5', function(){ 

			  if (dataNumber5 != 0 && dataNumber1 != 0 && dataNumber2 != 0 && dataNumber3 != 0 && dataNumber4 != 0 && $("#audit").val() == 0) {
				  $("button#save4").css({"backgroundColor":"#d2201d","cursor":"pointer","color":"#fff"}).prop("disabled",false);
			  } else {
				  $("button#save4").css({"backgroundColor":"#cbcbcb","cursor":"auto","color":"white"}).prop("disabled",true);
			  }
			    
		   }); 


		  /* hidden타입의 input에 값 변경시 감지하는 함수 */
		  function survey(selector, callback) {
		      var input = $(selector);
		      var oldvalue = input.val();
		      setInterval(function(){
		         if (input.val()!=oldvalue){
		             oldvalue = input.val();
		             callback();
		         }
		      }, 100);
		  }
		  	
		  $("#save4").click(function() {
			  var project_goal = $("#project_goal").val();
			  var project_budget = $("#project_budget").val();
			  var project_schedule = $("#project_schedule").val();
			  var project_team_intro = $("#project_team_intro").val();
			  var project_present_intro = $("#project_present_intro").val();
			  var idx = $("#idx").val();
			  if (confirm("저장하시겠습니까?") != true){
				return;
			  }
			  
			  $.ajax({
				  type		: "post",
				  dateType	: "text",
				  url		: "../project/storyUpdate",
				  data		: { "project_goal"			:project_goal,
					  			"project_budget"		:project_budget,
					  			"project_schedule"		:project_schedule,
					  			"project_team_intro"	:project_team_intro,					  			
					  			"project_present_intro"	:project_present_intro,
					  			"idx"					:idx
				  				},
				  success	: function(data){
					 alert("저장완료");
					 $("button#save4").css({"backgroundColor":"#cbcbcb","cursor":"auto","color":"white"}).prop("disabled",true);
				 },
				 error		:function(request,status,error){
				     alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
				 }				 
			  });
		  });		  
	});
</script>
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>

<header class="header_area project_back">
	<div id="btn" class="passbtn_box reward_boxForm">	
		<a class="main-logo" href="/">
		<img class="bunddeuk" alt="" src="${root }/img/core-img/bunddeuk.png">
		</a>
		<button type="button" id="finalSave4" class="btn final-btn final_btn">심사요청</button>
		<button type="button" id="save4" class="btn save save_btn" disabled="disabled">저장하기</button>
	</div>
</header>

<div class="media">
	<div class="main_title" style="width: 350px;">
	<h6>프로젝트 계획<i class="fa fa-asterisk iconStar"></i></h6>
		<br>
		<div class="back_color" style="">
			<span id="span_css" class="fa fa-check-circle-o">
			텍스트 에디터 사용법</span><br>
			<span id="span_css2">· Enter( )를 누르면 문단이 구분됩니다. 문단 내에서
			간격 없이 줄바꿈 하려면 shift(⇧) + enter(↵) 를 사용해주세요.<br>
			· ctrl+c/v를 이용해 선택한 이미지를 입력창 내에서 복사/붙여넣기 할 수 있습니다.<br>
			· 본문 텍스트와 이미지는 되도록 분리해서 작성해주세요. 통 이미지 사용은 불가합니다.</span>
		</div>
	</div>
	<div style="height: 350px;"></div>
	<div class="border_line" id="border_line_box">
		<div class="layout1 editor_line box_css">
		<h6>프로젝트 목적</h6>
		무엇을 만들기 위한 프로젝트인지 분명히 알려주세요.
		    <div>
		      <textarea id="project_goal" name="project_goal" required="required">${dto.project_goal }</textarea>
		    </div>			
		</div>
		<hr>
		<div class="layout1 editor_line box_css">
		<h6>프로젝트 예산</h6>
		펀딩 목표 금액을 제작에 어떻게 사용할 것인지 구체적으로 알려주세요. '인건비','배송비','인쇄비','대관료'등 세부 항목별로 작성해야 합니다.
		    <div>
		      <textarea id="project_budget" name="project_budget" required="required">${dto.project_budget }</textarea>
		    </div>			
		</div>
		<hr>
		<div class="layout1 editor_line box_css">
		<h6>프로젝트 일정</h6>
		작업 일정을 구체적인 날짜와 함께 작성하세요. 후원자가 일정을 보면서 어떤 작업이 진행될지 알 수 있어야 합니다. 펀딩 종료 이후의 제작 일정을 반드시 포함하세요.
		    <div>
		      <textarea id="project_schedule" name="project_schedule" required="required">${dto.project_schedule }</textarea>
		    </div>			
		</div>
		<hr>
		<div class="layout1 editor_line box_css">
		<h6>프로젝트 팀 소개</h6>
		프로젝트를 진행하는 팀(혹은 개인)을 알려주세요. 이 프로젝트를 완수할 수 있다는 점을 후원자가 알 수 있어야 합니다. 이전 프로젝트, 기타 활동 내용, SNS 등을 공개해보세요.
		    <div>
		      <textarea id="project_team_intro" name="project_team_intro" required="required">${dto.project_team_intro }</textarea>
		    </div>			
		</div>
		<hr>
		<div class="layout1 editor_line box_css">
		<h6>선물 설명</h6>
		    <div>
		      <textarea id="project_present_intro" name="project_present_intro" required="required">${dto.project_present_intro }</textarea>
		    </div>			
		</div>
	</div>
</div>
<hr>
<br>
<input type="hidden" name="idx" id="idx" value=${idx }>
<input type="hidden" name="sumdata1" id="sumdata1">
<input type="hidden" name="sumdata2" id="sumdata2">
<input type="hidden" name="sumdata3" id="sumdata3">
<input type="hidden" name="sumdata4" id="sumdata4">
<input type="hidden" name="sumdata5" id="sumdata5">