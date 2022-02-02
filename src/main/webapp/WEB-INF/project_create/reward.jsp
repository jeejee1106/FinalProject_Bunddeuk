<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script type="text/javascript">
	$(document).ready(function() {
	    $('#present_name').on('keyup', function() {
	    	var textlength = $(this).val().length + "/50";
	    	$(".present_length").html(textlength);
	    });
	});
	$(function() {
		projectData();
		projectlist();
		$("#plus_form").hide();
		$("#option_no").click(function() {
			$("#form1").css("border","1px solid red");
			$("#form2").css("border","1px solid #cccccc");
			$(".option_form").val('');
			$("#plus_form").hide();
		});
		$("#option_yes").click(function() {
			$("#form2").css("border","1px solid red");
			$("#form1").css("border","1px solid #cccccc");
			$("#plus_form").show();
			
		});
		
		$("input.price").on("keyup", function() {
			var price_data = $("#price").val();
			price_pay = price_data.split(',').join("");
			if(price_pay >= 1000000){
				$(".den_text2").html("1,000,000원 이하 금액을 입력해주세요");
			}else{
				$(".den_text2").html("");
				
			}
		})
		
		/* 초기화버튼 */
		$("#delete_btn").click(function() {
			$(".option_form").val('');
			$("#present_name").val('');
			$("#price").val('');
		});
		
		$(".searchclear").click(function() {
			$(this).prev().val('');
		})
			
		
		$("#save5").click(function() {
			var count_present = $("#db_present").val();
			if(count_present >= 5) {
				alert("추가가능한 선물은 최대 5개 입니다.");
				return;
			}
			var price_data = $("#price").val();
			if(price_data <=1000){
				alert("금액을 다시 입력해주세요");
				return;
			}
			if (confirm("선물을 추가하시겠습니까?") != true){
				return;
			}
			var present_name = $("#present_name").val();	
			var option1 = $("#option1").val();
			var option2 = $("#option2").val();
			var option3 = $("#option3").val();
			var option4 = $("#option4").val();
			var option5 = $("#option5").val();
			var idx = $("#idx").val();
			var price = price_data.split(',').join("");
			
			var option = '';
			
			if (option1 != '') {
				option += option1 + ',';
			}
			if (option2 != '') {
				option += option2 + ',';
			}
			if (option3 != '') {
				option += option3 + ',';
			}
			if (option4 != '') {
				option += option4 + ',';
			}
			if (option5 != '') {
				option += option5;
			}
			
			option = option.replace(/,$/, '');

 			$.ajax({
				type		: "post",
				dataType	: "text",
				url			: "../project/rewardUpdate",
				data		: { "present_name"	:present_name,
								"option"		:option,
								"price"			:price,
								"idx"			:idx
								},
				success		: function(data){
					alert("추가되었습니다!");	
					$("#present_name").val('');	
					$("#option1").val('');
					$("#option2").val('');
					$("#option3").val('');
					$("#option4").val('');
					$("#option5").val('');
					$("#price").val('');
					projectlist();
					projectData();
				},
				error		:function(request,status,error){
			        alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			    }
			}); 
		});
		
		$(document).on("click",".present_del_btn",function(){
			var num = $(this).next().val();
			//alert(num);
			if (confirm("선물을 삭제하시겠습니까?") != true){
				return;
			}
			$.ajax({
				type		: "post",
				dataType	: "text",
				url			: "../project/presentDelect",
				data		: { "num"	:num},
				context		: this, 
				success		: function(){
					alert("삭제되었습니다!");
					$(this).parent().parent(".present_box").remove();
					projectData();
				},
				error		:function(request,status,error){
			        alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			    }	
			});
								
		})
		
		$('#present_name').on('input', checkInput);
		$('#price').on('input', checkInput);

		function checkInput() {
		  var present_name = $('#present_name').val();
		  var price = $('#price').val();
		  price_pay = price.split(',').join("");

		  if (present_name != '' && price_pay<= 999999999 && price != '' && $("#audit").val() == 0) {
			  $("button#save5").css({"backgroundColor":"#1e90ff","cursor":"pointer","color":"#fff"}).prop("disabled",false);
		  } else {
			  $("button#save5").css({"backgroundColor":"#cbcbcb","cursor":"auto","color":"white"}).prop("disabled",true);
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
	
	function projectlist() {
		var idx = $("#idx").val();
		$.ajax({
			dataType	: "json",
			url			: "../project/presentList",
			data		: {"idx" : idx},
			success		: function(presentData){
				var list = "";
				var count = presentData.length;
				$("#db_present").val(count);
				
				$.each(presentData, function(i, dto){
				var price2 = dto.price.toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",");
				list += "<div class='present_box'>";
				list += 	"<div style='width: 70%'>"
				list +=			"<strong class='strong_font'>" + price2 + "원</strong><br>";
				list +=			"<span>" + dto.present_name + "</span><br>";
			    if(dto.present_option != null){
			    var jbSplit = dto.present_option.split(',');
			    for ( var i in jbSplit) {
			      list +=		 "<span style='font-size: 10px; margin-top: 10px'>" + jbSplit[i] +"<span><br>";
			      }
			    }
				list += 	"</div>";
				list += 	"<div style='width: 30px;'>";
				list += 		"<button type='button' class='btn present_del_btn'><span class='fa fa-trash-o'></span></button>";
				list += 		"<input type='hidden' class='num' value='" + dto.num + "'>";
				list += 	"</div>";
				list += "</div>"
				})
				$("#present_list").html(list);
				projectData();
			},
			error		:function(request,status,error){
		        alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		    }
		})
	}

	function projectData() {
		var idx = $("#idx").val();
		var db_present = $('#db_present').val();
		$.ajax({
			dataType	: "json",
			url			: "../project/getData",
			data		: {"idx" : idx},
			success		: function(data){
			 	$("#db_thumbnail").val(data.thumbnail);
				$("#db_title").val(data.title);
				$("#db_target").val(data.target_amount);//목표금액
				$("#db_project_goal").val(data.project_goal);//에디터작성
				$("#db_policy").val(data.anticipated_problem);
				$("#titl").val(data.title);
				var audit = data.audit;
				//alert(audit);
				
				
				let progress = 0;
				var db_thumbnail = $("#db_thumbnail").val();
				var titl = $("#titl").val();
				var db_target = $('#db_target').val();
				var db_project_goal = $('#db_project_goal').val();
				var db_policy = $('#db_policy').val();
				var zz = "mj";
				
				if(db_thumbnail != ''){
				progress = progress + 16;
				}
				if(titl != ''){
				progress = progress + 16;
				}
				if(db_target != ''){
				progress = progress + 16;
				} 
				if(db_present > 0){
				progress = progress + 20;
				}
				if(db_project_goal != ''){
				progress = progress + 16;
				}
				if(db_policy != ''){
				progress = progress + 16;
				} 
				$("#progress").val(progress);
				
				if(progress == 100 && audit == 0){
					 $("#finalSave1, #finalSave2, #finalSave3, #finalSave4, #finalSave5").css({"backgroundColor":"#d2201d","cursor":"pointer","color":"#fff"}).prop("disabled",false);
				}else if(audit == 1){
					$("button#save0,#save2,#save3,#save4,#save5").css({"backgroundColor":"#cbcbcb","cursor":"auto","color":"white"}).prop("disabled","disabled").html("작성완료");
					$("#finalSave1, #finalSave2, #finalSave3, #finalSave4, #finalSave5").css({"backgroundColor":"#cbcbcb","cursor":"auto","color":"white"}).prop("disabled","disabled").html("＊심사 중");
				}else{
					 $("#finalSave1, #finalSave2, #finalSave3, #finalSave4, #finalSave5").css({"backgroundColor":"#cbcbcb","cursor":"auto","color":"white"}).prop("disabled",true);
				}
			}
		});
	}
</script>
<!-- header(button) -->
<header class="header_area project_back">
	<div id="btn" class="passbtn_box reward_boxForm">	
		<a class="main-logo" href="/">
		<img class="bunddeuk" alt="" src="${root }/img/core-img/bunddeuk.png">
		</a>
	<button type="button" id="finalSave2" class="btn final-btn final_btn">심사요청</button>
	</div>
</header>
<div class="media">
	<div class="main_title" id="rewardForm">
	<h6>내가 만든 선물</h6>
		<br>
		<div>
			<div class="present_box">
				<div class="rewardBox">
					<strong class='strong_font'>1,000원+</strong><br>
					<span>선물 없이 후원하기</span>
				</div>
				<div class="present_box2" style="">
				</div>
			</div>
		</div>
		<div id="present_list">
			<div class="present_box">
				<div class="rewardBox">
					<strong class='strong_font'>1,000원+</strong><br>
					<span>선물 없이 후원하기</span>
				</div>
				<div class="present_box2">
				</div>
			</div>
		</div>
	</div>
	<div>
		<div class="layout1" id="boxLayout">
			<div class="groundBorder">
				<div class="boxLayout boxLayout2">
					<div class="sub_font" id="reward_sub_font">
					선물 만들기<br>
					</div>
					<div>
					선물은 후원자에게 프로젝트의 가치를 전달하는 수단입니다. 
					다양한 금액대로 여러 개의 선물을 만들어주세요. 펀딩 성공률이 높아지고, 
					더 많은 후원 금액을 모금할 수 있어요.
					</div>	
				</div>
				<div class="boxLayout2" id="reward_name">
					<p>선물 이름&nbsp;<span class="fa fa-question-circle-o"></span>
					<div></div>
					<input type="text" placeholder="선물 이름을 입력해주세요" id="present_name"
					class="textform" maxlength="50">
					<div class="present_length">0/50</div>
				</div>	
				<br>
				<div class="boxLayout2" id="reward_option">
					<p>옵션&nbsp;<span class="fa fa-question-circle-o"></span>
					<div>
						<div class="btn-group btn-group-toggle">
							<label class="btn textform" id="form1">
								<input type="radio" name="jb-radio" id="option_no" class="textform"> 없음
							</label>
							<label class="btn textform" id="form2">
								<input type="radio" name="jb-radio" id="option_yes" class="textform" > 객관식
							</label>							
						</div>
					</div>
				</div>
				<div class="boxLayout2" id="plus_form">
					<p>옵션 항목
					<input type="text" class="textform option_form" id="option1" name="option"
					placeholder="옵션 항목을 입력해주세요.예)블랙=230mm,블랙-240mm" maxlength="50">
	            	<span class='searchclear' id=''>&nbsp;&nbsp;X</span><br><br>
					<input type="text" class="textform option_form" id="option2" name="option"
					placeholder="옵션 항목을 입력해주세요.예)블랙=230mm,블랙-240mm" maxlength="50">
	            	<span class='searchclear' id=''>&nbsp;&nbsp;X</span><br><br>
					<input type="text" class="textform option_form" id="option3" name="option"
					placeholder="옵션 항목을 입력해주세요.예)블랙=230mm,블랙-240mm" maxlength="50">
	            	<span class='searchclear' id=''>&nbsp;&nbsp;X</span><br><br>
					<input type="text" class="textform option_form" id="option4" name="option"
					placeholder="옵션 항목을 입력해주세요.예)블랙=230mm,블랙-240mm" maxlength="50">
	            	<span class='searchclear' id=''>&nbsp;&nbsp;X</span><br><br>
					<input type="text" class="textform option_form" id="option5" name="option"
					placeholder="옵션 항목을 입력해주세요.예)블랙=230mm,블랙-240mm" maxlength="50">
	            	<span class='searchclear' id=''>&nbsp;&nbsp;X</span><br><br>
				</div>
				<div class="boxLayout2" id="rewardPay">
					<p>최소 후원 금액&nbsp;<span class="fa fa-question-circle-o"></span>
					<div>
					배송이 필요한 선물은 배송비를 포함해주세요.
					</div>
					<br>
					<input type="text" placeholder="1000원 이상의 금액을 입력해주세요" onkeyup="inputNumberFormat(this)"
					class="textform price" id="price" name="price">
					<div class="den_text2"></div>
				</div>
				<div class="boxLayout2">
				<button type="button" class="btn btn-default" id="delete_btn">초기화</button>
				<button type="button" class="btn" id="save5" disabled="disabled">추가하기</button>
				</div>
				<br>
			</div>
		</div>
	</div>
</div>
<hr>
<br>
<input type="hidden" id="idx" name="idx" value="${idx }">
<input type="hidden" id="db_present">
<input type="hidden" id="audit" value="${dto.audit }">