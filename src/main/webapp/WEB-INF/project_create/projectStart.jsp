<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet" type="text/css" href="/css/project-start.css">

<script type="text/javascript">
$(function() {
	$("div.layout2").hide();
	//$("div.layout1").hide();
	$(".btn-category").click(function() {
		//alert($(this).val());
		var s = "";
		s += "<button type='button' class='btn btn2'>다음</button>";
		$("#next").html(s);
		$(".btn-category").css({"backgroundColor":"#ffffff","color":"#000000DE"});
		$(this).css({"backgroundColor":"skyblue","color":"#fff"});
		var category = $(this).val();
		$("#category").val(category);
		
	});
	
	$(document).on("click",".btn2",function(){
		$("div.layout1").hide();
		$("div.layout2").show();

	});

	$(document).on("click","#back",function(){
		$("div.layout2").hide();
		$("div.layout1").show();
		
	});
	
	
    $('input[type="checkbox"]').click(function(){
        var tmpp = $(".inpu").prop('checked'); 
        var tt=$("[name='inpu']:checked").length;

        if(tmpp==true && tt==3){
            $("button.btn3").css({"backgroundColor":"#1e90ff","cursor":"pointer","color":"#fff"}).prop("disabled",false);
        }
        else{
            $("button.btn3").css({"backgroundColor":"#cbcbcb","cursor":"auto","color":"white"}).prop("disabled",true);
        }
    });
	
});
</script>
<div class="contact-area d-flex align-items-center">
    
    <div class="img">
        <img alt="" src="${root }/image/1.jpg">
    </div>  
    <div class="layout1">
        <h4>
			멋진 아이디어가 있으시군요! <br> 어떤 프로젝트를 계획 중이신가요?
		</h4>
		<p>나중에 변경 가능하니 너무 걱정마세요.</p>
		<br>
		<div>
		<ul>
			<li>
				<button type="button" value="게임" class="btn btn-category">게임</button>
			</li>
			<li>
				<button type="button" value="공연" class="btn btn-category">공연</button>
			</li>
			<li>
				<button type="button" value="디자인" class="btn btn-category">디자인</button>
			</li>
			<li>
				<button type="button" value="사진" class="btn btn-category">사진</button>
			</li>
			<li>
				<button type="button" value="영화·비디오" class="btn btn-category">영화·비디오</button>
			</li>
			<li>
				<button type="button" value="푸드" class="btn btn-category">푸드</button>
			</li>
			<li>
				<button type="button" value="음악" class="btn btn-category">음악</button>
			</li>
			<li>
				<button type="button" value="테크" class="btn btn-category">테크</button>
			</li>
			<li>
				<button type="button" value="패션" class="btn btn-category">패션</button>
			</li>
		</ul>
		</div>	
		<div id="next"></div>
    </div>
    
    <div class="contact-info layout2">
        <h4>
			마지막으로, 이런 준비가 필요해요.
		</h4>
		<p style="font-size:13px;">프로젝트를 진행하시려면 아래 내용을 준비해주세요.</p>
		<hr>
		<br>
			<div class="textAndCheck">
				<div class="checkBox1">
					<ul>
						<li style="margin-top: 9px;">
							<label>
								<input type="checkbox" class="inpu" name="inpu" id="inpu1">
			    			</label>
						</li>
						<li style="margin-top: 3px;">
						<label>
							<input type="checkbox" class="inpu" name="inpu" id="inpu2">
		    			</label>
						</li>
						<li style="margin-top: 23px;">
						<label>
							<input type="checkbox" class="inpu" name="inpu" id="inpu3">					
		    			</label>
						</li>
					</ul>
				</div>
				<div class="textBox1">
					<ul>
						<li>
							<label for="inpu1">
								<span>
								대표 창작자는 <strong>만 19세 이상의 성인</strong>이여야 합니다.
			    				</span>
			    			</label>
						</li>
						<li>
							<label for="inpu2">
								텀블벅에서 필요 시 연락 드릴 수 있도록 
								<strong>본인 명의의 휴대폰 번호</strong>와 <strong>이메일 주소</strong>가 필요합니다.
			    			</label>
						</li>
						<li>
							<label for="inpu3">
								펀딩 성공 후의 정산을 위해 <strong>신분등 또는 사업자 등록증, 국내 은행 계좌</strong>
								를 준비해주세요.					
			    			</label>
						</li>
					</ul>
				</div>
			</div>
		<br>
		<hr>
		<div>
			<span id="back" style="cursor: pointer;">
				<i class="fa fa-chevron-left bakcCss"></i>
				&nbsp;&nbsp;뒤로가기
			</span>
			<form action="insert" method="post">
			<button type="submit" class="btn btn3" disabled="disabled" onclick="/project/insert">시작하기</button>
			<input type="hidden" id="category" name="category">
			<input type="hidden" name="id" value="${sessionScope.id }">
			</form>
    	</div>
    </div>
</div>