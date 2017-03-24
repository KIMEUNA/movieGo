<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String cp=request.getContextPath();
	response.setStatus(HttpServletResponse.SC_OK);
%>

<div class="bodyFrame1" style="min-height: 450px;">
<div style="margin: 30px auto; width: 300px;">
	<div style="margin:10px; height: 50px; line-height: 150%; text-align: center">접근 권한이 없습니다.</div>
	<div style="margin:10px; height: 50px; text-align: center;">
	    <input type="button" value=" 메인화면으로 이동 >> "
	              class="moveButton"
	              onclick="javascript:location.href='<%=cp%>/';">
	</div>  
</div>

</div>
