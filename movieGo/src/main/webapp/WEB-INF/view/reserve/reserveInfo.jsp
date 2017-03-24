<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String cp=request.getContextPath();
%>

<script type="text/javascript">

function OnTnbLeftClick() {
	if(jQuery("#tnb_step_btn_left").attr("title")=="영화선택") {
		reserveStep1();
		$(".tnb").attr("class", "tnb step1");
		$("#tnb_step_btn_left").attr("title", "");
		$("#tnb_step_btn_right").attr("title", "좌석선택");
	} else {
		reserveStep2();
	}
};

function OnTnbRightClick() {
	
	if(jQuery("#tnb_step_btn_right").attr("title")=="좌석선택") {
		if(!"${sessionScope.member}") {
				jQuery("#blackscreen").css("display","block");
				jQuery("#popup_login").css("display","block");
				return;
		}
		reserveStep2();
		
	} else if(jQuery("#tnb_step_btn_right").attr("title")=="결제선택"){
		reserveStep3();
	} else  if(jQuery("#tnb_step_btn_right").attr("title")=="결제하기"){
		reserveCheck();
	}
};

function reserveStep2() {
	var url = "<%=cp%>/reserveStep2";
	var query = "scheduleIdx="+scheduleIdx;
	
	jQuery.ajax({
		type:"post",
		url:url,
		data:query,
		success:function(data) {
			jQuery("#steps").html(data);
			$(".tnb").attr("class", "tnb step2");
			$("#tnb_step_btn_left").attr("title", "영화선택");
			$("#tnb_step_btn_right").attr("title", "결제선택");
			
		},error:function(e) {
			console.log(e.responseText);
		}
	});
}

function reserveStep3() {
	if(selected==0) {
		alert("예약 좌석을 선택해 주세요.");
		return;
	}
	if(selected != limit) {
		alert("예약 인원과 좌석 수가 맞지 않습니다.");
		return;
	}
	var url = "<%=cp%>/reserveStep3";
	var query = "scheduleIdx="+scheduleIdx+"&totPrice="+(adultPrice+youthPrice)+"&adult="+adult+"&youth="+youth;
	
	for (var i = 0; i < seats.length; i++) 
		query+="&seats="+seats[i];
	
	jQuery.ajax({
		type:"post",
		url:url,
		data:query,
		success:function(data) {
			jQuery("#steps").html(data);
			$(".tnb").attr("class", "tnb step3");
			$("#tnb_step_btn_left").attr("title", "좌석선택");
			$("#tnb_step_btn_right").attr("title", "결제하기");
		},error:function(e) {
			console.log(e.responseText);
		}
	});
}

function numberWithCommas(x) {
    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}
</script>

<div class="tnb_container" style="top: 669px; bottom: auto;">
	<div class="tnb_reset_btn">
		<a href="#" onclick="ticketRestart();return false;">예매 다시하기</a>
	</div>

	<div class="tnb step1">
		<!-- btn-left -->
		<a class="btn-left" id="tnb_step_btn_left" href="#" onclick="OnTnbLeftClick(); return false;" title="">이전단계로 이동</a>
		<div class="info movie">

			<span class="movie_poster"> <!-- src 영화 포스터 이미지 넣어주기. --> 
			<img src="<%=cp%>/res/poster/${movie.poster}.jpg" alt="영화 포스터" style="visibility: hidden;">
			</span>

			<div class="row movie_title colspan2" style="display: none;">
				<span class="data letter-spacing-min ellipsis-line2"> <!-- href 에 영화 상세 정보를 볼 수 있는 form 경로 넣어주기. -->
					<a href="#" target="_blank" title="${movie.movieName}"> ${movie.movieName}</a>
				</span>
			</div>

			<div class="row movie_type" style="display: none;">
				<span class="data ellipsis-line1">${movie.genreName}</span>
			</div>

			<div class="row movie_rating" style="display: none;">
				<span class="data" title="">${movie.gradeName}</span>
			</div>
			<div class="placeholder" title="영화선택"></div>


		</div>


		<div class="info theater">
			<div class="row name" style="display: none;">
				<span class="header">극장</span> 
				<span class="data letter-spacing-min ellipsis-line1">  
						<c:if test="${not empty cinema.cinemaName}">
							MOVIE GO 
						</c:if> ${cinema.cinemaName}
				</span>
			</div>
			<div class="row date" style="display: none;">
				<span class="header">일시</span> 
				<span class="data">${date}</span>
			</div>
			<div class="row screen" style="display: none;">
				<span class="header">상영관</span> 
				<span class="data"></span>
			</div>
			<div class="row number" style="display: none;">
				<span class="header">인원</span> 
				<span class="data"></span>
			</div>
			<div class="placeholder" title="극장선택"></div>
		</div>


		<div class="info seat">
			<div class="row seat_name" style="height: 20px;">
				<span class="header">좌석명</span> 
				<span class="data"></span>
			</div>
			<div class="row seat_no colspan3">
				<span class="header">좌석번호</span> 
				<span class="data ellipsis-line3"></span>
			</div>
			<div class="placeholder" title="좌석선택" style="display: none;"></div>
		</div>

		<div class="info payment-ticket">
			<div class="row payment-adult">
				<span class="header">일반</span>
				<span class="data"></span>
			</div>
			<div class="row payment-youth">
				<span class="header">청소년</span> 
				<span class="data"></span>
			</div>
			<div class="row payment-final">
				<span class="header">총금액</span>
				<span class="data"></span>
			</div>
		</div>

		<div class="info path" style="display: none;">
			<div class="row colspan4">
				<span class="path-step2" title="좌석선택">&nbsp;</span> 
				<span class="path-step3" title="결제">&nbsp;</span>
			</div>
		</div>

		<!-- btn-right -->
		<div class="tnb_step_btn_right_before" id="tnb_step_btn_right_before"></div>
		<a class="btn-right" id="tnb_step_btn_right" href="#"
			onclick="OnTnbRightClick(); return false;" title="좌석선택" style="display: none;">다음단계로</a>
	</div>

</div>




