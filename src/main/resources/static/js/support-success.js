$(function() {
	$(".project-container").click(function () {
		let idx = $(this).find("#idx").val();
		location.href='../project/detail?idx='+idx;
	})  
  
    let startNum = 0;
    let sponsorNum = $("#supportNum").val();
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