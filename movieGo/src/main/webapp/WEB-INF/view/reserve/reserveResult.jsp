<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String cp=request.getContextPath();
%>

<div class="step step4" style="display: block;">
<div class="section section-complement">
    <div class="col-head">
    </div>
    
	<div class="col-body">
        <div class="article result">
            <div class="text_complement"><img src="<%=cp%>/res/images/text_complement.png" alt="예매가 완료 되었습니다."></div>
			
            <div class="ticket_summary_wrap">
                <div class="ticket_summary">
                    <div class="poster">
                    	<img src="<%=cp%>/res/poster/${dto.poster}.jpg" style="visibility: visible; display: inline;">
                    </div>
                    <table>
                        <caption>예매정보</caption>
                        <thead></thead>
                        <tbody>
                            <tr class="ticket_no">
                                <th scope="row">예매번호</th>
                                <td><span class="red">${dto.reserveIdx}</span></td>
                            </tr>
                            <tr class="movie_name">
                                <th scope="row">영화</th>
                                <td><em>${dto.movieName}</em></td>
                            </tr>
                            <tr class="theater">
                                <th scope="row">극장</th>
                                <td><em><span class="theater_name">MOVIE GO ${dto.cinemaName}</span> / <span class="theater_loc">${dto.multiplexName}</span></em></td>
                            </tr>
                            <tr class="movie_date">
                                <th scope="row">일시</th>
                                <td><em><!-- 2017년2월12일(일)09:40 ~ 11:25 -->${dto.startTime} ~ ${dto.endTime}</em></td>
                            </tr>
                            <tr class="people">
                                <th scope="row">인원</th>
                                <td>
                                	<em><c:if test="${dto.adult!=0}">일반 ${dto.adult}명 &nbsp;&nbsp;</c:if></em>
                                	<em><c:if test="${dto.youth!=0}">청소년 ${dto.youth}명</c:if></em>
                                </td>
                            </tr>
                            <tr class="seat">
                                <th scope="row">좌석</th>
                                <td><em>
	                                <c:forEach var="seat" items="${dto.seats}" varStatus="stat">${seat} ${not stat.last ? ', ' : ''}
	                                </c:forEach>
	                            </em></td>
                            </tr>
                            <tr class="payment_price">
                                <th scope="row">결제금액</th>
                                <td><span class="price"><fmt:formatNumber value="${dto.totPrice}" pattern="#,##0"/></span>원</td>
                            </tr>
                            <tr class="payment_method">
                                <th scope="row">결제수단</th>
                                <td>
                                	<c:forEach var="payment" items="${dto.payments}">
	                                	<div class="row">
			                                <span class="title"><em>${payment.split("/")[0]}</em></span>
			                                <span class="content"><span class="price">
			                                	<fmt:formatNumber value="${payment.split('/')[1]}" pattern="#,##0"/>
			                                </span>원</span>
		                                </div>
                                	</c:forEach>
	                            </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
            
            <div class="ticket_button_group"><div>
                <a class="btn_step4 btn_red btn_ticket_check_red" href="#" style="margin: 0px 5px; display: block;"><span>예매확인/취소</span></a>
            </div></div>
        </div>
    </div>
</div></div>