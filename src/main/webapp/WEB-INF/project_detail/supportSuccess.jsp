<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<link rel="stylesheet" type="text/css" href="/css/support-success.css">

<div class="inner">
	<p>
		<span class="red">축하합니다. 
			<span class="number"></span>번째<br>
		</span>
		공식 후원자가 되셨습니다! <br>
		<span class="detail">*후원내역은 <a id='detailLink' href="../profile">개인프로필</a>에서 하실수 있습니다.</span>
	
	</p>
	<c:if test="${recommendList.size()>3}">
		<div class="title">
			<span>이런 프로젝트는 어때요?</span>
		</div>
		<div class="recommend-container">
			<c:forEach var="dto" items="${recommendList}" begin="0" end="4">
				<div class="project-container">
					<input type = "hidden" id="idx" value="${dto.idx}">
					<img class="project-img" src="../thumbnail_image/${dto.thumbnail}" alt="">
					<div class="project-title">
						<span>${dto.title}</span>
					</div>
				</div>
			</c:forEach>
		</div>
	</c:if>
</div>

<script>
  $(function() {
		$(".project-container").click(function () {
			let idx = $(this).find("#idx").val();
			location.href='../project/detail?idx='+idx;
		})  
	  
        let startNum = 0;
        let sponsorNum = ${supportNum};
        let countSpeed = 60;
        if(sponsorNum > 50){
            countSpeed = 10;
        }
        counterSponsor();

        function counterSponsor() {

            count = setInterval(countNum, countSpeed);

            function countNum() {
                startNum++;
                if (startNum > sponsorNum) {
					clearInterval(count);
                } else {
					$(".number").text(startNum);
                }
            }
        }
    });
</script>