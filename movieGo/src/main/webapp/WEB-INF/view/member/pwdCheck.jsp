<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>
<script type="text/javascript">

	function gopwd() {
		var mode = "${mode}";
		if(mode == "dropout") {
		
			if(! confirm("정말로 탈퇴하시겠습니까?")) {
				return false;
			}
			return true;
		}	
		return true;
	}

</script>

	<!-- Contaniner -->
	<div id="contaniner" class="bg-bricks">
        <!-- LineMap -->
        <div id="ctl00_ctl00_navigation_line" class="linemap-wrap">
            <div class="sect-linemap">
                <div class="sect-bcrumb">
                    <ul>
                        <li><a href="<%=cp%>"><img alt="home" src="<%=cp%>/res/images/btn_home.png"></img></a></li>
                        
                            <li>
                                <a href="<%=cp%>/myinfo/mymain">My MovieGo</a>
                            </li>                     
                            <li>
                                <a href="<%=cp%>/member/pwdCheck">나의정보</a>
                            </li>                     
                            <li class="last">
                           	     비밀번호 확인
                            </li>
                    </ul>
                </div>
            </div>
        </div>
        <!-- //LineMap -->
		<!-- Contents Area -->
		<div id="contents" class="">
            <!-- Contents Start -->

<div class="cols-content" id="menu">
    <div class="col-aside">
	    <div class="snb">
	        <ul>
	            <li>
                    <a href="<%=cp%>/myinfo/mymain">MY HOME<i></i></a>
                </li>
	            <li >
                    <a href="<%=cp%>/reserve/myreserve" >나의 예매내역 <i></i></a>
                </li>
	            <li >
                    <a href="<%=cp%>/point/mypoint" >포인트 <i></i></a>
	            </li>            
	            <li class="on">
                    <a href="<%=cp%>/member/pwdCheck" >나의정보<i></i></a>
	                <ul>
                         <li>
                            <a href="<%=cp%>/member/pwdCheck" >개인정보 변경</a>
                        </li>
	                    <li >
                            <c:if test="${sessionScope.member.id!='admin' }">
                            	<a href="<%=cp%>/member/pwdCheck?dropout">회원탈퇴</a>
                            </c:if>
                        </li>                        
	                </ul>
	            </li>
	        </ul>
	    </div>
    </div>
	<div class="col-detail" id="mycgv_contents">
	    
<div class="tit-mycgv">
    <h3>비밀번호 확인</h3>
</div>

<p class="info-com">고객님의 개인정보 보호를 위한 절차이오니, MovieGo 로그인 시 사용하는 비밀번호를 입력해 주세요.</p>
<form method="post" onsubmit="return gopwd();" action="<%=cp%>/member/pwdCheck">
    <fieldset class="confirm">
        <legend>비밀번호 확인</legend>
        <div class="info-confirm">
            <p>
                <strong>아이디</strong>
                <strong>${sessionScope.member.id}</strong>
            </p>
                <p>
                    <strong><label for="txtPassword">비밀번호</label></strong> 
                    <input type="password" id="txtPassword" name="txtPassword" title="비밀번호" data-title="비밀번호를 " data-message="정상적으로 입력해 주세요." required="required" maxlength="20" class="small">
                </p>
        </div>
    </fieldset>
    <div class="set-btn">
        <button type="submit" id="save" class="round inred on"><span>확인</span></button> 
        <input type="hidden" name="mode" value="${mode}">
        <a href="<%=cp%>" class="round gray"><span>메인으로</span></a>
    </div>
</form>

	</div>
</div>
</div>
		</div>