<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript">
$(document).ready(function() {
    $('#title').on('keyup', function() {
    	var textlength = $("#title").val().length + "/50";
    	$(".text_length").html(textlength);
    });
});

$(function() {
	$("#finalSave1, #finalSave2, #finalSave3, #finalSave4, #finalSave5").css({"backgroundColor":"#cbcbcb","cursor":"auto","color":"white"});
	projectData();
	audit = ($("#audit").val());
	$("#getData").hide();
	var sel = $("#db_category").val();
	$("#category option[value='" + sel + "']").prop('selected', 'selected').change();
	
	var data1 = "${dto.thumbnail}";
	if(data1 != '') {
		$('#imgArea').attr('src' , "${root }/thumbnail_image/${dto.thumbnail}");
		$("#layout4").css({'margin-left':'100px','margin-top':'60px'});
		$("#img_layout").css({'display':'flex'});
		$(".filebox").children().html("이미지변경");
		$("#layout3").hide();
		
	}
	

	
	function readURL(input) {
		$("#layout3").hide();
	
		if (input.files && input.files[0]) {
			var reader = new FileReader();
			reader.onload = function(e) {
				$('#imgArea').attr('src', e.target.result); 
			}
			reader.readAsDataURL(input.files[0]);
		}
		$("#layout4").css({'margin-left':'100px','margin-top':'60px'});
		$("#img_layout").css({'display':'flex'});
		$(".filebox").children().html("이미지변경");
	}

	$(":input[name='upload']").change(function() {
		if( $(":input[name='upload']").val() == '' ) {
			$('#imgArea').attr('src' , '');  
		}
		$('#imgViewArea').css({ 'display' : '' });
		readURL(this);
	});
	
	$("#title,#upload").on("input",function() {
		if($("#title").val() != '' || $("#upload").val() != ''){
			 $("button#save0").css({"backgroundColor":"#d2201d","cursor":"pointer","color":"#fff"}).prop("disabled",false);
		}else{
			 $("button#save0").css({"backgroundColor":"#cbcbcb","cursor":"auto","color":"white"}).prop("disabled",true);
			 
		}
	});
	
	function imgAreaError(){
		$('#imgViewArea').css({ 'display' : 'none' });
	}
	
	

 	$("#finalSave1, #finalSave2, #finalSave3, #finalSave4, #finalSave5").click(function() {
		  var idx = $("#idx").val();
		  var audit = '1';
		  if (confirm("심사요청시 수정이 불가능합니다. 요청하시겠습니까?") != true){
				return;
			}
		  $.ajax({
			  type		: "post",
			  url		: "progressUpdata",
			  data		: {"idx" : idx, "audit" : audit},
			  success	: function() {
				  alert("요청완료!");
				  $("button#save0,#save2,#save3,#save4,#save5").css({"backgroundColor":"#cbcbcb","cursor":"auto","color":"white"}).prop("disabled",true);
				  $("#finalSave1, #finalSave2, #finalSave3, #finalSave4, #finalSave5").css({"backgroundColor":"#cbcbcb","cursor":"auto","color":"white"}).prop("disabled",true).html("심사중");
				  location.href="/";
			  },
			  error		: function(request,status,error){
			        alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			  }
		  })
	}); 

});
</script>
<form action="defaultUpdate" method="post" enctype="multipart/form-data" id="upload-file-form">

	<!-- header(button) -->
	<header class="header_area project_back reward_boxForm">
		<div id="btn" class="passbtn_box">	
			<a class="main-logo" href="/">
			<img class="bunddeuk" alt="" src="${root }/img/core-img/bunddeuk.png">
			</a>
			<button type="button" id="finalSave1" class="btn final-btn final_btn" disabled="disabled">심사요청</button>
			<button type="submit" id="save0" class="btn save btn_css save_btn" disabled="disabled">저장하기</button>
		</div>
	</header>
	
	<div class="media">
		<div class="main_title">
		<h6>프로젝트 카테고리<i class="fa fa-asterisk iconStar"></i></h6>
			<div class="sub_text">
				프로젝트 성격과 가장 일치하는 카테고리를 선택해주세요.<br>
				적합하지 않을 경우 운영자에 의해 조정될 수 있습니다.
			</div>
		</div>
		<div>
			<div class="layout1">
				<p>카테고리</p>
				<div>
					<select class="sel" id="category" name="category">
						<option value="게임">게임</option>
						<option value="공연">공연</option>
						<option value="디자인">디자인</option>
						<option value="사진">사진</option>
						<option value="영화·비디오">영화·비디오</option>
						<option value="푸드">푸드</option>
						<option value="음악">음악</option>
						<option value="테크">테크</option>
						<option value="패션">패션</option>
					</select>
				</div>
			</div>
		</div>
	</div>
	<hr>
	<br>
	<div class="media">
		<div class="main_title">
		<h6>프로젝트 제목<i class="fa fa-asterisk iconStar"></i></h6>
			<div class="sub_text">
				프로젝트와 주제, 창작물의 특징이 드러나는 멋진 제목을<br>
				붙여주세요.
			</div>
		</div>
		<div>
			<div class="layout1">
				<p>제목</p>
				<div class="groundBorder">
					<div class="sub_title">
						<div class="sub_font" id="subFont">
						제목은<br>
						어디에 쓰이나요?
						</div>	
						<div>
						<img alt="" src="${root }/image/title.png" class="img">
						</div>
					</div>
				</div>
				<br><br>
				<div>
					<input type="text" class="textform title_length" name="title" id="title" required="required" value="${dto.title }"
					placeholder="제목을 입력해주세요" maxlength="50">
					<div class="text_length">0/50</div>
				</div>
			</div>
		</div>
	</div>
	<hr>
	<br>
	<div class="media">
		<div class="main_title">
		<h6>프로젝트 대표 이미지<i class="fa fa-asterisk iconStar"></i></h6>
			<div class="sub_text">
				후원자들이 프로젝트의 내용을 쉽게 파악하고 좋은 인강을 받을 수 있도록 이미지 가이드라인을 따라주세요.
			</div>
		</div>
		<div>
	
			<div class="layout1">
				<div class="groundBorder">
					<div class="sub_title">
						<div>
						<img alt="" src="${root }/image/image.png" class="img">
						</div>
					</div>
				</div>
				<br><br>
				<div class="file_box">
					<div id="img_layout">
					<div id="imgViewArea" class="imgView">
						<img id="imgArea" class="imgView" onerror="imgAreaError()"/>
					</div>
						<div id="layout4">
							<div class="uploadImg" style="">
							<label for="upload">
								<img src="${root }/image/3.JPG">
							</label>
							</div>
							<div class="filebox"> 
								<label for="upload">이미지 업로드</label> 
								<input type="file" id="upload" name="upload"> 
							</div>
						</div>
						<div id="layout3">
							<label for="ex_file" class="label_box">
								파일 형식은 jpg또는 png로,<br>
								사이즈는 가로1,240px,세로 930px 이상<br>
								으로 올려주세요.
							</label>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<input type="hidden" value="${idx }" id="idx" name="idx">
</form>
<!-- 진행률 알아보기 -->
<div id="getData">
<input type="text" id="db_thumbnail">
<input type="text" id="db_target">
<input type="text" id="db_project_goal">
<input type="text" id="db_policy">
<input type="text" id="titl">
<input type="text" id="progress">
<input type="text" id="db_category" value="${dto.category  }">
</div>