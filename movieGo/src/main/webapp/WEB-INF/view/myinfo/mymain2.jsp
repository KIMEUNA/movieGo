<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>

<script type="text/javascript">

function reserveCancel(idx) {
	
	if(confirm("정말 취소하시겠습니까?")) {
		var url="<%=cp%>/myinfo/cancel";
		var query="reserveIdx="+idx;
		
		console.log(url+" "+query);
		
		jQuery.ajax({
			type:"post",
			url:url,
			data:query,
			dataType:"json",
			success:function(data) {
				
				if(data.state=="true")
					alert("취소되었습니다.");
				else 
					alert("취소에 실패했습니다.\n다시 시도해주세요.");
				
			},error:function(e) {
				console.log(e.responseText);
			}
		});
	} 
	return false;
};

function myReserveList() {
	
	var url="<%=cp%>/myinfo/myReserveList";
	
	jQuery.ajax({
		type:"post",
		url:url,
		dataType:"json",
		success:function(data) {
			
			if(data.list.length != 0) {
				var list=data.list;
				
				
			} else {
				jQuery(".lst-item").html("고객님의 최근 예매내역이 존재하지 않습니다.");
			}
			
			
			
			
		},error:function(e) {
			console.log(e.responseText);
		}
	});
	
	
};

</script>

	<!-- Contaniner -->
	<div id="contaniner" class="bg-bricks">
        <div id="ctl00_ctl00_navigation_line" class="linemap-wrap">
            <div class="sect-linemap">
                <div class="sect-bcrumb">
                    <ul>
                        <li><a href="<%=cp%>"><img alt="home" src="<%=cp%>/res/images/btn_home.png" /></a></li>                       
                            <li >
                                <a href="<%=cp%>/myinfo/mymain">My MovieGo</a>
                            </li>                        
                            <li class="last">MY HOME</li>
                    </ul>
                </div>
            </div>
        </div>
		<div id="contents" class="">

<div class="sect-common">
    <div class="mycgv-info-wrap">
        <div class="sect-person-info">
        	<div class="box-image">
				<span class="thumb-image">
					<img src="<%=cp%>/res/images/default_profile.gif"/>
					<span class="profile-mask"></span>
				</span>
        	</div>
					<div class="box-contents newtype">
						<div class="grade-info">
							<p style="margin-bottom: 4px; color: #342929; font-family: 'NanumBarunGothicBold', '맑은 고딕', '돋움', Dotum, sans-serif; font-size: 20px; line-height: 20px;">
								<strong class="txt-purple"> ${dto.name} </strong> 고객님의 정보 입니다.
							</p>
						</div>
						<div class="cols-benefit-info">
							<div class="col-one-point">
								<h3>POINT</h3>
								<a href="<%=cp%>/point/mypoint">POINT 더보기</a>
								<ul>
									<li><strong>사용가능 포인트</strong> <span><em class="txt-maroon">
									<fmt:formatNumber value="${dto.point}" pattern="#,##0" /></em> 점</span></li>
								</ul>
							</div>
						</div>
					</div>


				</div>

    </div>
</div>

<div class="cols-content" id="menu">
    <div class="col-aside">
	    <div class="snb">
	        <ul>
	            <li class="on">
                    <a href="<%=cp%>/myinfo/mymain">MY HOME<i></i></a>
                </li>
	            <li>
                    <a href="<%=cp%>/myreserve/myreserve" >나의 예매내역 <i></i></a>
                </li>
	            <li>
                    <a href="<%=cp%>/point/mypoint" >포인트 <i></i></a>
	            </li>            
	            <li>
                    <a href="<%=cp%>/member/pwdCheck" >나의정보<i></i></a>
	                <ul>
                         <li >
                            <a href="<%=cp%>/member/pwdCheck" >개인정보 변경</a>
                        </li>
	                    <li >
                            <c:if test="${sessionScope.member.id!='admin' }">
                            	<a href="<%=cp%>/member/pwdCheck?dropout">회원탈퇴</a>
                            </c:if>
                        </li>                        
	                </ul>
	            </li>
                <li class="my-event">
                	<a href="<%=cp%>/myinfo/mywatchmovie">내가 본 영화</a>
                </li> 
	        </ul>
	    </div>
    </div>
	<div class="col-detail" id="mycgv_contents">

<div class="sect-mycgv-reserve movielog col4">
    <div class="box-polaroid">
        <div class="box-inner wishlist" style="min-width: 33%;">
            <a href="<%=cp%>/myinfo/mywishlist" title="위시리스트">
                <h3>위시리스트</h3>
                <span>보고 싶은 영화들을 미리 <br />담아두고 싶다면?</span>
            </a>
        </div>
        <div class="box-inner watched" style="min-width: 33%;">
            <a href="<%=cp%>/myinfo/mywatchmovie" title="내가 본 영화">
                <h3>내가 본 영화</h3>
                <span>관람한 영화들을 한번에 <br />모아 보고 싶다면?</span>
            </a>
        </div>
        <div class="box-inner mvdiary" style="min-width: 33%;">
            <a href="#" title="무비다이어리">
                <h3>무비다이어리</h3>
                <span>관람 후 내 감상평을 적어 <br />추억하고 싶다면?</span>
            </a>
        </div>
    </div>
</div>
<div class="tit-mycgv">
	<h3>MY 예매내역</h3>
	<p><em>0건</em> <a href="<%=cp%>/myreserve/myreserve">예매내역 더보기</a></p>
</div>

    <!-- MY 예매내역 -->
    <div class="sect-base-booking">
	    <div class="box-polaroid">
	        <div class="box-inner">
                
                <c:if test="${empty list}">
             	    <div class="lst-item">
		    	        고객님의 최근 예매내역이 존재하지 않습니다.
	    	        </div>     
                </c:if>
                
                <c:forEach var="list" items="${list}">
                
	                <div class="lst-item">
	            	    <div class="box-number">
	            		    <em>예매번호</em>
	            		    <strong><i>${list.reserveIdx}</i></strong>
	            		    <span>(${list.reserveDate})</span>
	            	    </div>
		                <div class="box-image">
		            	    <span class="thumb-image"> 
		                        <img src="<%=cp%>/res/poster/${list.poster}.jpg" >
		                    </span>
		                </div>
		                <div class="box-contents">
		            	    <dl>
		            		    <dt>
                                    ${list.movieName}
                                </dt>
			        		    <dd>
                                    <em>관람극장</em> 
                                    <strong>MOVIE GO ${list.cinemaName}</strong> 
                                </dd>
			        		    <dd>
                                    <em>관람일시</em>
                                    <strong>${list.startTime}</strong>
                                </dd>
		            	    </dl>
		                </div>
		                <div class="box-detail">
		            	    <div class="account-info">
			            	    <dl>
			            	    	<dt>
				            	    	<c:forEach var="seat" items="${list.seats}" varStatus="stat">
				            	    		${seat}&nbsp;
				            	    	</c:forEach>
			            		    </dt>
			            		    
			            		    <c:forEach var="payment" items="${list.payments}">
			            		    		<dd>
                                                <em>${payment.payment_type}</em>
                                                <strong class="txt-lightblue"><fmt:formatNumber value="${payment.payment_price}" pattern="#,##0"/>원</strong>
                                            </dd>
			            		    </c:forEach>
			            	    </dl>
		            	    </div>
		            	    <div class="set-btn">
                                <button type="button" onclick="reserveCancel('${list.reserveIdx}');" class="round black cancel"><span>예매취소</span></button>
		            	    </div>
		                </div>
	                </div>
	                </c:forEach>
	                
	        </div>
	    </div>
    </div>

	</div>
</div>
</div>
</div>

	