<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%
	String cp = request.getContextPath();
%>

<script type="text/javascript" src="<%=cp%>/res/js/util.js"></script>
<link rel="stylesheet" href="<%=cp%>/res/css/base.css">

<script type="text/javascript">

var mode;

function returnChk(obj, idx) {
	obj.focus();
	jQuery("form[name="+mode+"Form] p").eq(idx).css("display", "block");
	return false;
}

function findPwdChk() {
	mode="findPwd";
	findChk();
};

function findIdChk() {
	mode="findId";
	findChk();
};

function findChk() {
	var chk=true;
    jQuery("form[name="+mode+"Form] input").each(function() {
    	var idx = $("form[name="+mode+"Form] input").index(this);
    	jQuery(".msg_info").css("display", "none");
    	
		if(!$(this).val()) {
			chk=returnChk($(this), idx);
		}
		if($(this).attr("name")=="email") {
		    if(!isValidEmail($(this).val())) {
		    	chk=returnChk($(this), idx);
		    }
		}
		if($(this).attr("name")=="tel") {
		    if(!isValidPhone($(this).val())) {
		    	chk=returnChk($(this), idx);
		    }
		}
		if(!chk)
			return false;
	});
    if(chk)
    	findSubmit();
}

function findSubmit() {
	var url="<%=cp%>/member/"+mode;
	var query=$("form[name="+mode+"Form]").serialize();
	
	jQuery.ajax({
		type:"post",
		url:url,
		data:query,
		dataType:"json",
		success:function(data) {
			if(data.state=="true") {
				if(mode=="findId") {
					jQuery("#findResult").text(data.id);
					jQuery("#findResult").css("display", "block");
				}else
					addHtml(data.name, data.email);
				
			}else if(data.state=="false") {
				alert("회원 정보가 없습니다.");
			}else if(data.state=="error") {
				alert("메일 전송에 실패했습니다.");
			}
			return;
		},error:function(e) {
			console.log(e.responseText);
		}
	});
};

function addHtml(name, email) {
	var out="<div class='location_wrap'><div class='location'>";
			out+="<a href='<%=cp%>' class='home'><span class='haze'>홈</span></a>";
			out+="<a href='<%=cp%>/member/login'>로그인</a>";
			out+="<a href='#' class='now'><span>비밀번호 확인</span></a></div></div>";
			out+="<div class='cont_header'><h1 class='h1_tit'>비밀번호 확인</h1>";
			out+="<p class='h_desc'>회원님의 개인정보 보호를 위해 관련 정보의 일부가 *로 표시됩니다.</p></div>";
			out+="<div class='cont_area'><div class='login_sec'><div class='regi_complete'><span class='bg post'></span>";
			out+="<p class='h2_tit'><span>"+name+"님의 임시비밀번호가<em class='em'>"+email+"</em>으로 발송완료 되었습니다.</span></p>";
			out+="<div class='btn_center'><a href='<%=cp%>/member/login' class='btn btn_em'><span>로그인</span></a>";
			out+="</div></div></div></div>";
	jQuery("#contents").html(out);
};

</script>

	<!-- Contaniner -->
	<div id="contaniner" class=""><!-- 벽돌 배경이미지 사용 시 class="bg-bricks" 적용 / 배경이미지가 없을 경우 class 삭제  -->

        <!-- LineMap -->

        <div id="ctl00_navigation_line" class="linemap-wrap">
            <div class="sect-linemap">
                <div class="sect-bcrumb">
                    <ul>
                        <li><a href="#"><img alt="home" src="<%=cp%>/res/images/btn_home.png"/></a></li>
                            <li><a href="#">회원서비스</a></li>
                            <li><a href="#">로그인</a></li>
                            <li class="last">아이디/비밀번호 찾기</li>
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
            <div class="sect-user" style="padding-top: 50px">
                <h3>아이디 / 비밀번호 찾기</h3>
                <p>
                    비밀번호가 기억나지 않으세요? 원하시는 방법을 선택하여 비밀번호를 재설정하실 수 있습니다. <br>
                    아이디를 조회하여 본인인증확인 후 재설정 가능합니다.
                </p>

                        <div class="cols-enterform find_0826 find_pw_id">
                            <div class="col-confirm">
                                <h4>아이디 / 비밀번호 찾기</h4>
                                
        <!-- ******************************************** 수정된 부분 시작! ******************************************** -->



<div class="box-confirm">
	<div class="login_wrap">
		<div class="id_find_wrap">
		
			<div class="find_area">
				<div class="find_handy">
					<div class="tit_box">
						<h2 class="h3_tit">아이디 찾기</h2>
						<p class="desc">회원정보에 이메일, 휴대전화 번호를 입력해주세요.</p>
					</div>
					<form name="findIdForm" method="post">
						<div class="check_member_form">
							<span class="input_txt w316"> 
								<input type="text" name="email" placeholder="이메일을 입력해주세요.">
							</span>
							<p class="msg_info">이메일을 정확히 입력해 주세요.</p>
							<span class="input_txt w316"> 
								<input type="text" name="tel" placeholder="ex) 010-1234-5678" maxlength="13">
							</span>
							<p class="msg_info">
								휴대폰번호를 입력해주세요.<br>(ex.010-1234-5678)
							</p>
							
							<p id="findResult" class="msg_info" style="color: red; height: 40px; font-size: 20px;"></p>
							<div class="btn_sec">
								<button type="button" onclick="findIdChk();" class="btn btn_em">아이디 찾기</button>
							</div>
						</div>
					</form>
				</div>
			</div>
		
			<div class="find_area" style="float: right;">
				<div class="find_handy">
					<div class="tit_box">
						<h2 class="h3_tit">임시비밀번호 발급</h2>
						<p class="desc">회원정보에 등록된 아이디, 이메일, 휴대전화 번호를 입력해주세요.</p>
					</div>
					<form name="findPwdForm" method="post">
						<div class="check_member_form">
							<span class="input_txt w316"> 
								<input type="text" name="id" placeholder="아이디를 입력해주세요.">
							</span>
							<p class="msg_info">아이디를 입력해주세요.</p>
							<span class="input_txt w316"> 
								<input type="text" name="email" placeholder="이메일을 입력해주세요.">
							</span>
							<p class="msg_info">이메일을 정확히 입력해 주세요.</p>
							<span class="input_txt w316"> 
								<input type="text" name="tel" placeholder="ex) 010-1234-5678" maxlength="13">
							</span>
							<p class="msg_info">
								휴대폰번호를 입력해주세요.<br>(ex.010-1234-5678)
							</p>
							<div class="btn_sec">
								<button type="button" onclick="findPwdChk();" class="btn btn_em">임시비밀번호 받기</button>
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</div>
					</div>
                        </div>
                    </div>
   <!-- ******************************************** 수정된 부분 끝! ******************************************** -->
    </div>    
    <div class="sect-loginguide">
        <dl class="box-operationguide">
            <dt>이용문의</dt>
            <dd>MovieGo 고객센터 : 1234-8282</dd>
            <dd>문의 가능 시간 : 매일 09:00~21:00 (주말 및 공휴일에도 상담 가능합니다)</dd>
        </dl>
    </div>
</div>
<!-- 실컨텐츠 끝 -->

            <!--/ Contents End -->

		</div>
		<!-- /Contents Area -->
		 
		 
		 