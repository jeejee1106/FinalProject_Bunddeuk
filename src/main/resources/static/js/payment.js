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
		var id = "${sessionScope.sessionId}";
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
		var id = "${sessionScope.sessionId}";
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
		var id = "${sessionScope.sessionId}";
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