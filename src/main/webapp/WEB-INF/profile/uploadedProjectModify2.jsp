<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
	.totalBox{
	display: flex;
	justify-content: space-between;
	}
	.ProjectEditorWrap{
	width: 900px;
	margin: 0px auto;
	margin-top: 20px;
	}
	.box{
	border: 1px solid rgb(242, 242, 242);
	border-radius: 5px;
	width: 140px;
    height: 170px;
    display: block;
    padding: 20px 0px 0px 22px;
	}
	span{
	display: block;
	}
	.backColor{
    background-color: white;
	
	}
	.iconImage svg {
    font-size: 24px;
    fill: rgb(248, 100, 83);
    }
    .iconImage{
    height: 80px;
    }
    .btn1{
    cursor: pointer;
    display: inline-flex;
    -webkit-box-align: center;
    align-items: center;
    -webkit-box-pack: center;
    justify-content: center;
    height: 40px;
    white-space: nowrap;
    border-radius: 4px;
    margin: 0px;
    outline: 0px;
    box-sizing: border-box;
    font-weight: normal;
    padding: 0px 16px;
    border: 1px solid rgb(240, 240, 240);
    color: rgb(61, 61, 61);
    background: rgb(255, 255, 255);
    }
    .gFChsx {
    display: flex;
    padding: 0px 100px;
    margin-bottom: 40px;
    }
    .cBaTug {
    position: relative;
    background: rgb(255, 255, 255);
    box-shadow: rgb(0 0 0 / 15%) 0px 2px 4px, rgb(0 0 0 / 10%) 0px 1px 0px;
    border-radius: 8px;
    margin-bottom: 17px;
    text-align: center;
    padding: 20px 0px 45px;
	}
	*, *:before, *:after {
    -webkit-box-sizing: inherit;
    box-sizing: inherit;
	}
	.gFChsx .article {
    background: rgb(252, 252, 252);
    border-radius: 8px;
    width: 100%;
    padding: 32px 16px;
    font-weight: 400;
    text-align: center;
    margin-bottom: 13px;
    font-size: 13px !important;
    line-height: 22px !important;
    justify-content: space-between;
	}
	.cBaTug .title {
    font-weight: 700;
    font-size: 24px !important;
    line-height: 36px !important;
	}
	ol {
	list-style-type: none;
    display: block;
    margin-block-start: 1em;
    margin-block-end: 1em;
    margin-inline-start: 0px;
    margin-inline-end: 0px;
    padding-inline-start: 10px;
	}
	.gFChsx ol li {
    list-style: none;
    margin-bottom: 16px;
    text-align: left;
    position: relative;
    padding-left: 16px;
	}
	.btnClose{
	margin-left: 400px;
	position: absolute;
	padding: 3px 3px;
	}
	.auditTitle,.title{
	font-weight: bold;
	color: rgb(61, 61, 61);
	}
</style>   
<script>
$(function() {
	projectlist();
	$("#data_pdto").hide();
	$(".btnClose,.btnOkay").click(function() {
		$(".showBox").hide();
	})
	$(".btn1").click(function() {
		$(".showBox").show();
		
	})

	
}) 
function projectlist() {
		var idx = $("#idx").val();
		$.ajax({
			dataType	: "json",
			url			: "/project/presentList",
			data		: {"idx" : idx},
			success		: function(presentData){
				var count = presentData.length;
				$("#db_present").val(count);
				//기본정보
				var title = $("#titl2").val();
				var thumbnail = $("#db_thumbnail2").val();
				//펀딩계획
				var target = $("#db_target2").val(); //값없으면 0
				//선물
				var present = $("#db_present").val();
				//목표
				var goal = $("#db_project_goal2").val();
				//예상문제
				var policy = $("#db_policy2").val();
				def = 0;
				fund = 0;
				presen = 0;
				projectGoal = 0;
				polic = 0;
				
				if(title != '') {
					def += 48;
				}
				if(thumbnail != '') {
					def += 52;
				}
				if(target != '' || target != 0) {
					fund += 100;
				}
				if(present != '') {
					presen += 100;
				}
				if(goal != '') {
					projectGoal += 100;
				}
				if(policy != '') {
					polic += 100;
				}
				$("#defaultPercent").html(def + "% 작성완료");
				$("#fundingPercent").html(fund + "% 작성완료");
				$("#rewardPercent").html(presen + "% 작성완료");
				$("#storyPercent").html(projectGoal + "% 작성완료");
				$("#policyPercent").html(polic + "% 작성완료");
			},
			error		:function(request,status,error){
		        alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		    }
		})
}
</script> 
<!-- 올린 프로젝트 관리 하단 -->

<link rel="stylesheet" type="text/css" href="/css/project-modify.css">

<div class="ProjectEditorWrap">
	<div class="Contents">
		<div class="ProjectMainWrap">
			<div class="AuditButtonWrap" style="height: 60px; margin-left: 800px;">
				<button class="btn1" color="grayEditor200">
					심사 기준
				</button>
			</div>
			<div class="showBox">
			<div class="style__ProjectAuditNotice-sc-1mawbc1-34 cBaTug">
				<button type="button" class="btn btnClose">
					<span class="fa fa-times close" style="background-color:rgb(252, 252, 252); font-size: 15px;">
					</span>
				</button>
			<div style="height: 30px;"></div>
			<p class="title">텀블벅의 프로젝트 심사 기준을 확인해주세요.</p>
			<p class="subTitle">심사 기준을 준수하면 보다 빠른 프로젝트 승인이 가능합니다.</p>
			<div class="style__ProjectAuditCheckWrap-sc-1mawbc1-35 gFChsx">
				<div class="article" style="margin-right: 30px;">
					<div class="CustomCheckIcon__CheckIcon-uuow3v-0 ddiTLt customIcon yes">
						<div name="check" class="Icon__SVGICON-sc-1xkf9cp-0 ccxeYs">
							<span class="fa fa-check-circle" style="color: rgb(94, 189, 145);"></span>
						</div>
					</div>
					<p class="auditTitle">승인 가능 프로젝트</p>
					<ol>
						<li>기존에 없던 새로운 시도</li>
						<li>기존에 없던 작품, 제품, 디지털 콘텐츠, 활동, 행사</li>
						<li>창작자의 이전 제품 및 콘텐츠는 새로운 선물에 부수적으로 제공 가능</li>
					</ol>
				</div>
				<div class="article">
					<div class="CustomCheckIcon__CheckIcon-uuow3v-0 ddiTLt customIcon no">
						<div name="close-1" class="Icon__SVGICON-sc-1xkf9cp-0 ccxeYs">
							<span class="fa fa-times-circle" style="color: rgb(230, 60, 65);"></span>
						</div>
					</div>
						<p class="auditTitle">반려 대상 프로젝트</p>
						<ol>
							<li>기존 상품· 콘텐츠의 판매 및 홍보</li>
							<li>제3자에 후원금 또는 물품 기부</li>
							<li>시중에 판매 및 유통되었던 제품·콘텐츠 제공</li>
							<li>현금, 주식, 지분, 복권, 사이버머니, 상품권 등 수익성 상품 제공</li>
							<li>추첨을 통해서만 제공되는 선물</li>
							<li>성인용 제품·콘텐츠, 무기, 군용장비, 라이터 등 위험 품목</li>
						</ol>
				</div>
			</div>
			<div class="buttonWrap">
				<button class="btn btnOkay">
					<span>확인</span>
				</button>
			</div>
		</div>
			</div>
			<!-- 작성중인 목록들 -->
			<div class="totalBox">
				<div class="box1 default box">
					<a href="/project/editor?idx=${pdto.idx }" class="backColor">
						<div class="iconImage">
							<div name="write-solid" class="Icon__SVGICON-sc-1xkf9cp-0 ccxeYs">
								<svg viewBox="0 0 48 48">
									<path d="M42.1181 14.5537C42.1557 14.5161 42.1544 14.454 42.1154 14.415L33.7715 6.07113C33.7325 6.03207 33.6704 6.03085 33.6329 6.06839L29.6905 10.0107C29.653 10.0483 29.6542 10.1103 29.6933 10.1494L38.0371 18.4933C38.0762 18.5323 38.1383 18.5335 38.1758 18.496L42.1181 14.5537Z"></path>
									<path d="M36.134 20.5378C36.1715 20.5003 36.1703 20.4382 36.1312 20.3992C36.0922 20.3601 27.7874 12.0553 27.7874 12.0553C27.7483 12.0163 27.6862 12.015 27.6487 12.0526C27.6111 12.0901 9.6289 30.0723 9.6289 30.0723C9.61462 30.0866 9.60538 30.1052 9.6025 30.1255L8.21584 39.856C8.20646 39.9218 8.2647 39.9801 8.33053 39.9707L18.061 38.584C18.0813 38.5811 18.0999 38.5719 18.1142 38.5576C18.1142 38.5576 36.0964 20.5754 36.134 20.5378Z"></path>
								</svg>
							</div>
						</div>
						<p>
							<strong>기본정보</strong><span id="defaultPercent">42% 작성완료</span>
						</p>
					</a>
				</div>
				<div class="box2 funding box">
					<a href="/project/editor2?idx=${pdto.idx }&key=funding">
						<div class="iconImage">
							<div name="funding-solid" class="Icon__SVGICON-sc-1xkf9cp-0 ccxeYs">
								<svg viewBox="0 0 48 48">
									<path d="M20.1565 29.3325L20.53 31.0588L20.9568 29.3325H20.1565Z"></path>
									<path d="M23.5981 27.5547L23.9888 25.9297L24.3796 27.5547H23.5981Z"></path>
									<path d="M27.0254 29.3325H27.8435L27.47 31.0588L27.0254 29.3325Z"></path>
									<path fill-rule="evenodd" clip-rule="evenodd" d="M5 7H43V41H5V7ZM17.7616 29.3325L18.834 32.8889H21.9805L23.1522 29.3325H24.828L26.0195 32.8889H29.1437L30.216 29.3325H32V27.5547H30.7382L31.7768 24H29.2552L28.2965 27.5547H26.4956L25.417 24H22.583L21.4844 27.5547H19.7012L18.7225 24H16.2008L17.2395 27.5547H16V29.3325H17.7616ZM31 13H17V17H31V13Z"></path>
								</svg>
							</div>
						</div>
						<p>
							<strong>펀딩 계획</strong><span id="fundingPercent">0% 작성완료</span>
						</p>
					</a>
				</div>
				<div class="box3 reward box">	
					<a href="/project/editor2?idx=${pdto.idx }&key=reward">
						<div class="iconImage">
							<div name="reward-solid" class="Icon__SVGICON-sc-1xkf9cp-0 ccxeYs">
								<svg viewBox="0 0 48 48">
									<path d="M6.1 14.9994C6.04477 14.9994 6 15.0442 6 15.0994L6 26.3066C6 26.3618 6.04477 26.4066 6.1 26.4066H9.5V41.8994C9.5 41.9547 9.54477 41.9994 9.6 41.9994H21.9C21.9552 41.9994 22 41.9547 22 41.8994V26.4066L26 26.4066V41.8994C26 41.9547 26.0448 41.9994 26.1 41.9994H38.4C38.4552 41.9994 38.5 41.9547 38.5 41.8994V26.4066H41.9C41.9552 26.4066 42 26.3618 42 26.3066V15.0994C42 15.0442 41.9552 14.9994 41.9 14.9994L6.1 14.9994Z"></path>
									<path d="M21.9125 11.8069L18.4181 4.11919C18.3907 4.05899 18.3135 4.04145 18.2628 4.08393L12.1476 9.2091C12.0855 9.26112 12.1078 9.3615 12.186 9.38236L21.7957 11.9449C21.8773 11.9667 21.9474 11.8838 21.9125 11.8069Z"></path>
									<path d="M26.0875 11.8069L29.5819 4.11919C29.6093 4.05899 29.6865 4.04145 29.7372 4.08393L35.8524 9.2091C35.9145 9.26112 35.8922 9.3615 35.814 9.38236L26.2043 11.9449C26.1227 11.9667 26.0526 11.8838 26.0875 11.8069Z"></path>
								</svg>
							</div>
						</div>
						<p>
							<strong>선물 구성</strong><span id="rewardPercent">0% 작성완료</span>
						</p>
					</a>
				</div>
				<div class="box4 story box">	
					<a href="/project/editor2?idx=${pdto.idx }&key=story">
						<div class="iconImage">
							<div name="story-solid" class="Icon__SVGICON-sc-1xkf9cp-0 ccxeYs">
								<svg viewBox="0 0 48 48">
									<path d="M4 10.641C9.64668 7.72904 16.3533 7.72904 22 10.641V39.9997C16.1392 38.1722 9.86084 38.1722 4 39.9997V10.641Z"></path>
									<path d="M26 10.641C31.6467 7.72904 38.3533 7.72904 44 10.641V39.9997C38.1392 38.1722 31.8608 38.1722 26 39.9997V10.641Z"></path></svg>
							</div>
						</div>
						<p>
							<strong>프로젝트 계획</strong><span id="storyPercent">0% 작성완료</span>
						</p>
					</a>
				</div>
				<div class="box5 policy box">	
					<a href="/project/editor2?idx=${pdto.idx }&key=policy">
						<div class="iconImage">
							<div name="safty-solid" class="Icon__SVGICON-sc-1xkf9cp-0 ccxeYs">
								<svg viewBox="0 0 48 48">
									<path fill-rule="evenodd" clip-rule="evenodd" d="M7.76307 6.95971C7.31518 7.06894 7 7.47022 7 7.93124V33.2239C7 33.5653 7.17415 33.8831 7.46189 34.0668L23.4619 44.2815C23.79 44.491 24.21 44.491 24.5381 44.2815L40.5381 34.0668C40.8258 33.8831 41 33.5653 41 33.2239V7.93124C41 7.47021 40.6848 7.06894 40.2369 6.95971L24.2369 3.05777C24.0813 3.01981 23.9187 3.01981 23.7631 3.05777L7.76307 6.95971ZM22.0549 28.3492L32.7011 17.703L30.2969 15.2988L21.9431 23.6526L17.6426 19.743L15.3555 22.2588L22.0549 28.3492Z"></path></svg>
							</div>
						</div>
						<p>
							<strong>신뢰와 안전</strong><span id="policyPercent">0% 작성완료</span>
						</p>
					</a>
				</div>	
				<!-- end작성중인 목록들 -->
			</div>
		</div>
	</div>
</div>
<div style="height: 60px;"></div>
<div id="data_pdto">
<input type="hidden" id="idx" value="${pdto.idx }">
<input type="hidden" id="titl2" value="${pdto.title }">
<input type="hidden" id="db_thumbnail2" value="${pdto.thumbnail }">
<input type="hidden" id="db_target2" value="${pdto.target_amount }">
<input type="hidden" id="db_project_goal2" value="${pdto.project_goal }">
<input type="hidden" id="db_present">
<input type="hidden" id="db_policy2" value="${pdto.anticipated_problem }">
</div>