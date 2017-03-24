<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String cp = request.getContextPath();
%>

<link rel="stylesheet" href="<%=cp%>/res/css/common(1).css" />
<link rel="stylesheet" href="<%=cp%>/res/css/reservation.css" />
<link rel="stylesheet" href="<%=cp%>/res/css/reservation_tnb.css" />
<link rel="stylesheet" href="<%=cp%>/res/css/reservation_popup.css" />
<link rel="stylesheet" href="<%=cp%>/res/css/reservation_step3.css" />
<link rel="stylesheet" href="<%=cp%>/res/css/reservation_step3_special.css" />
<link rel="stylesheet" href="<%=cp%>/res/css/reservation_step3_step1.css" />
<link rel="stylesheet" href="<%=cp%>/res/css/reservation_step3_step2.css" />

<script type="text/javascript">

var movieIdx;
var cityIdx;
var cinemaIdx;
var dateIdx;
var date;
var scheduleIdx;

var adult=0;	// 일반
var youth=0;	// 청소년
var adultPrice=0;	// 일반 가격
var youthPrice=0;	// 청소년 가격
var selected=0;	// 선택 좌석 수
var limit=0;			// 총 예매 인원 수
var seatBlock=0;	// 좌석 붙임 설정
var seats = new Array();	// 좌석 배열

$(function() {
	reserveStep1();
	reserveInfo();
	console.log(age());
	if("${message}") 
		alert("${message}");
	
	/* 간결하게 코딩하기............... */
	jQuery("body").on("click", ".btnMovie", function(){
		$(".btnMovie").parent().removeClass("selected");
		$parent = $(this).parent();
		movieIdx = $parent.attr("data-index");
		reserveStep1();
	});
	jQuery("body").on("click", ".btnCity", function(){
		$(".btnCity").parent().removeClass("selected");
		$parent = $(this).parent();
		cityIdx = $parent.attr("data-index");
		reserveStep1();
	});
	jQuery("body").on("click", ".btnCinema", function(){
		$(".btnCinema").parent().removeClass("selected");
		$parent = $(this).parent();
		cinemaIdx = $parent.attr("data-index");
		reserveStep1();
	});
	jQuery("body").on("click", ".btnDate", function(){
		$(".btnDate").parent().removeClass("selected");
		$parent = $(this).parent();
		dateIdx = $parent.attr("data-index");
		date = $parent.attr("data-date");
		reserveStep1();
	});
	 jQuery("body").on("click", ".btnTime", function() {
			$(".btnTime").parent().removeClass("selected");
			$parent = $(this).parent();
			$parent.addClass("selected");
			scheduleIdx = $parent.attr("data-index");
			
			jQuery.ajax({
				type:"post",
				url:"<%=cp%>/reserve/timeInfo",
				data:"scheduleIdx="+scheduleIdx,
				dataType:"json",
				success:function(data) {
					var dateOut = "<span class='header'>일시</span><span class='data'>"+data.date+"</span>";
					var screenOut = "<span class='header'>상영관</span><span class='data'>"+data.multiplexName+"</span>";
					
					jQuery(".date").html(dateOut);
					jQuery(".screen").html(screenOut);
					
					jQuery("#tnb_step_btn_right").css("display", "block");
					jQuery("#tnb_step_btn_right").addClass("on");
				},error:function(e) {
					console.log(e.responseText);
				}
			});
	});
	 
	jQuery("body").on("click", "#steps", function(e) {
		
		var cla = e.target.getAttribute("class");
		if(cla != "btnMovie" 
				&& cla != "btnCinema" 
				&& cla != "btnDate" 
				&& cla != "day" 
				&& cla != "dayweek")
			return;
		
		reserveInfo();
	});
});

function reserveInfo() {
	var url = "<%=cp%>/reserveInfo";
	
	jQuery.post(url, {movieIdx:movieIdx, cinemaIdx:cinemaIdx, date:date}, function(data) {
		jQuery("#tnb_area").html(data);
		
		if(movieIdx)
			movieInfo();
		if(cinemaIdx || date)
			cinemaInfo();
		
	});
};

/* 만나이 계산. */
function age() {
	var birth = "${sessionScope.member.birth}";
	
    var today = new Date();
    var year = today.getFullYear();
    var month = (today.getMonth() + 1);
    var day = today.getDate();       
    if (month < 10) month = '0' + month;
    if (day < 10) day = '0' + day;
    var monthDay = month + day;
       
    birth = birth.replace('-', '').replace('-', '');
    var birthdayy = birth.substr(0, 4);
    var birthdaymd = birth.substr(4, 4);
 
    var age = monthDay < birthdaymd ? year - birthdayy - 1 : year - birthdayy;
    return age;
}

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
    f.action = "<%=cp%>/reserveLogin";
    f.submit();
    
    return true;
}

function reserveStep1() {
	var url = "<%=cp%>/reserveStep1";
	
	jQuery.post(url, {movieIdx:movieIdx, 
							cityIdx:cityIdx, 
							cinemaIdx:cinemaIdx, 
							dateIdx:dateIdx, 
							date:date
							}, function(data) {
		jQuery("#steps").html(data);
		
		if(movieIdx && cinemaIdx && date) 
			timeSchedule();
	});	
};

function movieInfo() {
	jQuery(".tnb .info.movie .movie_poster img").css("visibility", "visible");
	jQuery(".tnb .info.movie div").css("display", "block");
	jQuery(".tnb .info.movie .placeholder").addClass("hidden");
};

function cinemaInfo() {
	jQuery(".tnb .info.theater div").css("display", "block");
	jQuery(".tnb .info.theater .placeholder").addClass("hidden");
};
</script>



<!-- Contaniner -->
<div id="contaniner">

	<!-- LineMap -->
	<div id="ctl00_navigation_line" class="linemap-wrap">
		<div class="sect-linemap">
			<div class="sect-bcrumb">
				<ul>
					<li><a href="<%=cp%>"><img alt="home" src="<%=cp%>/res/images/btn_home.png"></img></a></li>
					<li><a href="#">예매</a></li>
					<li class="last">빠른예매</li>
				</ul>
			</div>
		</div>
	</div>
	<!-- //LineMap -->

	<!-- Contents Area -->
	<div id="contents" style="height: 1px; padding: 0;"></div>
	
	<div title="CGV 빠른예매" style="width:100%;  height:769px; border:0 none;">
	
	<div id="wrap" oncontextmenu="return false" ondragstart="return false"> <!-- onselectstart="return false" -->
		<!-- 컨텐츠 -->
		<div id="container">
			<!-- 빠른예매 -->
			<div id="ticket" class="ticket ko">

				<!-- 타이틀 -->
				<div class="navi">
					<span class="right">
					<a class="button button-reservation-restart" href="<%=cp%>/reserve"><span>예매 다시하기</span></a>
					</span>
				</div>
				<!-- //타이틀 -->
				
				<!-- 메인컨텐츠 -->
				<div id="steps" class="steps"></div>
				
				<!-- (reserveInfo forward.) -->
				<div id="tnb_area" class="tnb_area" style="height: 193px;"></div>
				
				<div class="blackscreen" style="display: none;" id="blackscreen"></div>
				
			</div>
			<!-- //빠른예매 -->
		</div>
		<!-- //컨텐츠 -->
	<!-- Popup - 로그인 -->
	<div class="ft_layer_popup popup_login" style="position: absolute; display: none;" id="popup_login">
		<div class="hd">
			<div class="title_area">
				<h4>MOVIEGO회원 로그인</h4>
				<span class="sreader"></span>
			</div>
		</div>
		<div class="bd">
			<form id="form1" name="loginForm" method="post" onsubmit="return loginSubmit();">
				<div class="login_form">
					<div class="input_wrap id">
						<label for="txtUserId" class="blind">아이디</label>
						<input name="txtUserId" id="txtUserId" required="required" maxlength="25">
					</div>
					<div class="input_wrap password">
						<label for="txtPassword" class="blind">비밀번호</label>
						<input name="txtPassword" id="txtPassword" required="required" maxlength="25" type="password">
					</div>
					<button type="submit" title="Login" class="btn_login">
						<span>로그인</span>
					</button>
				</div>
			</form>
			<div class="linkbar">
				<a href="<%=cp%>/member/member" class="join_member">회원가입</a>
				<a href="#" class="join_guest">비회원 예매</a>
				<a href="<%=cp%>/member/findId" class="id_find">아이디찾기</a>
				<a href="<%=cp%>/member/findPwd" class="pw_find">비밀번호찾기</a>
			</div>
		</div>
	</div>
	<!-- //Popup -->
		</div>




	</div>
</div>
<!-- /Contaniner -->




