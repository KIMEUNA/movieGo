<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
   String cp = request.getContextPath();
%>

<script type="text/javascript">
jQuery(function() {
   jQuery(".im-wrap .lnb > ul > li").hover(
      function() {
         jQuery(this).addClass("on");
      },
      function() {
         jQuery(this).removeClass("on");
      }
   );
});
</script>

<!-- Header -->
   <div id="header">
      <div class="head">
         <h1><a href="<%=cp%>"><img src="<%=cp%>/res/images/h1_cgv.png" alt="CGV"></img></a></h1>
         <div class="sect-service">
            <h2>서비스 메뉴</h2>
            <ul class="gnb">
            <c:if test="${empty sessionScope.member}">
                    <li><a href="<%=cp%>/member/login" class="login" ><span>로그인</span></a></li>
               <li><a href="<%=cp%>/member/member" class="join"><span>회원가입</span></a></li>
            </c:if>
            <c:if test="${not empty sessionScope.member}">
               <li><a href="<%=cp%>/member/logout" class="logout" ><span>로그아웃</span></a></li>
               <li><a href="<%=cp%>/myinfo/mymain" class="mycgv required-login"><span>MY MOVIEGO</span></a></li>
            </c:if>
               <li><a href="<%=cp%>/notice/noticeList" class="customer"><span>공지사항</span></a></li>
            </ul>
         </div>
            
            <div class="im-wrap"> <!-- Important wrap -->
            <h2><img src="<%=cp%>/res/images/h2_cultureplex.png" alt="CULTUREPLEX"></h2>
            <!-- Local Navigation Bar -->
            <div class="lnb">
               <h2>CGV 주메뉴</h2>
               <ul id="gnb_list">
                  <li class="movie">
                     <a href="<%=cp%>/movies">영화</a>
                     <div class="sub-wrap">
                        <i></i>
                        <div class="smenu">
                           <ul>
                              <li><a href="<%=cp%>/gpa/gpa">차트/평점</a></li>
                           </ul>
                        </div>
                     </div>
                  </li>
                  <li class="booking"><a href="<%=cp%>/reserve">예매</a>
                     <div class="sub-wrap">
                        <i></i>
                        <div class="smenu">
                           <ul>
                              <li><a href="<%=cp%>/reserve">빠른예매</a></li>
                           </ul>
                        </div>
                     </div>
                  </li><!-- 
                  <li class="theaters"><a href="#">극장</a>
                     <div class="sub-wrap">
                        <i></i>
                        <div class="smenu">
                           <ul>
                              <li><a href="#">CGV 극장</a></li>
                              <li><a href="#">특별관</a></li>
                              <li class="last"><a href="#" title="새창" class="specialclub">Club서비스</a></li>
                           </ul>
                        </div>
                     </div>
                  </li>
                        <li class="culture"><a href="#">이벤트&amp;컬쳐</a>
                     <div class="sub-wrap">
                        <i></i>
                        <div class="smenu">
                           <ul>
                              <li><a href="#">이벤트</a></li>
                              <li><a href="#">티켓·팝콘스토어</a></li>
                              <li><a href="#">매거진</a></li>
                           
                           </ul>
                        </div>
                     </div>
                  </li> -->
               </ul>
            </div>
            <!-- /Local Navigation Bar -->
                <!-- Integrated search(통합검색) -->
                <div class="sect-srh">
               <h2>통합검색서비스</h2>
               <fieldset>
                  <legend>통합검색</legend>
                  <input type="text" title="통합검색" id="header_keyword" name="header_keyword" placeholder="통합검색">
                  <button type="button" class="btn-go-search" id="btn_header_search">검색</button>
               </fieldset>
            </div>
            <!-- /Integrated search(통합검색) -->
            <!-- Quick Phototicket -->
         </div>
      </div>
      
   </div>
   <!-- /Header -->

