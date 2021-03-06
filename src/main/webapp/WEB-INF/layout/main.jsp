<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
	/* hidden????????? input??? ??? ????????? ???????????? ?????? */
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
			list = "<h2>??? ????????? ???????????????,</h2><h2>????????? ???????????? ?????? </h2><p>??????????????????????????? ????????? ????????????????????? ?????? ??????!</p>";
			$("#slider2").html(list);
		}
		if(num == '2'){
			$("#slider2").css("background-color","#e18d08");
			list = "<h2>Joy and Freedom! </h2><h2>????????? ??? ????????????!</h2><p>???????????? ????????? ????????? ???????????????!</p>";
			$("#slider2").html(list);
		}
		if(num == '3'){
			$("#slider2").css("background-color","#2b4b62");
			list = "<h2>????????? ??????,</h2><h2>?????????????????? ?????? ??????. </h2><p>???????????? ?????? ??? ?????? ??????,????????? ????????? ????????????????</p>";
			$("#slider2").html(list);	
		}
		if(num == '4'){
			$("#slider2").css("background-color","#6a2045");
			list = "<h2><???????????? ?????????>?????? </h2><h2>????????? ??????????????? </h2><p>???????????? ??????????????? ???????????? ?????????????????????:)</p>";
			$("#slider2").html(list);	
		}
		if(num == '5'){
			$("#slider2").css("background-color","rgb(51, 51, 51)");
			list = "<h2>Bunddeuk</h2><h2>???????????? ??????????????? </h2><p>???????????? ???????????? ???????????? ???????????? ???????????????</p>";
			$("#slider2").html(list);	
		}
	});
})
</script>

<!-- Start Banner -->
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
  	<div class="sub_benner" id="slider2"></div>
    <!--controls-->
    <div class="btns" id="next"><i class="fa fa-arrow-right"></i></div>
    <div class="btns" id="previous"><i class="fa fa-arrow-left"></i></div>
</div>
<!-- End Banner -->
		
<div class="totalLayout">	
	<div class="totalLayout-title">
		<a class="list-titles" title="?????? ????????????" href="/project/stateList?category=default&state=default&percent=default&search=default">?????? ????????????</a>
	</div>
	<div class="main-lists">
		<c:forEach var="projectDto" items="${allProjectList}">
			<div class="project-list-mini">
				<a href="/project/detail?idx=${projectDto.idx}&key=detail"class="list-thumbnail">
					<div class="thumbnail-image">
						<img src="${root}/thumbnail_image/${projectDto.thumbnail}">
					</div>
					<div class="category-name">
						${projectDto.category } ??? ${projectDto.name }
					</div>
					<div class="main-project-title">
						${projectDto.title}
					</div>
				</a>
				<div class="percentageAchieved">
					<fmt:formatNumber value="${projectDto.total_amount div projectDto.target_amount * 100}" pattern="0" />% ??????
				</div>
			</div>
		</c:forEach>
	</div>
	<hr>
	<div class="totalLayout-title">
		<a class="list-titles" title="?????? ????????????" href="/project/stateList?category=default&state=pop&percent=default&search=default">?????? ????????????</a>
	</div>
	<div class="main-lists">
		<c:forEach var="projectDto" items="${popularProjectList}">
			<div class="project-list-mini">
				<a href="/project/detail?idx=${projectDto.idx}&key=detail"class="list-thumbnail">
					<div class="thumbnail-image">
						<img src="${root}/thumbnail_image/${projectDto.thumbnail}">
					</div>
					<div class="category-name">
						${projectDto.category } ??? ${projectDto.name }
					</div>
					
					<div class="main-project-title">
						${projectDto.title}
					</div>
				</a>
				<div class="percentageAchieved">
					<fmt:formatNumber value="${projectDto.total_amount div projectDto.target_amount * 100}" pattern="0" />% ??????
				</div>
			</div>
		</c:forEach>
	</div>
	<hr>
	<div class="totalLayout-title">
		<a class="list-titles" title="???????????? ????????????" href="/project/stateList?category=default&state=endsoon&percent=default&search=default">???????????? ????????????</a>
	</div>
	<div class="main-lists">
		<c:forEach var="projectDto" items="${closingProjectList}">
			<div class="project-list-mini">
				<a href="/project/detail?idx=${projectDto.idx}&key=detail"class="list-thumbnail">
					<div class="thumbnail-image">
						<img src="${root}/thumbnail_image/${projectDto.thumbnail}">
					</div>
					<div class="category-name">
						${projectDto.category } ??? ${projectDto.name }
					</div>
					<div class="main-project-title">
						${projectDto.title}
					</div>
				</a>
				<div class="percentageAchieved">
					<fmt:formatNumber value="${projectDto.total_amount div projectDto.target_amount * 100}" pattern="0" />% ??????
				</div>
			</div>
		</c:forEach>
	</div>
	<hr>
	<div class="totalLayout-title">
		<a class="list-titles" title="?????? ????????????" href="/project/stateList?category=default&state=new&percent=default&search=default">?????? ????????????</a>
	</div>
	<div class="main-lists">
		<c:forEach var="projectDto" items="${newProjectList}">
			<div class="project-list-mini">
				<a href="/project/detail?idx=${projectDto.idx}&key=detail"class="list-thumbnail">
					<div class="thumbnail-image">
						<img src="${root}/thumbnail_image/${projectDto.thumbnail}">
					</div>
					<div class="category-name">
						${projectDto.category } ??? ${projectDto.name }
					</div>
					<div class="main-project-title">
						${projectDto.title}
					</div>
				</a>
				<div class="percentageAchieved">
					<fmt:formatNumber value="${projectDto.total_amount div projectDto.target_amount * 100}" pattern="0" />% ??????
				</div>
			</div>
		</c:forEach>
	</div>
	<div class="bottom_logo">
		<img src="${root}/image/bottom-logo-img.png">
		<div class="bottom_text">
		<h6>?????? ??????????????? ????????? ????????????????</h6>
		<h2>???????????? ?????? ?????? ???</h2>
		<h2>??????????????? ???????????????</h2>
		</div>
	</div>
</div>