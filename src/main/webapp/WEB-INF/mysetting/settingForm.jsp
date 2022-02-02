<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri = "http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" type="text/css" href="/css/setting.css">
<style>
a{
	font-size:20px;
	font-weight: bold;
}
</style>
<script>
$(document).ready(function () 
{
    $('a').hover(function(){
        $(this).css('font-size','20px');
    }, function() {
        $(this).css('font-size','20px');
    });
});
</script>

<br>
<div class="container" style="margin-bottom:50px;">
	<h2 style="color:gray;">설정</h2>
	<div class="tabs">
		<div class="tabs-header">
			<div class="border"></div>
			<ul>
				<li class="active"><a href="#tab-1" tab-id="1" ripple="ripple" ripple-color="#FFF">프로필</a></li>
				<li><a href="#tab-2" tab-id="2" ripple="ripple" ripple-color="#FFF">계정</a></li>
				<li><a href="#tab-3" tab-id="3" ripple="ripple" ripple-color="#FFF">배송지</a></li>
			</ul>
		</div>
		<div style="margin-top:-16px;">
			<hr>
		</div>
		<div class="tabs-content">
			<div tab-id="1" class="tab active">
				<%@ include file="/WEB-INF/mysetting/profile.jsp" %>
			</div>
			<div tab-id="2" class="tab">
				<%@ include file="/WEB-INF/mysetting/account.jsp" %>
			</div>
			<div tab-id="3" class="tab">
				<%@ include file="/WEB-INF/mysetting/delivery.jsp" %>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript">
 
function setThumbnail(event) {
	var reader = new FileReader();
	
	reader.onload = function(event) { 
		$(".img2").attr("src", event.target.result);
	}; 
	reader.readAsDataURL(event.target.files[0]); 
}
 
$(document).on("keyup", ".phoneNumber", function() {
	$(this).val( $(this).val().replace(/[^0-9]/g, "").replace(/(^02|^0505|^1[0-9]{3}|^0[0-9]{2})([0-9]+)?([0-9]{4})$/,"$1-$2-$3").replace("--", "-") ); 
});
 
$(function(){

	$('#Email_div').hide();
	$("span.updatespan_email").click(function(){
		$("div.profileemail").show();
		$('#Email_div').hide();
	});
 
	$('div.ptofilephotoupdate').hide();
	$("span.updatePhoto").click(function(){
		$("div.ptofilephotoupdate").show();
		$("div.profilephoto").hide();
	});
	
	$("span.close1").click(function(){
		$("div.profilephoto").show();
		$("div.ptofilephotoupdate").hide();
	});
	
	$('div.ptofilenameupdate').hide();
	$("span.updateName").click(function(){
		$("#name").val("${dto.name}");
		$("div.ptofilenameupdate").show();
		$("div.profilename").hide();
	});
	
	$("span.close2").click(function(){
		$("div.profilename").show();
		$("div.ptofilenameupdate").hide();
	});

	
	$('div.profileurlupdate').hide();
	$("span.updateUrl").click(function(){
		$("#url").val("${dto.url}");
		$("div.profileurlupdate").show();
		$("div.profileurl").hide();
	});
	
	$("span.close3").click(function(){
		$("div.profileurl").show();
		$("div.profileurlupdate").hide();
		$("b.urlmsg").html("");
	});

	$('div.introduceupdate').hide();
	$("span.updateIntroduce").click(function(){
	//	$("#introduce").val("${dto.introduce}");
		var content = "${dto.introduce}";
		var result = content.replace(/(<br>|<br\/>|<br \/>)/g, '\r\n');
		$("#introduce").val(result);
		$("div.introduceupdate").show();
		$("div.introduce").hide();
	});
	
	$("span.close4").click(function(){
		$("div.introduce").show();
		$("div.introduceupdate").hide();
	});
	
	$('div.privacyupdate').hide();
	$("span.updatePrivacy").click(function(){
		$("div.privacyupdate").show();
		$("div.privacy").hide();
	});
	
	$("span.close5").click(function(){
		var privacy = $("#privacy").val();
		if(privacy=="0"){
			$("#privacy").prop("checked", false);
		}
		if(privacy=="1"){
			$("#privacy").prop("checked", true);
		}
		$("div.privacy").show();
		$("div.privacyupdate").hide();
	});
	
	$('div.ptofileemailupdate').hide();
	$("span.updateEmail").click(function(){
		$("#emailupdate").val("${dto.email}");
		$("b.emailmsg").html("");
		$("div.ptofileemailupdate").show();
		$("div.profileemail").hide();
	});
	
	$("span.close6").click(function(){
		$("div.profileemail").show();
		$("div.ptofileemailupdate").hide();
	});
	
	$('div.passupdate').hide();
	$("span.updatePass").click(function(){
		$("b.pass1msg").html("");
		$("b.passmsg2").html("");
		$("b.passmsg").html("");
		$("div.passupdate").show();
		$("div.password").hide();
	});
	
	$("span.close7").click(function(){
		$("div.password").show();0
		$("div.passupdate").hide();
	});
	
	$('div.hpupdate').hide();
	$("span.updateHp").click(function(){
		$("#hp").val("${dto.hp}");
		$("b.hpmsg").html("");
		$("div.hpupdate").show();
		$("div.hp").hide();
	});
	
	$("span.close8").click(function(){
		$("div.hp").show();
		$("div.hpupdate").hide();
	});
	
	
	$("span.memberDelete").click(function(){
		location.href="leave";
	});
	
	$("#pass1").blur(function(){ //현재 비밀번호
		
		var pass=$(this).val().trim();//입력값
		if(pass.trim().length==0){
			$("b.pass1msg").html("<font color='red'>현재 비밀번호를 입력하세요</font>");
			return;
		}
		
		var mbrPwd = $("#pass1").val();  // pw 입력
		var check1 = /^(?=.*[a-zA-Z])(?=.*[0-9]).{10,12}$/.test(mbrPwd);   //영문,숫자
		var check2 = /^(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9]).{10,12}$/.test(mbrPwd);  //영문,특수문자
		var check3 = /^(?=.*[^a-zA-Z0-9])(?=.*[0-9]).{10,12}$/.test(mbrPwd);  //특수문자, 숫자
		var num = $("#num").val();
		
		$.ajax({
			type:"get",
			dataType:"json",
			data:{"num":num,"pass":pass},
			url:"../member/passcheck",
			success:function(data){
				if(data.check==1){
					$("b.pass1msg").html("");
				}else{
					$("b.pass1msg").html("<font color='red'>현재 비밀번호가 일치하지 않습니다.</font>");
					$("#pass1").val("");
					$("#pass1").focus();
				}
			}
		});
	});
		
	$("#pass").blur(function(){
		
		var pass=$(this).val().trim();//입력값
		
		if(pass.trim().length==0){
			$("b.passmsg").html("<font color='red'>패스워드를 입력해주세요</font>");
			return;
		}
		
		var mbrPwd = $("#pass").val();  // pw 입력
		var check1 = /^(?=.*[a-zA-Z])(?=.*[0-9]).{10,12}$/.test(mbrPwd);   //영문,숫자
		var check2 = /^(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9]).{10,12}$/.test(mbrPwd);  //영문,특수문자
		var check3 = /^(?=.*[^a-zA-Z0-9])(?=.*[0-9]).{10,12}$/.test(mbrPwd);  //특수문자, 숫자
		
		if(!(check1||check2||check3)) {
			$("b.passmsg").html("<font color='red'>10자~12자리의 영문(대소문자)+숫자+특수문자 중 2종류 이상을 조합하여 사용할 수 있습니다.</font>");
			$("#pass").val("");
			$("#pass").focus();
		} else if(/(\w)\1\1/.test(mbrPwd)) {
			$("b.passmsg").html("<font color='red'>같은 문자를 3번 이상 사용하실 수 없습니다.</font>");
			$("#pass").val("");
			$("#pass").focus();
		} else {
			$("b.passmsg").html("<font color='blue'>사용 가능한 비밀번호입니다.</font>");
		}
	});

	$("#pass2").blur(function(){
		
		var pass2=$(this).val().trim();//입력값
		
		if(pass2.trim().length==0){
			$("b.passmsg2").html("<font color='red'>패스워드를 입력해주세요</font>");
			return;
		}
		
		var pass = $("#pass").val();  // pw 입력
		var pass2 = $("#pass2").val();  // pw 입력
		
		if(pass!=pass2){
			$("b.passmsg2").html("<font color='red'>비밀번호가 서로 다릅니다.</font>");
			$("#pass2").val("");
			$("#pass2").focus();
		} else{
			$("b.passmsg2").html("");  
		}
	});
		
		
	$("#hp").blur(function(){
		
		var hp=$(this).val().trim();//입력값
		
		if(hp.trim().length==0){
			$("b.hpmsg").html("<font color='red'>핸드폰 번호를 입력해주세요</font>");
			return;
		}
		
		var mbrhp = $("#hp").val();  
		var regExp = /^(01[016789]{1})-?[0-9]{3,4}-?[0-9]{4}$/.test(mbrhp);;
		
		if(!(regExp)){
			$("b.hpmsg").html("<font color='red'>핸드폰 번호를 확인해주세요</font>");
			$("#hp").val("");
			$("#hp").focus();
		} else{
			$("b.hpmsg").html("");  
		}
	});
});
</script>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script> 
<script type="text/javascript">
$(document).ready(function () {

  // Intial Border Position
  var activePos = $('.tabs-header .active').position();

  // Change Position
  function changePos() {

    // Update Position
    activePos = $('.tabs-header .active').position();

    // Change Position & Width
    $('.border').stop().css({
      left: activePos.left,
      width: $('.tabs-header .active').width()
    });
  }

  changePos();

  // Intial Tab Height
  var tabHeight = $('.tab.active').height();

  // Animate Tab Height
  function animateTabHeight() {

    // Update Tab Height
    tabHeight = $('.tab.active').height();

  }

  animateTabHeight();

  // Change Tab
  function changeTab() {
    var getTabId = $('.tabs-header .active a').attr('tab-id');

    // Remove Active State
    $('.tab').stop().fadeOut(300, function () {
      // Remove Class
      $(this).removeClass('active');
    }).hide();

    $('.tab[tab-id=' + getTabId + ']').stop().fadeIn(300, function () {
      // Add Class
      $(this).addClass('active');

      // Animate Height
      animateTabHeight();
    });
  }

  // Tabs
  $('.tabs-header a').on('click', function (e) {
    e.preventDefault();

    // Tab Id
    var tabId = $(this).attr('tab-id');

    // Remove Active State
    $('.tabs-header a').stop().parent().removeClass('active');

    // Add Active State
    $(this).stop().parent().addClass('active');

    changePos();

    // Update Current Itm
    tabCurrentItem = tabItems.filter('.active');

    // Remove Active State
    $('.tab').stop().fadeOut(300, function () {
      // Remove Class
      $(this).removeClass('active');
    }).hide();

    // Add Active State
    $('.tab[tab-id="' + tabId + '"]').stop().fadeIn(300, function () {
      // Add Class
      $(this).addClass('active');

    });
  });

  // Tab Items
  var tabItems = $('.tabs-header ul li');

  // Tab Current Item
  var tabCurrentItem = tabItems.filter('.active');

  // Next Button
  $('#next').on('click', function (e) {
    e.preventDefault();

    var nextItem = tabCurrentItem.next();

    tabCurrentItem.removeClass('active');

    if (nextItem.length) {
      tabCurrentItem = nextItem.addClass('active');
    } else {
      tabCurrentItem = tabItems.first().addClass('active');
    }

    changePos();
    changeTab();
  });
 
  // Prev Button
  $('#prev').on('click', function (e) {
    e.preventDefault();

    var prevItem = tabCurrentItem.prev();

    tabCurrentItem.removeClass('active');

    if (prevItem.length) {
      tabCurrentItem = prevItem.addClass('active');
    } else {
      tabCurrentItem = tabItems.last().addClass('active');
    }

    changePos();
    changeTab();
  });

  // Ripple
  $('[ripple]').on('click', function (e) {
    var rippleDiv = $('<div class="ripple" ></div>'),
      rippleOffset = $(this).offset(),
      rippleY = e.pageY - rippleOffset.top,
      rippleX = e.pageX - rippleOffset.left,
      ripple = $('.ripple');

    rippleDiv.css({
      top: rippleY - (ripple.height() / 2),
      left: rippleX - (ripple.width() / 2),
      background: $(this).attr("ripple-color")
    }).appendTo($(this));

    window.setTimeout(function () {
      rippleDiv.remove();
    }, 1500);
  });
});
</script>
