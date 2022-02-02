<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" integrity="sha512-894YE6QWD5I59HgZOGReFYm4dnWc1Qt5NtvYSaNcOP+u1T9qYdvdihz0PPSiiqn/+/3e7Jo4EaG7TubfWGUrMQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js" integrity="sha512-uto9mlQzrs59VwILcLiRYeLKPPbS/bT71da/OEBYEwcdNUk8jYIy+D176RYoop1Da+f9mvkYrmj5MCLZWEtQuA==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.css" integrity="sha512-aOG0c6nPNzGk+5zjwyJaoRUgCdOrfSDhmMID2u4+OIslr0GjpLKo7Xm0Ao3xmpM4T8AmIouRkqwj1nrdVsLKEQ==" crossorigin="anonymous" referrerpolicy="no-referrer" />

<script>
	$(document).ready(function(){
		var goal_pay = "${dto.target_amount }";
		if(goal_pay != ''){
		var pay_fee = goal_pay * 0.033;
		var flet_fee = goal_pay * 0.055;
		var total_fee = pay_fee + flet_fee;
		var total_pay = goal_pay - total_fee;
		
		var option = {
				  maximumFractionDigits: 0
				};
		$("#goal_pay").html(total_pay.toLocaleString('ko-KR',option) + "원");
		
		/* 총 수수료 */
		$("#total_fee").html(total_fee.toLocaleString('ko-KR',option) + "원"); 
		
		/* 결제수수료3.3% */
		$("#pay_fee").html(pay_fee.toLocaleString('ko-KR',option) + "원");
		/* 플랫폼 수수료 5.5% */
		$("#flet_fee").html(flet_fee.toLocaleString('ko-KR',option) + "원"); 
		
		$("#target_amount").val(goal_pay);
		}
	});

	$(function(){	
		$("#start_date").datepicker({
			closeText: '닫기',
			
			prevText: '이전달',

			nextText: '다음달',

			currentText: '오늘',

			monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],

			monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],

			dayNames: ['일','월','화','수','목','금','토'],

			dayNamesShort: ['일','월','화','수','목','금','토'],

			dayNamesMin: ['일','월','화','수','목','금','토'],

			weekHeader: 'Wk',

			dateFormat: 'yy-mm-dd',

			firstDay: 0,

			isRTL: false,

			duration:200,

			showAnim:'show',

			showMonthAfterYear: true,

			yearSuffix:'년' , 
			
			minDate: 10 , 
			
			maxDate: "+60D" ,
			
			onSelect: showDays,
			
			onSelect: function (date) {
				var endDate = $('#end_date');
				var startDate = $(this).datepicker('getDate');
				var minDate = $(this).datepicker('getDate');
				endDate.datepicker('setDate', minDate);
				startDate.setDate(startDate.getDate() + 30);
				endDate.datepicker('option', 'maxDate', startDate);
				endDate.datepicker('option', 'minDate', minDate);
			}
		});
		
		$("#end_date").datepicker({
			closeText: '닫기',
			
			prevText: '이전달',

			nextText: '다음달',

			currentText: '오늘',

			monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],

			monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],

			dayNames: ['일','월','화','수','목','금','토'],

			dayNamesShort: ['일','월','화','수','목','금','토'],

			dayNamesMin: ['일','월','화','수','목','금','토'],

			weekHeader: 'Wk',

			dateFormat: 'yy-mm-dd',

			firstDay: 0,

			isRTL: false,

			duration:200,

			showAnim:'show',

			showMonthAfterYear: true,

			yearSuffix:'년',
			
			onSelect: showDays
		});
		
		$("#end_date").click(function(){
			var sart = $("#start_date").val();
			if(sart.trim().length == 0){
				alert("시작일을 입력해주세요");
				$("#start_date").focus();
				return;
			}
		});
		function showDays() {
		    var start = $('#start_date').datepicker('getDate');
		    var end   = $('#end_date').datepicker('getDate');
		    if(!start || !end)
		        return;
		    var days = (end - start)/1000/60/60/24;
		    $('#num_nights').html(days + "일");  
		    $('#test_day').val(days + "일");  
		}
		
		$('input.num').on('keyup', function () {
			var pay = $("#target").val();
			
			goal_pay = pay.split(',').join("");
			if(goal_pay > 999999999) {
				$(".den_text").html("999,999,999원 이하인 금액을 입력해주세요.");
			}else{
				$(".den_text").html("");
				
			}
			
			var option = {
					  maximumFractionDigits: 0
					};
			
			var pay_fee = goal_pay * 0.033;
			var flet_fee = goal_pay * 0.055;
			var total_fee = pay_fee + flet_fee;
			var total_pay = goal_pay - total_fee;
			
			$("#goal_pay").html(total_pay.toLocaleString('ko-KR',option) + "원");
			
			/* 총 수수료 */
			$("#total_fee").html(total_fee.toLocaleString('ko-KR',option) + "원"); 
			
			/* 결제수수료3.3% */
			$("#pay_fee").html(pay_fee.toLocaleString('ko-KR',option) + "원");
			/* 플랫폼 수수료 5.5% */
			$("#flet_fee").html(flet_fee.toLocaleString('ko-KR',option) + "원"); 
			
			$("#target_amount").val(goal_pay);
			
		});		
		
		$("#save2").click(function(){
			var idx = $("#idx").val();
			var target_amount = $("#target_amount").val();
			var start_date = $("#start_date").val();
			var time_start = $("#time_start").val();
			var end_date = $("#end_date").val();
			var test_day = $('#test_day').val();
			if (confirm("저장하시겠습니까?") != true){
				return;
			}
			$.ajax({
				type		: "post",
				dateType	: "text",
				url			: "../project/fundingUpdate",
				data		: {	"idx"			:idx,
								"target_amount"	:target_amount,
								"start_date"	:start_date,
								"time_start"	:time_start,
								"end_date"		:end_date
								},
				success		: function(data){
					alert("저장완료");
					$("#db_target").val("1");
					projectData();
					//db_target = target_amount;
					$("button#save2").css({"backgroundColor":"#cbcbcb","cursor":"auto","color":"white"}).prop("disabled",true);
				},
				error		:function(request,status,error){
			        alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			    }
			});
		});

		
 		$('#target').on('input', checkInput);
		$('#start_date').on('input', checkInput);
		$('#time_start').on('change', checkInput);
		$('#end_date').on('change keyup paste', checkInput);

		// input 입력 시에 checkInput 함수실행
		function checkInput() {
		  var target = $('#target').val();
		  var test_day = $('#test_day').val();
		  var pay = $("#target").val();
		  goal_pay = pay.split(',').join("");
		  var sart = $("#start_date").val();
		  if (target != '' && goal_pay >= 500000 && goal_pay <= 999999999 && $("#audit").val() == 0 && sart.trim().length != 0) {
			  $("button#save2").css({"backgroundColor":"#d2201d","cursor":"pointer","color":"#fff"}).prop("disabled",false);
		  } else {
			  $("button#save2").css({"backgroundColor":"#cbcbcb","cursor":"auto","color":"white"}).prop("disabled",true);
		  }
		}		
	});

	function inputNumberFormat(obj) {
	    obj.value = comma(uncomma(obj.value));
	}
	
	function comma(str) {
	    str = String(str);
	    return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
	}
	
	function uncomma(str) {
	    str = String(str);
	    return str.replace(/[^\d]+/g, '');
	}
</script>
<!-- header(button) -->
<header class="header_area project_back">
		<div id="btn" class="passbtn_box reward_boxForm">	
			<a class="main-logo" href="/">
			<img class="bunddeuk" alt="" src="${root }/img/core-img/bunddeuk.png">
			</a>
		<button type="button" id="finalSave5" class="btn final-btn final_btn">심사요청</button>
		<button type="button" id="save2" class="btn save save_btn" disabled="disabled">저장하기</button>
	</div>
</header>
<div class="media">
	<div class="main_title">
	<h6>목표 금액<i class="fa fa-asterisk iconStar"></i></h6>
		<div class="sub_text">
			프로젝트를 완수하기 위해 필요한 금액을 설정해주세요.		
		</div>
		<br>
		<div class="goalText">
			<span style="" class="fa fa-check-circle-o">
			목표 금액을 설정 시 꼭 알아두세요!</span><br>
			<span style="font-size: 11px;">* 종료일까지 목표금액을 달성하지 못하면 후원자 결제가 진행되지 않습니다.<br>
			* 종료 전 후원 취소를 대비해 10% 이상 초과 달성을 목표로 해주세요.<br>
			* 제작비, 선물 배송비, 인건비, 예비 비용 등을 함께 고려해주세요.</span>
		</div>
	</div>
	<div>
		<div class="layout1">
			<div class="groundBorder" id="borderGround">
				<div>
					<div style="" class="sub_font" id="goalPayCss">
					목표금액<br>
					</div>
				</div>
				<div>
					<input type="text" placeholder="50만원 이상의 금액을 입력해주세요" id="target" name="target" required="required"
					class="textform num" onkeyup="inputNumberFormat(this)" value='<fmt:formatNumber value="${dto.target_amount }"></fmt:formatNumber>'>원
					<div class="den_text"></div>
				</div>	
				<div class="madeGoalPay">
					목표금액 달성 시 예상 수령액<span id="goal_pay" class="playPay"></span>
					<br><hr>
					총 수수료 <span id="total_fee" class="playPay"></span> <br>
					결제대행 수수료(총 결제액의 3% + VAT) <span id="pay_fee" class="playPay"></span><br>
					플랫폼 수수료(총 모금액의 5% + VAT)<span id="flet_fee" class="playPay"></span>
				</div>
			</div>
		</div>
	</div>
</div>
<hr>
<br>
<div class="media">
	<div class="main_title">
	<h6>펀딩 일정<i class="fa fa-asterisk iconStar"></i></h6>
		<div class="sub_text">
			설정한 일시가 되면 펀딩이 자동 시작됩니다.<br> 펀딩 시작 전까지 날짜를 변경할 수 있고, 즉시 펀딩을 시작할 수도 있습니다.
		</div>
	</div>
	<div>
		<div class="layout1" >
			<ol>
				<li>
					<div class="dateData">
						<div class="startDateForm">
							<p>시작일
							<div>
								<input type="text" class="textform" id="start_date" required="required" value="${dto.start_date }">
							</div>
						</div >
						<div style="width: 20px;"></div>
						<div class="startDateForm">
							<p>시작 시간
							<div>
							<select id="time_start" name="time_start" class="textform">
								<option disabled="disabled" selected="selected">시간을 선택해주세요</option>
								<c:set var="breakPoint" value="0" />
								<c:forEach var="i" begin="09" end="18">
								    <c:forEach var="j" begin="0" end="1">
								        <c:if test="${(i == 18) && (j == 1)}">    
								            <c:set var="breakPoint" value="1" />                                    
								        </c:if>
								        <c:if test="${breakPoint == 0}">    
								                                        
								            <option value="${i}:<fmt:formatNumber pattern="00" value="${j*30}" />">${i}시<fmt:formatNumber pattern="00" value="${j*30}" />분</option>                                                                            
								        </c:if>
								    </c:forEach>
								</c:forEach>
								</select>
							</div>
						</div>
					</div>
					<div class="fundingTime">
						<p>펀딩기간
						<div id="total_date">
							<span id="num_nights"></span>
						</div>
					</div>
				</li>
				<li>
					<div class="endDateForm">
						<div>
							<p>종료일
						</div>
						<div class="endDate_form">
							<input type="text" class="textform" id="end_date" required="required" value="${dto.end_date }">
						</div>
					</div>
					<br><br>
				</li>
				<li>
					<div class="fundingTime2">
						<p>후원자 결제 종료
						<div id="total_date">
						종료일 다음 날부터 7일</div>
					</div>					
				</li>
				<li>
					<div class="fundingTime2">
						<p>정산일
						<div id="total_date">
						후원자 결제 종료 다음 날부터 7영업일</div>
					</div>					
				</li>
			</ol>
		</div>
	</div>
</div>
<input type="hidden" id="idx" name="idx" value="${idx }">
<input type="hidden" id="target_amount" name="target_amount">
<input type="hidden" id="test_day" name="test_day">
<input type="hidden" id="db_target" name="db_target" value="${dto.target_amount }">
