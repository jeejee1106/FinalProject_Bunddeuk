<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet" type="text/css" href="/css/list-category.css">
<script type="text/javascript">
	let category="default";
	let state="default";
	let percent="default";
	let search = "default";
	
	if (search != '') {
		search = '${search}'
	}
	
	$(function() {
		//검색 후 검색키워드 클릭하면 키워드 삭제
		$(".cancel-search").click(function() {
			$(this).removeClass("cancel-search");
			location.href = '/project/stateList?category=default&state=default'
		});
		
		//카테고리, 상태 선택에 따른 리스트 출력
		category = $("#category").val();
		state = $("#state").val();
	    //일단 선택되어진 상태에 대한 리스트를 먼저 뿌린 후
		list();
	    //그 다음부터 바뀌는 상태에 따라 리스트 뿌림
		$(".list-gore-btn").change(function(){
			category = $("#list-gore").val();
			list();
		});
		$(".list-state-btn").change(function(){
			state = $("#list-state").val();
			list();
		});
		$(".list-percent-btn").change(function(){
			percent = $("#list-percent").val();
			list();
		});
	});
	
	function list() {
		$.ajax({
			type : "get",
			dataType : "json",
			url : "/stateList/allList",
			data:{"category":category, "state":state, "percent":percent, "search":search},
			success : function(data) {
			var s = "";
			$.each(data,function(i, dto) {
				//공개예정 프로젝트 리스트 출력
				if(state=='book'){
					s += "<div class='category-list'>";
					s +=	"<div class='project-list-mini'>";
					s += 		"<a href='/project/bookdetail?idx=" + dto.idx + "' class='list-thumbnail'>";
					s += 			"<div class='thumbnail-image'>";
					s += 				"<img src=${root}/thumbnail_image/" +dto.thumbnail+">";
					s += 			"</div>";
					s += 			"<div class='category-name'>";
					s += 				dto.category + "ㅣ" + dto.name;
					s += 			"</div>";
					s += 			"<div class='main-project-title'>";
					s += 				dto.title;
					s += 			"</div>";
					s += 		"</a>";
					s += 		"<div class='title-line'>";
					s += 		"</div>";
					s += 		"<div>";
					s += 			"공개 예정일&nbsp;&nbsp;&nbsp;" + dto.start_date;
					s += 		"</div>";
					s += 	"</div>";
					s += "</div>";
				//그 외 프로젝트들 리스트 출력
				}else{
					s += "<div class='category-list'>";
					s +=	"<div class='project-list-mini'>";
					s += 		"<a href='/project/detail?idx=" + dto.idx + "' class='list-thumbnail'>";
					s += 			"<div class='thumbnail-image'>";
					s += 				"<img src=${root}/thumbnail_image/" +dto.thumbnail+">";
					s += 			"</div>";
					s += 			"<div class='category-name'>";
					s += 				dto.category + "ㅣ" + dto.name;
					s += 			"</div>";
					s += 			"<div class='main-project-title'>";
					s += 				dto.title;
					s += 			"</div>";
					s += 			"<div class='title-line'>";
					s += 			"</div>";
					s += 		"</a>";
					s += 		"<span class='project-totalAmount'>";
					s += 			dto.total_amount.toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",") + "원";
					s += 		"</span>";
					s += 		"<span class='percentageAchieved2'>";
					s += 			(Math.round(dto.total_amount / dto.target_amount * 100)) + "%";
					s += 		"</span>";
					s += 	"</div>";
					s += "</div>";
				}
					});
						$(".list-chul-ajax").html(s);
					}
				});
	}

</script>
<div class="totalLayout">
	<div class="list-select">
		<div class="wrap">
			<span class="list-gore">
				<select class="list-gore-btn" id="list-gore">
					<option value="default">카테고리</option>
					<option value="게임" ${category=='게임'?'selected':'' }>게임</option>
					<option value="공연" ${category=='공연'?'selected':'' }>공연</option>
					<option value="디자인" ${category=='디자인'?'selected':'' }>디자인</option>
					<option value="사진" ${category=='사진'?'selected':'' }>사진</option>
					<option value="영화·비디오" ${category=='영화·비디오'?'selected':'' }>영화·비디오</option>
					<option value="푸드" ${category=='푸드'?'selected':'' }>푸드</option>
					<option value="음악" ${category=='음악'?'selected':'' }>음악</option>
					<option value="테크" ${category=='테크'?'selected':'' }>테크</option>
					<option value="패션" ${category=='패션'?'selected':'' }>패션</option>
				</select>
			</span>
			<span class="list-gore">
				<select class="list-state-btn" id="list-state">
					<option value="default"${state=='default'?'selected':'' }>모든 프로젝트</option>
					<option value="pop"${state=='pop'?'selected':'' }>인기 프로젝트</option>
					<option value="endsoon"${state=='endsoon'?'selected':'' }>마감임박 프로젝트</option>
					<option value="new"${state=='new'?'selected':'' }>신규 프로젝트</option>
					<option value="book"${state=='book'?'selected':'' }>공개예정 프로젝트</option>
				</select>
			</span>
			<span class="list-gore">
				<select class="list-percent-btn" id="list-percent">
					<option value="default">달성률</option>
					<option value="75down">75% 이하</option>
					<option value="75to100">75%~100%</option>
					<option value="100up">100% 이상</option>
				</select>
			</span>
			<c:choose>
				<c:when test="${search != 'default'}">
					<span class="cancel-search">
						${search} <i class="fa fa-remove"></i>
					</span>
				</c:when>
				<c:otherwise>
					<span></span>
				</c:otherwise>
			</c:choose>
		</div>
	</div>
</div>
<div class="totalLayout">
	<div class="list-chul-ajax">
	
	</div>
</div>
<input type="hidden" id="category" value="${category}">
<input type="hidden" id="state" value="${state}">