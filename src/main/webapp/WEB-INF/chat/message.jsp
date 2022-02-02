<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://code.jquery.com/jquery-3.5.0.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script> -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.css" type="text/css" rel="stylesheet" />
<link rel="stylesheet" type="text/css" href="/css/message.css">
<div class="inner">
	<div class="list-container">
		<div class="title-container">
			<span class="title"><i class="fa fa-comments-o"></i> 채팅</span>
		</div>
		<c:choose>
			<c:when test="${list.size() == 0}">
				<p class="empty-message">
					참여중인 채팅이 없습니다. <br> <span class="empty-message2">맴버와
						채팅을 시작해보세요</span>
				</p>
			</c:when>
			<c:otherwise>
				<ul>
					<c:forEach var="messageInfo" items="${list}">
						<%-- <c:if test="${messageInfo.exit_id != sessionScope.id}"> --%>
						<li class="info-container">
							<div class="open-chat">
								<input type="hidden" id="loginUser" value="${sessionScope.id}">
								<input type="hidden" id="exitCount" value="${messageInfo.exit_count}"> 
								<input type="hidden" id="room" value="${messageInfo.room}">
								<c:choose>
									<c:when test="${messageInfo.photo == null}">
										<img class="profile-img" src="../profile_image/basic.jpg"alt="프로필이미지">
									</c:when>
									<c:otherwise>
										<img class="profile-img" src="../profile_image/${messageInfo.photo}" alt="프로필이미지">
									</c:otherwise>
								</c:choose>
								<c:choose>
									<c:when test="${messageInfo.recv_id == sessionScope.id}">
										<input type="hidden" id="reciver" value="${messageInfo.send_id  }">
									</c:when>
									<c:otherwise>
										<input type="hidden" id="reciver" value="${messageInfo.recv_id  }">
									</c:otherwise>
								</c:choose>
								<c:choose>
									<c:when test="${messageInfo.send_id == sessionScope.id}">
										<span class="chat-id">${messageInfo.recv_id}</span>
									</c:when>
									<c:otherwise>
										<span class="chat-id">${messageInfo.send_id }</span>
									</c:otherwise>
								</c:choose>
								<span class="chat-time">${messageInfo.send_time}</span>
								<c:choose>
									<c:when test="${messageInfo.exit_count >0}">
										<span class="chat-content"><span class='glyphicon glyphicon-log-out'></span> 상대방이 채팅방을 나가셨습니다.</span>
									</c:when>
									<c:otherwise>
										<span class="chat-content">${messageInfo.content}</span>
									</c:otherwise>
								</c:choose>
								<c:if test="${messageInfo.unread != 0}">
									<span class="unread-count">안읽은메세지 ${messageInfo.unread}</span>
								</c:if>
							</div>
							<div class="option-cotainer">
								<span class="glyphicon glyphicon-option-vertical list-btn"></span>
								<div class="option-list">
									<span class="read-btn cursor">읽음</span> <input type="hidden" id="unreadCheck" value="${messageInfo.unread}">
									<hr>
									<span class="exit-list cursor">나가기</span>
								</div>
							</div>
						</li>
						<%-- </c:if> --%>
					</c:forEach>
				</ul>
			</c:otherwise>
		</c:choose>
	</div>
	<div class="chat-container">
		<div class="title-container">
			<span class="glyphicon glyphicon-list list"
				onclick="location.href='list'"></span> <span class="title"><i
				class="fa fa-comments-o"></i> 채팅</span> <span
				class="glyphicon glyphicon-cog option"></span>
			<div class="function-conatiner">
				<ul>
					<li><span class="glyphicon glyphicon-cog"> 채팅기능</span></li>
					<li class=" cursor autoReload"><span class="glyphicon glyphicon-play"></span> RELOAD자동</li>
					<li class=" cursor manualReload"><span class="glyphicon glyphicon-wrench"></span> RELOAD수동</li>
					<li class=" cursor stopReload"><span class="glyphicon glyphicon-stop"></span> RELOAD중지</li>
					<li class=" cursor exit-btn"><span class="glyphicon glyphicon-log-out"></span> 채팅방나가기</li>
					<!-- <li class = " cursor report-btn"><span class="glyphicon glyphicon-bullhorn"></span> 신고하기</li> -->
				</ul>
			</div>
		</div>
		<div class="print"></div>

		<div class="text-container">
			<input type="hidden" id="reciverInfo"> <input type="hidden" id="senderInfo"> 
			<input type="hidden" id="roomInfo">
			<input type="hidden" id="exitCountInfo">
			<textarea placeholder="메세지를 입력하세요." class="text"></textarea>
			<span class="send-btn glyphicon glyphicon-send"></span>
		</div>
	</div>
	<!-- 삭제 Modal -->
	<div class="modal fade" id="myModal" role="dialog">
		<div class="modal-dialog modal-sm">

			<!-- Modal content-->
			<div class="modal-content" style="max-width: 90%; width: auto;">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title">신고하기</h4>
				</div>
				<div class="modal-body form-inline">
					<form action="/report/send" method="post">
						<input type="hidden" name="address" value="wonseob7942@naver.com">
						<input type="hidden" id="reportRoom" name="room"> 
						<input type="hidden" id="reportId" name="id" value="${sessionScope.id}">
						<input name="title" placeholder="제목" required="required">
						<br>
						<textarea name="message" placeholder="신고 내용을 입력해주세요." cols="33"
							rows="10" required="required"></textarea>
						<button class="btn btn-default" type="submit">제출</button>
					</form>
				</div>
			</div>

		</div>
	</div>

</div>



<script>
	$(".option-list").hide()
	$(".chat-container").hide()
	$(".function-conatiner").hide()
	//list
	$(".list-btn").click(
		function() {
			$(this).parent().parent().siblings().children().children(
					".option-list").hide();
			$(this).next(".option-list").toggle();
		})
	//chat
	$(".option").click(function() {
		$(".function-conatiner").toggle()
	})

	$(".open-chat").click(function() {
		$(".chat-container").show();
		$(".list-container").hide();
		$(".text").focus();
		let sender = $(this).find("#loginUser").val();
		let reciver = $(this).find("#reciver").val();
		let room = $(this).find("#room").val();
		let exitCount = $(this).find("#exitCount").val();

		$("#reportRoom").val(room)
		$("#senderInfo").val(sender);
		$("#reciverInfo").val(reciver);
		$("#roomInfo").val(room);
		$("#exitCountInfo").val(exitCount);

		senderInfo = $("#senderInfo").val();
		roomInfo = $("#roomInfo").val();

		$.ajax({
			url : "../chat/chatList",
			method : "post",
			dataType : "json",
			data : {
				"send_id" : sender,
				"room" : room
			},
			success : function(data) {
				let s = "<ul class='show-message'>";
				for (i = 0; i < data.length; i++) {
					if (sender == data[i].send_id) {
						s += "<li class='chat-info'>";
						s += "<div class='right-container'>";
						s += "<pre class='sender-content'>"+ data[i].content+ "</pre>";
						s += "<span class='send-time right-time'>"+ data[i].send_time
						if (data[i].read_check == 0) {
							s += "<span class ='unread-message'>  미확인</span>"
						}
						s += "</span>";
						s += "</div>";
						s += "</li>";
					} else {
						s += "<li class='chat-info'>";
						s += "<div class='left-container'>";
						if (data[i].photo != null) {
							s += "<img class='profile-img' src='../profile_image/"+data[i].photo+"' alt='프로필이미지'>";
						} else {
							s += "<img class='profile-img' src='../profile_image/basic.jpg' alt='프로필이미지'>";
						}
						s += "<span class='reciver-id'>"+ data[i].send_id + "</span>";
						s += "<pre class='reciver-content'>" + data[i].content + "</pre>";
						s += "<span class='send-time left-time'>" + data[i].send_time + "</span>";
						s += "</div>";
						s += "</li>";
					}

					if (data[i].exit_count > 0) {
						s += "<pre class='exit-message '><span class='glyphicon glyphicon-log-out'></span> 상대방이 채팅방을 나가셨습니다.</pre>"
						$(".text").attr({
							readonly : 'readonly',
							placeholder : '메세지 전송이 불가능합니다.'
						})
						$(".send-btn").hide();
					}
				}
				s += "</ul>";
				$(".print").html(s);
				$(".show-message").scrollTop($(".show-message")[0].scrollHeight);
			}
		});
	});
	//check length
	$(".text").keyup(function() {
		let content = $(this).val()
		let contentSize = (content.length + content.split('\n').length - 1);
		if (contentSize > 1000) {
			alert("1000자 이하로 입력해주세요")
			$(this).val(content.substring(0, 1000));
			return;
		}
	})

	$(".send-btn").click(function() {
		reciverInfo = $("#reciverInfo").val();
		contentInfo = $(".text").val();
		if (contentInfo.trim() == "") {
			alert("메세지를 입력해주세요")
			$(".text").val("");
			$(".text").focus();
			return;
		}
		$.ajax({
			url : "../chat/send",
			method : "post",
			data : {
				"send_id" : senderInfo,
				"recv_id" : reciverInfo,
				"content" : contentInfo,
				"room" : roomInfo
			},
			success : function() {
				$(".text").val("");
				$(".text").focus();
				getMessageList();
			}
		});
	});
	$(".text").keydown(function(key) {
		if (key.keyCode == 13) {

			if (!key.shiftKey) {
				$('.send-btn').trigger('click');
			}
		}
	});

	function getMessageList() {
		$.ajax({
			url : "../chat/chatList",
			method : "post",
			dataType : "json",
			data : {
				"send_id" : senderInfo,
				"room" : roomInfo
			},
			success : function(data) {
				let s = "<ul class='show-message'>";
				for (i = 0; i < data.length; i++) {
					if (senderInfo == data[i].send_id) {
						s += "<li class='chat-info'>";
						s += "<div class='right-container'>";
						s += "<pre class='sender-content'>"+ data[i].content + "</pre>";
						s += "<span class='send-time right-time'>"+ data[i].send_time
						if (data[i].read_check == 0) {
							s += "<span class ='unread-message'>  미확인</span>"
						}
						s += "</span>";
						s += "</div>";
						s += "</li>";
					} else {
						s += "<li class='chat-info'>";
						s += "<div class='left-container'>";
						if (data[i].photo != null) {
							s += "<img class='profile-img' src='../profile_image/"+data[i].photo+"' alt='프로필이미지'>";
						} else {
							s += "<img class='profile-img' src='../profile_image/basic.jpg' alt='프로필이미지'>";
						}
						s += "<span class='reciver-id'>"+ data[i].send_id + "</span>";
						s += "<pre class='reciver-content'>"+ data[i].content + "</pre>";
						s += "<span class='send-time left-time'>"+ data[i].send_time + "</span>";
						s += "</div>";
						s += "</li>";
					}
					if (data[i].exit_count > 0) {
						s += "<pre class='exit-message '><span class='glyphicon glyphicon-log-out'></span> 상대방이 채팅방을 나가셨습니다.</pre>"
						$(".text").attr({
							readonly : 'readonly',
							placeholder : '메세지 전송이 불가능합니다.'
						})
						$(".send-btn").hide();
					}
				}
				s += "</ul>";
				$(".print").html(s);
				$(".show-message").scrollTop($(".show-message")[0].scrollHeight);
			}
		});
	}

	$(".read-btn").click(function() {
		if ($(this).next("#unreadCheck").val() == 0) {
			alert("미확인 메세지가 없습니다.")
			return;
		}
		let selectedRoom = $(this).parent().parent().siblings().find("#room").val()
		let loginUserInfo = $("#loginUser").val()
		$.ajax({
			url : "../chat/read",
			method : "post",
			data : {
				"send_id" : loginUserInfo,
				"room" : selectedRoom
			},
			success : function(data) {
				location.href = "list";
			}
		});
	});

	//report
	$(".report-btn").click(function() {
		$("#myModal").modal();
	});
	$(".exit-list").click(function() {
		let check = confirm("채팅방을 나가시 겠습니까?");
		if (check == true) {
			let exitRoom = $(this).parent().parent().siblings().find("#room").val()
			let exitId = $(this).parent().parent().siblings().find("#loginUser").val()
			$.ajax({
				url : "../chat/exit",
				method : "post",
				data : {
					"exit_id" : exitId,
					"room" : exitRoom
				},
				success : function() {
					location.href = "list";
				}
			});
		}
	});
	$(".exit-btn").click(function() {
		let check = confirm("채팅방을 나가시 겠습니까?");
		if (check == true) {
			$.ajax({
				url : "../chat/exit",
				method : "post",
				data : {
					"exit_id" : senderInfo,
					"room" : roomInfo
				},
				success : function() {
					location.href = "list";
				}
			});
		}
	});

	$(window).keydown(function(key) {
		if (key.keyCode == 65 && key.shiftKey) {
			$(".autoReload").trigger('click');
		} else if (key.keyCode == 83 && key.shiftKey) {
			$(".stopReload").trigger('click');
		} else if (key.keyCode == 90 && key.shiftKey) {
			$(".manualReload").trigger('click');
		}
	});

	//reload
	$(".manualReload").click(function() {
		alert("수동 리로드")
		getMessageList()
	})
	$(".autoReload").click(function() {
		StartReload()
	})
	$(".stopReload").click(function() {
		StopReload()
	})

	let liveChat = false;
	function StartReload() {
		getMessageList();
		alert("실시간 채팅 실행");
		liveChat = true;
		reload = setInterval(getMessageList, 1000);
	}
	function StopReload() {
		if (liveChat == false) {
			alert("실시간 채팅이 미실행중입니다.");
			return;
		}
		clearInterval(reload);
		alert("실시간 채팅 중지");
		liveChat = false;
	}
</script>
