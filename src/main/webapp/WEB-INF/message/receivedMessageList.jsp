<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 받은 메세지 리스트-->

<link rel="stylesheet" type="text/css" href="/css/profile.css">

<script type="text/javascript">
$(function(){
	$(".wrap3").click(function(){
			$(".message-modal").fadeIn();
	});
	
	//메세지 답장 시 최대 1000자 제한
	$("#reply").keyup(function(){
		var content = $(this).val();
		$('.word-count').html(content.length+" / 1000");
		if (content.length > 1000){
	        alert("최대 1000자까지 입력 가능합니다.");
	        $(this).val(content.substring(0, 1000));
	        $('.word-count').html("1000 / 1000");
	    }
	});
});
//메세지 보기(다이얼로그)
$(document).on("click","#msg-view",function() {
	
	num = $(this).attr("num");
	$.ajax({
		type: "get",
		dataType: "json",
		url: "messagedata",
		data: {"num":num},
		success: function(data){
			$("#content").val(data.content);
			$("#send_name").val(data.send_name);
			$("#send_time").val(data.send_time);
			$("#inquiry_type").val(data.inquiry_type);
			
			$("#reply").val();
			
			//alert(data.content+","+data.send_name+","+data.send_time+","+data.inquiry_type);
		}
	});
 	$(document).on("click", ".message-title", function() {
		location.reload();
	});
});

// 답장 버튼 클릭시
$(document).on("click","#replybtn",function() {
	var content = $("#reply").val();
	var inquiry_type = $("#inquiry_type").val();
	var recv_name= $("#send_name").val(); // 상대방 name
	var username = $("#name").val(); // 나의 name
	//var id = $("#id").val();
	//alert(content+","+recv_name+","+inquiry_type+","+username);
	
	if(content==""){
		alert("메세지를 입력해주세요.");
		return;
	}
	
	$.ajax ({
		type: "post",
		dataType: "text",
		url: "messageReply",
		data: {"content":content,"inquiry_type":inquiry_type,"recv_name":recv_name},
		success: function (data) {
			alert("전송성공");
		}
	});
	
	location.reload();
});
</script>

<!-- 메뉴 -->
<div class="container">
	<div class="header-profile">
		<div class="container-user">
			<div class="user-photo" style="width: 100px; height: 100px;">
				<c:if test="${dto.photo == null}">
					<img src="../../profile_image/basic.jpg"/>
				</c:if>
				<c:if test="${dto.photo != null}">
					<img src="../../profile_image/${dto.photo }"/>
				</c:if>
			</div>
			<div class="a">
				<div class="user-name">
					<span>${name }</span>
					<c:if test="${sessionScope.id == id }">
						<a class="user-info" href="/setting/main">
							<div name="setting">
								<img src="${root }/image/settings.png">
							</div>
						</a>
					</c:if>
				</div>
			</div>
		</div>
		<div class="container-tab">
			<div class="tab-warpper">
				<c:if test="${ sessionScope.id != 'admin'}">
					<div class="tab-warpper-in">
						<span class="tab current">
							<div class="link-wrapper">
								<a href="/profile/${sessionScope.url}">소개</a>
							</div>
						</span>
						<span class="tab">
							<div class="link-wrapper">
								<a href="/profile/${sessionScope.url}/backed">후원한 프로젝트 </a>
							</div>
						</span>
						<span class="tab">
							<div class="link-wrapper">
								<a href="/profile/${sessionScope.url}/created">올린 프로젝트</a>
							</div>
						</span>
						<span class="tab">
							<div class="link-wrapper">
								<a href="/profile/${sessionScope.url}/liked">관심프로젝트 </a>
							</div>
						</span>
						<c:if test="${sessionScope.id == dto.id }">
							<span class="tab">
								<div class="link-wrapper">
									<a href="/message/receivedMessage" class="select">문의 메세지 </a>
								</div>
							</span>
							<c:if test="${dto.id != sessionScope.id}">
								<span class="tab">
									<div class="link-wrapper">
										<a class='personal-chat'>채팅 </a>
									</div>
								</span>
							</c:if>
						</c:if>
					</div>
				</c:if>
			</div>
		</div>
	</div>
	<form name="popForm">
		<input type="hidden" name="id" value="${dto.id}" />
	</form>
</div>

<!-- 스크립트 -->
<script type="text/javascript">
$(function () {
   $(".personal-chat").click(function() {
      /* let num = ${num}; */
      /* var win = window.open("../chat/personalChat?num="+num, "PopupWin", "width=480,height=765 , left = 400px, top = 100px");  */
      onSubmit()
   })
})   

function onSubmit(){
	var myForm = document.popForm;
	var url = "/chat/personalChat";
	window.open("" ,"popForm","width=480,height=765 , left = 400px, top = 100px");
	myForm.action =url;
	myForm.method="post";
	myForm.target="popForm";
	myForm.submit();
}
</script>

<!-- Message list -->
<div class="MessageThreads">
	<br>
	<div class="MessageWrap">
		<button type="button" class="button1 selected" onclick="location.href='receivedMessage?name=${name}'">받은 메시지</button>
		<button type="button" class="button2" onclick="location.href='sentMessage?name=${name}'">보낸 메시지</button>
	</div>
	<br>
	<div class="msgcount">
		받은 메세지(<b>${totalCount }</b>)
	</div>
	<br>
	<div style="" class="msgList">
	<c:if test="${empty recvList}">
	받은 메세지가 없습니다
	</c:if>
		<c:if test="${totalCount>0}">
			<c:forEach var="a" items="${recvList}">
			<a id="msg-view" num=${a.num }>
				<div>
					<div class="wrap1">
						<div class="wrap2">
							<div class="wrap3">
								<div class="MsgContentWrap">
									<div class="creator">
										<b>${a.send_name }</b>
									</div>
									<div class="Msgcontent">
										<span>${a.content }</span>
									</div>
								</div>
								<div class="readWrap">
									<c:if test="${a.read_chk > 0 }">
										<div class="read">읽음</div>
										<br>
										<div class="send_time">받은시간<br>
										${a.send_time }</div>
									</c:if>
									<c:if test="${a.read_chk == 0 }">
										<div class="read" style="font-weight: bold;">안읽음</div>
										<br>
										<div class="send_time">받은시간<br>
										${a.send_time }</div>
									</c:if>
								</div>
							</div>
						</div>
					</div>
				</div>
			</a>
			</c:forEach>
		</c:if>
	</div>
			<!-- 페이징  -->
	<div class="pagination-wrap" style="margin: 20px auto;">
	<c:if test="${totalCount>0 }">
		<nav aria-label="Page navigation example">
			<ul class="pagination justify-content-center">
				<!-- 이전 -->
				<c:if test="${startPage>1 }">
					<li class="page-item"><a class="page-link" href="receivedMessage=${startPage-1}"
						aria-label="Previous"> <span aria-hidden="true">&laquo;</span></a>
					</li>
				</c:if>

				<c:forEach var="pp" begin="${startPage}" end="${endPage}">
					<c:if test="${currentPage==pp}">
						<li class="page-item active"><a class="page-link"
							href="receivedMessage=${pp}">${pp}</a></li>
					</c:if>
					<c:if test="${currentPage!=pp}">
						<li class="page-item"><a class="page-link"
							href="receivedMessage=${pp}">${pp}</a></li>
					</c:if>
				</c:forEach>
				
				<!-- 다음 -->
				<c:if test="${endPage<totalPage }">
					<li class="page-item"><a class="page-link"
						href="receivedMessage=${endPage+1}"
						aria-label="Next"> <span aria-hidden="true">&raquo;</span>
					</a></li>
				</c:if>
			</ul>
		</nav>
	</c:if>
	</div>
	<!-- /페이징 -->
</div>

<!-- Message Modal -->
<div class="message-modal">
	<div class="modal-content">
		<div class="message-title">
			<span class="message-title">받은 메세지</span>
			<button type="button" class="message-title2" data-dismiss="modal"><i class="fa fa-times"></i></button>
		</div>
		<div class="message-main">
			<table class= "table table-bordered">
				<tr>
					<td>
						보낸 사람
					</td>
					<td>
						<input type="text" id="send_name" readonly="readonly" style="border: none;">
					</td>
				</tr>
				<tr>
					<td>
						받은 시간
					</td>
					<td>
						<input type="text" id="send_time" readonly="readonly" style="border: none;">
					</td>
				</tr>
				<tr>
					<td>
						문의 유형
					</td>
					<td>
						<input type="text" id="inquiry_type" readonly="readonly" style="border: none;">
					</td>
				</tr>
				</table>
				<span class="message-title">문의 내용</span>
				<textarea id="content" readonly="readonly" class="receive-content" placeholder="메세지 내용을 적어주세요."></textarea>
				<span class="message-title">답장</span>
				<textarea class="form-control" rows="5" id="reply"></textarea>
				<span class="word-count">0/1000</span>
				<button type="button" class="btn-send" data-dismiss="modal" id="replybtn">전송</button>
		</div>
	</div>
</div>
<!-- /Modal -->