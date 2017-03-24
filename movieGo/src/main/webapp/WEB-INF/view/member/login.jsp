<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%
	String cp = request.getContextPath();
%>

<script type="text/javascript">
function loginSubmit() {
        var f = document.loginForm;
    	var str = f.txtUserId.value;
    	
        if(!str) {
            f.txtUserId.focus();
            return false;
        }
        str = f.txtPassword.value;
        if(!str) {
            f.txtPassword.focus();
            return false;
        }
        f.action = "<%=cp%>/member/login_check";
        f.submit();
        
        return true;
}
</script>
	
	<!-- Contaniner -->
	<div id="contaniner" class=""><!-- 벽돌 배경이미지 사용 시 class="bg-bricks" 적용 / 배경이미지가 없을 경우 class 삭제  -->

        <!-- LineMap -->

        <div id="ctl00_navigation_line" class="linemap-wrap">
            <div class="sect-linemap">
                <div class="sect-bcrumb">
                    <ul>
                        <li><a href="<%=cp%>"><img alt="home" src="<%=cp%>/res/images/btn_home.png"></img></a></li>
                            <li>
                                <a href="#">회원서비스</a>
                            </li>
                            <li class="last">로그인</li>
                        
                        
                    </ul>
                </div>
            </div>
        </div>
        <!-- //LineMap -->

		<!-- Contents Area -->
		<div id="contents" class="">
            
            <!-- Contents Start -->
			

<!-- 실컨텐츠 시작 -->
<div class="wrap-login">
    <div class="sect-login">
        <ul class="tab-menu-round">
            <li class="on">
                <a href="#">로그인</a>
            </li>
<!--             <li>
                <a href="#">비회원로그인</a>
            </li> -->
        </ul>
        <div class="box-login">
            <h3 class="hidden">회원 로그인</h3>
            <form name="loginForm" method="post" onsubmit="return loginSubmit();">
            <fieldset>
                <legend>회원 로그인</legend>
                <p>아이디 비밀번호를 입력하신 후, 로그인 버튼을 클릭해 주세요.</p>
                <div class="login">
                    <input type="text" title="아이디" id="txtUserId" name="txtUserId" autofocus="autofocus" 
                    			data-title="아이디를 " data-message="입력하세요." required="required">
                    <input type="password" title="패스워드" id="txtPassword" name="txtPassword" 
                    				data-title="패스워드를 " data-message="입력하세요." required="required">
                </div>
                <div class="save-id">
             <input type="checkbox" id="save_id">아이디 저장</div>
                <button type="submit" id="submit" title="로그인"><span>로그인</span></button>
                <div class="login-option">
                    <a href="<%=cp%>/member/findInfo">아이디 / 비밀번호 찾기</a>
                </div>
            </fieldset>
            </form>           
        </div>
    </div>    
    <div class="sect-loginguide">
        <div class="box-useguide">
            <strong>MovieGo 회원이 아니신가요?</strong>
            <span>회원가입하시고 다양한 혜택을 누리세요!</span>
            <strong>
                <a title="새창" target="_blank" href="#" class="round red"><span>MovieGo 회원가입하기</span></a>
            </strong>
        </div>
    </div>
</div>
<!-- 실컨텐츠 끝 --> 

            <!--/ Contents End -->

		</div>
		<!-- /Contents Area -->
	</div>
	<!-- /Contaniner -->
	
