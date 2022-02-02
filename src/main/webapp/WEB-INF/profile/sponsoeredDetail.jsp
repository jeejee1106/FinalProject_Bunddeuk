<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!-- 후원 성공 세부내역 -->

<link rel="stylesheet" type="text/css" href="/css/support-profile.css">

<style>
.message-modal{ 
		display:none;
		position:fixed;
		width:100%;
		height:100%;
		background: rgba(0,0,0,0.8);
		top:0;
		left:0;
		z-index: 1000;
	
	}

	.modal_content{
		width:600px;
		height:500px;
		background:#fff;
		border-radius:10px;
		position:absolute;
		box-sizing:border-box;
		padding:30px 30px 30px 30px;
		top: calc(50% - 250px);
		left: calc(50% - 300px);
	}
	
	.message-title{
		font-size: 20px;
		font-weight: bold;
		margin-bottom: 20px;
	}
	.message-title2{
		float: right;
		cursor: pointer;
	}
	.word-count{
		float: right;
	}
	#btn-send{
		width: 540px;
		height: 50px;
		margin-top: 10px;
		font-size: 12pt;
		font-weight: bold;
		border-radius: 5px;
		color: white;
		background-color: #dda0dd;
	}
</style>

<script type="text/javascript">
$(function(){
	
	$("button.WarrantyCancelButton").click(function() {
		var num = $(this).attr("num");
		//alert(num);
		var a = confirm("후원을 취소하시겠습니까?");
		if (a == true) {
			var quary = {"num":num};
			$.ajax ({
				type : "get",
				data : quary,
				url : "support_cancel",
				dataType: "text",
				success : function(data) {
					//alert("취소 성공");
					location.href = "backed";
				},
				error: function(){
					alert("code = "+ request.status + " message = " + request.responseText + " error = " + error); // 실패 시 처리
				}
			});
		}
	});
	
	$(".message-title2").click(function(){
		$(".message-modal").fadeOut();
	});
	
 	$(".AskCreatorButton").click(function() {
		var idx = $(this).attr("idx");
		$(".message-modal").fadeIn();
	});
 	
 	$("#btn-send").click(function() {
 		var content = $("#message-content").val();
 		var inquiry_type = $("#inquiry_type").val();
 		var recv_name= $("#recv_name").val(); // 상대방 name
 		var send_name = $("#send_name").val(); // 나의 name
 		
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
 	
});

</script>

<!-- 후원 내역 -->
<div class="Page">
	<section class="ProjectIntroWrapper">
		<div class="inner" style="align-items: start;">
			<div class="ImgArea">
				<a href="/project/detail?idx=${sdto.idx }">
					<img src="../../thumbnail_image/${sdto.thumbnail }">
				</a>
			</div>
			<div class="ProjectInfo">
				<span class="intro">${sdto.category } | ${sdto.name }</span>
				<h3 class="title-ProjectInfo">
					<a href="/project/detail?idx=${sdto.idx }">${sdto.title }</a>
				</h3>
				<div class="flex">
					<strong class="account"><fmt:formatNumber value="${sdto.total_amount }"/>원</strong>
				</div>
				<button class="AskCreatorButton" idx="${sdto.idx }">
					<div name="letter" class="AskCreatorButtonIcon">
						<svg viewBox="0 0 48 48" class="askbtn-svg">
							<path fill-rule="evenodd" clip-rule="evenodd" d="M41.9 37.8966H6.1C5.1 37.8966 4.2 37.0958 4.2 35.997V34.5964L15.7 26.3993L19 29.0977C21.9 31.4981 26.099 31.4981 29.099 29.0977L32.4 26.3993L43.9 34.5964V35.997C43.799 37.0958 43 37.8966 41.9 37.8966ZM13.9 24.9996L4.2 31.898V17.0015L13.9 24.9996ZM43.799 17.0015V31.898L34.099 24.9996L43.799 17.0015ZM6.1 9.20333H41.9C42.9 9.20333 43.799 10.0031 43.799 11.1029V14.2022L27.7 27.499C25.599 29.1986 22.5 29.1986 20.4 27.499L4.2 14.2022V11.0029C4.2 10.0031 5.1 9.10336 6.1 9.20333ZM41.9 7.00385H6.1C3.9 6.90287 2 8.80243 2 11.0029V35.997C2 38.2955 3.9 40.0951 6.1 39.9961H41.9C44.2 39.9961 46 38.1965 46 35.997V11.0029C46 8.80243 44.2 6.90287 41.9 7.00385Z"></path>
						</svg>
					</div>
					<div class="text">창작자에게 문의</div>
				</button>
			</div>
		</div>
	</section>
	<div class="Container_WarrantyDetailWrapper">
		<div class="CardWrapper">
			<div class="SettingForm">
				<div class="FormHeader">
					<p class="FormTitle">후원 정보</p>
				</div>
				<div class="RoundedWrapper">
					<table>
						<tbody>
							<tr>
								<th>후원 날짜</th>
								<td>${sdto.support_date } </td>
							</tr>
							<tr>
								<th>후원 번호</th>
								<td>${sdto.num }</td>
							</tr>
							<tr>
								<th>펀딩 마감일</th>
								<td>${sdto.end_date }</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
		</div>
		<div class="CardWrapper">
			<div class="SettingForm">
				<div class="FormHeader">
					<p class="FormTitle">선물 정보</p>
					<!-- <button class="PlainLink" color="sub0180" type="button">변경</button> -->
				</div>
				<div class="RoundedWrapper">
					<table>
						<tbody>
							<tr>
								<th>선물 구성</th>
								<td>${sdto.present_name }</td>
							</tr>
							<tr>
								<th>후원 금액</th>
								<td><fmt:formatNumber value="${sdto.price }"/>원</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
		</div>
		<div class="CardWrapper">
			<div class="SettingForm">
				<div class="FormHeader">
					<p class="FormTitle">결제 정보</p>
					<!-- <button class="PlainLink" color="sub0180" type="button">변경</button> -->
				</div>
				<div class="RoundedWrapper">
					<table>
						<tbody>
							<tr>
								<th>결제 수단</th>
								<td>카카오페이</td>
							</tr>
							<tr>
								<th>결제 금액</th>
								<td><fmt:formatNumber value="${sdto.price }"/>원</td>
							</tr>
							<tr>
								<th>결제 상태</th>
								<td>
								<c:if test="${sdto.payment_status == 0}">
									결제예약
								</c:if>
								<c:if test="${sdto.payment_status == 1}">
									결제완료
								</c:if>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
		</div>
		<div class="CardWrapper">
			<div class="SettingForm">
				<div class="FormHeader">
					<p class="FormTitle">배송 정보</p>
					<!-- <button class="PlainLink" color="sub0180" type="button">변경</button> -->
				</div>
				<div class="RoundedWrapper">
					<table>
						<tbody>
							<tr>
								<th>받는 사람</th>
								<td>${sdto.id }</td>
							</tr>
							<tr>
								<th>연락처</th>
								<td>${sdto.hp }</td>
							</tr>
							<tr>
								<th>주소</th>
								<td>${sdto.addr }</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
		</div>
		<div class="btn-wrap">
			<button type="button" class="WarrantyCancelButton" num="${sdto.num }">
				후원 취소</button>
			<button type="button" class="GoToWarrantyListButton"
				onclick="location.href='/profile/${sessionScope.url}/backed'">
				후원목록 보기</button>
		</div>
	</div>
</div>

<!-- start message modal -->
<div class="container">
 <div class="message-modal">
	<div class="modal_content">
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
						<input type="text" readonly="readonly" id="recv_name" value="${sdto.name}">
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
			<textarea style="width: 540px; height: 200px;" placeholder="프로젝트 진행자에게 문의하고 싶은 내용을 적어주세요." id="message-content"></textarea>
			<span class="word-count">0/1000</span>
			<button type="button" id="btn-send">전송</button>
		</div>
	</div>
</div>
</div>
<!-- end message modal -->
