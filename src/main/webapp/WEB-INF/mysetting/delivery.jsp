<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri = "http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" type="text/css" href="/css/delivery.css">

<style>
.drop{
float:right;
}
.drop:hover{
	background-color: silver;
}
select {
	float:right;
    width: 35px; /* 원하는 너비설정 */
    padding: .8em .5em; /* 여백으로 높이 설정 */
    font-family: inherit;  /* 폰트 상속 */
    background: url('../profile_image/dropd.PNG') no-repeat 95% 50%; /* 네이티브 화살표를 커스텀 화살표로 대체 */
    border: 1px solid white;
    border-radius: 0px; /* iOS 둥근모서리 제거 */
    -webkit-appearance: none; /* 네이티브 외형 감추기 */
    -moz-appearance: none;
    appearance: none;
}

/* IE 10, 11의 네이티브 화살표 숨기기 */
select::-ms-expand {
    display: none;
}


.update-save{
	width: 55px;
	height: 35px;
	border: none;
	border-radius: 5px;
	background-color: #1e90ff;
	margin-top: 10px;
	color: white;
	font-weight: bold;
}


</style>

<!-- 
<script type="text/javascript">	
$(function () {	
	list();
	
	function list() {
		$.ajax({
			type:"get",
			dataType:"json",
			url:"alist",			
			success:function(data){
				var s="";
				$.each(data, function(i, a) {
					s+="<div class='' style='' type='address'>";
					s+="<b>"+a.name+"</b>";
					if(a.pin==1){
						s+="<span type='isDefault' class='Label__Wrapper-ac7bbp-0'>기본</span>";
					}
					s+="<img src='../profile_image/dropd.PNG' class='dropdown-toggle' data-toggle='dropdown' style='float:right;'>";
					s+="<div class='dropdown-menu'>";
					s+="<div class='drop'>";
					s+="<div class='d_update' num='"+a.num+"' data-toggle='modal' data-target='#md' style='cursor:pointer;'>수정</div></div>";
					s+="<div class='drop'>";
					s+="<div class='d_delete' num='"+a.num+"' style='cursor:pointer;'>삭제</div></div></div>";
					s+="<div class=''> ${a.addr } ${a.addr2 }<br>${a.hp } </div>";
				})
				$(".restlist").html(s);
			}
		 }); 
	}
	
})	
</script>
 -->


		<div class="">
					<p class="">등록된 배송지</p>
			<div style="float:right;">
				<button class="PlainLink__StyledLink-qbfirs-0 delivery" data-toggle="modal" data-target="#moaModal" color="sub0180" type="button">+ 추가</button>
			</div>
				<br><br>
			<c:if test="${totalCount==0}">
				<img src="../profile_image/delivery.PNG">
			</c:if>
			<c:forEach var="a" items="${list}" varStatus="i">
					<div class="" style="margin-top:-1px; padding:20px;10px;20px;10px; border:1px solid silver; border-radius: 5px 5px 5px 5px;" type="address">
								<b style="font-size:13pt;">${a.name }</b>
								<c:if test="${a.pin==1 }">
								<span type="isDefault" class="Label__Wrapper-ac7bbp-0">기본</span>
								</c:if>
								<div class="drop">
								     <div class="d_delete" num="${a.num }" style="cursor:pointer;">삭제</div>
								</div>
								<div class="drop">
								     <div class="d_update" num="${a.num }" data-toggle="modal" data-target="#md" style="cursor:pointer;">수정&nbsp;&nbsp;</div>
								</div>
							<div style="margin-top:10px;">
								<span>${a.addr }&nbsp;</span>${a.addr2 }<br>
							</div>
							<div style="margin-top:5px;">${a.hp }</div>
					</div>
				</c:forEach>
		</div>
		
		
		<div class="CommonStyled__SettingPageDescBox-bpcmiq-1 cwYHpD">
			<p class="fnt-p1 tbb-clr-gray-80 fnt-st-bd">배송지를 삭제하면 예약된 후원의 배송지
				정보도 삭제되나요?</p>
			<div class="fnt-p3 tbb-clr-gray-60">
				현재 후원하신 프로젝트에 등록된 배송지가 삭제됩니다.&nbsp;
					<div style="color:blue; cursor:pointer;" class="txt2" onclick="location.href='/profile/${sessionScope.url}/backed'">
							<u>내 후원현황 바로가기</u>
						</div>
			</div>
		</div>
		
		
	</div>





 <!-- Moa Modal-->
  <div class="modal fade" id="moaModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <h4 class="modal-title" id="exampleModalLabel"><b>배송지 추가</b></h4>
          <button class="close" type="button" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">x</span>
          </button>
        </div>
        <div class="modal-body">
	        <span>받는 사람</span>
	     <!--    <form action="deliveryinsert" method="post"> -->
	        <input type="hidden" name="id" id="id" value="${dto.id }">
	         <input type="text" class="form-control" style="margin-top:10px; width:60%; height:40px;" placeholder="받는 분 성함을 입력해주세요."
                       id="dname" name="name" maxlength="20" required="required" >
              <b class="namemsg"></b><br>
            <span>주소</span>
            <input type="hidden" id="sample4_postcode" placeholder="우편번호">
            <span class="glyphicon glyphicon-search" style="margin-top:30px; cursor:pointer;" onclick="sample4_execDaumPostcode()"></span><br>
			<input type="button" class="form-control addr" style="margin-top:10px; text-align:left; height:40px;" id="sample4_roadAddress" required="required" onclick="sample4_execDaumPostcode()" placeholder="도로명주소">
			<b class="add1"></b><br>
			<span id="guide" style="color:#999;display:none"></span><br>
			
			<input type="text" class="form-control addr2" id="sample4_detailAddress" style="margin-top:-10px; height:40px;" required="required" placeholder="상세주소">
			<b class="add12"></b><br>
			
			<div style="margin-top:30px;"></div>
			
			<span>받는 사람 휴대폰 번호</span>
			<input type="text" class="form-control phoneNumber" id="hp1" name="hp" maxlength="13" style="width: 100%; margin-top: 10px; height:40px;" placeholder="받는 분 휴대폰 번호를 입력해주세요.">
            <b class="hp1msg"></b><br>
            <label>
            <input type="checkbox" id="pin" style="margin-top:30px; margin-bottom:20px;"> 기본 배송지로 등록   
             </label>
             <div class="modal-footer">
          		<button class="update-save insterbtn" style="width:100%" type="submit" data-dismiss="modal">등록완료</button>
       		 </div>
        <!-- </form>  -->
        </div>
        
      </div>
    </div>
  </div>
  
  
   <!-- Moa Modal2-->
  <div class="modal fade" id="md" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel2" aria-hidden="true">
    <div class="modal-dialog" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <h4 class="modal-title" id="exampleModalLabel"><b>배송지 추가</b></h4>
          <button class="close" type="button" id="close2" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">x</span>
          </button>
        </div>
        <div class="modal-body">
	        <span>받는 사람</span>
	     <!--    <form action="deliveryinsert" method="post"> -->
	        <input type="hidden"  id="updateid" value="${dto.id }">
	        <input type="hidden"  id="num" value="${dto.num }">
	         <input type="text" class="form-control" style="margin-top:10px; width:60%; height:40px;" id="updatename" placeholder="받는 분 성함을 입력해주세요."
                        maxlength="20" required="required" value="">
                        <b class="updatenamemsg"></b><br>
            <span>주소</span>
            <input type="hidden" id="sample4_postcode2" placeholder="우편번호">
            <span class="glyphicon glyphicon-search" style="margin-top:30px; cursor:pointer;" onclick="sample4_execDaumPostcode()"></span><br>
			<input type="button" class="form-control updateaddr" required="required" value="" style="margin-top:10px; text-align:left; height:40px;" onclick="sample4_execDaumPostcode()" id="sample4_roadAddress2" placeholder="도로명주소">
			<b class="add21"></b><br>
			
			<span id="guide" style="color:#999;display:none"></span><br>
			
			<input type="text" required="required" class="form-control updateaddr2" id="sample4_detailAddress2" value="" style="margin-top:-10px; height:40px;" placeholder="상세주소">
			<b class="add22"></b><br>
			
			<div style="margin-top:30px;"></div>
			
			<span>받는 사람 휴대폰 번호</span>
			<input type="text" class="form-control phoneNumber" id="updatehp1" value="" maxlength="13" style="width: 100%; margin-top: 10px; height:40px;" placeholder="받는 분 휴대폰 번호를 입력해주세요.">
			<b class="updatehp1msg"></b><br>
			<label>
            <input type="checkbox" id="pin1" style="margin-top:30px; margin-bottom:20px;"> 기본 배송지로 등록   
			</label>
             <div class="modal-footer">
          		<button class="update-save updatebtn" style="width:100%" type="submit" data-dismiss="modal">수정완료</button>
       		 </div>
        <!-- </form>  -->
        </div>
        
      </div>
    </div>
  </div>














<script type="text/javascript">
	

		$("div.d_update").click(function() {
			var num = $(this).attr("num");
		/*	var addr = $("#aaddr").val();
			var addr2 = $("#aaddr2").val();
			var hp = $("#ahp").val();
			var pin = $("#apin").val();
			$("#updatename").val(name);
			$(".aaddr").val(addr);
			$(".aaddr2").val(addr2);
			$("#updatehp1").val(hp);
			if(pin==1){
				$("#pin1").prop("checked", true);
			}*/
			$("b.updatehp1msg").html("");  
			$("b.updatenamemsg").html("");
			$("b.add21").html(""); 
			$("b.add22").html(""); 
			
			
			$.ajax({
				type:"get",
				dataType:"json",
				data:{"num":num},
				url:"deliveryupdate",
				success:function(data){
					$("#num").val(data.num);
					$("#updatename").val(data.name);
					$(".updateaddr").val(data.addr);
					$(".updateaddr2").val(data.addr2);
					$("#updatehp1").val(data.hp);
					if(data.pin=="1"){
						$("#pin1").prop("checked", true);
					}else{
						$("#pin1").prop("checked", false);
					}
				}
			});
			
		});
	

	  $("button.delivery").click(function() {
		  	$("#dname").val("");
			$(".addr").val("");
			$(".addr2").val("");
			$("#hp1").val("");
			$("b.namemsg").html("");
			$("b.hp1msg").html("");
			$("b.add1").html("");
			$("b.add12").html(""); 
			$("#pin").prop("checked", false);
		});
	  
	  $(document).on("keyup", ".phoneNumber", function() { 
			 $(this).val( $(this).val().replace(/[^0-9]/g, "").replace(/(^02|^0505|^1[0-9]{3}|^0[0-9]{2})([0-9]+)?([0-9]{4})$/,"$1-$2-$3").replace("--", "-") ); 
			 });

	  
	//수정 버튼 이벤트
		$("button.updatebtn").click(function(){
			
			var name=$("#updatename").val().trim();//입력값
			if(name.trim().length==0){
				$("b.updatenamemsg").html("<font color='red'> 비워두시면 안됩니다.</font>");
				return false;
			}else{
				$("b.updatenamemsg").html("");  
			}
			
			
			
			
			var add21=$("#sample4_roadAddress2").val().trim();//입력값
			if(add21.trim().length==0){
				$("b.add21").html("<font color='red'> 주소를 선택해주세요.</font>");
				return false;
			}else{
				$("b.add21").html("");  
			}
			
			var add22=$("#sample4_detailAddress2").val().trim();//입력값
			if(add22.trim().length==0){
				$("b.add22").html("<font color='red'> 상세주소를 입력해주세요.</font>");
				return false;
			}else{
				$("b.add22").html("");  
			}
		
			
			var hp=$("#updatehp1").val().trim();//입력값
			if(hp.trim().length==0){
				$("b.updatehp1msg").html("<font color='red'>핸드폰 번호를 입력해주세요</font>");
				return false;
			}
			
			
			
			var mbrhp = $("#updatehp1").val();  
			var regExp = /^(01[016789]{1})-?[0-9]{3,4}-?[0-9]{4}$/.test(mbrhp);;
			
			
			
			if(!(regExp)){
				$("b.updatehp1msg").html("<font color='red'>핸드폰 번호를 확인해주세요</font>");
				$("#updatehp1").val("");
				$("#updatehp1").focus();
				return false;
			}else{
				$("b.updatehp1msg").html("");  
			}
			
			
			var check = $("#pin1").is(":checked");
			var pin
			if(check){
				pin = 1;
			}else{
				pin = 0;
			}
			
			//num,pass 읽기
			var num = $("#num").val();
			var id=$("#updateid").val();
			var addr=$(".updateaddr").val();
			var addr2=$(".updateaddr2").val();
			//삭제파일 호출
			$.ajax({
				type:"get",
				dataType:"json",
				data:{"num":num,"id":id,"name":name,"addr":addr,"addr2":addr2,"hp":hp,"pin":pin},
				url:"updatedelivery",
				success:function(data){
					location.reload();
				},error:function(error){
					//$("#d_content").load('/setting/main #d_content');
					location.reload();
				}
			});
		});
	
	
	
	
	
		$("div.d_delete").click(function() {
			var num = $(this).attr("num");
			$.ajax({
				type:"get",
				dataType:"json",
				data:{"num":num},
				url:"deliverydelete",
				success:function(data){
					location.reload();
				},error:function(error){
				//	$("#d_content").load('/setting/main #d_content');
					alert("삭제되었습니다.");
					location.reload();
				}
			});
			
		});
		
	  	
		//insert 버튼 이벤트
		$("button.insterbtn").click(function(){
			
			var name=$("#dname").val().trim();//입력값
			if(name.trim().length==0){
				$("b.namemsg").html("<font color='red'> 비워두시면 안됩니다.</font>");
				return false;
			}else{
				$("b.namemsg").html("");  
			}
			
			
			
			var add1=$("#sample4_roadAddress").val().trim();//입력값
			if(add1.trim().length==0){
				$("b.add1").html("<font color='red'> 주소를 선택해주세요.</font>");
				return false;
			}else{
				$("b.add1").html("");  
			}
			
			var add12=$("#sample4_detailAddress").val().trim();//입력값
			if(add12.trim().length==0){
				$("b.add12").html("<font color='red'> 상세주소를 입력해주세요.</font>");
				return false;
			}else{
				$("b.add12").html("");  
			}
			
			
			var hp=$("#hp1").val().trim();//입력값
			if(hp.trim().length==0){
				$("b.hp1msg").html("<font color='red'>핸드폰 번호를 입력해주세요</font>");
				return false;
			}
			
			var mbrhp = $("#hp1").val();  
			var regExp = /^(01[016789]{1})-?[0-9]{3,4}-?[0-9]{4}$/.test(mbrhp);
			
			
			if(!(regExp)){
				$("b.hp1msg").html("<font color='red'>핸드폰 번호를 확인해주세요</font>");
				$("#hp1").val("");
				$("#hp1").focus();
				return false;
			}else{
				$("b.hp1msg").html("");  
			}
			
			var check = $("#pin").is(":checked");
			
			var pin
			
			if(check){
				pin = 1;
			}else{
				pin = 0;
			}
			
			//num,pass 읽기
			var id=$("#id").val();
			var addr=$("#sample4_roadAddress").val();
			var addr2=$("#sample4_detailAddress").val();
			var hp=$("#hp1").val();
			//삭제파일 호출
			$.ajax({
				type:"get",
				dataType:"json",
				data:{"id":id,"name":name,"addr":addr,"addr2":addr2,"hp":hp,"pin":pin},
				url:"deliveryinsert",
				success:function(data){
					alert("인서트 성공");
					location.reload();
				},error:function(error){
				//	$("#d_content").load('/setting/main #d_content');
					location.reload();
				}
			});
		});
	  
	  </script>
	  

		<script
			src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js">
		</script>
	<script>
    //본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
    function sample4_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var roadAddr = data.roadAddress; // 도로명 주소 변수
                var extraRoadAddr = ''; // 참고 항목 변수

                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraRoadAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                   extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraRoadAddr !== ''){
                    extraRoadAddr = ' (' + extraRoadAddr + ')';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample4_postcode').value = data.zonecode;
                document.getElementById("sample4_roadAddress").value = roadAddr;
                document.getElementById("sample4_roadAddress2").value = roadAddr;
                

                var guideTextBox = document.getElementById("guide");
                // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
                if(data.autoRoadAddress) {
                    var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
                    guideTextBox.innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
                    guideTextBox.style.display = 'block';

                } else if(data.autoJibunAddress) {
                    var expJibunAddr = data.autoJibunAddress;
                    guideTextBox.innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';
                    guideTextBox.style.display = 'block';
                } else {
                    guideTextBox.innerHTML = '';
                    guideTextBox.style.display = 'none';
                }
            }
        }).open();
    }
</script>















