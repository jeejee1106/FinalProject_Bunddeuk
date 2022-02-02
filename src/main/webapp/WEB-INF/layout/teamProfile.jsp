<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script>
	$(function() {
		$(".profile_box").hide();
		
		$("#mj_proflie").click(function(event) {
			$(".profile_box").hide();
			$("#kmj").show();
			event.preventDefault();
			 $('html,body').animate({scrollTop:$("#focus_mj").offset().top - 300}, 500);
		});
		$("#ws_proflie").click(function(event) {
			$(".profile_box").hide();
			$("#kws").show();
			event.preventDefault();
			$('html,body').animate({scrollTop:$("#focus_ws").offset().top - 300}, 500);			
		});
		$("#dh_proflie").click(function(event) {
			$(".profile_box").hide();
			$("#kdh").show();
			event.preventDefault();
			$('html,body').animate({scrollTop:$("#focus_dh").offset().top - 300}, 500);			
		});
		$("#jw_proflie").click(function(event) {
			$(".profile_box").hide();
			$("#ajw").show();
			event.preventDefault();
			$('html,body').animate({scrollTop:$("#focus_jw").offset().top - 300}, 500);
		});
		$("#hm_proflie").click(function(event) {
			$(".profile_box").hide();
			$("#khm").show();
			event.preventDefault();
			$('html,body').animate({scrollTop:$("#focus_hm").offset().top - 300}, 500);
		});
	});
</script>
<div class="totalLayout">
	<img alt="" src="${root }/img/core-img/img2.jfif" class="logo_img2">   
	<div class="totalLayout_text"> 
		<img alt="" src="${root }/img/core-img/bunddeuk.png" class="logo_img">   
	</div>
		<h3 class="h1_css">Bunddeuk-Buddeuk</h3>
		<h6>번뜩이를 탄생시킨 5명의 히어로들을 소개합니다.</h6><br>
		<hr>
		
	<!-- 프로필 -->	
	<div class="totalLayout1">
		<div class="profileBox" id="mj_img">
			<span>KIM MINJEE</span>
			<img alt="" src="${root }/img/core-img/kmj.jpg" class="team_myimg" id="mj_proflie">
		</div>
		<div class="profileBox" id="ws_img">
			<span>KIM WONSEOP</span>
			<img alt="" src="${root }/img/core-img/kws.jpg" class="team_myimg" id="ws_proflie">
		</div>
		<div class="profileBox" id="dh_img">
			<span>KANG DONGHAM</span>
			<img alt="" src="${root }/img/core-img/kdh.jpg" class="team_myimg" id="dh_proflie">
		</div>
		<div class="profileBox" id="jw_img">
			<span>AN JIWON</span>
			<img alt="" src="${root }/img/core-img/ajw.jpg" class="team_myimg" id="jw_proflie">
		</div>
		<div class="profileBox1" id="hm_img">
			<span>KIM HAEMIN</span>
			<img alt="" src="${root }/img/core-img/khm.jpg" class="team_myimg" id="hm_proflie">
		</div>
	</div>
	<!-- end 프로필 -->
	<hr> 
	
	
	
	<!--****************김민지 프로필************************
	*********************************************************  -->
	<div class="profile_box" id="kmj">
		<h1>MINJEE KIM</h1>
		<p class="spanFont">Developer</p>
		<p class="subFOnt">안녕하세요! 번뜩번뜩 팀의 김민지입니다:) 고통을 즐기겠습니다.</p>
		<div class="point_te">
			<img alt="" src="${root }/img/core-img/point.JPG" class="point_img">
		</div>
		<div class="point_profile">
			<img alt="" src="${root }/img/core-img/kmj.jpg" class="point_img" id="focus_mj">
		</div>
		
		
		<div class="profile_data">
			<div class="biography">
				<h4>PROFILE
			</div>
			<div class="biography_date">
				<p>이    름: </p>
				<p>생년월일: </p>
			
				<p>2013.02 ~ 2019.02</p>
				<p>2021.08 ~ 2021.12</p>
			</div>
			<div class="biography_data">
				<p>김  민  지<p>
				<p>1995.11.06<p>
				<p>4년제 대학교 졸업<p>
				<p>비트캠프 213기 수료<p>
			</div>
		</div>
		
		<hr class="css_line">
		
		<div class="profile_data">
			<div class="biography">
				<h4>PART
			</div>
			<div class="biography_data">
				<p>카카오 정기 결제 API 기능 구현<p>
				<p>프로젝트 상세 페이지 - css, 관심프로젝트 등록, 후원하기<p>
				<p>메인 페이지 리스트 css<p>
				<p>git, notion등 협업툴 관리<p>
			</div>
		</div>
		<br>
		<hr>
	</div>
	<!--*****************************************************
	*********************************************************  -->
	
	
	<!--****************김원섭 프로필************************
	*********************************************************  -->
	<div class="profile_box" id="kws">
		<h1>WONSEOP KIM</h1>
		<p class="spanFont">Developer</p>
		<p class="subFOnt">안녕하세요! 번뜩번뜩 팀의 김원섭입니다ㅎ</p>
		<div class="point_te">
			<img alt="" src="${root }/img/core-img/point.JPG" class="point_img">
		</div>
		<div class="point_profile">
			<img alt="" src="${root }/img/core-img/kws.jpg" class="point_img" id="focus_ws">
		</div>
		
		
		<div class="profile_data">
			<div class="biography">
				<h4>PROFILE
			</div>

			<div class="biography_data">
		        <p>이    름: 김원섭 </p>
		        <p>생년월일: 1993.12.07 </p>
				<p>비트캠프 213기 수료<p>
			</div>
		</div>
		
		<hr class="css_line">
		
		<div class="profile_data">
			<div class="biography">
				<h4>PART
			</div>
			<div class="biography_data">
	          <p>채팅 기능 구현<p>
	          <p>댓글 기능 구현<p>
	          <p>후원 축하 페이지 구현<p>
	          <p>프로젝트 카테고리별 출력 및 검색 백엔드 부분 구현<p>
	          <p>윈도우 가상컴퓨터를 통한 서버 배포<p>
			</div>
		</div>
		<br>
		<hr>
	</div>
	<!--*****************************************************
	*********************************************************  -->
	
	
	<!--****************강동한 프로필************************
	*********************************************************  -->
	<div class="profile_box" id="kdh">
		<h1>Kang Dong Han</h1>
		<p class="spanFont">Developer</p>
		<p class="subFOnt">안녕하세요! 번뜩번뜩 팀의 강동한입니다:)</p>
		<div class="point_te">
			<img alt="" src="${root }/img/core-img/point.JPG" class="point_img">
		</div>
		<div class="point_profile">
			<img alt="" src="${root }/img/core-img/kdh.jpg" class="point_img" id="focus_dh">
		</div>
		
		
		<div class="profile_data">
			<div class="biography">
				<h4>PROFILE
			</div>
			<div class="biography_date">
				<p>이    름: 강동한 </p>
         		<p>비트캠프 214기 수료<p>
			</div>
		</div>
		
		<hr class="css_line">
		
		<div class="profile_data">
			<div class="biography">
				<h4>PART
			</div>
			<div class="biography_data">
				<p>회원가입, 회원탈퇴, 회원정보 수정 구현<p>
          		<p>카카오 로그인, 이메일 인증 기능 구현<p>
          		<p>배송지  기능 구현<p>
          		<p>url 이동 구현, 비밀번호 암호화 구현<p>

			</div>
		</div>
		<br>
		<hr>
	</div>
	<!--*****************************************************
	*********************************************************  -->
	
	
	<!--****************안지원 프로필************************
	*********************************************************  -->
	<div class="profile_box" id="ajw">
		<h1>JIWON AHN</h1>
		<p class="spanFont">Developer</p>
		<p class="subFOnt">안녕하세요! 번뜩번뜩 팀의 안지원입니다:)</p>
		<div class="point_te">
			<img alt="" src="${root }/img/core-img/point.JPG" class="point_img">
		</div>
		<div class="point_profile">
			<img alt="" src="${root }/img/core-img/ajw.jpg" class="point_img" id="focus_jw">
		</div>
		
		
		<div class="profile_data">
			<div class="biography">
				<h4>PROFILE
			</div>
			<div class="biography_data">
		        <p>이    름: 안지원 </p>
		        <p>생년월일: 1990.01.21 </p>
				<p>4년제 대학교 졸업<p>
				<p>비트캠프 214기 수료<p>
			</div>
		</div>
		
		<hr class="css_line">
		
		<div class="profile_data">
			<div class="biography">
				<h4>PART
			</div>
			<div class="biography_data">
		        <p>프로필 기능 구현<p>
		        <p>메세지 기능 구현<p>
		        <p>공지사항 기능 구현<p>
		        <p>관리자 기능 구현<p>
			</div>
		</div>
		<br>
		<hr>
	</div>
	<!--*****************************************************
	*********************************************************  -->
	
	
	<!--김해민 프로필  -->
	<div class="profile_box" id="khm">
		<h1>HAEMIN KIM</h1>
		<p class="spanFont">Developer</p>
		<p class="subFOnt">안녕하세요! 번뜩번뜩 팀의 김해민입니다:) 번뜩팀을 함께 탄생시킨 4명의 제 소중한 히어로들과 앞으로도 나아가겠습니다!</p>
		<div class="point_te">
			<img alt="" src="${root }/img/core-img/point.JPG" class="point_img">
		</div>
		<div class="point_profile">
			<img alt="" src="${root }/img/core-img/khm.jpg" class="point_img" id="focus_hm">
		</div>
		
		
		<div class="profile_data">
			<div class="biography">
				<h4>PROFILE
			</div>
			<div class="biography_date">
				<p>이    름: </p>
				<p>생년월일: </p>
			
				<p>2013.02 ~ 2019.02</p>
				<p>2021.08 ~ 2021.12</p>
			</div>
			<div class="biography_data">
				<p>김  해  민<p>
				<p>1994.10.05<p>
				<p>4년제 대학교 졸업<p>
				<p>비트캠프 213기 수료<p>
			</div>
		</div>
		
		<hr class="css_line">
		
		<div class="profile_data">
			<div class="biography">
				<h4>PART
			</div>
			<div class="biography_data">
				<p>AWS - RDS 생성 후 배포, EC2 서버배포<p>
				<p>프로젝트 작성(summerNote,DatePicker) 백엔드,프론트<p>
				<p>해더,배너,푸터 프론트<p>
				<p>개발자 소개 페이지,배너 제작<p>
			</div>
		</div>
		<br>
		<hr>
	</div>
	<!-- end 김해민프로필 -->
	<div class="end_layout">
		<br>
		<h2>Let me introduce the creators.</h2>
		<h6>번뜩이 제작에 도움을 주신 창작자님들을 소개합니다.</h6><br><br>
		<img alt="" src="${root }/img/core-img/creators.jpg" class="creators_img">
	</div>
	
</div>