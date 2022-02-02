<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script>
$(function() {
	//current position
	var pos = 0;
	//number of slides
	var totalSlides = $('#slider-wrap ul li').length;
	//get the slide width
	var sliderWidth = $('#slider-wrap').width();
	$(document).ready(function(){
	  
	  
	  /*****************
	   BUILD THE SLIDER
	  *****************/
	  //set width to be 'x' times the number of slides
	  $('#slider-wrap ul#slider').width(sliderWidth*totalSlides);
	  
	    //next slide  
	  $('#next').click(function(){
	    slideRight();
	  });
	  
	  //previous slide
	  $('#previous').click(function(){
	    slideLeft();
	  });
	  
	  
	  
	  /*************************
	   //*> OPTIONAL SETTINGS
	  ************************/
	  //automatic slider
	  var autoSlider = setInterval(slideRight, 3000);
	  
	  //for each slide 
	  $.each($('#slider-wrap ul li'), function() { 
	     //create a pagination
	     var li = document.createElement('li');
	     $('#pagination-wrap ul').append(li);    
	  });
	  //counter
	  countSlides();
	  
	  //pagination
	  pagination();
	  
	  //hide/show controls/btns when hover
	  //pause automatic slide when hover
	  $('#slider-wrap').hover(
	    function(){ $(this).addClass('active'); clearInterval(autoSlider); }, 
	    function(){ $(this).removeClass('active'); autoSlider = setInterval(slideRight, 3000); }
	  );
	  
	});//DOCUMENT READY
	  
	/***********
	 SLIDE LEFT
	************/
	function slideLeft(){
	  pos--;
	  if(pos==-1){ pos = totalSlides-1; }
	  $('#slider-wrap ul#slider').css('left', -(sliderWidth*pos));  
	  //*> optional
	  countSlides();
	  pagination();
	}
	/************
	 SLIDE RIGHT
	*************/
	function slideRight(){
	  pos++;
	  if(pos==totalSlides){ pos = 0; }
	  $('#slider-wrap ul#slider').css('left', -(sliderWidth*pos)); 
	  //*> optional 
	  countSlides();
	  pagination();
	}
	  
	/************************
	 //*> OPTIONAL SETTINGS
	************************/
	function countSlides(){
	  $('#counter').html(pos+1 + ' / ' + totalSlides);
	  $('#counter2').val(pos+1);
	}
	function pagination(){
	  $('#pagination-wrap ul li').removeClass('active');
	  $('#pagination-wrap ul li:eq('+pos+')').addClass('active');
	}
	
	
	/************************
	//*>SUB BENNER
	/************************
	/* hidden타입의 input에 값 변경시 감지하는 함수 */
	function survey(selector, callback) {
	    var input = $(selector);
	    var oldvalue = input.val();
	    setInterval(function(){
	       if (input.val()!=oldvalue){
	           oldvalue = input.val();
	           callback();
	       }
	    }, 80);
	}	
	
	  survey('#counter2', function(){ 
		var num = $('#counter2').val();
		var listText = '';
		if(num == '1'){
			$("#slider2").css("background-color","#122a1c");
			list = "<h2>내 마음이 투명하다면,</h2><h2>울창한 숲일지도 몰라 </h2><p>『나터뷰』『성격의 단점을 서술하시오』를 이은 신작!</p>";
			$("#slider2").html(list);
		}
		if(num == '2'){
			$("#slider2").css("background-color","#e18d08");
			list = "<h2>Joy and Freedom! </h2><h2>창작을 더 자유롭게!</h2><p>자유롭고 즐겁게 창작에 몰입하세요!</p>";
			$("#slider2").html(list);
		}
		if(num == '3'){
			$("#slider2").css("background-color","#2b4b62");
			list = "<h2>트러블 피부,</h2><h2>천연소재에서 답을 찾다. </h2><p>마스크를 벗을 수 없는 오늘,당신의 피부는 안녕한가요?</p>";
			$("#slider2").html(list);	
		}
		if(num == '4'){
			$("#slider2").css("background-color","#6a2045");
			list = "<h2><시간길목 정류장>에서 </h2><h2>당신을 기다립니다 </h2><p>시간길목 정류장에서 여러분을 기다리겠습니다:)</p>";
			$("#slider2").html(list);	
		}
		if(num == '5'){
			$("#slider2").css("background-color","rgb(51, 51, 51)");
			list = "<h2>Bunddeuk</h2><h2>개발팀을 소개합니다 </h2><p>번뜩이를 탄생시킨 다섯명의 히어로를 소개합니다</p>";
			$("#slider2").html(list);	
		}
	});
})
</script>
<!-- Start Banner Hero -->
<input type="hidden" id="counter2">
<div id="wrapper" style="margin-top: 30px;">
        <!-- 1/5 -->
        <div id="counter"></div>
    <div id="slider-wrap" class="bannerWallpaper">
		<ul id="slider">
         	<li>
         	<a href="/project/detail?idx=408&key=detail">
			<img src="${root }/img/bg-img/myhert.jpg">
			</a>
          	</li>
          
         	<li>
			<a href="/project/detail?idx=411&key=detail">
			<img src="${root }/img/bg-img/400face3.jpg">			
			</a>
          	</li>
          
         	<li>
			<a href="/project/detail?idx=420&key=detail">
			<img src="${root }/img/bg-img/sochang3.jpg">
            </a>
            </li>
           
         	<li>
         	<a href="/project/detail?idx=414&key=detail">         	
			<img src="${root }/img/bg-img/timebook.jpg">
			</a>
            </li>
           
         	<li>
         	<a href="/layout/teamProfile">
			<img src="${root }/img/bg-img/teamimg.jpg">
            </a>
            </li>
		</ul>
	</div>
    <div id="" class="testLayout">
    		<div class="sub_benner" id="slider2">
<!--     		<h2>가장 나다운</h2><h2>2022를 찾아보세요 </h2>
    		<p>200가지 역대 최대 달력*다이어리 기획전 </p> -->
    		</div>
    </div>
         <!--controls-->
        <div class="btns" id="next"><i class="fa fa-arrow-right"></i></div>
        <div class="btns" id="previous"><i class="fa fa-arrow-left"></i></div>
</div>

<!-- End Banner Hero -->
		
		
<div class="totalLayout">	
	<div class="totalLayout-title">
		<a class="list-titles" title="모든 프로젝트" href="/listchul/listChul?state=no&category=no">모든 프로젝트</a>
	</div>
	<div class="main-lists">
		<c:forEach var="dto" items="${alist}">
			<div class="project-list-mini">
				<a href="/project/detail?idx=${dto.idx}&key=detail"class="list-thumbnail">
					<div class="thumbnail-image">
						<img src="${root}/thumbnail_image/${dto.thumbnail}">
					</div>
					<div class="category-name">
						${dto.category } ㅣ ${dto.name }
					</div>
					<div class="main-project-title">
						${dto.title}
					</div>
				</a>
				<div class="percentageAchieved">
					<fmt:formatNumber value="${dto.total_amount div dto.target_amount * 100}" pattern="0" />% 달성
				</div>
			</div>
		</c:forEach>
	</div>
	<hr>
	<div class="totalLayout-title">
		<a class="list-titles" title="인기 프로젝트" href="/listchul/listChul?state=pop&category=no">인기 프로젝트</a>
	</div>
	<div class="main-lists">
		<c:forEach var="dto" items="${plist}">
			<div class="project-list-mini">
				<a href="/project/detail?idx=${dto.idx}&key=detail"class="list-thumbnail">
					<div class="thumbnail-image">
						<img src="${root}/thumbnail_image/${dto.thumbnail}">
					</div>
					<div class="category-name">
						${dto.category } ㅣ ${dto.name }
					</div>
					<div class="main-project-title">
						${dto.title}
					</div>
				</a>
				<div class="percentageAchieved">
					<fmt:formatNumber value="${dto.total_amount div dto.target_amount * 100}" pattern="0" />% 달성
				</div>
			</div>
		</c:forEach>
	</div>
	<hr>
	<div class="totalLayout-title">
		<a class="list-titles" title="마감임박 프로젝트" href="/listchul/listChul?state=endsoon&category=no">마감임박 프로젝트</a>
	</div>
	<div class="main-lists">
		<c:forEach var="dto" items="${elist}">
			<div class="project-list-mini">
				<a href="/project/detail?idx=${dto.idx}&key=detail"class="list-thumbnail">
					<div class="thumbnail-image">
						<img src="${root}/thumbnail_image/${dto.thumbnail}">
					</div>
					<div class="category-name">
						${dto.category } ㅣ ${dto.name }
					</div>
					<div class="main-project-title">
						${dto.title}
					</div>
				</a>
				<div class="percentageAchieved">
					<fmt:formatNumber value="${dto.total_amount div dto.target_amount * 100}" pattern="0" />% 달성
				</div>
			</div>
		</c:forEach>
	</div>
	<hr>
	<div class="totalLayout-title">
		<a class="list-titles" title="신규 프로젝트" href="/listchul/listChul?state=new&category=no">신규 프로젝트</a>
	</div>
	<div class="main-lists">
		<c:forEach var="dto" items="${nlist}">
			<div class="project-list-mini">
				<a href="/project/detail?idx=${dto.idx}&key=detail"class="list-thumbnail">
					<div class="thumbnail-image">
						<img src="${root}/thumbnail_image/${dto.thumbnail}">
					</div>
					<div class="category-name">
						${dto.category } ㅣ ${dto.name }
					</div>
					<div class="main-project-title">
						${dto.title}
					</div>
				</a>
				<div class="percentageAchieved">
					<fmt:formatNumber value="${dto.total_amount div dto.target_amount * 100}" pattern="0" />% 달성
				</div>
			</div>
		</c:forEach>
	</div>
	<div class="bottom_logo">
		<img src="${root}/image/bottom-logo-img.png">
		<div class="bottom_text">
		<h6>좋은 아이디어를 가지고 있으신가요?</h6>
		<h2>텀블벅과 함께 마음 속</h2>
		<h2>프로젝트를 실현하세요</h2>
		</div>
	</div>
</div>