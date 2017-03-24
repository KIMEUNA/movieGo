<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String cp = request.getContextPath();
%>


<script type="text/javascript">
    $movieIdx = "${movieIdx}";
    
    $(function(){
    	listGpa($movieIdx);    	
    });
    
function movieLike(movieIdx) {
	var mid="${sessionScope.member.memberIdx}";		
	if(!mid){
		if(confirm("로그인이 필요한 서비스입니다.\n확인을 누르시면 로그인 창으로 이동합니다.")){login();};
		return;
	}
	
	var url="<%=cp%>/gpa/movieLike";
	var query="movieIdx="+movieIdx;
	query+="&memberIdx="+mid;
	
	alert(query);
	
	$.ajax({
		type:"POST"
		,url:url
		,data:query
		,dataType:"JSON"
		,success:function(data){
			var state=data.state;

			if(state=="only") {
				alert("이미 누르신 영화입니다.");
				return;
			}
				
			movieList("${pageNo}");
	
			
		}
		,error:function(e){
			console.log(e);
		}
	});
}     
    	
</script>

<div class="sect-gradelist" style="height: 432px; background: #333333;">
				<h4 class="hidden">평점 영화 리스트</h4>
				<div class="slider" id="gradeList">

			<div class="item-wrap">
						<div class="item" style="width: 980px; height: 432px;">
							<div class="sect-chart gradelist">
								<ul data-page="0"  id="slide_banner" style="height: 424px;">
		<c:forEach var="movie" items="${movieList}" varStatus="stat">

									<%-- <li  class="${movie.movieIdx==movieIdx ? 'on' : ''}" > --%>
									<li  class="activemovie" style="height: 404px;" >
										<div class="box-image" >
											<a  href="javascript:listGpa(${movie.movieIdx});"> 
											<span class="thumb-image"> 
											<img src="<%=cp%>/res/images/${movie.movieIdx}_185.jpg" 
													alt="${movie.movieName} 포스터"
													style="width: 100%; height: 100%;" />
													<span class="ico-grade grade-${movie.grade}">${movie.grade}
														<c:if test="${movie.grade != '전체' }">세 이상</c:if>
													</span>
											</span>
											</a> <span class="screentype"></span>
										</div>
										<div class="box-contents">
											<strong class="title">${movie.movieName}</strong>
											<div class="score">
												<strong class="percent">예매율<span>${movie.reservePer}%</span></strong>
											<!-- 	<div class="egg-gage small">
													<span class="egg great"></span> 
													<span class="percent">91%</span>
												</div> -->
											</div>
											<span class="txt-info"> <strong> ${movie.regdate} <span> 개봉</span>
											</strong>
											</span> <span class="like">
												<%-- <button class="btn-like" value="${movie.movieIdx}">영화 찜하기</button>  --%>
												<button class="btn-like" onclick="movieLike('${movie.movieIdx}');">영화 찜하기</button> 
												<span class="count"> <strong><i>${movie.movieLike}</i><span>명이
															선택</span></strong> <i class="corner-RT"></i><i class="corner-LT"></i><i
													class="corner-LB"></i><i class="corner-RB"></i><i
													class="corner-arrow"></i>
											</span><a class="link-reservation" href="<%=cp%>/reserve?movieIdx=${movie.movieIdx}">예매</a>
											</span>
										</div>
									</li>				
							
									
</c:forEach>
			</ul>
							</div>
						</div>
					</div>

					<button type="button" class="btn-prev dim" onclick="slideMovie();"></button>
					<button type="button" class="btn-next" onclick="slideMovie();"></button>
				</div>

			</div>