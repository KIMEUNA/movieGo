<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String cp = request.getContextPath();
%>

<script type="text/javascript">
function searchList(){
	var f=document.searchForm;
	f.action="<%=cp%>/notice/noticeList";
	f.submit();
}
</script>

	<div id="contaniner" class="">
        <!-- LineMap -->
        <div id="ctl00_navigation_line" class="linemap-wrap">
            <div class="sect-linemap">
                <div class="sect-bcrumb">
                    <ul>
                            <li><a href="#">고객센터</a></li>
                            <li class="last">공지/뉴스</li>
                    </ul>
                </div>
                <div class="sect-special">
                    <ul>
                        <li><a href="#">VIP LOUNGE</a></li>
                        <li><a href="#" title="새창" class="specialclub">Club서비스</a></li>
                        <li><a href="#" title="새창" class="photi" target="_blank">포토티켓</a></li>
                    </ul>
                </div>
            </div>
        </div>
        <!-- //LineMap -->
		<!-- Contents Area -->
		<div id="contents" class="">
            <!-- Contents Start -->
<!-- Contents Area -->

<div id="contents">
	<!-- Contents Start -->
	<div class="cols-content">
		
<div class="col-aside">
    <h2>
        고객센터 메뉴</h2>
    <div class="snb">
        <ul>
            <li class=""><a href="#">고객센터 메인<i></i></a></li>
            <li class="on"><a href="#" title="현재선택">공지/뉴스<i></i></a></li>
            <li class=""><a href="#">이메일 문의<i></i></a></li>
            <li class=''><a href="#">분실물 문의<i></i></a></li>
			<li class=''><a href="#">단체/ 대관 문의<i></i></a></li>
			<li class=''><a href="#">대학로 옥탑 예약<i></i></a></li>
        </ul>
    </div>
</div>
		<div class="col-detail">
			<div class="customer_top" style="">
				<h2 class="tit">공지/뉴스</h2>
				<p class="stit">CGV의 주요한 이슈 및 여러가지 소식들을 확인하실 수 있습니다.</p>
			</div>
			
			 <div style="float: left; width: 100%; text-align: left;">
        		     <form name="searchForm" method="post" class="form-inline">
						  <select class="form-control input-sm" name="searchKey" >
						      <option value="subject">제목</option>
						      <option value="content">내용</option>
						  </select>
						  
						  <input type="text" class="form-control input-sm input-search" name="searchValue">
						  <button type="button" class="round inblack" onclick="searchList();">　검색하기　</button>
        		     </form>
        		</div>
        		
			<div style="border-bottom: #d5d5d5 solid 1px;">
      		<c:if test="${dataCount!=0}">
      		    <div style="clear : both; height : 30px; line-height : 30px;">
	      		      <div style="float: left;">${dataCount}개(${page}/${total_page} 페이지)</div>
	      		      <div style="float: right;">&nbsp;</div>
      		    </div>
      		</c:if>	
      	</div>
			<div class="tbl_area" style="text-align: center">
				<table style="border-bottom: #d5d5d5 solid 1px">
					<caption>목록</caption>
				<thead>
	                <tr style="height: 30px;  background-color: #FAF4C0">
		                  <th class="text-center" style="width: 80px; text-align: center">번호</th>
		                  <th class="text-center" style="width: 100px; text-align: center">구분</th>
		                  <th>제목</th>
		                  <th class="text-center" style="width: 80px; text-align: center">글쓴이</th>
		                  <th class="text-center" style="width: 100px; text-align: center">날짜</th>
		                  <th class="text-center" style="width: 100px;text-align: center">조회수</th>
	                </tr>
                </thead>
			<tbody>
       <c:forEach var="dto" items="${noticeList}"> <!--[공지] 리스트 -->
	                <tr  style="height: 30px;">
	                <td class="text-center" style="text-align: center">
	                <span style="display: inline-block;width: 28px;height:18px;line-height:18px; background: #ED4C00;color: #FFFFFF;">공지</span>
	                </td>
		                <td class="text-center" style="text-align: center">${dto.type}</td>
                        <td><a href="${urlArticle}&noticeIdx=${dto.noticeIdx}">${dto.subject}</a></td>
                        <td class="text-center" style="text-align: center">${dto.employeeName}</td>
                        <td class="text-center" style="text-align: center">${dto.regDate}</td>
                        <td class="text-center" style="text-align: center">${dto.hitCount}</td>
	                </tr>
	    </c:forEach> 
	    
	    <c:forEach var="dto" items="${list}">  <!--그냥 공지사항 리스트 -->
                    <tr  style="height: 30px">
                        <td class="text-center" style="text-align: center">${dto.listNum}</td>
                        <td class="text-center" style="text-align: center">${dto.type}</td>
                        <td><a href="${urlArticle}&noticeIdx=${dto.noticeIdx}">${dto.subject}</a></td>
                        <td class="text-center" style="text-align: center">${dto.employeeName}</td>
                        <td class="text-center" style="text-align: center">${dto.regDate}</td>
                        <td class="text-center" style="text-align: center">${dto.hitCount}</td>
                    </tr>
     	</c:forEach>     
	    
               </tbody>
				</table>
				
				 <div class="paging" style="text-align: center; min-height: 50px; line-height: 50px;">
	          	  <c:if test="${dataCount==0}">
	                  	등록된 게시물이 없습니다.
	         	  </c:if>
	          	  <c:if test="${dataCount!=0}">
	              	  ${paging}
	           	 </c:if>
      		  </div>    
      		 </div>
      		  
			<div class="search_order">
				<ol>
				<li><span class="ico_oder find_q">01 자주찾는 질문 검색</span></li>
				<li><span class="ico_oder email_i">02 이메일 문의</span></li>
				<li><span class="ico_oder tel_i">03 고객센터 전화문의</span><span class="num">1544-1122</span></li>
				</ol>
			</div>
		</div>
		
			</div>
		</div>
	</div>
	<!-- //Contents End -->
</div>
<!-- //Contents Area -->