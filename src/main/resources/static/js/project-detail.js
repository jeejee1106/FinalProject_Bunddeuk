$(document).ready(function(){
    var topBar = $("#topBar").offset();
    

	//detail 페이지에서는 헤더 고정 풀기
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

	//plan 네비바 상단고정
	var jbOffset = $('.plan-menu').offset();
	$(window).scroll(function(){
		if ($(document).scrollTop() > jbOffset.top) {
			$('.plan-menu').addClass('jbFixed').css({"height" : "78px", "line-height": "78px"});
		}
		else {
			$('.plan-menu').removeClass('jbFixed').css({"height" : "", "line-height": ""});
		}
	});
});

$(function(){
	
	/*********************************************************
	***************** 디테일 페이지 스크립트(detail) ****************
	**********************************************************/
	loginok= $("#loginok").val();
	loginId = $("#id").val();
	var likeCheck = $("#likeCheck").val();
	
	//좋아요를 눌렀다면 하트 빨갛게
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
	
	/*********************************************************
	********************** 계획 스크립트(plan) *******************
	**********************************************************/
	//plan 네비바 색상변경
	$(".plan-list-title").click(function(){
		$(this).css('background', '#afeeee');
		$(this).parent().siblings().children().css('background', 'none'); 
	});
	
	var menuHeight = $('.plan-menu').outerHeight();
	//plan 네비바 클릭 시 해당영역으로 스크롤 이동
	$(".plan-list-purpose").click(function(event){
		event.preventDefault();
		$('html,body').animate({scrollTop:$("#purpose").offset().top - menuHeight}, 500);
	});
	$(".plan-list-budget").click(function(event){
		event.preventDefault();
		$('html,body').animate({scrollTop:$("#budget").offset().top - menuHeight - 30}, 500);
	});
	$(".plan-list-schedule").click(function(event){
		event.preventDefault();
		$('html,body').animate({scrollTop:$("#schedule").offset().top - menuHeight - 30}, 500);
	});
	$(".plan-list-team-intro").click(function(event){
		event.preventDefault();
		$('html,body').animate({scrollTop:$("#team-intro").offset().top - menuHeight - 30}, 500);
	});
	$(".plan-list-present-intro").click(function(event){
		event.preventDefault();
		$('html,body').animate({scrollTop:$("#present-intro").offset().top - menuHeight - 30}, 500);
	});
	$(".plan-list-trust-safety").click(function(event){
		event.preventDefault();
		$('html,body').animate({scrollTop:$("#trust-safety").offset().top - menuHeight - 30}, 500);
	});
	
	
	/*********************************************************
	***************** 댓글 스크립트 (community) ******************
	**********************************************************/
	//정렬 - 오래된순 (등록순)
	$(".order-asc").click(function() {
		$(".comment-order").val("1")
		$(".order-desc").css({
			"color":"#b7b7b7"
		})
		$(".order-asc").css({
			"color":"#333"
		})
		getCommentList()
	})

	//정렬 - 최신순
	$(".order-desc").click(function() {
		$(".comment-order").val("2")
		$(".order-asc").css({
			"color":"#b7b7b7"
		})
		$(".order-desc").css({
			"color":"#333"
		})
		getCommentList()
	})
	countComment()
	
	//컨텐트내용표시
	$(document).on("click",".parent-writer", function() {
		let parentName = $(this).text().replace(/^./, "");
		let check = confirm(parentName+"님이 작성한 상위 댓글의 내용을 확인하시겠습니까?")
		if(check != true){
			return;
		}
		let num = $(this).next("#parentNum").val();
        $.ajax({
            url : "../comment/getComment",
            type : 'POST', 
            data : {num:num},
            success : function(data) {
            	if(data.length == 0){
            		alert("해당상위 댓글은 삭제되었습니다.")
            	}else{
	            	alert(data)
            	}
            }, 
            error : function(xhr, status) {
                alert(xhr + " : " + status);
            }
        });
	})
	
	//profile
	$(document).on("click",".profile-photo", function() {
		if($(this).attr("id") == 'admin'){
			alert("관리자 프로필로는이동이 불가능합니다.")
			return;
		}
		let profileId = $(this).attr("id");
		let check = confirm(profileId+"님의 프로필 페이지로 이동하시겠습니까?");
		if(check == true){
			$("#profileId").val("");
			$("#profileId").val($(this).attr("id"));
			$(".to-profile").submit();
		}
	})
	getCommentList();
	
	//getlist
	function getCommentList() {
		let loginCheck = $("#sessionScope").val();
	    let loginUser = $("#loginUser").val();	
		let num = $("#pnum").val();
		let order = $(".comment-order").val();
       	$.ajax({
               url : "../comment/list",
               type : 'get', 
               dataType: 'json',
               data: {pnum:num, order:order},
               success : function(data) {
            	countComment();
               	let projectWriter = $("#creator-id");
                let s = ''; 
               	for(i=0; i<data.length; i++){
               		
               		s+="<hr>"
                	s += "<div class='show-comment' style='padding-left:"+data[i].grps*52+"px;'>";
               		if(data[i].tempdel == 1){
                		s +="<span class ='delete-msg'>댓글이 삭제되었습니다.</span>"
               		}else{
               			 if(data[i].fix == 1 && data[i].grph == 0){
		                	s += "&nbsp;<span style='color:red'><i class='fa fa-thumb-tack'></i></span>";	
		                }
	                	if(data[i].grph == 0 && loginCheck=='yes' && loginUser == projectWriter){
		                	if(data[i].fix != 1){
		                		s += "<button title='댓글을 고정합니다.' class='fix-style fix'><i class='fa fa-thumb-tack'></i></button><br>";	
		                	}else{
		                		s += "<button title='댓글고정을 취소합니다.' class='fix-style cancel-fix'><i class='fa fa-times'></i></button><br>";	
		                	}
	                	}
	                	if(data[i].grph != 0){
						s += "<img class='re-image' src='../profile_image/re.png'> ";
	                	}
	                	if(data[i].photo == null){
						s += "<img class='profile-photo' title='"+data[i].writer+"님의 프로필페이지로 이동합니다.' src='../profile_image/basic.jpg' id='"+data[i].writer+"'>";
		                }else{
                		s += "<img class='profile-photo' title='"+data[i].writer+"님의 프로필페이지로 이동합니다.' src='../profile_image/"+data[i].photo+"' id='"+data[i].writer+"'>";
		                }
	                	s += "<span class='re-writer-name'>&nbsp;"+data[i].writer+"</span>";
	                	if(data[i].writer == projectWriter){
	                	s += "<span class='project-writer'>창작자</span>";
	                	}
	                	if(data[i].fix == 1 && data[i].grph == 0){
		                	s += "&nbsp;<span class='fix-msg'><i class='fa fa-thumb-tack'></i> "+projectWriter+"님이 고정함</span>";	
		                }
	                	if(data[i].grph == 0 && loginCheck=='yes' && loginUser == projectWriter){
		                	if(data[i].fix != 1){
		                		s += "<button class='fix-style fix'><i class='fa fa-thumb-tack'></i></button><br>";	
		                	}else{
		                		s += "<button class='fix-style cancel-fix'><i class='fa fa-times'></i></button><br>";	
		                	}
	                	}
	                	if(data[i].parent != 'no' && data[i].parent != data[i].writer){
	                	s += "<div class='parent-writer'>@"+data[i].parent+"</div>"
	                	s += "<input type='hidden' id='parentNum' value='"+data[i].parent_num+"'>"
	                	}
	                	if(data[i].grps > 0){
		                	s += "<pre style ='width:475px;' class='re-content'>"+data[i].content+"</pre>";
	                	}else{
		                	s += "<pre style ='width:530px;' class='re-content'>"+data[i].content+"</pre>";
	                	}
	                	s += "<span id='time'>"+data[i].writetime+"</span>";
	                	
	                	if(loginCheck == 'yes'){
	                	s += "<button class='fix-style reply'><span style='color:gray;'>답글</span></button>";
		                	if(data[i].writer == loginUser){
	                			s += "<button class='re-del-option'><span><i class='fa fa-ellipsis-v'></i></span></button>";
				                s += "<button class='fix-style up-loc re-update'><span><i class='fa fa-pencil'></i> 수정</span></button>";
								s += "<button class='fix-style del-loc delete-btn'><span><i class='fa fa-trash-o'></i> 삭제</span></button>";              	
		                	}
	                	}
	                	s += "<input type='hidden' id='parent' value='"+data[i].writer+"'>";
		    			s += "<input type='hidden' id='pnum' value='"+data[i].pnum+"'>";
	                	s += "<input type='hidden' id='writer' value='"+data[i].writer+"'>"
	                	s += "<input type='hidden' id='num' value='"+data[i].num+"'>"
	                	s += "<input type='hidden' id='grp' value='"+data[i].grp+"'>"
	                	s += "<input type='hidden' id='grph' value='"+data[i].grph+"'>"
	                	s += "<input type='hidden' id='grps' value='"+data[i].grps+"'>";
	                	s += "<input type='hidden' id='content' value='"+data[i].content+"'>"
	                	s += "<input type='hidden' id='tempdel' value='"+data[i].tempdel+"'>"
                	s += "</div>";
               		}
                	s += "<div class='update-form'></div>";
                	s += "<div class='reply-form'></div>";
	                	
               	}
               	$(".comment-list").html(s);
               	$(".re-update").hide();
               	$(".delete-btn").hide();
               	$(".re-del-option").hide();
               	
               }, 
               error : function(xhr, status, error) {
                   alert("댓글리스트 에러" + xhr + " : " + status + "에러원인 : " + error);
               }
           }); 
	}
	
	//reply
	$(".send-btn").click(function() {
		let comment = $(".comment").val()
		if(comment.trim().length == 0){
			alert("댓글 내용을 입력하지 않았습니다.")
			$(".comment").focus()
			return;
		}
		let formData = $("#comment").serialize();

        $.ajax({
            cache : false,
            url : "../comment/insert",
            type : 'POST', 
            data : formData, 
            success : function() {
            	getCommentList();
            	$(".comment").val("")
            	$(".count-content").text('0')
            }, 
            error : function(xhr, status) {
                alert(xhr + " : " + status);
            }
        }); 
	})
	
	//댓글 글자수 제한
	$(".comment").keyup(function(){
		let content = $(this).val()
		let contentSize = (content.length+content.split('\n').length-1);
		$(".count-content").html(contentSize)
		if(contentSize > 500){
			alert("500자 이하로 입력해주세요")
			$(this).val(content.substring(0, 500));
			$(".count-content").html('500')
			return;
		}
	})
	
	//대댓글 폼 숨기기
	$(document).on("click",".hide-btn", function() {
		$(this).parent().siblings(".reply-comment").val("")
		$(".reply-form").hide()
		
	})
	
	//'답글'버튼 누르면 폼 나오는 건데 굳이 스크립트로 말고 html에 만들어서 hide, show하면 되지 않을까
	$(document).on("click",".reply", function() {
		$(".reply-form").hide()
		$(".update-form").hide()
		$(this).parent().next().next(".reply-form").show()
		let loginUser = $("#loginUser").val();
		let parent = $(this).siblings("#parent").val()
		let parentNum = $(this).siblings("#num").val()
		let pnum = $(this).siblings("#pnum").val() 
		let grp = $(this).siblings("#grp").val()
		let grph = $(this).siblings("#grph").val()
		let grps = $(this).siblings("#grps").val()
		let s = ""
		s += "<form action='../comment/reply' class='reply-form' method='post'>";
			s += "<div class='reply-container'>";
				s += "<input type='hidden' name='writer' value='" + loginUser + "'>";
				s += "<input type='hidden' name='parent' value='"+parent+"'>";
				s += "<input type='hidden' name='parent_num' value='"+parentNum+"'>";
				s += "<input type='hidden' name='pnum' value='"+pnum+"'>";
				s += "<input type='hidden' name='grp' id='grp' value='"+grp+"'>";
				s += "<input type='hidden' name='grph' id='grph' value='"+grph+"'>";
				s += "<input type='hidden' name='grps' id='grps' value='"+grps+"'>";
				s += "<textarea required name='content' class='reply-comment' placeholder='"+parent+"님에게 답글 쓰기'></textarea>"
				s += "<div class='btn-container'>";
					s += "<span class='countLength count-reply'>0</span><span class='countLength'>/500</span><br>"
					s += "<button type='button' class='base-btn hide-btn'>취소</button>";			    			
	    			s += "<button type='button' class='base-btn reply-btn'>등록</button>"
				s += "</div>";
			s += "</div>";
		s += "</form>";
		$(this).parent().siblings('.reply-form').html(s)
	})
	
	//답글 등록 버튼 기능
	$(document).on("click",".reply-btn", function() {
		let comment = $(this).parent().siblings(".reply-comment")
		if(comment.val().length == 0){
			alert("댓글 내용을 입력하지 않았습니다.")
			comment.focus()
			return;
		}
		if(comment.val().length > 500){
			alert("500자 이하로 입력해주세요")
			comment.focus()
			return;
		}
		let formData2 = $(this).parent().parent().parent().serialize();
        $.ajax({
            cache : false,
            url : "../comment/reply",
            type : 'POST',
            data : formData2, 
            success : function() {
            	getCommentList();
            }, 
            error : function(xhr, status, error) {
                alert("댓글 등록 에러 : " + xhr + " : " + status + ", error : " + error);
            }
        }); 	 
	})
	
	//답글 폼 글자수 키업 이벤트
	$(document).on("keyup",".reply-comment", function() {
		let content = $(this).val()
		let contentSize = ($(this).val().length+$(this).val().split('\n').length-1);
		$(".count-reply").html(contentSize)
		if(contentSize > 500){
			alert("500자 이하로 입력해주세요")
			$(this).val(content.substring(0, 500));
			$(".count-reply").html('500')
			return;
		}
	})
	
	//show comment
	$(document).on("mouseenter",".show-comment", function() {
		$(this).children(".re-del-option").show();
	})
	$(document).on("mouseleave",".show-comment", function() {
		$(this).children(".re-del-option").hide();
		$(this).children(".re-update").hide()
		$(this).children(".delete-btn").hide()
	})
	//re-del-option
 	$(document).on("click",".re-del-option", function() {
		$(this).parent().siblings().children(".re-update").hide()
		$(this).parent().siblings().children(".delete-btn").hide()

		$(this).siblings(".re-update").toggle()
		$(this).siblings(".delete-btn").toggle()
		
	});
	
	//삭제
	$(document).on("click",".delete-btn", function() {
		let check = confirm("삭제하시겠습니까?")
		if(check != true){
			return;
		}
		let num = $(this).siblings("#num").val();
		let grp = $(this).siblings("#grp").val();
		let grph = $(this).siblings("#grph").val();
		let tempDel = $(this).siblings("#tempdel").val();
        $.ajax({
            url : "../comment/delete",
            type : 'POST', 
            data : {num:num, grp:grp, grph:grph, tempdel:tempDel},
            success : function() {
            	getCommentList();
            }, 
            error : function(xhr, status) {
                alert(xhr + " : " + status);
            }
        }); 
	})
	
	$(document).on("click",".hide-updatefrm", function() {
		$(".update-container").hide()
	})
	$(document).on("click",".re-update", function() {
		let content = $(this).siblings(".re-content")
		$(".reply-form").hide()
		$(".update-form").html('')
		$(".update-form").show()
		let s = '';
		s += "<div class='update-container'>";
			s += "<textarea name='content' class='update-comment'>"+content.text()+"</textarea>"
			s += "<div class='btn-container'>";
				s += "<span class='count-update countLength'>"+(content.text().length+(content.text().split('\n').length-1))+"</span><span class='countLength'>/500</span><br>"
				s += "<button type='button' class='base-btn hide-updatefrm'>취소</button>";			    			
				s += "<button type='button' class='base-btn update-btn'>수정</button>"
				s += "<input type='hidden' id='update-num' value='"+$(this).siblings("#num").val()+"'>"
			s += "</div>";
		s += "</div>";
		$(this).parent().next('.update-form').html(s)
		$(this).hide();
		$(this).next().hide();
	}) 
	$(document).on("keyup",".update-comment", function() {
		let content = $(this).val()
		let contentSize = ($(this).val().length+$(this).val().split('\n').length-1);
		$(".count-update").html(contentSize)
		if(contentSize > 500){
			alert("500자 이하로 입력해주세요")
			$(this).val(content.substring(0, 500));
			$(".count-update").html('500')
			return;
		}
		
	})
	
	//update
	$(document).on("click",".update-btn", function() {
		let check = confirm("수정하시겠습니까?")
		if(check == true){
			let num = $(this).next("#update-num").val()
			let comment = $(this).parent().siblings(".update-comment").val()
			if(comment.trim().length == 0){
				alert("댓글 내용을 입력하지 않았습니다.")
				$(".update-comment").focus()
				return;
			}
			$.ajax({
	            url : "../comment/update",
	            type : 'POST', 
	            data : {num:num, comment:comment},
	            success : function() {
	            	getCommentList();
	            }, 
	            error : function(xhr, status) {
	                alert(xhr + " : " + status);
	            }
	        }); 
			
		}
	}) 
	//fix
	$(document).on("click",".fix", function() {
		let check = confirm("댓글을 고정하시겠습니까? 이전에 고정한 댓글이 있으면 현제 글로 변경됩니다.")
		if(check != true){
			return;
		}
		let grp = $(this).siblings("#grp").val()
		$.ajax({
            url : "../comment/fix",
            type : 'POST', 
            data : {grp:grp},
            success : function() {
            	getCommentList();
            }, 
            error : function(xhr, status) {
                alert(xhr + " : " + status);
            }
        }); 
	})
	$(document).on("click",".cancel-fix", function() {
		let check = confirm("고정을 취소하시겠습니까?")
		if(check != true){
			return;
		}
		let grp = $(this).siblings("#grp").val()
		$.ajax({
            url : "../comment/cancelFix",
            type : 'POST', 
            data : {grp:grp},
            success : function() {
            	getCommentList();
            }, 
            error : function(xhr, status) {
                alert(xhr + " : " + status);
            }
        }); 
	})
	
	function countComment() {
		let pnum = $("#pnum").val();
		$.ajax({
            url : "/comment/countComment",
            type : "post", 
            data : {pnum:pnum},
            success : function(data) {
            	$(".commentCount").text(data)
            }, 
            error : function(xhr, status) {
                alert("countComment에러" + xhr + " : " + status);
            }
        }); 
	}
	
	
});

$(document).on("click","#btn-send",function(){
	var content = $("#message-content").val();
	var inquiry_type = $("#inquiry_type").val();
	var recv_name= $("#recv_name").val(); // 상대방 name
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