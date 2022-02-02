<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri = "http://java.sun.com/jsp/jstl/core" %>

<style>
.title{
	font-size:11pt;
}
.update-save{
	width: 55px;
	height: 35px;
	border: none;
	border-radius: 5px;
	background-color: #1e90ff;
	color: white;
	font-weight: bold;
}
</style>

<div class="profilephoto">
	<span class="title">
		<b>프로필 사진</b>
	</span>
	<span class="updatePhoto">
		<span class="updatespan">변경</span>
		<br>
	</span>
	<br>
	<c:if test="${dto.photo == null}">
		<img class="img1" src="../profile_image/basic.jpg"/>
	</c:if>
	<c:if test="${dto.photo != null}">
		<img class="img1" src="../profile_image/${dto.photo }"/>
	</c:if>
	<hr>
</div>
    	
<div class="ptofilephotoupdate">
	<span class="title">
		<b>프로필 사진</b>
	</span>
	<span class="close1">
		<span class="updatespan">취소</span>
		<br>
	</span>
	<br>
	
	<c:if test="${dto.photo == null}">
		<img class="img2" align="left" src="../profile_image/basic.jpg"/>
	</c:if>
	<c:if test="${dto.photo != null}">
		<img class="img2" align="left" src="../profile_image/${dto.photo }"/>
	</c:if>
	
	<form action="updatephoto" method="post" enctype="multipart/form-data">
		<input type="hidden" name="num" value="${dto.num}">
		<p style="margin-top: 10px; margin-left: 110px;">
			<input type="button" class="btn btn-default" value="파일 업로드" onclick=document.all.file.click();> 
			<input type="file" onchange="setThumbnail(event);" name="file" id="file" style="display: none;"/>
			<br>
			250 x 250 픽셀에 최적화되어 있으며, 10Mb 이하의 JPG, GIF, PNG 파일을 지원합니다.
			<br>
			<button type="submit" class="update-save" style="">저장</button>
		</p>
	</form>
	<hr>
</div>
    	
<!-- 이름 -->
<div class="profilename">
	<span class="title">
		<b>이름</b>
	</span>
	<span class="updateName">
		<span class="updatespan">변경</span>
		<br>
	</span>
	<div style="margin-top:10px;">
		${dto.name}
	</div>
	<hr>
</div>

<div class="ptofilenameupdate">
	<span class="title">
		<b>이름</b>
	</span>
	<span class="close2">
		<span class="updatespan">취소</span>
		<br>
	</span>
	<form action="updatename" method="post" onsubmit="return namecheck();">
		<input type="hidden" name="num" value="${dto.num}">
		<input type="text" class="form-control" id="name" name="name" maxlength="20" required="required" style="width:50%; margin-top:10px;" value="${dto.name}"> 		
		<div>
			<b class="namemsg"></b>
		</div>
		<button type="submit" class="update-save" style="margin-top:10px;">저장</button>	
	</form>
	<hr>
</div>
    
<script>
function namecheck() {

	var name=$("#name").val().trim();//입력값	
	var rs = "";
	
	if(name.trim().length==0){
		$("b.namemsg").html("<font color='red'>닉네임을 입력해주세요</font>");
		rs = false;
	}
	
	$.ajax({
		type:"get",
		dataType:"json",
		data:{"name":name},
		url:"../member/namecheck",
		async: false,
		success:function(data){
			if(data.check==1){
				$("b.namemsg").html("<font color='red'>이미 사용중인 닉네임입니다.</font>");
				$("#name").focus();
				rs = false;
			}else{
				$("b.namemsg").html("");
				rs = true;
			}
		}
	});
	return rs;
}
</script> 
    	
<!--  url -->
<div class="profileurl">
	<span class="title">
		<b>사용자(URL)</b>
	</span>
	<span class="updateUrl">
		<span class="updatespan">변경</span>
		<br>
	</span>
	<div style="margin-top:10px;">
		http://localhost:9002/profile/<b>${dto.url }</b>
	</div>
	<hr>
</div>

<div class="profileurlupdate">
	<span class="title">
		<b>사용자(URL)</b>
	</span>
	<span class="close3">
		<span class="updatespan">취소</span>
		<br>
	</span>
	<form action="updateurl" method="post" onsubmit="return urlcheck();">
		<div class="form-group">
			<input type="hidden" name="num" value="${dto.num}">
			<input type="text" required="required" class="form-control" id="url" name="url" style="width:50%; margin-top:10px;" value="${dto.url }">
			<div style="color:gray; margin-top:10px;">
				<div>
					사용자 이름은 회원님의 프로필 주소로 활용됩니다. ex) http://localhost:9002/profile/사용자이름
				</div>
				<div class="url-check">
					4~12자리의 영문,숫자,영문+숫자의 조합으로 입력해주세요
				</div>
			</div>
			<div>
				<b class="urlmsg"></b>
			</div>
		</div>
		<button type="submit" class="update-save">저장</button>
	</form>
	<hr>
</div>  
    	
<script>
function urlcheck() {
	var url = $("#url").val().trim();
	var rs = "";
	var regExp=/^[a-zA-z0-9]{4,12}$/.test(url); //url 유효성 검사

	if(url.trim().length==0){
		$("b.urlmsg").html("<font color='red'>url을 입력해주세요</font>");
		rs = false;
	}

	$.ajax({
		type:"get",
		dataType:"json",
		data:{"url":url},
		url:"../member/urlcheck",
		async: false,
		success:function(data){
			if(data.check==1){
				$("b.urlmsg").html("<font color='red'>이미 사용중인 URL입니다.</font>");
				$("#url").focus();
				rs = false;
			}else{
				if(!(regExp)){
					$(".url-check").css({"color" : "red", "font-weight" : "bold"});
					$("#url").val("");
					$("#url").focus();
					rs = false;
				}else{
					rs = true;
				}
			}
		}
	});
  	return rs;
}
</script>  	
		
<!--  소개 -->
<div class="introduce">
	<span class="title">
		<b>소개</b>
	</span>
	<span class="updateIntroduce">
		<span class="updatespan">변경</span>
		<br>
	</span>
	<div style="margin-top:10px; color:gray;">
		<c:if test="${dto.introduce == null}">
			등록된 소개가 없습니다.
		</c:if>
		<c:if test="${dto.introduce != null}">
			<div style="margin-top:10px;">${dto.introduce}</div>
		</c:if>
	</div>
	<hr>
</div>
 	
<div class="introduceupdate">
	<span class="title">
		<b>소개</b>
	</span>
	<span class="close4">
		<span class="updatespan">취소</span>
		<br>
	</span>
	<form action="updateintroduce" method="post">
		<input type="hidden" name="num" value="${dto.num}">
		<textarea class="form-control" required="required" style="width:100%; height:200px; margin-top:10px;"id="introduce" name="introduce" placeholder="자기소개를 입력해주세요."></textarea>		
		<button type="submit" class="update-save" style="margin-top:10px;">저장</button>
	</form>
	<hr>
</div>
    	
<!--  프라이버시 -->
<div class="privacy">
	<span class="title">
		<b>프라이버시</b>
	</span>
	<span class="updatePrivacy">
		<span class="updatespan">변경</span>
		<br>
	</span>
	<div style="margin-top:10px; color:gray;">
		<c:if test="${dto.privacy == '1'}">
			<span style="margin-top:10px;">후원한 프로젝트 목록을 공개합니다.</span>
		</c:if>
		<c:if test="${dto.privacy == '0'}">
			<div style="margin-top:10px;">후원한 프로젝트 목록을 공개하지 않습니다.</div>
		</c:if>
	</div>
	<hr>
</div>

<div class="privacyupdate">
	<span class="title">
		<b>프라이버시</b>
	</span>
	<span class="close5">
		<span class="updatespan">취소</span>
		<br>
	</span>
	<br>
	<form action="privacyupdate" method="post">
		<input type="hidden" name="num" value="${dto.num}">
		<label>
			<input type="checkbox" ${dto.privacy == "1"?"checked":""} value="${dto.privacy}" name="privacy" id="privacy"><span style="margin-top:10px;">후원한 프로젝트 목록을 공개합니다.</span><br>
		</label>
		<br>
		<button type="submit" class="update-save" style="margin-top:10px;">저장</button>
	</form>
	<hr>
</div>
