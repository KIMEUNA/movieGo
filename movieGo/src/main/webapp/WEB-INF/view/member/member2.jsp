<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
   String cp = request.getContextPath();
%>

<script src="<%=cp%>/res/js/form.validate.js"></script>
<script src="<%=cp%>/res/js/password_ck.js"></script>
<link rel="stylesheet" href="<%=cp%>/res/css/base.css">

<script type="text/javascript">

    // 오프라인 회원정보
    function setUserInfo() {
        // 기본정보 hidden
        if('' != '') {$('#legl_rep_nm').val('')};
        if('' != '') {$('#legl_rep_ssn1').val('')};
        if('' != '') {$('#legl_rep_ssn2').val('')};
        if('' != '') {$('#legl_rep_mob_no1').val('')};
        if('' != '') {$('#legl_rep_mob_no2').val('')};
        if('' != '') {$('#legl_rep_mob_no3').val('')};
        if('' != '') {$('#legl_rep_email_addr1').val('')};
        if('' != '') {$('#legl_rep_email_addr2').val('')};
        if('' != '') {$('#legl_rep_rel_cnts').val('')};
        if('' != '') {$('#legl_rep_agr_dy').val('')};
        if('' != '') {$('#legl_rep_agr_yn').val('')};
        if('' != '') {$('#email_addr1').val('')};
        if('' != '') {$('#email_addr_opt').val('')};
        if('' != '') {$('#email_addr2').val('')};

        // 이메일 직접입력일때
        if($('#email_addr2').val() != '' && ($('#email_addr_opt').val() != $('#email_addr2').val())) {
            $('#email_addr_opt').val('0');
        }

        // 휴대폰
        if('' != '') {$('#mob_no_1').val('')};
        if('' != '') {$('#mob_no_2').val('')};
        if('' != '') {$('#mob_no_3').val('')};

        // 생일
        if('' != '') {
            $('#birth_yy').val('');
            $('#birth_mm').val('');
            $('#birth_dd').val('');
        }
    }

    // 이메일 셋팅
    function setEmail(){
        // 직접입력일때
        if($('#email_addr_opt').val() == '0') {
            $('#email_addr2').attr('readonly', false);
        } else if ($('#email_addr_opt').val() != '') {
            $('#email_addr2').attr('readonly', true);
            $('#email_addr2').val($('#email_addr_opt').val());
        } else {
            $('#email_addr2').attr('readonly', true);
        }
    }
    
    // 이메일 직접입력일때 추가필드 초기화
    function chkEmail(){
        // 직접입력일때
        if($('#email_addr_opt').val() == '0') {
            $('#email_addr2').val('');
        }
    }

    // cabs lock 체크
    var msgStr  = "";
    function cabsCheck() {
        var id = this.id;
        if(checkCapsLock()) {
            msgStr = "Cabs lock가 켜져 있습니다.";
        } else {
            $("#msg_"+id).hide();
            msgStr  = "";
        }
    }

    // 패스워드 강도 체크
    var pwStrength = false;
    function checkPassword() {
    	pwStrength = false;
        var special_chars1 = "~!@#$%&*";
        var pw = new Password(document.getElementById('pass').value, special_chars1);
        var verdict = pw.getStrength();
        var hint = msgStr;
        if (pw.lcase_count  == 0)   hint += "";
        if (pw.ucase_count  == 0)   hint += "";
        if (pw.num_count    == 0)   hint += "";
        if (pw.schar_count  == 0)   hint += "";
        if (pw.run_score    <= 1)   hint += "";

        alertMsg("alert_pass_strength", "<em>"+verdict+" "+hint+"</em>");
        if(pw.strength >= 38){ pwStrength=true;}
    }

    // 취소
    function goCancel() {
        if(!confirm('회원가입을 취소하시겠습니까?')) return;
        location.href='<%=cp%>';
    }   
    
    function beforeSubmit() {
        // 이메일 셋팅
        if($('#email_addr_opt').val() != "0"){
            $('#email_addr2').val($('#email_addr_opt').val());
        }
        if(!checkInput()) return false;	
        if(!confirm('소중한 고객님의 정보는 CJ ONE 제휴 브랜드와 함께 변경 적용됩니다.\n이대로 입력하시겠습니까?')) {
            return false;
        } else {			           
        	ajaxRegister();
            return true;
        }
    }

	function alertMsg(objId, ErrMsg){
		$("#"+objId).html(ErrMsg);
		$("#"+objId).show();
	}
    
	function showErrorMsg(occur_loc, occur_msg){
		$("#msg_pwd").addClass("hide");
		$("#msg_pwd_chedk").addClass("hide");
		$("#alert_mob_no").addClass("hide");
		$("#alert_email_addr").addClass("hide");
		$("#alert_rcm_id").addClass("hide");		
		$("#id").removeClass("error");
		$("#pwd").removeClass("error");
		$("#pwd_chedk").removeClass("error");
		$("#mob_no_1").removeClass("error");
		$("#email_addr1").removeClass("error");
		$("#rcm_id").removeClass("error");		
		$("#" + occur_loc).addClass("error");
		if(occur_msg.length < 1){
			$("#msg_" + occur_loc).removeClass("hide");
		} else {
			$("#msg_" + occur_msg)
			$("#msg_" + occur_msg).removeClass("hide");
		}
	} 
	var flag = "invalid";

    // 회원가입 체크
    function checkInput() {
        if( $('#id').val().length < 6 ) {
        	alertMsg("alert_id", "6~12자리의 영문 소문자 또는 영문 소문자+숫자 아이디를 입력해 주세요.");
            $('#id').focus();
            return false;
        }
		return true;
    }      
    
    function check() {
    	var f = document.memberForm;
    	var str;   	
    	str = f.pass.value;
    	if(!/^(?=.*[a-z])(?=.*[!@#$%^*+=-]|.*[0-9]).{5,10}$/i.test(str)) { 
    		f.pass.focus();
    		return false;
    	}    	
    	if(f.passCheck.value != str) {
    		$("#passCheck + .help-block").html("비밀번호가 일치하지 않습니다.");
    		f.passCheck.focus();
    		return false;
    	} else {
    		$("#passCheck + .help-block").html("비밀번호를 한번 더 입력해주세요.");
    	}
	
        str = f.birth.value;
        if(!isValidDateFormat(str)) {
            f.birth.focus();
            return false;
        }

        str = f.email.value;
        if(!isValidEmail(str)) {
            f.email.focus();
            return false;
        }
        
        str = f.tel.value;
        if(!isValidPhone(str)) {
            f.tel.focus();
            return false;
        }
        
        var mode="${mode}";
        if(mode=="created") {
        	f.action = "<%=cp%>/member/member";
        } else if(mode=="update") {
        	f.action = "<%=cp%>/member/update";
        }        
        return true;
    }
     
    /*  전화번호가 양식에 틀리면 focus를 준다. */
    function setFocusMobileTel(id) {
        /* 전화번호 검사 */
        var objMp   = $('#mob_no_'+id);
        var chkVal  = "";

        if(objMp.val() == "")   chkVal  = "*";

        if(objMp.val() != "" && ((id == "2" && objMp.val().length < 3) || (id == "3" && objMp.val().length < 4)))   chkVal  = "*";

        if(chkVal != "") {
            alertMsg("alert_mob_no", "전화번호를  정확히 입력해 주세요.");
            objMp.focus();
            return false;
        }
        else return true;
    }

    // 아이디 유효성 검사 
    function isValid_mbrId(str) {
        var patten = new Array();
        var msg = new Array();
        var p;
        var ret_msg = new Array();
        patten["not_eng_num"] =/^[a-z0-9]+$/g;  //a-z와 0-9 이외의 문자가 있는지 확인    
        msg["not_eng_num"] = "영문 소문자/숫자만 사용가능합니다.";
        patten["len"] = /^\w{6,12}$/;	// 문자열 길이
        msg["len"] = "6~12자리로 사용가능합니다.";
        patten["only_num"] = /[a-zA-Z]/;// 숫자만
        msg["only_num"] = "영문 소문자/숫자의 혼용으로 사용가능합니다(숫자만으로는 사용불가).";
    	 var retVal = checkSpace( str );
    	 if( retVal ) {
    		 alert("아이디는 빈 공간 없이 연속된 영문 소문자와 숫자만 사용할 수 있습니다.");
    		 alertMsg('msg_id', "아이디는 빈 공간 없이 연속된 영문 소문자와 숫자만 사용할 수 있습니다.");
    		 return false;
    	 }
    	var i=0;
    	for (x in patten)
    	{
    		p = eval(patten[x]);
    		if(!p.test(str))
    		{
    			ret_msg[i] = msg[x];
    			i++;
    		} 
    	}
    	if(i>0) {
    		alertMsg("alert_id", "<span style='font-weight: bold;'>6~12자리의 영문 소문자 또는 영문 소문자+숫자 아이디를 입력해 주세요.</span>");
    		return false;
    	}
    	else return true;
    }
    
    // 아이디 중복검사 
    function idCheck()  {
        	if ( isValid_mbrId($('#id').val()) ) {
                if ( $('#id').val().length > 5 ) {
    				$.ajax({
    			        url     : '<%=cp%>/member/idCheck',
    			        dataType  : 'json',
    			        data	: 'id='+$('#id').val(),
    			        type    : 'POST',
    			        error   : function(err) { alert(err); },
    			        success   : function(resp) {

    			        	if (resp.passed == 'true') {

    			        		alertMsg("alert_id", "<span style='color:blue;font-weight: bold;'>이 아이디는 사용 가능 합니다.");
    			        	}  	else {

    			        		alertMsg("alert_id", "<span style='color:red;font-weight: bold;'>중복된 아이디입니다.");
    			        		$('#id').focus();
    			        	}			        	
    			        }
    				});
                } else {
                	alertMsg("alert_id", "6~12자리의 영문 소문자 또는 영문 소문자+숫자 아이디를 입력해 주세요.");
                    $('#id').focus();
                }
        	} else {
        		$('#id').focus();
        	}
    }
    
    // 전화번호 중복 검사
    function telCheck() {
    	var tel=$("#tel").val();
    	
    	var url="<%=cp%>/member/telCheck";
    	var params="tel="+tel;
    	$.ajax({
    		type:"POST"
    		,url:url
    		,data:params
    		,dataType:"JSON"
    		,success:function(data) {
    			var passed=data.passed;
    			if(passed==="true") {
    				var str="<span style='color:blue;font-weight: bold;'>"+tel+"</span> <span style='color:blue;font-weight: bold;'>전화번호는 사용 가능 합니다.</span>";
    				alertMsg("alert_tel", str);
    			} else {
    				var str="<span style='color:red;font-weight: bold;'>"+tel+"</span> <span style='color:red;font-weight: bold;'>중복된 전화번호 입니다.</span>";
    				alertMsg("alert_tel", str);

    				$("#tel").val("");
    				$("#tel").focus();
    			}
    		}
    	});
    }
  
    // 이메일 중복 검사
    function emailCheck() {
    	var email=$("#email").val();
    	
    	var url="<%=cp%>/member/emailCheck";
    	var params="email="+email;
    	$.ajax({
    		type:"POST"
    		,url:url
    		,data:params
    		,dataType:"JSON"
    		,success:function(data) {
    			var passed=data.passed;
    			if(passed==="true") {
    				var str="<span style='color:blue;font-weight: bold;'>"+email+"</span> <span style='color:blue;font-weight: bold;'>메일은 사용 가능 합니다.</span>";
    				alertMsg("alert_email", str);
    			} else {
    				var str="<span style='color:red;font-weight: bold;'>"+email+"</span> <span style='color:red;font-weight: bold;'>중복된 메일주소 입니다.</span>";
    				alertMsg("alert_email", str);

    				$("#email").val("");
    				$("#email").focus();
    			}
    		}
    	});
    }

	// 생년월일
	function date_change(){
		$('#birth_dd').empty();
		var dt = new Date($('#birth_yy').val(), $('#birth_mm').val(), 0);
	    $('#birth_dd').append($('<option value="일">일</option>'));
		for(var i=1; i<=dt.getDate(); i++){
			if(i<10){
				if(i == 1){
					$('#birth_dd').append($('<option value="0'+i+'" selected="selected" >0' + i + '</option>'));
				}else{
					$('#birth_dd').append($('<option value="0'+i+'">0' + i + '</option>'));
				}
			}else{
				$('#birth_dd').append($('<option value="'+i+'">' + i + '</option>'));
			}
		}
		$('[data-skin="form"] select#birth_dd').formSkin('addSkin');
	}

</script>

  	<!--contents-->
	<div id="contentsWrap">
		<div id="contents">
			<!--title-->
			<div class="location_wrap">
				<div class="location"><a href="#" class="home"><span class="haze">홈</span></a></div>
			</div>
			
			<div class="cont_header">
				<h1 class="h1_tit">${mode=="created"?"회원 가입":"회원 정보 수정"}</h1>
			</div>
			<!--title-->
			<div class="cont_area">
				<div class="member_join">
					<div class="member_data">
						<h2 class="haze">회원정보 입력</h2>

						<div class="member_info">
							<form id="form1" method="post" action="" name="memberForm" onsubmit="return check();">
							    <input type='hidden' id="id_validate"   name="id_validate"   value="">							    
							
								<div class="table_header">
									<div class="info"><p class="msg_mandatory"><span class="haze">"필수"</span> 표시는 필수 입력 항목입니다.</p></div>
								</div>
								<div class="table_col">
									<table>
										<caption>회원기본정보 입력 표로 회원정보 이름, 아이디, 비밀번호, 비밀번호 확인, 생년월일, 휴대전화, 이메일을 나타냅니다.</caption>
										<colgroup>
											<col class='title'>
											<col class='body'>
										</colgroup>
										<tbody>
											<tr class="input">
												<th scope="row" class="mandatory">
													<label for="input_member_name"><span class="haze">"필수"</span> 이름</label>
												</th>
												<td>
													<div class="input_group">
														<span class="input_txt"><input type="text" class="text" title="이름 입력" placeholder="이름을 입력해주세요." name="name" id="name" required="required"
														value="${dto.name}" ${mode=="update" ? "readonly='readonly' style='border:none;' ":""}></span><!-- 에러시 .error 클래스 추가 -->
													</div>
												</td>
											</tr>
											<tr class="input">
												<th scope="row" class="mandatory">
													<label for="id"><span class="haze">"필수"</span> 아이디</label>
												</th>
												<td>
													<div class="input_group">
														<span class="input_txt w250"><input type="text" class="text" title="사용 할 영문 아이디 명 입력" placeholder="아이디를 입력해주세요." 
														name="id" id="id"  required="required" maxlength="12" value="${dto.id}" onchange="idCheck();"
														${mode=="update" ? "readonly='readonly' style='border:none;'":""}><!-- 에러시 .error 클래스 추가 --></span>
														<p class="msg_info em hide" id="alert_id"></p>
													</div>
												</td>
											</tr>
											<tr class="input">
												<th scope="row" class="mandatory">
													<label for="pass"><span class="haze">"필수"</span> 비밀번호</label>
												</th>
												<td>
													<div class="input_group">
														<span class="input_txt w250"><input type="password" class="text" placeholder="비밀번호를 입력해주세요." name="pass" id="pass" maxlength="12" required="required"></span>
														<span class="pwd_lv" id="alert_pass_strength"></span>
														<p class="msg_info em hide" id="msg_pass" >비밀번호는 5~10자이며 하나 이상의 숫자나 특수문자가 포함되어야 합니다.</p>
													</div>
												</td>
											</tr>
											<tr class="input">
												<th scope="row" class="mandatory">
													<label for="pass_check"><span class="haze">"필수"</span> 비밀번호 확인</label>
												</th>
												<td>
													<div class="input_group">
														<span class="input_txt"><input type="password" class="text" placeholder="비밀번호를 다시 입력해주세요." name="passCheck"  id="passCheck" maxlength="12" required="required"></span>
														<p class="msg_info em hide" id="msg_pass_check">비밀번호와 비밀번호 확인이 일치하지 않습니다.</p>
													</div>
												</td>
											</tr>
											<tr class="input">
												<th scope="row" class="mandatory">
													<label for="birth_yy">
													<span class="haze">"필수"</span> 생년월일</label>
												</th>
												<td>
													<div class="form-group">
														<span class="input_txt"><input class="form-control" id="birth" name="birth" type="date" placeholder="생년월일을 입력하세요." 
														value="${dto.birth}" required="required" ${mode=="update" ? "readonly='readonly' style='border:none;'":""}></span>
													</div>
													<p class="help-block">생년월일은 2000-01-01 형식으로 입력 합니다.</p>
												</td>
											</tr>
											<tr class="input">
												<th scope="row" class="mandatory">
													<label for="mob_no_1"><span class="haze">"필수"</span> 전화번호</label>
												</th>
												<td>
													<div class="form-group">
														<span class="input_txt"><input  id="tel" name="tel" type="text" placeholder="전화번호를 입력하세요." onchange="telCheck();" value="${dto.tel}" required="required"></span>
														<p class="help-block">전화번호는 010-0000-0000 형식으로 입력 합니다.</p>
            											<p class="msg_info em hide" id="alert_tel"></p>
													</div>
												</td>
											</tr>
											<tr class="input">
												<th scope="row" class="mandatory">
													<label for="email_addr1"><span class="haze">"필수"</span> 이메일</label>
												</th>
												<td>
													<div class="email_write">
														<span class="input_txt"><input id="email" name="email" type="email" placeholder="이메일주소를 입력하세요." onchange="emailCheck();" value="${dto.email}" required="required"></span>
            											<p class="help-block">이메일은 aaa@aaa.com 형식으로 입력 합니다.</p>
            											<p class="msg_desc">이메일 주소 입력 시 사용 가능 특수 문자 : - . _</p>
														<p class="msg_info em hide" id="alert_email_addr">이메일 주소를 다시 확인해주세요.</p>
														<p class="msg_info em hide" id="alert_email"></p>
													</div>													
												</td>
											</tr>
										</tbody>
									</table>
								</div>
								<div class="btn_sec">
									<c:if test="${mode=='created'}">
										<button type="button" class="btn btn-danger" onclick="javascript:goCancel();">가입취소</button>
										<button type="submit" name="sendButton" class="btn btn-primary">회원가입</button>
									</c:if>
									<c:if test="${mode=='update'}">
										<button type="button" class="btn btn-danger" onclick="javascript:location.href='<%=cp%>/';">수정취소 <span class="glyphicon glyphicon-remove"></span></button>
										<button type="submit" class="btn btn-primary">정보수정 <span class="glyphicon glyphicon-ok"></span></button>
									</c:if>
								</div>
								<div class="box_gray box_btm">
									<dl class="box_info">
										<dt>이용안내</dt>
										<dd>
											<ul class="bul_list">
												<li class="dot_arr">movieGo 회원가입 후에도 각 제휴 브랜드 웹사이트에서 통합 아이디를 사용하여 로그인 하시려면, 각 브랜드 웹사이트의 이용약관에 대한 동의를 거친 후에 이용 가능합니다.</li>
												<li class="dot_arr">개인정보 수집 및 활용 동의 (선택)에 거부한 회원님은 마케팅 정보 수신을 받으실 수 없습니다.</li>
											</ul>
										</dd>
									</dl>
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!--//contents-->
