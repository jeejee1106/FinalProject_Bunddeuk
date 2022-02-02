<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<style>
.style__Container-sc-7of8vt-0{
    -webkit-text-size-adjust: 100%;
    font-size: 14px;
    line-height: 1.7em;
    color: rgba(0, 0, 0, 0.87);
    -webkit-font-smoothing: antialiased;
    -webkit-box-direction: normal;
    font-family: 'SF Pro Text', 'Helvetica Neue', 'Segoe UI', Arial, 'NotoSansKR', sans-serif;
    box-sizing: inherit;
    word-break: break-all;
    text-decoration: none;
    -webkit-tap-highlight-color: rgba(0,0,0,.1);
    position: relative;
    display: block;
    width: 100%;
    -webkit-box-flex: 1;
    flex-grow: 1;
    background: rgb(255, 255, 255);

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

.Container__ContainerComponent-sc-1ey2h1l-0{

    -webkit-text-size-adjust: 100%;
    font-size: 14px;
    line-height: 1.7em;
    color: rgba(0, 0, 0, 0.87);
    -webkit-font-smoothing: antialiased;
    -webkit-box-direction: normal;
    font-family: 'SF Pro Text', 'Helvetica Neue', 'Segoe UI', Arial, 'NotoSansKR', sans-serif;
    box-sizing: inherit;
    word-break: break-all;
    text-decoration: none;
    -webkit-tap-highlight-color: rgba(0,0,0,.1);
    text-align: center;
    width: 400px;
    padding: 72px 0px 0px;
    margin: 0px auto 12px;
}

.style__Wrapper-mir8lt-1{
    -webkit-text-size-adjust: 100%;
    font-size: 14px;
    line-height: 1.7em;
    color: rgba(0, 0, 0, 0.87);
    -webkit-font-smoothing: antialiased;
    -webkit-box-direction: normal;
    font-family: 'SF Pro Text', 'Helvetica Neue', 'Segoe UI', Arial, 'NotoSansKR', sans-serif;
    text-align: center;
    box-sizing: inherit;
    word-break: break-all;
    text-decoration: none;
    -webkit-tap-highlight-color: rgba(0,0,0,.1);
    padding: 32px;
    border-radius: 5px;
    border: 1px solid rgb(228, 228, 228);
}

.style__Form-mir8lt-4{
    -webkit-text-size-adjust: 100%;
    font-size: 14px;
    line-height: 1.7em;
    color: rgba(0, 0, 0, 0.87);
    -webkit-font-smoothing: antialiased;
    -webkit-box-direction: normal;
    font-family: 'SF Pro Text', 'Helvetica Neue', 'Segoe UI', Arial, 'NotoSansKR', sans-serif;
    text-align: center;
    word-break: break-all;
    -webkit-tap-highlight-color: rgba(0,0,0,.1);
    box-sizing: inherit;
}

.StyledTBB__FormWrapper-trchgn-6{
    -webkit-text-size-adjust: 100%;
    font-size: 14px;
    line-height: 1.7em;
    color: rgba(0, 0, 0, 0.87);
    -webkit-font-smoothing: antialiased;
    -webkit-box-direction: normal;
    font-family: 'SF Pro Text', 'Helvetica Neue', 'Segoe UI', Arial, 'NotoSansKR', sans-serif;
    box-sizing: inherit;
    word-break: break-all;
    text-decoration: none;
    -webkit-tap-highlight-color: rgba(0,0,0,.1);
    text-align: left;
    margin: 0px 0px 23px;
}
.StyledTBB__FormLabel-trchgn-4{
    -webkit-text-size-adjust: 100%;
    font-size: 14px;
    line-height: 1.7em;
    -webkit-font-smoothing: antialiased;
    -webkit-box-direction: normal;
    font-family: 'SF Pro Text', 'Helvetica Neue', 'Segoe UI', Arial, 'NotoSansKR', sans-serif;
    text-align: left;
    box-sizing: inherit;
    word-break: break-all;
    text-decoration: none;
    -webkit-tap-highlight-color: rgba(0,0,0,.1);
    color: rgb(61, 61, 61);
    margin: 0px 0px 10px;
}
.StyledTBB__FormContent-trchgn-5{
    -webkit-text-size-adjust: 100%;
    font-size: 14px;
    line-height: 1.7em;
    color: rgba(0, 0, 0, 0.87);
    -webkit-font-smoothing: antialiased;
    -webkit-box-direction: normal;
    font-family: 'SF Pro Text', 'Helvetica Neue', 'Segoe UI', Arial, 'NotoSansKR', sans-serif;
    text-align: left;
    box-sizing: inherit;
    word-break: break-all;
    text-decoration: none;
    -webkit-tap-highlight-color: rgba(0,0,0,.1);
    width: auto;
    margin: 0px 0px 12px;
}
.Input__InputWrapper-j7moqy-0{
    -webkit-text-size-adjust: 100%;
    -webkit-font-smoothing: antialiased;
    -webkit-box-direction: normal;
    font-family: 'SF Pro Text', 'Helvetica Neue', 'Segoe UI', Arial, 'NotoSansKR', sans-serif;
    text-align: left;
    word-break: break-all;
    -webkit-tap-highlight-color: rgba(0,0,0,.1);
    box-sizing: inherit;
    border: 1px solid rgb(230, 230, 230);
    color: rgb(13, 13, 13);
    background: rgb(255, 255, 255);
    padding: 0px 12px;
    max-height: 44px;
    min-width: 100px;
    display: flex;
    font-size: 14px;
    line-height: 24px;
    letter-spacing: -0.015em;
    -webkit-box-align: center;
    align-items: center;
    border-radius: 4px;
}

.Input__InnerInput-j7moqy-1{
    -webkit-text-size-adjust: 100%;
    -webkit-font-smoothing: antialiased;
    -webkit-box-direction: normal;
    word-break: break-all;
    -webkit-tap-highlight-color: rgba(0,0,0,.1);
    color: inherit;
    font: inherit;
    line-height: normal;
    width: 100%;
    background: transparent;
    border: 0px;
    box-sizing: border-box;
    height: 100%;
    outline: none;
    margin: 0px;
    appearance: none !important;
    padding: 13px 0px;
}
.StyledTBB__FormDescription-trchgn-7{
    -webkit-text-size-adjust: 100%;
    -webkit-font-smoothing: antialiased;
    -webkit-box-direction: normal;
    font-family: 'SF Pro Text', 'Helvetica Neue', 'Segoe UI', Arial, 'NotoSansKR', sans-serif;
    text-align: left;
    box-sizing: inherit;
    word-break: break-all;
    text-decoration: none;
    -webkit-tap-highlight-color: rgba(0,0,0,.1);
    margin: 8px 0px 0px;
    color: rgb(61, 61, 61);
    font-size: 14px;
    line-height: 24px;
    letter-spacing: -0.015em;
}
.SolidButton__Button-sc-1gsinzz-0{
    -webkit-text-size-adjust: 100%;
    -webkit-font-smoothing: antialiased;
    -webkit-box-direction: normal;
    word-break: break-all;
    -webkit-tap-highlight-color: rgba(0,0,0,.1);
    font: inherit;
    overflow: visible;
    text-transform: none;
    -webkit-appearance: button;
    width: 100%;
    cursor: pointer;
    display: inline-flex;
    -webkit-box-align: center;
    align-items: center;
    -webkit-box-pack: center;
    justify-content: center;
    height: 52px;
    white-space: nowrap;
    border-radius: 4px;
    margin: 0px;
    border: 0px;
    outline: none;
    font-weight: bold;
    box-sizing: border-box;
    padding: 0px 24px;
    background-color: rgb(255, 87, 87);
    color: rgb(255, 255, 255);
    font-size: 16px;
    line-height: 27px;
    letter-spacing: -0.02em;
}

.style__FooterCopyright-sc-7of8vt-21{
-webkit-text-size-adjust: 100%;
    -webkit-font-smoothing: antialiased;
    -webkit-box-direction: normal;
    font-family: 'SF Pro Text', 'Helvetica Neue', 'Segoe UI', Arial, 'NotoSansKR', sans-serif;
    box-sizing: inherit;
    word-break: break-all;
    text-decoration: none;
    -webkit-tap-highlight-color: rgba(0,0,0,.1);
    display: block;
    width: 100%;
    color: rgb(158, 158, 158);
    font-size: 13px;
    line-height: 20px;
    text-align: center;
}
</style>



<div class="style__Container-sc-7of8vt-0 gmYOwM">
	<div
		class="Container__ContainerComponent-sc-1ey2h1l-0 kUAclQ style__MembershipContainer-mir8lt-0 egIvRl">
		<div class="style__Wrapper-mir8lt-1 bUKxLC">
			<h3 style="margin-bottom: 30px;">비밀번호 찾기</h3>
			<form action="../setting/findpassword" method="post" onsubmit="return emailcheck();" autocomplete="on" class="style__Form-mir8lt-4 cFNky">
				<div
					class="StyledTBB__FormWrapper-trchgn-6 hCtMzp style__FormComponent-mir8lt-5 jDGVtY forgetPassword">
					<div class="StyledTBB__FormLabel-trchgn-4 keSzYC">이메일 주소</div>
					<div
						class="StyledTBB__FormContent-trchgn-5 iBKDvR form-input-wrapper">
						<span class="Input__InputWrapper-j7moqy-0 dXKaPI style__MembershipInput-mir8lt-3 klRmKv">
							<input type="text" inputmode="text" id="email" name="email" placeholder="가입하신 이메일 주소를 입력해주세요."
							autocomplete="off" required="required" autocapitalize="off"
							class="Input__InnerInput-j7moqy-1 bfmNPl" value="">
						</span>
						<b class="emailmsg"></b>
					</div>
					<div class="StyledTBB__FormDescription-trchgn-7 dcierJ form-desc-wrapper">번뜩이
						가입 후 인증하신 이메일을 입력하시면 새 비밀번호를 생성할 수 있는 링크를 보내드립니다.</div>
				</div>
				<button class="SolidButton__Button-sc-1gsinzz-0 cumLqd style__FormButton-mir8lt-6 bTvWmu fnt-p1"
					color="main80" type="submit">
					<span>비밀번호 설정 링크 받기</span>
				</button>
			</form>
		</div>
	</div>
	<div class="style__FooterCopyright-sc-7of8vt-21 kpnzcM"
		style="text-align: center; margin-bottom:50px;">© 2021 Bunddeuk Inc.</div>
</div>

<script>

function emailcheck(){
	var email = $("#email").val();
	var num = $("#num").val();
	var rs = "";
	
	$.ajax({
		type:"get",
		dataType:"json",
		data:{"email":email},
		url:"../member/emailcheck",
		async: false,
		success:function(data){
			if(data.check==0){
				$("b.emailmsg").html("<font color='red'>해당 이메일이 존재하지 않습니다.</font>");
				rs =false;
			}else{
				$("b.emailmsg").html("");
				alert("임시 비밀번호가 이메일로 전송되었습니다.");
				rs = true;
			}
		}
	});
	return rs;
	
	}
</script>


