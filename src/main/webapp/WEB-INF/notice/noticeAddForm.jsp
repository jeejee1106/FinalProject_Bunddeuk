<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 공지사항 입력 폼 -->

<link rel="stylesheet" type="text/css" href="/css/notice.css">
<script src="//cdn.ckeditor.com/4.17.1/standard/ckeditor.js"></script>

<script>
$(document).ready(function() {
	CKEDITOR.replace("ckeditor", {
		filebrowserUploadUrl:'/notice/upload_ckeditor',
		height: 400
	});
	
 	CKEDITOR.on("dialogDefinition", function(e) {
		var dialogName = e.data.name;
		var dialogDefinition = e.data.definition;
		
		switch(dialogName) {
			case 'image':
				//dialogDefinition.removeContents('info');
				dialogDefinition.removeContents('link');
				dialogDefinition.removeContents('advanced');
				break;
		}
	});
	
	$('#btn_save').click(function() {
		//alert(CKEDITOR.instances.ckeditor.getData());
		location.href="/notice";
	});
	$('#btn_reset').click(function() {
		var a = confirm("작성중인 내용이 초기화 시키겠습니까?");
		if(a == true) {
			CKEDITOR.instances.ckeditor.setData('');
			$("#subject").val("");
		}
	});
	$('#btn_cancel').click(function() {
		var a = confirm("사이트에서 나가시겠습니까?");
		if(a == true) {
			 location.href="/notice";
		}
	});
	
});

</script>
<!-- 공지사항 타이틀 -->
<div class="Notices_SettingTitle">
	<div class="Container__ContainerComponent">
		<span class="fnt-lt">공지사항 작성하기</span>
	</div>
	<div class="Container__TabContainerComponent">
		<div class="TabContainer">
		</div>
	</div>
</div>
<!-- /공지사항 타이틀 -->
<!-- 입력폼 -->
<div style="width: 60%; margin: auto; margin-top: 30px;">
	<form action="insert" method="post">
		<table class="table table-bordered">
			<tr>
				<th>제목</th>
				<td>
					<input type="text" name="subject" id="subject" class="form-control" style="width: 100%;"/>
				</td>
			</tr>
			<tr>
				<th>내용</th>
				<td>
					<textarea id="ckeditor" name="content"></textarea>
				</td>
			</tr>
			<tr>
				<td colspan="3">
				<div style="float: right;">
					<button type="submit" class="btn" id="btn_save">
						글쓰기
					</button>
					<button type="button" class="btn" id="btn_reset">
						새로쓰기
					</button>
					<button type="button" class="btn" id="btn_cancel">
						취소
					</button>
				</div>
				</td>
			</tr>
		</table>
	</form>
</div>