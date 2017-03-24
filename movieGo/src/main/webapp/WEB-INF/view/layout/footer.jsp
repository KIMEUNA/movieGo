<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String cp = request.getContextPath();
%>

<footer class="bs-docs-footer" role="contentinfo">
	<div class="container">
		<!-- Footer -->
	<div id="footer">
		<div class="foot">
			<div class="sect-cinfo">
				<p class="logo">MovieGo 로고</p>
				<h2>MovieGo 회사소개 및 정책</h2>
				<div class="policy">
					<ul>
						<li><a href="#" target="_blank">회사소개</a></li>
						<li><a href="#" target="_blank">IR</a></li>
						<li><a href="#" target="_blank">채용정보</a></li>
						<li><a href="#" target="_blank">광고문의</a></li>
						<li><a href="#" target="_blank">제휴문의</a></li>
						<li><a href="#">이용약관</a></li>
                        <li><a href="#">편성기준</a></li>
						<li><a href="#" class="empha-red">개인정보처리방침</a></li>
						<li><a href="#">법적고지</a></li>
						<li><a href="#">이메일주소무단수집거부</a></li>
						<li><a href="#">상생경영</a></li>
						<li><a href="#">사이트맵</a></li>
					</ul>
				</div>
				<div class="share">
					<a href="#" target="_blank" class="facebook" title="새창">페이스북</a><a href="#" target="_blank" class="twitter" title="새창">트위터</a><a href="#" target="_blank" class="instagram" title="새창">인스타그램</a>
				</div>
				<div class="address">
					<address>KH 정보교육원 4층 오른쪽 뒷자리아이들</address>
					<p class="vl">
						<span>대표이사 : 정지영</span><span>사업자등록번호 : 000-00-00000</span><span>통신판매업신고번호 : 역삼 8282</span>
					</p>
					<p class="vl">
						<span>개인정보보호 책임자 : 마케팅 실장 조우성</span><span>대표이메일 : moviego@movemove</span><span>MOVIEGO고객센터 : 0000-0000</span>
					</p>
					<p class="copyright">© 2017 MOVIEGO. All Rights Reserved</p>
				</div>
				<div class="familysite">
					<label for="familysite" class="hidden">MOVIEGO그룹 계열사 바로가기</label>
					<select id="familysite">
						<option value="">계열사 바로가기</option>
                        <optgroup label="MOVIEGO그룹">
<option value="#">MOVIEGO주식회사</option>
</optgroup><optgroup label="엔터테인먼트 &amp; 미디어">
<option value="#">MOVIEGO헬로비전</option>
<option value="#">MOVIEGO파워캐스트</option>
</optgroup><optgroup label="식품 &amp; 식품서비스">
<option value="#">MOVIEGO제당</option>
<option value="#">MOVIEGO웨이</option>
<option value="#">MOVIEGO푸드빌</option>
</optgroup><optgroup label="신유통">
<option value="#">MOVIEGO쇼핑</option>
<option value="#">MOVIEGO통운</option>
<option value="#">MOVIEGO텔레닉스</option>
<option value="#">MOVIEGO네트웍스</option>
</optgroup><optgroup label="인프라">
<option value="#">MOVIEGO건설</option>
</optgroup>
					</select>
					<button type="button" title="새창" onclick="goFamilySite()">GO</button>
				</div>
			</div>
		</div>
        <!-- Float Ad -->

        <div class="adFloat2" style="display:none">

            <!-- <iframe src="WEB-INF/view/sub@Popicon.html" width="154" height="182" frameborder="0" scrolling="no" topmargin="0" leftmargin="0" marginwidth="0" marginheight="0" allowtransparency="true" id="ad_float1" title="광고-모아나" style="display: none;"></iframe> -->
        </div>
        <!-- <script type="text/javascript">            OpenAD();</script> -->
        <!-- //Float Ad -->
	</div>
	<!-- /Footer -->

	</div>
</footer>
