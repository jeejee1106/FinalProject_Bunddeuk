$(document).ready(function(){
    var topBar = $("#topBar").offset();
    
    $(window).scroll(function(){
        var docScrollY = $(document).scrollTop()
        var barThis = $("#topBar")
        var fixNext = $("#fixNextTag")
 
        if( docScrollY == topBar.top ) {
            barThis.addClass("top_bar_fix");
            fixNext.addClass("pd_top_80");
        }else{
            barThis.removeClass("top_bar_fix");
            fixNext.removeClass("pd_top_80");
        }
    });
});

$(function(){
	loginok= $("#loginok").val();
	loginId = $("#id").val();
	var likeCheck = $("#likeCheck").val();
	
	if(likeCheck == 1){
		$(".project-sub-heart").html("<i class='fa fa-heart' style='color: red;'></i>");
	}
	
	//본인이 만든 프로젝트는 찜, 메세지, 후원 못하게 설정
	var creatorId = $("#creatorId").val();
	if(loginId == creatorId){
		$(".project-sub-heart").css({"pointer-events" : "none", "color" : "gray"});
		$(".btn-support").css({"pointer-events" : "none", "backgroundColor" : "#cbcbcb"});
		$(".btn-present-support").css({"pointer-events" : "none", "backgroundColor" : "#cbcbcb"});
		$(".btn-creator-message").css({"pointer-events" : "none", "backgroundColor" : "#cbcbcb", "color" : "white"});
	}
	
	//프로필 이미지 클릭 시 해당 작가의 프로필 페이지로 이동
	$(document).on("click",".creator-image", function() {
		if($(this).attr("id") == 'admin'){
			alert("관리자 페이지로는 이동이 불가능합니다.");
			return;
		}
		
		let check = confirm("프로필 페이지로 이동하시 겠습니까?");
		if(check == true){
			$("#creator-id").val("");
			$("#creator-id").val($(this).attr("id"));
			$(".sub-profile").submit();
		}
	});
	
	$(".project-community").hide();
	$(".btn-project-community").css("color", "gray");
	
	$(".btn-project-plan").click(function(){
		$(this).css("color", "black");
		$(".btn-project-community").css("color", "gray");
		$(".project-community").hide();
		$(".project-plan").show();
	});

	$(".btn-project-community").click(function(){
		$(this).css("color", "black");
		$(".btn-project-plan").css("color", "gray");
		$(".project-plan").hide();
		$(".project-community").show();
	});
	
	$(".scroll_move").click(function(event){
        event.preventDefault();
        $('html,body').animate({scrollTop:$(".content-navigation-container").offset().top}, 500);
	});

	$(".btn-support").click(function(event){
        event.preventDefault();
        $('html,body').animate({scrollTop:$(".present-title").offset().top}, 500);
	});
	$(".btn-creator-message").click(function(){
		if(loginok==''){
			alert("로그인이 필요한 페이지 입니다.")
			location.href = "/login/main";
		}else{
			$(".message-modal").fadeIn();
			$("#inquiry_type").val("문의유형");
			$("#message-content").val("");
		}
	});
	
	$(".message-title2").click(function(){
		$(".message-modal").fadeOut();
	});
	
	$("#message-content").keyup(function(){
		var content = $(this).val();
		$('.word-count').html(content.length+" / 1000");
		if (content.length > 1000){
	        alert("최대 1000자까지 입력 가능합니다.");
	        $(this).val(content.substring(0, 1000));
	        $('.word-count').html("1000 / 1000");
	    }
	});
	
	$(".project-sub-heart").click(function(){
		if(loginok==''){
			alert("로그인이 필요한 서비스 입니다.")
			return;
		}
		
		var idx = $("#dto-idx").val();
		$.ajax({
			type : "post",
			url : "/liked/check",
			data : {"idx":idx, "id":loginId},
			success : function(data){
				if(data == 0){
					$(".project-sub-heart").html("<i class='fa fa-heart' style='color: red;'></i>");
					alert("관심 프로젝트에 등록되었습니다.");
				}else{
					$(".project-sub-heart").html("<i class='fa fa-heart-o'></i>");
					alert("관심 프로젝트에서 삭제되었습니다.");
				}
			},
			error : function(request,status,error){
		        alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		    }
		});
	});
	
});

$(document).on("click","#btn-send",function(){
	var content = $("#message-content").val();
	var inquiry_type = $("#inquiry_type").val();
	var recv_name= $("#recv_name").val(); // 상대방 name
	var send_name = $("#send_name").val(); // 나의 name
	if(content==""){
		alert("메세지 내용을 입력하세요.");
		return;
	}
	if(inquiry_type==null){
		alert("문의유형을 선택해주세요.");
		return;
	}
	
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

function paycheck() {
	var rs = "";
	var supportCheck = $("#supportCheck").val();
	alert(supportCheck);
	var rs = "";
	if(supportCheck!=0 && loginok!=''){
		alert("이미 후원한 프로젝트 입니다.")
		rs = false;
	}
	
	if(loginok==''){
		alert("로그인이 필요한 페이지 입니다.")
		location.href = "/login/main";
		rs = false;
	}
	return rs;
}