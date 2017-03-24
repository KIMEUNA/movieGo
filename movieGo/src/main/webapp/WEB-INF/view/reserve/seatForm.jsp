<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String cp=request.getContextPath();
%>

<script type="text/javascript">

$(function(){
	
	// 예매 인원 설정
	$("#nop_group a").click(function(){
		var count = $(this).parent().attr("data-count");
		$("#nop_group li").removeClass("selected");
		
		if($(this).parent().attr("data-type") == "adult") {
			adult = count;
			$("#nop_group li[data-type=youth]").eq(youth).addClass("selected");
		} else {
			youth = count;
			$("#nop_group li[data-type=adult]").eq(adult).addClass("selected");
		}
		$(this).parent().addClass("selected");
		limit=Number(adult)+Number(youth);
		seatBlock=4;
		if(limit < 4)
			seatBlock=limit;
		jQuery(".seat_block").removeClass("selected");
		jQuery(".seat").removeClass("selected");
		
		if(limit!=0 && limit < 5) 
			jQuery(".seat_block").eq(limit-1).addClass("selected");
		else if(limit!=0 && limit < 16)
			jQuery(".seat_block").eq(3).addClass("selected");
		
		jQuery(".seat_block").removeClass("enabled");
		for (var i = 0; i < limit; i++) {
			jQuery(".seat_block").eq(i).addClass("enabled");
			if(i==3) break;
		}
		
		reset();
		
		if(limit == 0)	 jQuery(".section-seat").addClass("dimmed");
		else 			     jQuery(".section-seat").removeClass("dimmed");
	});
	
	// 좌석 마우스 이벤트
	jQuery(".seat").hover(
		function() {
			for (var i = 0; i < seatBlock; i++) {
				if($(".seat:eq("+($('.seat').index(this)+i)+")").hasClass("reserved")) 
					return;
			}
			for (var i = 0; i < seatBlock; i++) 
				$(".seat:eq("+($('.seat').index(this)+i)+")").addClass("preselect");
		},
		function() {
			for (var i = 0; i < seatBlock; i++) 
				$(".seat:eq("+($('.seat').index(this)+i)+")").removeClass("preselect");
		}
	);
	
	// 좌석 선택
	jQuery(".seat").on("click", function() {
		
		for (var i = 0; i < seatBlock; i++)
			if($(".seat:eq("+($('.seat').index(this)+i)+")").hasClass("reserved")) 
				return;
		
		selected=selected+seatBlock;
		
		if(!selectChk())
			return;
		
		var seatGrade="일반";
		var seatPrice=0;	// 좌석에 대한 추가 금액 ************ 시간이 되면하고 ~~
		if(jQuery(this).hasClass("rating_comfort")) {
			seatGrade="standrad";
		}else if(jQuery(this).hasClass("rating_economy")) {
			seatGrade="economy";
			seatPrice=1000;
		}else if(jQuery(this).hasClass("rating_prime")) {
			seatGrade="prime";
			seatPrice=2000;
		}
		
		var priceArr="${price}".split(","); // 가격
		
		for (var i = 0; i < seatBlock; i++) {
			$(".seat:eq("+($('.seat').index(this)+i)+")").addClass("selected");
			seats.push($(".seat:eq("+($('.seat').index(this)+i)+")").attr("data-seatNum"));
			
			if(adultPrice < (adult*(Number(priceArr[0]))))
				adultPrice=adultPrice+Number(priceArr[0]);
			else
				youthPrice=youthPrice+Number(priceArr[1]);
		}
		
		var seatsStr="";
		jQuery.each(seats, function(index, value) {
			seatsStr=seatsStr+value+" ";
		});
		seatOut(seatGrade+"석", seatsStr, adultPrice, youthPrice);
	});

	// 좌석 붙임 라벨
	jQuery(".seat_block label").click(function() {
		if(!jQuery(this).parent().hasClass("enabled")) return;
		jQuery(".seat_block").removeClass("selected");
		jQuery(this).parent().addClass("selected");
		seatBlock = jQuery(this).parent().index()+1;
	});

	jQuery(function() {
		reservationState();
	});
});

function reset() {
	seatOut("", "", 0, 0);
	seats=new Array();
	selected=0;
	
	jQuery(".seat").removeClass("selected");
	
	var adultStr="";
	var youthStr="";
	
	if(adult != 0)
		adultStr="일반 "+adult+"명 ";
	if(youth != 0) 
		youthStr="청소년 "+youth+"명";
	
	adultPrice=0;
	youthPrice=0;
	
	var out="<span class='header'>인원</span><span class='data'>"+adultStr+youthStr+"</span>";
	jQuery(".number").html(out);
}

// 좌석 인원수 체크.
function selectChk() {
	if(limit < selected) {
		if(!confirm("이미 좌석을 모두 선택하셨습니다.\n선택하신 좌석으로 변경하시겠습니까?"))
			return false;
		
		reset();
		selected=seatBlock;
	}
	return true;
};

function seatOut(seatGrade, seatsStr, adultPrice, youthPrice) {
	console.log("seatGrade : "+ seatGrade +", seatsStr : "+seatsStr);
	var seatOut="<span class='header'>좌석명</span><span class='data'>"+seatGrade+"</span>";
	var seatsOut="<span class='header'>좌석번호</span><span class='data ellipsis-line3'>"+seatsStr+"</span>";
	
	jQuery(".seat_name").html(seatOut);
	jQuery(".seat_no").html(seatsOut);
	
	console.log(Number(adultPrice));
	
	jQuery(".payment-adult .data").html(numberWithCommas(adultPrice)+"원");
	jQuery(".payment-youth .data").html(numberWithCommas(youthPrice)+"원");
	jQuery(".payment-final .data").html(numberWithCommas((adultPrice+youthPrice))+"원");
}

//예약된 정보 불러오기
function reservationState() {
	var url="<%=cp%>/reserveState";
	var query="scheduleIdx="+scheduleIdx;
	
    $.ajax({
        type: "post",
        url: url,
        data: query,
        dataType: "json",
        success: function(data){
        	$("#seats_list .seat").each(function(){
        		jQuery(".seat").removeClass("reserved");
        	});
        	
        	for(var i=0; i<data.list.length; i++) {
        		var item=data.list[i];
        		var seatNum=item.seatNum;
        		
        		$("#seats_list .seat").each(function(){
					var seat=$(this).attr("data-seatNum");
					if(seat == seatNum) 
						$(this).addClass("reserved");
				});        		
        	}
        },
        error: function(e){
            console.log(e.responseText);
        }
    });
}
</script>

<div class="step step2" style="display: block;">
	<!-- SEAT 섹션 -->
	<div class="section section-seat three_line dimmed">
		<div class="col-head" id="skip_seat_list">
			<h3 class="sreader">
				인원 / 좌석
			</h3>
			
		<a href="javascript:void(0)" id="reservarionDiscountInfo" 
				style="position: absolute; top: 3px; left: 15px; 
				color: rgb(255, 255, 255); font-weight: bold;">☞&nbsp;관람 할인 안내</a>
		</div>
		<div class="col-body">
			<div class="person_screen">
				<!-- NUMBEROFPEOPLE 섹션 -->
				<div class="section section-numberofpeople">
					<div class="col-body">
						<div class="numberofpeople-select" id="nop_group">
							<div class="group adult" id="nop_group_adult">
								<span class="title">일반</span>
								<ul>
								<c:forEach begin="0" end="8" varStatus="stat">
									<li data-count="${stat.index}" ${stat.first ? 'class=selected' : ''} data-type="adult">
										<a href="#" onclick="return false;">
											<span class="sreader mod">일반</span>${stat.index}
											<span class="sreader">명</span>
										</a>
									</li>
								</c:forEach>
								</ul>
							</div>
							<div class="group youth" id="nop_group_youth">
							
								<span class="title">청소년</span>
								<ul>
								<c:forEach begin="0" end="8" varStatus="stat">
									<li data-count="${stat.index}" ${stat.first ? 'class=selected' : ''} data-type="youth">
										<a href="#" onclick="return false;">
											<span class="sreader mod">청소년</span>${stat.index}
											<span class="sreader">명</span>
										</a>
									</li>
								</c:forEach>
								</ul>
								
							</div>
						</div>
					</div>
				</div>
				<!-- 인접좌석 -->
				<div class="adjacent_seat_wrap">
					<div class="adjacent_seat" id="adjacent_seat">
						<span class="title">좌석 붙임 설정</span>
						<div class="block_wrap">
							<c:forEach begin="1" end="4" varStatus="stat">
								<span class="seat_block block${stat.index}">
									<label>
										<!-- <input type="radio" name="adjacent_seat"> -->
										<c:forEach begin="1" end="${stat.index}">
											<span class="box"></span>
										</c:forEach>&nbsp;&nbsp;
										<span class="sreader">${stat.index}석 좌석붙임</span>
									</label>
								</span>
							</c:forEach>
						</div>
					</div>
				</div>
				<!-- NUMBEROFPEOPLE 섹션 -->
				<div class="section section-screen-select"><div>
					<div class="title">선택하신 상영관<span>/</span>시간</div>
					<div class="screen-time">
						<span class="screen">${dto.multiplexName}</span>
						<span class="seats seat_all">(${dto.seat})</span>
						<span class="time">${dto.startTime} - ${dto.endTime}</span>
						<span class="seats seat_remain">(잔여 62석)</span>
					</div>
					
				</div></div>
			</div>
			<!-- THEATER -->
			<div class="theater_minimap">
				<div class="theater nano has-scrollbar" id="seat_minimap_nano">
					<div class="content" tabindex="-1" style="right: -17px; bottom: -17px;">
						<div class="screen" title="SCREEN" style="width: 652px;">
							<span class="text"></span>
						</div>
								${dto.seatMap}
					</div>
				</div>


				<div class="legend" style="width: 110px;">
				
					<div class="seat-icon-desc">
						<span class="icon selected"><span class="icon"></span>선택</span>
						<span class="icon reserved"><span class="icon"></span>예매완료</span>
						<span class="icon notavail"><span class="icon"></span>선택불가</span>
					</div>
					<div class="seat-type">
						<span class="radiobutton type-rating_prime" title="Prime 석" style="display: block;">
						Prime Zone<span class="icon"></span></span>
						<span class="radiobutton type-rating_comfort" title="Standard 석" style="display: block;">
						Standard Zone<span class="icon"></span></span>
						<span class="radiobutton type-rating_economy" title="Economy 석" style="display: block;">
						Economy Zone<span class="icon"></span></span>
						<span class="radiobutton type-normal" style="display: block;">
						<span class="icon"></span>일반석</span>
						<span class="radiobutton type-couple" title="연인, 가족, 친구를 위한 둘만의 좌석" style="display: none;">
						<span class="icon"></span>커플석</span>
						<span class="radiobutton type-sweetbox" title="국내 최대 넓이의 프리미엄 커플좌석" style="display: none;">
						<span class="icon"></span>SWEETBOX</span>
						<span class="radiobutton type-veatbox" title="음향 진동 시스템이 적용된 특별좌석" style="display: none;">
						<span class="icon"></span>VEATBOX</span>
						<span class="radiobutton type-4d" title="바람, 진동 등 오감으로 영화 관람, 4DX" style="display: none;">
						<span class="icon"></span>4DX</span>
						<span class="radiobutton type-widebox" title="일반석보다 더 넓고 편안한 좌석" style="display: none;">
						<span class="icon"></span>WIDEBOX</span>
					</div>
				</div>
			</div>
		   <div class="mouse_block"></div>
		</div>
	</div>
	<a class="btn-refresh" href="#" onclick="return false;">
		<span>다시하기</span>
	</a>
	<!-- 시간표 변경 -->
	<div class="section_time_popup" id="section_time_popup">
		<div class="canvas">
			<div class="sprite">
				<div class="time-option">
					<span class="morning">조조</span><span class="night">심야</span>
				</div>
				<div class="time-list nano has-scrollbar" id="time_popup_list">
					<div class="content scroll-y" tabindex="-1" style="right: -17px;"></div>
					<div class="pane pane-y" style="display: none; opacity: 1; visibility: visible;">
						<div class="slider slider-y" style="height: 50px;"></div>
					</div>
					<div class="pane pane-x" style="display: none; opacity: 1; visibility: visible;">
						<div class="slider slider-x" style="width: 50px;"></div>
					</div>
				</div>
			</div>
			<div class="buttons">
				<a href="#" onclick="return false;" class="btn_ok"><span>확인</span></a>
				<a href="#" onclick="return false;" class="btn_cancel"><span>취소</span></a>
			</div>
		</div>
		<div class="corner"></div>
	</div>
	<!-- 시간표 변경 -->
</div>

