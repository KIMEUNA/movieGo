<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String cp=request.getContextPath();
%>

<script type="text/javascript">

var payment="신용카드";

jQuery(function() {
	summary();
	
	jQuery("#btnReserveOk").disabled = false;
	
	jQuery(".tpm_header").click(function() {
		if(jQuery(this).parent().hasClass("opened"))
			jQuery(this).parent().removeClass("opened");
		else
			jQuery(this).parent().addClass("opened");
	});
	jQuery(".radio_group span[class=pay_radio]").click(function() {
		jQuery(".payment_input").each(function() {
			jQuery(".payment_input").css("display", "none");
		});
		
		payment = jQuery(this).children("label").text();
		
		jQuery(".payment_input").eq(jQuery(this).index()).css("display", "block");
		summary();
	});
	
	jQuery("input[id=moviego_use]").change(function() {
		var myPoint="${point}";
		if(myPoint < Number($(this).val())) {
			$(this).val(numberWithCommas(myPoint));
			summary();
			return;
		}
		$(this).val(numberWithCommas($(this).val()));
		summary();
	});

	jQuery("input[id=moviego_all]").change(function() {
		if($(this).is(":checked")) {
			jQuery("input[id=moviego_use]").val(numberWithCommas("${point}"));
		} else
			jQuery("input[id=moviego_use]").val("0");
		summary();
	});
	
	jQuery("#paymentInfoConfirm input[type=checkbox]").each(function() {
		if( ! $(this).is(":checked")) {
			jQuery("#btnReserveOk").disabled = false;
		}
	});
	
	jQuery(".cancel").click(function() {
		jQuery("#blackscreen").css("display","none");
		jQuery("#popup_reservation_check").css("display", "none");
	});
});



function reserveCheck() {
	
	var seats="${seats}".split(","); // 가격
	
	var url = "<%=cp%>/reserve/reserveCheck";
	var query = "scheduleIdx="+scheduleIdx+"&totPrice=${dto.totPrice}";
		query+="&payments="+payment+"/"+jQuery("#summary_payment_total").text().replace(",", "");
	
	if(jQuery("#moviego_use").val()!=0)
		query+="&payments=적립금/"+jQuery("#moviego_use").val().replace(",", "");
	
	for (var i = 0; i < seats.length; i++)
		query+="&seats="+seats[i];
	console.log(query);
	
	jQuery.ajax({
		type:"post",
		url:url,
		data:query,
		dataType:"json",
		success:function(data) {
			var dto=data.dto;
			jQuery("#popup_reservation_check tr[class=movie_name] td").text(dto.movieName);
			jQuery("#popup_reservation_check tr[class=theater] td").text("MOVIEGO "+dto.cinemaName);
			jQuery("#popup_reservation_check tr[class=multiplex] td").text(dto.multiplexName);
			jQuery("#popup_reservation_check tr[class=movie_date] td").text(dto.startTime+" ~ "+dto.endTime);
			jQuery("#popup_reservation_check tr[class=people] td").text("일반 : "+adult+"명 청소년 : "+youth+"명");
			jQuery("#popup_reservation_check tr[class=seat] td").text(data.seats);
			jQuery("#popup_reservation_check tr[class=payment_price] td").html("<span class='price'>"+numberWithCommas(dto.totPrice)+"</span>원");
			
			var payment=dto.payments;
			var payOut="";
			for (var i = 0; i < payment.length; i++) 
				payOut=payOut+"<div class='row'><span class='title'>"+payment[i].split("/")[0]+"</span><span class='content'><span class='price'>"+numberWithCommas(payment[i].split("/")[1])+"</span>원</span></div>";
			
			jQuery("#popup_reservation_check tr[class=payment_method] td div[class=payment_methods]").html(payOut);
			
			// 상영시간 - 2017년 2월 12일(일) 09:40 ~ 11:25 이렇게 !!
			
			jQuery("#blackscreen").css("display","block");
			jQuery("#popup_reservation_check").css("display", "block");
			
	        var offset = $("#popup_reservation_check").offset();
	        $('html, body').animate({scrollTop : offset.top}, 400);
	        
	        // 영화이름, 지점, 상영관, 일시 를 추가한다.
	        var formHidden=jQuery("#formHidden").html();
	        var movieName="<input type='hidden' name='movieName' value=\""+dto.movieName+"\">";
	        var cinemaName="<input type='hidden' name='cinemaName' value=\""+dto.cinemaName+"\">";
	        var multiplexName="<input type='hidden' name='multiplexName' value=\""+dto.multiplexName+"\">";
	        var startTime="<input type='hidden' name='startTime' value=\""+dto.startTime+"\">";
	        var endTime="<input type='hidden' name='endTime' value=\""+dto.endTime+"\">";
	        var poster="<input type='hidden' name='poster' value=\""+dto.poster+"\">";
	        jQuery("#formHidden").html(formHidden+movieName+cinemaName+multiplexName+startTime+endTime+poster);

		},error:function(e) {
			console.log(e.responseText);
		}
	});
	

}


function summary() {
	num=jQuery("input[id=moviego_use]").val().replace(",","");
	var totPrice="${dto.totPrice}";
	jQuery("#summary_discount_total").text(numberWithCommas(num));
	jQuery("#summary_payment_total").text(numberWithCommas(totPrice-num));
	
	jQuery("#summary_payment_list dl[class=code_0010]")
				.html("<dt style='top: 11px;''>"+payment+"</dt>");
	jQuery(".pay_amt").text(jQuery("#summary_payment_total").text());
}

function pointFocus() {
	if(!jQuery("#moviego_use").val())
		jQuery("#moviego_use").val("");
};

function pointBlur() {
	if(!jQuery("#moviego_use").val())
		jQuery("#moviego_use").val("0");
};

function paymentSubmit() {
	
	var mid="${sessionScope.member.memberIdx}";
	if(!mid) {
		alert("로그인 후 이용 가능합니다.");
		return;
	}
	
	var url = "<%=cp%>/reserve/paymentSubmit";
	var query = $('form[name=paymentForm]').serialize()+"&memberIdx="+mid;
		query+="&payments="+payment+"/"+jQuery("#summary_payment_total").text().replace(",", "");
		
	if(jQuery("#moviego_use").val()!=0)
		query+="&payments=적립금/"+jQuery("#moviego_use").val().replace(",", "");
	
	console.log(query);
	
	jQuery.ajax({
		type:"post",
		url:url,
		data:query,
		success:function(data) {
			jQuery("#blackscreen").css("display","none");
			jQuery("#steps").html(data);
			jQuery("#tnb_area").html("");
		},error:function(e) {
			console.log(e.responseText);
		}
	});
	
}

</script>

<div class="step step3" style="display: block;">

<div class="ticket_payment_method">
	<a href="#" onclick="return false;" id="ticket_payment_top" class="sreader">결제시작</a>

	<h4 class="ts3_titlebar ts3_t1" style="margin-top: 40px;">
		<span class="header">STEP 1</span>
		<span class="title">할인수단 선택</span>
		<a href="#" onclick="return false;"><span>다시하기</span></a>
	</h4>
	
	<!--<div class="ts3_titlebar_exp">할인수단 선택은 복합 적용이 가능합니다.</div>-->
	<div class="tpm_wrap tpm_point">
	<div class="tpm_header">
		<h4 class="default">
			MOVIEGO 포인트
		</h4>
		
		<h4 class="only_cgvticket">
			MOVIEGO 포인트
		</h4>
		<a class="tpmh_btn" href="#" onclick="return false;"><span>닫기</span></a>
		
	</div>
	
	<div class="tpm_body">
	
	<div class="tpm_row">
			<div class="tpm_box cj_one_point"><div>
				<h5>MOVIE GO 포인트</h5>
				<div class="tpm_cj_one_point">
					<div class="tpcop">
						<span class="title">현재 보유 포인트:</span>
						<span class="point point_have verdana"><fmt:formatNumber value="${point}" pattern="#,##0"/>P</span>
						<span class="title title2">사용할 포인트:</span>
						<span class="form_wrap">
							<label for="cj_one_point_use">사용할 포인트 입력</label>
							<input id="moviego_use" type="text" value="0" maxlength="7" class="type-n nohan" onfocus="pointFocus();" onblur="pointBlur();">
						</span>
						<span class="point point_use verdana">P</span>
						<span class="title title3">
							모두사용
							<label for="cj_one_point_all">포인트 모두 사용</label>
							<input id="moviego_all" type="checkbox">
						</span>
					</div>
				</div>
			</div></div>
		</div>
	</div>
</div>


	<h4 class="ts3_titlebar ts3_t2">
		<span class="header">STEP 2</span>
		<span class="title">결제정보 입력</span>
	</h4>
	
<div class="tpm_wrap tpm_last_pay">
	<div class="promotion_message" id="promotion_message" style="display: none;">
		<div class="msg"></div>
		<a href="#" onclick="showHidePromotionMessage();return false;">상세보기</a>
		<div class="msg_box" style="display: none;"></div>
	</div>
	<div class="tpm_body">
		<div>
			<div class="payment_select radio_group">
				<span class="pay_radio">
					<input type="radio" id="last_pay_radio1" name="last_pay_radio" value="0" checked="checked">
					<label for="last_pay_radio1">신용카드</label>
				</span>
				<span class="pay_radio">
					<input type="radio" id="last_pay_radio2" name="last_pay_radio" value="1">
					<label for="last_pay_radio2">휴대폰 결제</label>
				</span>
				<span class="pay_radio">
					<input type="radio" id="last_pay_radio3" name="last_pay_radio" value="2">
					<label for="last_pay_radio3">계좌이체</label>
				</span>
			</div>



<div class="payment_form">
			

<!-- 신용카드 -->
<h5>신용카드 정보 입력</h5><!-- title -->
<div class="payment_input payment_card" style="display: block;">

	<div class="table_wrap card_default" id="card_default">
		<table>
			<caption>신용카드의 종류, 카드번호, 비밀번호, 유효기간, 주민등록번호 입력</caption>
			<thead></thead>
			<tbody>
				<tr><th class="row">결제금액</th>
					<td>
						<strong class="pay_amt" style="margin: 0 5px 0 5px; font-size:1.5em;">6,000</strong>원
					</td>
				</tr>
				<tr>
					<th scope="row"><label for="lp_card_type">카드종류</label></th>
					<td>
						<div class="form_wrap select card_type form_bg">
							<select id="lp_card_type">
								<option selected="selected">카드를 선택하세요</option>
								<option data-card_cd="N0002">BC카드</option>
								<option data-card_cd="N0004">국민카드</option>
								<option data-card_cd="N0023">삼성카드(올앳포함)</option>
								<option data-card_cd="N0021">신한카드</option>
								<option data-card_cd="N0005">현대카드</option>
								<option data-card_cd="N0012">KEB하나카드(구,외환)</option>
								<option data-card_cd="N0018">우리(평화)카드</option>
								<option data-card_cd="N0001">롯데/아멕스카드</option>
								<option data-card_cd="N0003">시티카드(구,한미)</option>
								<option data-card_cd="N0022">신세계카드</option>
								<option data-card_cd="N0017">NH카드</option>
								<option data-card_cd="N0006">하나카드(구,하나SK)</option>
								<option data-card_cd="N0014">광주VISA카드</option>
								<option data-card_cd="N0019">산은캐피탈</option>
								<option data-card_cd="N0016">수협카드</option>
								<option data-card_cd="N0011">KDB산업은행카드</option>
								<option data-card_cd="N0009">전북은행카드</option>
								<option data-card_cd="N0010">제주은행카드</option>
								<option data-card_cd="N0013">우체국카드</option>
								<option data-card_cd="N0020">스탠다드차타드은행카드</option>
								<option data-card_cd="N0015">MG체크카드</option>
								<option data-card_cd="N0007">현대증권카드</option>
								<option data-card_cd="N0008">기업은행카드</option>
							</select>
						</div>
						
					</td>
				</tr>
				<tr id="input_card_num">
					<th scope="row"><label for="lp_card_no1">카드번호</label></th>
					<td>
						<div>
							<div class="form_wrap text card_no form_bg">
								<label for="lp_card_no1">카드 번호 첫번째 숫자 입력</label>
								<input id="lp_card_no1" type="text" maxlength="4" class="type-n nohan">
							</div>
							<span class="divider">-</span>
							<div class="form_wrap text card_no form_bg">
								<label for="lp_card_no2">카드 번호 두번째 숫자 입력</label>
								<input id="lp_card_no2" type="password" maxlength="4" class="type-n nohan">
							</div>
							<span class="divider">-</span>
							<div class="form_wrap text card_no form_bg">
								<label for="lp_card_no3">카드 번호 세번째 숫자 입력</label>
								<input id="lp_card_no3" type="password" maxlength="4" class="type-n nohan">
							</div><span class="divider">-</span>
							<div class="form_wrap text card_no form_bg">
								<label for="lp_card_no4">카드 번호 네번째 숫자 입력</label>
								<input id="lp_card_no4" type="text" maxlength="4" class="type-n nohan">
							</div>
						</div>
					</td>
				</tr>
				<tr id="input_card_pw">
					<th scope="row"><label for="lp_card_pw">비밀번호</label></th>
					<td>
						<div>
							<div class="form_wrap text card_pw form_bg">
								<label for="lp_card_pw">카드 비밀번호 숫자 입력</label>
								<input id="lp_card_pw" type="password" maxlength="2" class="type-n nohan">
							</div><span class="password">**</span>
						</div>
					</td>
				</tr>
			</tbody>
		</table>
	</div>
</div>
<!-- 신용카드 -->




			    <!-- 휴대폰 -->
<h5>휴대폰 정보 입력</h5>
<div class="payment_input payment_phone" style="display: none;">
	<div class="table_wrap phone_wrap" id="phone_wrap">
		<table>
			<caption>휴대폰 번호, 주민등록번호, 결제금액 입력 및 약관 동의</caption>
				<thead></thead>
				<tbody>
					<tr><th class="row">결제금액</th>
						<td>
							<strong class="pay_amt" style="margin: 0 5px 0 5px; font-size:1.5em;">6,000</strong>원
						</td>
					</tr>
					<tr>
						<th scope="row">상품명</th>
						<td>영화티켓예매</td>
					</tr>
					
					
					
					
					
					<tr>
						<th scope="row">통신사 선택</th>
						<td><div>
							<div class="form_wrap radio carrier radio_group">
								<input type="radio" id="lp_carrier_skt" name="lp_carrier" value="SKT" checked="checked"/>
								<label for="lp_carrier_skt">SKT</label>
								<input type="radio" id="lp_carrier_kt" name="lp_carrier" value="KTF"/>
								<label for="lp_carrier_kt">KT</label>
								<input type="radio" id="lp_carrier_lgt" name="lp_carrier" value="LGT"/>
								<label for="lp_carrier_lgt">LGU+</label>
                                <span>|&nbsp;&nbsp;&nbsp;</span>
                                <input type="radio" id="lp_carrier_cjh" name="lp_carrier" value="CJH"/>
                                <label for="lp_carrier_cjh">헬로모바일</label>
							</div>
						</div></td>
					</tr>
					<tr>
						<th scope="row">휴대폰 번호</th>
						<td><div>
							<div class="form_wrap select phone_no1 form_bg">
								<label for="lp_phone_no1">휴대폰 국번 선택</label>
								<select id="lp_phone_no1">
									<option>국번선택</option>
									<option>010</option>
									<option>011</option>
									<option>016</option>
									<option>017</option>
									<option>018</option>
									<option>019</option>
								</select>
							</div><span class="divider">-</span><div class="form_wrap text card_no form_bg">
								<label for="lp_phone_no2">휴대폰 번호 앞자리 숫자 입력</label>
								<input id="lp_phone_no2" type="text" maxlength="4" class="type-n nohan"/>
							</div><span class="divider">-</span><div class="form_wrap text card_no form_bg">
								<label for="lp_phone_no3">휴대폰 번호 뒷자리 숫자 입력</label>
								<input id="lp_phone_no3" type="text" maxlength="4" class="type-n nohan"/>
							</div>
						</div></td>
					</tr>
					
					
					
					
					<tr id="phone_price_row" style="display: none;">
						<th scope="row">결제금액</th>
						<td><div>
							<div class="form_wrap text card_ssn form_bg">
								<label for="lp_phone_amount">결제금액 숫자 입력</label>
								<input id="lp_phone_amount" type="text" maxlength="6" class="type-n nohan align-right">
							</div><span class="string2">원</span>
						</div></td>
					</tr>
				</tbody>
			</table>
		</div>
		
	</div>
<!-- 휴대폰 -->



<!-- 계좌이체 -->

<div class="payment_input payment_transfer" style="display: none;">
	<div class="table_wrap transfer_wrap" id="transfer_wrap">
		<h6>계좌이체 순서</h6>
		<div>1. 아래 결제하기 버튼 클릭 후 다음 단계로 이동<br>
		2. 결제내역 확인 후 결제하기 버튼 클릭 시 팝업창이 뜸<br>
		3. 해당 팝업에서 원하는 은행을 선택 후 계좌이체 정보를 입력하시면 됩니다.</div>
	</div>
	<div class="payment_input_exp">
		<span>
			<span style="font-weight:bold; color: red;">계좌이체 진행시 원활한 사용을 위하여 다음 사항을 꼭 확인해주세요.</span><br>
			1. 익스플로어에서만 사용 가능합니다. (크롬, 파이어폭스, 사파리 등 사용 불가)<br>
			2. 팝업 차단 설정을 꼭 해제하셔야 합니다.(도구 → 팝업 차단 끄기)<br>
			&nbsp;*팝업 차단 해제 시, 웹브라우저 새로고침으로 인해 최대 10분 동안 동일 좌석 선택이 제한될 수 있습니다.
		</span>
	</div>
</div>

<!-- 계좌이체 -->


			
			</div>
		</div>
	</div>
</div>
</div>


	<div class="ticket_payment_summary">
	    <div class="tps_wrap" style="top: 0px;">
		<div class="tps_body">
			<div class="summary_box total_box">
				<div class="payment_header">결제하실 금액</div>
				<div class="payment_footer">
				    <div class="result">
				        <span class="num verdana" id="summary_total_amount">
				        	<fmt:formatNumber value="${dto.totPrice}" pattern="#,##0"/>
				        </span><span class="won">원</span>
			        </div>
			    </div>
			</div>
			<div class="summary_box discount_box" id="tps_discount_box">
				<div class="payment_header">할인내역</div>
				<div class="payment_body" id="summary_discount_list"></div>
				<div class="payment_footer">
				    <div class="label">
				        <span>총 할인금액</span>
				    </div>
				    <div class="result">
				        <span class="num verdana" id="summary_discount_total">0</span><span class="won">원</span>
				    </div>
			    </div>
			</div>
			<div class="summary_box payment_box" id="tps_payment_box">
				<div class="payment_header">결제내역</div>
				<div class="payment_body" id="summary_payment_list">
					<dl data-code="0010" class="code_0010">
					<dt style="top: 11px;">신용카드</dt>
					<dd><span class="num"><fmt:formatNumber value="${dto.totPrice}" pattern="#,##0"/></span>
					<span class="won">원</span></dd></dl>
				</div>
				<div class="payment_footer">
				    <div class="label">
	                    <span>남은 결제금액</span>
	                </div>
	                <div class="result">
	                    <span class="num verdana" id="summary_payment_total">
	                    	<fmt:formatNumber value="${dto.totPrice}" pattern="#,##0"/>
	                    </span><span class="won">원</span>
	                </div>
	            </div>
			</div>
		</div>
	</div>
	</div>
	


<!-- Popup - 결제 확인 -->
	<div class="ft_layer_popup popup_reservation_check" id="popup_reservation_check" style="position: absolute; top: -50px; display: none;">
		<div class="hd">
			<div class="title_area">

				<h4>예매내역 확인</h4>

			</div>
			<a title="닫기" href="#" onclick="return false;" class="layer_close">
			<span class="sreader">창 닫기</span></a>
		</div>
		<!-- //hd -->
		<div class="bd">
			<div class="article reservation_info">

				<h5>
					예매정보<span class="desc">결제하시기 전 예매내역을 다시 한번 확인해 주세요.</span>
				</h5>

				<div class="content">
					<div class="poster">
						<img src="" alt="" style="display: inline; visibility: visible;">
					</div>
					<table>
						<caption>예매정보</caption>
						<thead></thead>
						<tbody>
							<tr class="movie_name">
								<th scope="row">영화명</th>
								<td></td>
							</tr>
							<tr class="theater">
								<th scope="row">극장</th>
								<td></td>
							</tr>
							<tr class="multiplex">
								<th scope="row">상영관</th>
								<td></td>
							</tr>
							<tr class="movie_date">
								<th scope="row">일시</th>
								<td></td>
							</tr>
							<tr class="people">
								<th scope="row">인원</th>
								<td></td>
							</tr>
							<tr class="seat">
								<th scope="row">좌석</th>
								<td></td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
			
			
			<div class="article payment_info">
				<h5>결제정보<span class="desc">결제하기 버튼을 클릭하시면 결제가 완료됩니다.</span></h5>
				<table>
					<caption>결제정보</caption>
					<thead></thead>
					<tbody>
						<tr class="payment_price">
							<th scope="row">결제금액</th>
							<td></td>
						</tr>
						<tr class="payment_method">
							<th scope="row">결제수단</th>
							<td>
								<div style="height: 170px; overflow: auto;">
									<div class="payment_methods">
									</div>
								</div>
							</td>
						</tr>
					</tbody>
				</table>
			</div>
			
			<div class="article desc" style="border-bottom: none; background: none;">
				<ul><li>인터넷 예매는 온라인상으로 영화상영 시간 20분 전 까지 취소 가능합니다.</li></ul>
			</div>
			<div class="agreement" style="border-top: 1px solid rgb(204, 204, 204); 
												padding-top: 15px; background: rgb(238, 238, 238); 
												height: 80px; text-align: left; border-bottom: 1px solid rgb(204, 204, 204); 
												padding-bottom: 15px; margin: 0px 0px 28px;">
				<div id="paymentInfoConfirm" style="float: left; width: 45%; height: 100%;">
					<span class="inputModel" style="display: block; width: 400px; min-height: 15px; margin: 0px 0px 7px 20px;">
						<input class="inputModel_input" type="checkbox" style="display: inline-block; vertical-align: top; margin-top: 1px;" id="resvPKGfirm">
						<label class="inputModel_label" style="width: 93%; display: inline-block; margin-left: 10px; font-weight: bold;" for="resvPKGfirm">
						본 영화는 동시상영 영화로 부분환불이 불가한 영화입니다.</label>
					</span>
					<span class="inputModel" style="display: block; width: 400px; min-height: 15px; margin: 0px 0px 7px 20px;">
						<input class="inputModel_input" type="checkbox" style="display: inline-block; vertical-align: top; margin-top: 1px;" id="resvNoshowfirm">
						<label class="inputModel_label" style="width: 93%; display: inline-block; margin-left: 10px; font-weight: bold;" for="resvNoshowfirm">
						취소 기한을 확인하였으며, 이에 동의합니다.</label>
					</span>
					<span class="inputModel" style="display: block; width: 420px; min-height: 15px; margin: 0px 0px 0px 20px; clear: both;">
						<input class="inputModel_input" type="checkbox" style="display: inline-block; vertical-align: top; margin-top: 1px;" id="resvConfirm">
						<label class="inputModel_label" style="width: 93%; display: inline-block; margin-left: 10px; font-weight: bold;" for="resvConfirm">
						상기 결제 내역을 모두 확인 했습니다</label>
					</span>
				</div>
			</div>
		</div>
		
		<!-- //bd -->
		<form name="paymentForm" method="post">
			<div id="formHidden">
				<input type="hidden" name="scheduleIdx" value="${dto.scheduleIdx}">
				<input type="hidden" name="totPrice" value="${dto.totPrice}">
				<input type="hidden" name="adult" value="${dto.adult}">
				<input type="hidden" name="youth" value="${dto.youth}">
				<c:forEach var="seat" items="${dto.seats}">
					<input type="hidden" name="seats" value="${seat}">
				</c:forEach>
			</div>
			<div class="ft">
				<button title="예매 결제하기" id="btnReserveOk" type="button" onclick="paymentSubmit();" class="reservation">
					<span class="sreader">예매 결제하기</span>
				</button>
				<button title="예매 취소" type="button" class="cancel">
					<span class="sreader">예매 취소</span>
				</button>
			</div>
		</form>
		<!-- //ft -->
	</div>

<div class="ticket_payment_clear"></div>

</div>



