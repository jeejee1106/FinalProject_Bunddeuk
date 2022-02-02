<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- <link href="https://fonts.googleapis.com/css2?family=Dokdo&family=Gaegu&family=Gugi&family=Nanum+Pen+Script&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-3.5.0.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script> -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.css" type="text/css" rel="stylesheet" />
<link rel="stylesheet" type="text/css" href="/css/personalChat.css">
<div class="inner">
      <div class="chat-container">
           <div class="title-container">
               <span class="glyphicon glyphicon-list list"></span>
               <span class="title"><i class="fa fa-comments-o" ></i> 채팅</span>
               <span class="glyphicon glyphicon-cog option"></span>
               <div class="function-conatiner">
                   <ul>
                       <li><span class = "glyphicon glyphicon-cog"> 채팅기능</span></li>
                       <li class = " cursor autoReload"><span class = "glyphicon glyphicon-play"></span> RELOAD자동</li>
                       <li class = " cursor manualReload"><span class = "glyphicon glyphicon-wrench"></span> RELOAD수동</li>
                       <li class = " cursor stopReload"><span class = "glyphicon glyphicon-stop"></span> RELOAD중지</li>
                       <li class = " cursor exit-btn"><span class="glyphicon glyphicon-log-out"></span> 채팅방나가기</li>
                   </ul>
               </div>
           </div>
           <div class="print"></div>
          
           <div class="text-container">
	       	 <input type="hidden" id="reciver" value="${dto.id}"> 
		 	 <input type="hidden" id="sender" value="${sessionScope.id}"> 
			 <input type="hidden" id="room"> 
			 <input type="hidden" id="listSize">
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
<script type="text/javascript">
	$(".function-conatiner").hide()
	$(".option").click(function () { 
		    $(".function-conatiner").toggle()
	})

	checkRoomInfo();
	//room
	function checkRoomInfo(){
		let sender = $("#sender").val();
		let reciver = $("#reciver").val();
		$.ajax({
			url: "../chat/getRoomNumber",
			method: "post",
			dataType: "json",
			data: {"send_id":sender, "recv_id":reciver},
			success: function(data){
				$("#room").val(data);
				getMessageList();
				return;
			}
		})
	}	
	
	function getMessageList() {
		let sender = $("#sender").val();
		let room = $("#room").val();
		$("#reportRoom").val(room)
		$.ajax({
			url: "../chat/chatList",
			method: "post",
			dataType: "json",
			data: {"send_id":sender, "room":room},
			success: function(data){
				$("#listSize").val(data.length)
				let count = 0;
				if(data.length != 0){
					count = data[0].exit_count;
				}
				let s = "<ul class='show-message'>";
				for(i=0; i<data.length; i++){
					if(sender == data[i].send_id){
						s += "<li class='chat-info'>";
						s += "<div class='right-container'>";
						s += "<pre class='sender-content'>"+data[i].content+"</pre>";
						s += "<span class='send-time right-time'>"+data[i].send_time
						if(data[i].read_check == 0){
						s += "<span class ='unread-message'>  미확인</span>"
						}
						s += "</span>";
						s += "</div>";
						s += "</li>";
					}else{
		                s += "<li class='chat-info'>";
		                s += "<div class='left-container'>";
		                if(data[i].photo != null){
			                s += "<img class='profile-img' src='../profile_image/"+data[i].photo+"' alt='프로필이미지'>";
		                }else{
			                s += "<img class='profile-img' src='../profile_image/basic.jpg' alt='프로필이미지'>";
		                }
		                s += "<span class='reciver-id'>"+data[i].send_id+"</span>";
		                s += "<pre class='reciver-content'>"+data[i].content+"</pre>";
		                s += "<span class='send-time left-time'>"+data[i].send_time+"</span>";
		                s += "</div>";
		                s += "</li>";
					}
					if(data[i].exit_count > 0){
						s += "<pre class='exit-message '><span class='glyphicon glyphicon-log-out'></span> 상대방이 채팅방을 나가셨습니다.</pre>"
						$(".text").attr({
							readonly:'readonly',
							placeholder:'메세지 전송이 불가능합니다.'
						})
						$(".send-btn").hide();
				 	}
				}
				
					
				s +="</ul>";
				$(".print").html(s);
				$(".show-message").scrollTop($(".show-message")[0].scrollHeight);
				
			}
		})
	}
	$(".text").keyup(function(){
		let content = $(this).val()
		let contentSize = (content.length+content.split('\n').length-1);
		if(contentSize > 1000){
			alert("1000자 이하로 입력해주세요")
			$(this).val(content.substring(0, 1000));
			return;
		}
	})
	$(".send-btn").click(function() {
		let sender = $("#sender").val();
		let reciver = $("#reciver").val();
		let content = $(".text").val();
		let room = $("#room").val();
		if(content.trim() == ""){
			alert("메세지를 입력해주세요")
			 $(".text").val("");
			 $(".text").focus("");
			return
		}
		$.ajax({
			url: "../chat/send",
			method: "post",
			data: {"send_id":sender, "recv_id":reciver, "content":content, "room":room},
			success: function(){
				$(".text").val("");
				$(".text").focus();
				getMessageList();
			}
		})
		
	});
	
	$(".text").keydown(function(key) {
    if (key.keyCode == 13) {
    	  if (!key.shiftKey){
    		  $('.send-btn').trigger('click');
          }
    	}
	});
	$(".exit-btn").click(function() {
		if($("#listSize").val() == 0){
			alert("채팅 내역이 없습니다.")
			return;
		}
		let exitId = $("#sender").val();
		let roomInfo = $("#room").val();
		let check = confirm("채팅방을 나가시 겠습니까?");
		if(check == true){
			$.ajax({
		  		url: "../chat/exit",
				method: "post",
		  		data: {"exit_id":exitId, "room":roomInfo},
				success: function(){
					location.href = "list";
					window.close();
				}	
			});
	  		
		}
  	});
	$(".list").click(function() {
		if($("#listSize").val()>0){
			location.href='../chat/list';
		}else{
			alert("채팅 내역이 없습니다.");
			return;
		}
	});
	$(".report-btn").click(function() {
		if($("#listSize").val() == 0){
			alert("채팅 내역이 없습니다.")
			return;
		}
		$("#myModal").modal();
		return
  	});
	
	
	//reload
  	$(window).keydown(function(key) {
        if (key.keyCode == 65 && key.shiftKey) {
        	$(".autoReload").trigger('click');
        }else if (key.keyCode == 83 && key.shiftKey) {
        	$(".stopReload").trigger('click');
		}else if (key.keyCode == 90 && key.shiftKey){
        	$(".manualReload").trigger('click');
		} 
    });
	//reload
	$(".manualReload").click(function() {
		getMessageList()
	})
	$(".autoReload").click(function() {
		StartReload()
	})
	$(".stopReload").click(function() {
		StopReload()
	})

   	function StartReload() {
   		getMessageList();
   		alert("auto reload start")
   	   	reload = setInterval(getMessageList, 1000);
   	}
   	function StopReload() {
   		clearInterval(reload);
   		alert("auto reload stop")
   	}
</script>
