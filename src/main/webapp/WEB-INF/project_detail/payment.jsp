<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script type="text/javascript" src="https://service.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" type="text/css" href="/css/payment.css">

<script type="text/javascript">
	$(function(){
		
		$(".final-payment-check-content").hide();
		$(".add-info").hide();
		
		//이용약관 모두 선택해야 버튼 활성화
		$('input[type="checkbox"]').click(function(){
	        var agree = $(".final-check").prop('checked'); 
	        var agreeLength=$("[name='check-agree']:checked").length;

	        if(agree==true && agreeLength==2){
	            $(".btn-final-payment-support").css({"backgroundColor":"skyblue","cursor":"pointer","color":"white"}).prop("disabled",false);
	        }
	        else{
	            $(".btn-final-payment-support").css({"backgroundColor":"#cbcbcb","cursor":"auto","color":"white"}).prop("disabled",true);
	        }
	    });
		
		//이용약관 펼치기
		$(".down-icon").click(function(){
			$(this).parent().siblings().toggle(500);
			if(!$(this).hasClass("icon-change")){
				$(this).addClass("icon-change");
				$(this).html("닫기&nbsp;<i class='fa fa-angle-up'></i>");
			}else{
				$(this).removeClass("icon-change");
				$(this).html("열기&nbsp;<i class='fa fa-angle-down'></i>");
			}
		});
		
		//이메일 선택 이벤트
		$("#selemail").change(function(){
			if($(this).val()=='_'){
				$("#email2").val(''); //지정된 메일 지우기
				$("#email2").focus(); //포커스 주기
			}else{
				$("#email2").val($(this).val());
			}
		});
		
		//추가 버튼 누르면 정보 입력창 띄우기
		$(".plus-icon").click(function(){
			$(this).next(".add-info").show();
		});
		
		//입력받은 핸드폰 번호 바로 출력하기
		$(".btn-add-hp").click(function(){
			var id = "${sessionScope.id}";
			var hp1 = $("#hp1").val();
			var hp2 = $("#hp2").val();
			var hp3 = $("#hp3").val();
			var hp = hp1 + "-" + hp2 + "-" + hp3;
			//alert(hp + id);
			
			$.ajax({
				type : "post",
				url : "/payment/hpUpdate",
				data : {"hp":hp, "id":id},
				success : function(data){
					$("#add-hp").html(data);
					$("#ajax_hp").val(data);
				},
				error : function(request,status,error){
			        alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			    }
			});
		});
		
		//입력받은 이메일 바로 출력하기
		$(".btn-add-email").click(function(){
			var id = "${sessionScope.id}";
			var email1 = $("#email1").val();
			var email2 = $("#email2").val();
			var email = email1 + "@" + email2;
			//alert(email + id);
			
			$.ajax({
				type : "post",
				url : "/payment/emailUpdate",
				data : {"email":email, "id":id},
				success : function(data){
					$("#add-email").html(data);
					$("#ajax_email").val(data);
				},
				error : function(request,status,error){
			        alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			    }
			});
		});
		
		//입력받은 배송지 바로 출력하기
		$(".btn-add-addr").click(function(){
			//alert("Df");
			var check = $("#pin").is(":checked");
			var id = "${sessionScope.id}";
			var name=$("#name").val();
			var addr=$("#sample4_roadAddress").val();
			var addr2=$("#sample4_detailAddress").val();
			var hp=$("#deli-hp").val();
			
			$.ajax({
				type:"get",
				dataType:"text",
				data:{"id":id,"name":name,"addr":addr,"addr2":addr2,"hp":hp},
				url:"/payment/deliveryInsert",
				success:function(data){
					$("#add-addr").html(data);
					$("#ajax_addr").val(data);
				},error : function(request,status,error){
			        alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			    }
			});
		});
		
		
	});
</script>
<div class="container project-payment">
	<div class="project-info">
		<div class="project-info-img">
			<img alt="" src="/thumbnail_image/${dto.thumbnail }">
		</div>
		<div class="project-info-intro">
			<span class="project-info-intro-category">
				${dto.category }
			</span>
			<h4 class="project-info-intro-title">
				${dto.title }
			</h4>
			<div class="project-info-intro-sub">
				<span style="font-weight: bold;"><fmt:formatNumber value="${dto.total_amount }"/>원</span>&nbsp;
				<span style="color: red">${percentageAchieved }%</span>&nbsp;
				<span>
					<fmt:parseDate value="${today }" var="strPlanDate" pattern="yyyy-MM-dd"/>
					<fmt:parseNumber value="${strPlanDate.time / (1000*60*60*24)}" integerOnly="true" var="strDate" />
					<fmt:parseDate value="${dto.end_date }" var="endPlanDate" pattern="yyyy-MM-dd"/>
					<fmt:parseNumber value="${endPlanDate.time / (1000*60*60*24)}" integerOnly="true" var="endDate" />
					${endDate - strDate }일 남음
				</span>
			</div>
		</div>
	</div>
	
	<hr>
	
	<form action="/project_support/success" method="post" id="final-support-submit">
		<input type="hidden" name="id" id="id" value="${sessionScope.id}">
		<input type="hidden" name="idx" value="${dto.idx}">
		<input type="hidden" name="supportNum" value="${dto.number_support}">
		<input type="hidden" name="end_date" value="${dto.end_date}">
		<%-- <input type="hidden" name="addr" value="${addr}"> --%>
		<input type="hidden" name="present_name" value="${pstN}">
		<input type="hidden" name="present_option" value="${pstO}">
		<input type="hidden" name="price" value="${pstP}">
		<input type="hidden" name="pstP" value="${pstP }">
	
		<input type="hidden" id="db_hp" value="${mdto.hp }">
		<input type="hidden" id="db_addr" value="${addr }">
		<input type="hidden" id="db_email" value="${mdto.email }">
		<input type="hidden" name="ajax_addr" id="ajax_addr">
		<input type="hidden" name="ajax_email" id="ajax_email">
		<input type="hidden" name="ajax_hp" id="ajax_hp">
	
	
		<div class="payment-content">
			<div class="payment-left">
				<div class="project-payment-info">
					<div class="payment-info-present">
						<div class="payment-info-title">
							선물 정보
						</div>
						<table class="info-table">
							<thead>
								<tr>
									<th>선물 구성</th>
									<td>
										${pstN } / 옵션 : ${pstO }
									</td>
								</tr>
								<tr>
									<th>선물 금액</th>
									<td>
										<fmt:formatNumber value="${pstP }"/>
									</td>
								</tr>
							</thead>
						</table>
					</div>
					<div class="payment-info-support">
						<div class="payment-info-title">
							후원자 정보
						</div>
						<table class="info-table">
							<thead>
								<tr>
									<th>연락처</th>
									<td id="add-hp">
										<c:choose>
											<c:when test="${mdto.hp == null}">
												연락처를 등록해주세요 <i class="fa fa-plus plus-icon">&nbsp;추가</i>
												<div class="add-info add-info-hp">
													<select name="hp1" id="hp1" class="hp-text">
														<option value="-" selected="selected" disabled="disabled">선택</option> 
														<option value="010">010</option>
														<option value="011">011</option>
														<option value="016">016</option>
														<option value="017">017</option>
														<option value="018">018</option>
														<option value="019">019</option>
													</select>
													<b>-</b>
													<input type="text" class="hp-text" id="hp2" required="required" maxlength="4">
													<b>-</b>
													<input type="text" class="hp-text" id="hp3" required="required" maxlength="4">
													<span>
														<button type="button" class="btn-add-info btn-add-hp">등록하기</button>
													</span>
												</div>
											</c:when>
											<c:otherwise>
												${mdto.hp }
											</c:otherwise>
										</c:choose>
									</td>
								</tr>
								<tr>
									<th>이메일</th>
									<td id="add-email">
										<c:choose>
											<c:when test="${mdto.email == null}">
												이메일을 등록해주세요 <i class="fa fa-plus plus-icon">&nbsp;추가</i>
												<div class="add-info add-info-email">
													<input type="text" class="email-text" id="email1" required="required">
													<b>@</b>
													<input type="text" class="email-text" id="email2" required="required">
													<select id="selemail">
														<option value="_">직접입력</option>
														<option value="naver.com">네이버</option>
														<option value="nate.com">네이트</option>
														<option value="gmail.com">구글</option>
														<option value="hanmail.net">다음</option>
													</select>
													<span>
														<button type="button" class="btn-add-info btn-add-email">등록하기</button>
													</span>
												</div>
											</c:when>
											<c:otherwise>
												${mdto.email }
											</c:otherwise>
										</c:choose>
									</td>
								</tr>
								<tr>
									<th>배송주소</th>
									<td id="add-addr">
										<c:choose>
											<c:when test="${addr == 'x x'}">
												배송지를 등록해주세요 <i class="fa fa-plus plus-icon PlainLink__StyledLink-qbfirs-0 iFKMSH delivery"
												data-toggle="modal" data-target="#moaModal">&nbsp;추가</i>
											</c:when>
											<c:otherwise>
												${addr}
											</c:otherwise>
										</c:choose>
									</td>
								</tr>
							</thead>
						</table>
					</div>
				</div>
			</div>
			<div class="payment-right">
				<div class="final-payment-info">
					<span class="final-title">최종 후원 금액</span>
					<fmt:formatNumber value="${pstP }"/>원
				</div>
				<div class="final-payment-notice">
					<div class="final-notice">
						프로젝트 성공시, 결제는 <strong style="color: tomato">${pymDate}</strong> 에 진행됩니다.
						프로젝트가 무산되거나 중단된 경우, 예약된 결제는 자동으로 취소됩니다.
					</div>
					<div class="final-payment-check">
						<div class="final-payment-check-privacy">
							<div class="final-payment-check-title">
								<span>
									<label>
										<input type="checkbox" class="final-check" name="check-agree">&nbsp; 개인정보 제 3자 제공 동의
									</label>
								</span>
								<span class="down-icon">
									열기&nbsp;<i class="fa fa-angle-down"></i>
								</span>
							</div>
							<div class="final-payment-check-content">
								회원의 개인정보는 당사의 개인정보 취급방침에 따라 안전하게 보호됩니다. 
								'회사'는 이용자들의 개인정보를 개인정보 취급방침의 '제 2조 수집하는 개인정보의 항목, 수집방법 및 이용목적'에서 고지한 범위 내에서 사용하며, 
								이용자의 사전 동의 없이는 동 범위를 초과하여 이용하거나 원칙적으로 이용자의 개인정보를 외부에 공개하지 않습니다.
								<table class="final-payment-check-privacy-content-tb">
									<tr>
										<th style="width: 100px;">제공받는 자</th>
										<td>후원 프로젝트의 창작자</td>
									</tr>
									<tr>
										<th>제공 목적</th>
										<td>선물 전달 및 배송과 관련된 상담 및 민원처리</td>
									</tr>
									<tr>
										<th>제공 정보</th>
										<td>수취인 성명, 휴대전화 번호, 배송 주소</td>
									</tr>
									<tr>
										<th>보유 및 이용 기간</th>
										<td>재화 또는 서비스의 제공이 완료된 즉시 파기(단, 관계법령에 정해진 규정에 따라 법정기간 동안 보관)</td>
									</tr>
								</table>
								* 동의 거부권 등에 대한 고지
								개인정보 제공은 서비스 이용을 위해 꼭 필요합니다. 개인정보 제공을 거부하실 수 있으나, 이 경우 서비스 이용이 제한될 수 있습니다.
							</div>
						</div>
						<div class="final-payment-check-instructions">
							<div class="final-payment-check-title">
								<span>
									<label>
										<input type="checkbox" class="final-check" name="check-agree">&nbsp; 후원 유의사항 확인
									</label>
								</span>
								<span class="down-icon">
									열기&nbsp;<i class="fa fa-angle-down"></i>
								</span>
							</div>
							<div class="final-payment-check-content">
								<li>
									후원은 구매가 아닌 창의적인 계획에 자금을 지원하는 일입니다.
								</li>
								<div style="padding-left: 15px;">
									텀블벅에서의 후원은 아직 실현되지 않은 프로젝트가 실현될 수 있도록 제작비를 후원하는 과정으로, 
									기존의 상품 또는 용역을 거래의 대상으로 하는 매매와는 차이가 있습니다. 따라서 전자상거래법상 청약철회 등의 규정이 적용되지 않습니다.
								</div>
								<li>
									프로젝트는 계획과 달리 진행될 수 있습니다.
								</li>
								<div style="padding-left: 15px;">
									예상을 뛰어넘는 멋진 결과가 나올 수 있지만 진행 과정에서 계획이 지연, 변경되거나 무산될 수도 있습니다. 
									본 프로젝트를 완수할 책임과 권리는 창작자에게 있습니다.
								</div>
							</div>
						</div>
					</div>
					<div class="final-payment-button">
						<button type="button" class="btn-final-payment-support" disabled="disabled">
							후원하기
						</button>
					</div>
				</div>
			</div>
		</div>
	</form>
</div>

<!-- delivery Modal start-->
<div class="modal fade" id="moaModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title" id="exampleModalLabel"><b>배송지 추가</b></h4>
				<button class="close" type="button" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">x</span>
				</button>
			</div>
			<div class="modal-body">
				<span>받는 사람</span>
				<input type="hidden" name="id" id="id" value="${dto.id }">
				<input type="text" class="form-control" style="margin-top:10px; width:60%; height:40px;" id="name" placeholder="받는 분 성함을 입력해주세요."
					name="name" maxlength="20" required="required" >
				<span>주소</span>
				<input type="hidden" id="sample4_postcode" placeholder="우편번호">
				<span style="margin-top:30px; cursor:pointer;" onclick="sample4_execDaumPostcode()">
					<i class="fa  fa-search"></i>
				</span><br>
				<input type="text" class="form-control addr" style="margin-top:10px; height:40px;" id="sample4_roadAddress" placeholder="도로명주소">
				<span id="guide" style="color:#999;display:none"></span><br>
				<input type="text" class="form-control addr2" id="sample4_detailAddress" style="margin-top:-10px; margin-bottom:30px; height:40px;" placeholder="상세주소">
				<span>받는 사람 휴대폰 번호</span>
				<input type="text" class="form-control" id="deli-hp" name="hp" maxlength="20" style="width: 100%; margin-top: 10px; height:40px;" placeholder="받는 분 휴대폰 번호를 입력해주세요.">
				<input type="checkbox" id="pin" style="margin-top:30px; margin-bottom:20px;" checked="checked" disabled="disabled"> 기본 배송지로 등록   
				<div class="modal-footer">
					<button class="btn btn-danger btn-add-addr" style="width:100%" type="submit" data-dismiss="modal">등록완료</button>
				</div>
			</div>
		</div>
	</div>
</div>

<!-- kakaopayment API -->
<script src="/js/kakaopayment.js"></script>

<!-- delivery Modal end-->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"> </script>
<script>
function sample4_execDaumPostcode() {
	new daum.Postcode({
		oncomplete: function(data) {
			// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

			// 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
			// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
			var roadAddr = data.roadAddress; // 도로명 주소 변수
			var extraRoadAddr = ''; // 참고 항목 변수

			// 법정동명이 있을 경우 추가한다. (법정리는 제외)
			// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
			if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
				extraRoadAddr += data.bname;
			}
			// 건물명이 있고, 공동주택일 경우 추가한다.
			if(data.buildingName !== '' && data.apartment === 'Y'){
				extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
			}
			// 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
			if(extraRoadAddr !== ''){
				extraRoadAddr = ' (' + extraRoadAddr + ')';
			}
	
			// 우편번호와 주소 정보를 해당 필드에 넣는다.
			document.getElementById('sample4_postcode').value = data.zonecode;
			document.getElementById("sample4_roadAddress").value = roadAddr;
	
			var guideTextBox = document.getElementById("guide");
			// 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
			if(data.autoRoadAddress) {
				var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
				guideTextBox.innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
				guideTextBox.style.display = 'block';
			} else if(data.autoJibunAddress) {
				var expJibunAddr = data.autoJibunAddress;
				guideTextBox.innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';
				guideTextBox.style.display = 'block';
			} else {
				guideTextBox.innerHTML = '';
				guideTextBox.style.display = 'none';
			}
		}
	}).open();
}
</script>