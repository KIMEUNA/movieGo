<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>

	<div id="contaniner" class="bg-bricks">
        <div id="ctl00_ctl00_navigation_line" class="linemap-wrap">
            <div class="sect-linemap">
                <div class="sect-bcrumb">
                    <ul>
                        <li><a href="<%=cp%>"><img alt="home" src="<%=cp%>/res/images/btn_home.png"></img></a></li>                    
                            <li>
                                <a href="<%=cp%>/myinfo/mymain">My MovieGo</a>
                            </li>                    
                            <li class="last">나의 예매내역</li>
                    </ul>
                </div>
            </div>
        </div>
		<div id="contents" class="">

<div class="cols-content" id="menu">
    <div class="col-aside">
	    <div class="snb">
	        <ul>
	            <li>
                    <a href="<%=cp%>/myinfo/mymain">MY HOME<i></i></a>
                </li>
	            <li class="on">
                    <a href="<%=cp%>/myreserve/myreserve" >나의 예매내역 <i></i></a>
                </li>
	            <li >
                    <a href="<%=cp%>/point/mypoint" >포인트 <i></i></a>
	            </li>            
	            <li >
                    <a href="<%=cp%>/member/pwdCheck" >나의정보<i></i></a>
	                <ul>
                         <li >
                            <a href="<%=cp%>/member/pwdCheck" >개인정보 변경</a>
                        </li>
	                    <li >
                            <c:if test="${sessionScope.member.id!='admin' }">
                            	<a href="<%=cp%>/member/pwdcheck?dropout">회원탈퇴</a>
                            </c:if>
                        </li>                        
	                </ul>
	            </li>
	        </ul>
	    </div>
    </div>
	
	
	
	<div class="col-detail">
	    <div class="movielog-detail-wrap">
	        <!-- Title & Button Combo -->
            <form id="form1" method="get" novalidate="novalidate">
	            <div class="tit-mycgv">
		            <h3>내가 본 영화</h3>
		            <p><em>${list.size()}건</em></p>
		            <div class="set-combo">
                        <a href="/movies/point/my-list.aspx" class="round red on"><span>내 평점 보기</span></a>
		            </div>
		        </div>
            </form>
		    <!-- //Title & Button Combo -->
		    <!-- 내가 본 영화 리스트 -->
            
		    <div class="sect-movielog-lst">
			    <ul id="watched_list_container">
                    <c:forEach var="list" items="${list}">
                    		<li>
                                <div class="article-movie-info">
				            		<div class="box-image"> 
				                    	    <a href="#">
				                        	<span class="thumb-image"> 
				                                <img src="<%=cp%>/res/poster/${list.poster}.jpg">
                                                <span class="ico-grade grade-15">${list.gradeName}</span>
                                                    <i></i>
				                            </span> 
				                        </a> 
				                    </div>
				                    <div class="box-contents">
				                    	<div class="title"> 
				                        	<a href="#">
                                                <strong id="strong_79383">${list.movieName}</strong>
                                            </a>
				                        </div>
				                        
                                        
                                        
                                        <p class="date">${list.startTime} ~ ${list.endTime}</p>
				                        <p class="theater">MOVIEGO ${list.cinemaName}점&nbsp; ${list.multiplexName} / ${list.count} 명</p>
				                        <!-- add_css82 평점 개편 -->
                                        <ul class="writerinfo" id="wid_271712886">                                        
	                                        <li class="writer-opinion">
	                                        <c:if test="${empty list.content}">
	                                        	<a class="link-gradewrite" href="#" data-movieidx="${list.movieIdx}">이 영화를 평가해주세요</a>
	                                        </c:if>
	                                        <c:if test="${not empty list.content}">
	                                        	<a class="link-gradewrite" href="#" data-movieidx="${list.movieIdx}"><span class="egg-icon good"></span>${list.content}</a>
	                                        </c:if>
                                            </li>
                                        </ul>
				                    </div>
				                </div>
			                </li>
                    </c:forEach>
			    </ul>
		    </div>
		    <!-- //내가 본 영화 리스트 -->
	    </div>
<div class="paging">
	${paging}
</div>
	</div>
	
	
</div>
</div>
		</div>
	<!-- /Contaniner -->