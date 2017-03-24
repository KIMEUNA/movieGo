<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String cp = request.getContextPath();
%>
<!-- Contaniner -->
<div id="contaniner" class="">
	<!-- LineMap -->
	<div id="ctl00_navigation_line" class="linemap-wrap">
		<div class="sect-linemap">
			<div class="sect-bcrumb">
				<ul>
					<li><a href="/"></a></li>
					<li><a href="/support/">고객센터</a></li>
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
					<h2>고객센터 메뉴</h2>
					<div class="snb">
						<ul>
							<li class=''><a href="#">고객센터 메인<i></i></a></li>
							<li class='on'><a href="#"title="현재선택">공지/뉴스<i></i></a></li>
							<li class=''><a href="#">이메일 문의<i></i></a></li>
							<li class=''><a href="#">분실물 문의<i></i></a></li>
							<li class=''><a href="#">단체/대관 문의<i></i></a></li>
							<li class=''><a href="#">대학로 옥탑 예약<i></i></a></li>
						</ul>
					</div>
				</div>
				<div class="col-detail">
					
				<h2 class="tit" style="height: 20px">공지/뉴스</h2>
				
					<div class="customer_top" style="height: 20px">
						<p class="stit" style="border-bottom: #d5d5d5 solid 2px;">CGV의 주요한 이슈 및 여러가지 소식들을 확인하실 수 있습니다.</p>
					</div>
					<div class="board_view_area" style="border-bottom: #d5d5d5 solid 2px;">
					<table style="border-bottom: #d5d5d5 solid 2px; height: 30px" >
						<tbody>
							<tr style="height: 50px;">
								<td>제목 : ${dto.subject}</td>   <!-- 글제목 -->
								<td class="stit_area" style="text-align: right"><span>[등록일]<em class="regist_day">&nbsp;${dto.regDate}</em></span>  <!--작성일-->
									<span class="check_tit_area">[조회수]<em class="check_num">&nbsp;${dto.hitCount}</em></span>    <!--조회수-->
								</td>
							</tr>
						</tbody>
					</table>
					
					<div class="view_area" style="height: 400px; border-bottom: #d5d5d5 solid 2px;" >   <!-- 내용  -->
						<p>${dto.content}</p>
					</div>
						
					<div class="customer_btn" style="border-bottom: #d5d5d5 solid 2px;">
               		    <button type="button" class="round inblack" id="btn_list" onclick="javascript:location.href='<%=cp%>/notice/noticeList?${params}';">
               		     	<span>목록으로</span> 
               		     </button>
               		</div>
                		
               	<c:forEach var="vo" items="${listFile}">    <!-- listfile을 받아와서 vo로 뿌려주는것, item은 collection이라고 쉽게 생각하자 -->
                     <tr>
                         <td colspan="2">
                              <span style="display: inline-block; min-width: 45px;">첨부</span> :
                                  <a href="<%=cp%>/notice/download?fileIdx=${vo.fileIdx}">${vo.originalFilename}</a>
                                  (<fmt:formatNumber value="${vo.fileSize/1024}" pattern="0.00"/> KByte)
                         </td>
                     </tr>
				</c:forEach>	
                		
						
						<!-- 이전글,다음글 (s) -->
					  
					<div class="btm_sup_list">
							<ul class="line_sup_next">
                              <li style="display: inline-block; min-width: 45px;">이전글 : </li> 
                            	  <c:if test="${not empty preReadDto}">
                                  	<a href="<%=cp%>/notice/article?${params}&noticeIdx=${preReadDto.noticeIdx}">${preReadDto.subject}</a>
                              	</c:if>					
                         	</ul>
               
	                    <ul class="line_sup_next">
	                    	<li style="display: inline-block; min-width: 45px;">다음글 : </li>
	                    		<c:if test="${not empty nextReadDto}">
	                              <a href="<%=cp%>/notice/article?${params}&noticeIdx=${nextReadDto.noticeIdx}">${nextReadDto.subject}</a>
	                          </c:if>
	                     </ul>
	                    </div> 
                 
						
						<!-- 이전글,다음글 (e) -->
					</div>
					
				</div>
			</div>
			<!-- //Contents End -->
		</div>
		<!-- //Contents Area -->

		<!--/ Contents End -->
	</div>
	<!-- /Contents Area -->
</div>
<!-- /Contaniner -->
