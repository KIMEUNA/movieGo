<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>

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
                            <li  class="last">포인트</li>
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
	            <li >
                    <a href="<%=cp%>/myreserve/myreserve" >나의 예매내역 <i></i></a>
                </li>
	            <li class="on">
                    <a href="<%=cp%>/point/mypoint" >포인트 <i></i></a>
	            </li>            
	            <li>
                    <a href="<%=cp%>/member/pwdCheck" >나의정보<i></i></a>
	                <ul>
                         <li>
                            <a href="<%=cp%>/member/pwdCheck" >개인정보 변경</a>
                        </li>
	                    <li >
                            <c:if test="${sessionScope.member.id!='admin' }">
                            	<a href="<%=cp%>/member/pwdCheck?dropout">회원탈퇴</a>
                            </c:if>
                        </li>                        
	                </ul>
	            </li>
	        </ul>
	    </div>
    </div>
	<div class="col-detail" id="mycgv_contents">
	    
  <input type="hidden" id="isUSER" name="isUSER" value="N" />
    <div class="tit-mycgv">
	    <h3>포인트</h3>
	</div>

    <div class="tit-mycgv">
	    <h4>포인트 적립 및 사용내역</h4>
	</div>


    <div class="tbl-breakdown">
        <table>
            <colgroup>
                <col span="2" width="50%" />
            </colgroup>
            <thead>
                <tr>
	                <th scope="col">구분</th>
	                <th scope="col">내용</th>
                </tr>
            </thead>
            <tbody>
                <tr class="tooltip_list">
                	<th scope="row">
						<p style="text-align: center;"><strong>사용가능 포인트</strong></p>		
					</th>
                		<td>
                		<p style="text-align: center;"><fmt:formatNumber value="${dto.savePoint}" pattern="#,##0"/>p</p>
                		</td>
                </tr>               
            </tbody>
        </table>
    </div>
    

<div class="sect-use-expense">
    <form name="pointForm" method="post" >

    <div class="box-polaroid">
        <div class="box-inner">
            <strong class="period">조회기간</strong>
            <span id="period_wrap"></span>
            <p>
                <label for="startdate">시작일 입력</label><input type="date" id="startdate" name="startdate"  value="${startdate }"/> ~
                <label for="enddate">종료일 입력</label><input type="date" id="enddate" name="enddate"   value="${enddate }"/>
                <button type="button" id="btn_search" class="round inblack"><span>조회하기</span></button>
            </p>
        </div>
    </div>
    </form>
</div>

	<div class="tbl-data">
		<table summary="상품명, 구매극장, 결제금액, 적립일, 적립금액 표기">
			<caption>CGV 영화 관람권 사용내역 리스트</caption>
			<colgroup>
				<col width="18%"/>
				<col width="18%">
				<col width="18%">
				<col width="18%">
			</colgroup>
			<thead>
				<tr>
					<th scope="col">구매 구분</th>
					<th scope="col">구매 극장</th>
					<th scope="col">적립일</th>
					<th scope="col">적립</th>
				</tr>
			</thead>
		<tbody>      
			<c:if test="${empty list}">
                <tr>
                    <td colspan="4" class="nodata">내역이 존재하지 않습니다.</td>
                </tr>
			</c:if>
			<c:if test="${not empty list}">
				<c:forEach var="dto" items="${list}" varStatus="stat">
					<tr align="center">
	                    <td>${dto.kind}</td>
	                    <td>${dto.cinemaName}</td>
	                    <td>${dto.regdate}</td>
	                    <td><fmt:formatNumber value="${dto.savePoint}" pattern="#,##0"/>p</td>
	                </tr>
				</c:forEach>
			</c:if>
			</tbody>
		</table>
	</div>

<div class="paging">
	${paging}
</div>


<script type="text/javascript">
//<![CDATA[
    (function ($) {
        $(function () {

            $('#btn_search').on('click', function () {
        		if(! $("#startdate").val()) {
        			$("#startdate").focus();
        			return;
        		}
  
        		if(! $("#enddate").val()) {
        			$("#enddate").focus();
        			return;
        		}
          		
        		var f=document.pointForm;
        		f.action="<%=cp%>/point/mypoint";
        		f.submit();
            });
            
            $('#period_wrap').datePeriod({
                'start': $('#startdate'),
                'end': $('#enddate'),
                'data': [
                    { 'title': '2주일', 'data-period': 2, 'data-type': 'w' },
                    { 'title': '1개월', 'data-period': 1, 'data-type': 'm' },
                    { 'title': '3개월', 'data-period': 3, 'data-type': 'm' },

                ]
            });


        });
        
        
        $(function (){
        	$('#period_wrap button').click(function(){
        		var data= $(this).attr("data-period");
        		
                var date=new Date();
                var s, y, m, d;
                y=date.getFullYear();
                m=date.getMonth()+1;
                d=date.getDate();
                if(d<10) d="0"+d;
                if(m<10) m="0"+m;
                
                $("#enddate").val(y+"-"+m+"-"+d);
                var arr = $("#enddate").val().split('-');
                
                var dt = new Date(arr[0], arr[1]-1, arr[2]);       		
                var dt_v = new Date(arr[0], arr[1]-1, arr[2]);
                
                var Denddate;
                if(data=="1") {
                    dt_v.setMonth(dt.getMonth() - 1);
                  } else if(data=="2") {
                    dt_v.setDate(dt.getDate() - 14);
                } else if(data=="3") {
                	dt_v.setMonth(dt.getMonth() - 3);
                }
                m=dt_v.getMonth()+1;
                d=dt_v.getDate();
                if(d<10) d="0"+d;
                if(m<10) m="0"+m;
                Denddate = dt_v.getFullYear() + '-' + m + '-' + d;  
                
                $("#startdate").val(Denddate);
        	});
        	
        });
    })(jQuery);

//]]>
</script>
	</div>
</div>
</div>
		</div>
	<!-- /Contaniner -->