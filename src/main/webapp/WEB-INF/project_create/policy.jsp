<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script>
$(function() {
	$("#copy").hide();
	$("#data").hide();
	var data = $("#data").val();
	var copy = $("#copy").val();
	if(data != "" && data != copy){
		$("#anticipated_problem").val(data);
	}
	$("#save3").click(function() {
		var anticipated_problem = $("#anticipated_problem").val();
		var idx = $("#idx").val();		
		
		if(anticipated_problem == copy || anticipated_problem == data){
		alert("내용을 입력주세요");
		$("button#save3").css({"backgroundColor":"#cbcbcb","cursor":"auto","color":"white"}).prop("disabled",true);
		}else if (confirm("저장하시겠습니까?") != true){
			return;
		}else{
			$("button#save3").css({"backgroundColor":"#d2201d","cursor":"pointer","color":"#fff"}).prop("disabled",false);
			$.ajax({
				type		: "post",
				dataType	: "text",
				url			: "policyUpdate",
				data		: {"anticipated_problem":anticipated_problem, "idx":idx},
				success		: function(date){
					alert("저장되었습니다!");
					projectData();
					$("#anticipated_problem").val(anticipated_problem);
					$("button#save3").css({"backgroundColor":"#cbcbcb","cursor":"auto","color":"white"}).prop("disabled",true);
				},
				error		:function(request,status,error){
			        alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			    }
			});
		}
	});
	$("#anticipated_problem").on("input",function() {
		var anticipated_problem = $("#anticipated_problem").val();
		var copy = $("#copy").val();
		
		if(anticipated_problem != copy && $("#audit").val() == 0){
			 $("button#save3").css({"backgroundColor":"#d2201d","cursor":"pointer","color":"#fff"}).prop("disabled",false);
		}else{
			 $("button#save3").css({"backgroundColor":"#cbcbcb","cursor":"auto","color":"white"}).prop("disabled",true);
			 
		}
	});
})
</script>    
<!-- header(button) -->
<header class="header_area project_back">
	<div id="btn" class="passbtn_box box_css3 reward_boxForm">	
		<a class="main-logo" href="/">
		<img class="bunddeuk" alt="" src="${root }/img/core-img/bunddeuk.png">
		</a>
		<button type="button" id="finalSave3" class="btn final-btn final_btn">심사요청</button>
		<button type="button" id="save3" class="btn save save_btn" disabled="disabled">저장하기</button>
	</div>
</header>
<div class="media">
	<div class="main_title">
	<h6>예상되는 어려움<i id="span_css3" class="fa fa-asterisk"></i></h6>
		<div class="sub_text">
			펀딩 진행 및 선물 전달 과정에서 발생 가능한 문제가 있다면 후원자에게 명확하게 알려주세요.
			 대응 계획을 함께 적는다면 후원자에게 신뢰를 줄 수 있습니다.		
		</div>
	</div>
	<div>
		<div class="layout1">
			<div class="groundBorder" id="box_css3">
				<div>
					<div class="sub_font polict_css1">
					<span class="fa fa-exclamation-circle"></span>
					&nbsp;예상되는 어려움<br>
					</div>
					<div style="margin: 20px;">
					프로젝트의 진행 및 선물 전달 과정에서 예상되는 어려움을 기입해주세요.<br><br>
					아래와 같은 사항을 고려해서 작성해보세요.<br>
					</div>
				</div>
				<div>
					<textarea rows="" class="border_line" cols=""id="anticipated_problem">
					
	· 제작 과정에서 발생할 수 있는 변동사항이 있다면 무엇인가요? (예산, 선물 내용 등)
	· 선물 전달 일정이 지연될 가능성이 있나요 ?
	· 펀딩 자금이 고갈돼 선물을 전달하지 못한다면 어떤 조치를 취할 수 있을까요?
	· 이외에 발생가능한 문제는 무엇이 있으며 어떻게 대응할 예정인가요?
					</textarea>
				</div>	
			</div>
		</div>
	</div>
</div>
<hr>
<br>
<div class="media">
	<div class="main_title">
	<h6>프로젝트 후원 정책<i class="fa fa-asterisk" id="span_css2"></i></h6>
		<div class="sub_text">
			프로젝트 진행 및 선물 전달 과정에서 발생할 수 있는 위험 요소를 고려하여 신중히 설정해주세요. 
			예기치 못한 분쟁이 발생할 경우 중요한 기준이 됩니다.	
		</div>
	</div>
	<div>
		<div class="layout1">
			<div class="groundBorder" style="height: 400px;">
				<div>
					<div class="policy_css2">
					<span class="fa fa-file-text"></span>
					&nbsp;교환 및 환불 안내<br>
					</div>
					<div style="margin: 20px;">
					공통적으로 적용되는 교환 및 환불 정책입니다.<br><br>
					</div>
				</div>
				<div>
					<textarea rows="" class="border_line" cols="" id="anticipated" disabled>
					
모든 프로젝트 공통
- 펀딩 종료일 후에는 즉시 제작 및 실행에 착수하는 프로젝트 특성상 단순 변심에 의한 후원금 환불이 불가능합니다.
- 예상 전달일로부터 30일 이상 선물 전달이 이뤄지지 않을 경우, 환불을 원하시는 분들께는 수수료를 제한 후원금을 환불해 드립니다.
(플랫폼 수수료: 모금액의 5%, 부가세 별도 / 결제 수수료: 결제 성공액의 3%, 부가세 별도 )
- 선물 전달을 위한 배송지 및 서베이 답변은 종료 후 3일 후에 일괄 취합할 예정입니다.
- 이후 배송지 변경이나 서베이 답변 변경을 원하실 때에는 '창작자에게 문의하기'로 개별 문의하셔야 합니다.

배송이 필요한 선물
- 파손 또는 불량품 수령 시 7일 이내로 교환이 가능합니다.
- 교환 및 AS 문의는 '창작자에게 문의하기'로 신청해 주세요.
- 파손이나 불량품 교환시 발생하는 비용은 창작자가 부담합니다. 선물 확인을 위한 포장 훼손 외에 아이템의 가치가 훼손된 경우에는 교환 및 환불이 불가합니다.
- 후원자가 배송지를 잘못 기재하거나 창작자에게 사전 고지 없이 배송지를 수정하여 배송사고가 발생할 경우 
창작자는 최대  2번까지 재발송 해 드립니다. 배송비 부담은 후원자에게 있습니다.

공연/행사 등 현장수령으로 이루어지는 선물
- 행사 참가권은 타인에게 양도가 불가능합니다.
- 현장에서 수령해야 하는 선물을 수령하지 못하신 경우 환불은 가능하며, 선물 배송을 위한 추가 배송비를 별도 요청드릴 수 있습니다.

디지털 콘텐츠로 이뤄진 선물
- 전달된 파일에 심각한 결함이나 저작권상 문제가 있을 경우, 수수료 제외하여 환불 가능합니다.
- 전달된 파일은 타인에게 양도가 불가능합니다.
					</textarea>
				</div>	
			</div>
		</div>
	</div>
</div>
				<div>
					<textarea rows="" class="border_line" cols="" id="copy">
					
	· 제작 과정에서 발생할 수 있는 변동사항이 있다면 무엇인가요? (예산, 선물 내용 등)
	· 선물 전달 일정이 지연될 가능성이 있나요 ?
	· 펀딩 자금이 고갈돼 선물을 전달하지 못한다면 어떤 조치를 취할 수 있을까요?
	· 이외에 발생가능한 문제는 무엇이 있으며 어떻게 대응할 예정인가요?
					</textarea>
				</div>
<input type="hidden" id="idx" name="idx" value="${idx }">
<textarea id="data">${dto.anticipated_problem }</textarea>