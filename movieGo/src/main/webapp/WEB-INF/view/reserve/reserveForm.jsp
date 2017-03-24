<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String cp=request.getContextPath();
%>

<style type="text/css">
[data-tooltip-text]:hover {
	position: relative;
}

[data-tooltip-text]:hover:after {
	background-color: #000000;
	background-color: rgba(0, 0, 0, 0.8);

	-webkit-border-radius: 5px;
	-moz-border-radius: 5px;
	border-radius: 5px;

	color: #FFFFFF;
	font-size: 12px;
	content: attr(data-tooltip-text);

	top: 0;
	left: 0;    
	padding: 5px 5px;
	position: absolute;
	width: 70px;

	z-index: 9999;
}
</style>

<script type="text/javascript">
function timeSchedule() {
	
	var url = "<%=cp%>/reserve/schedule";
	var query = "movieIdx="+movieIdx+"&cinemaIdx="+cinemaIdx+"&date="+date;
	
	jQuery.ajax({
		type:"post",
		url:url,
		data:query,
		dataType:"json",
		success:function(data) {
			
			if(data.scheduleList.length != 0) {
				jQuery(".step1 .section-time .col-body .placeholder ").addClass("hidden");
				
				var out = "";
				var pre = "";
				var next = "";
				var multiplexIdxPre = "";
				var multiplexIdxNext = "";
				
				 for (var i = 0; i < data.scheduleList.length; i++) {
					 var $scheduleIdx = data.scheduleList[i].scheduleIdx;
					 var multiplexIdx = data.scheduleList[i].multiplexIdx;
					 var movieIdx = data.scheduleList[i].movieIdx;
					 var multiplexGrade = data.scheduleList[i].multiplexGrade;
					 var multiplexName = data.scheduleList[i].multiplexName;
					 var seat = data.scheduleList[i].seat;
					 var count = data.scheduleList[i].count;
					 var inning = data.scheduleList[i].inning;
					 var runTime = data.scheduleList[i].runTime;
					 var startTime = data.scheduleList[i].startTime;
					 var endTime = data.scheduleList[i].endTime;
					 
					 if(i < data.scheduleList.length-1)
						 multiplexIdxNext = data.scheduleList[i+1].multiplexIdx;

					 if(multiplexIdx != multiplexIdxPre) {
						pre = "<div class='theater'>";
						pre+= "<span class='title'>";
						pre+= "<span class='name'>"+multiplexGrade+"D</span>";
						pre+= "<span class='floor'>"+multiplexName+"</span>";
						pre+= "<span class='seatcount'>("+seat+")석</span>";
						pre+= "</span><ul>";
					
						out+=pre;
					}
					 
					 var cla="";
					 if(scheduleIdx==$scheduleIdx)
						 cla=" class='selected'";
					 
					out+= "<li data-index=\""+$scheduleIdx+"\" data-movie=\""+movieIdx+"\""+cla+">"; 
					out+= "<a data-tooltip-text=\"종료 : "+endTime+"\" class='btnTime' href=''#' onclick='return false;'>";
					out+= "<span class='time'>";
					out+= "<span data-time=\""+$scheduleIdx+"\">"+startTime+"</span></span>";
					out+= "<span class='count'>  "+count+" 석</span>";
					out+= "<span class='sreader'>"+endTime+"</span>";
					out+= "<span class='sreader mod'></span></a></li>";
					
					
					if(multiplexIdx != multiplexIdxNext) {
						next = "</ul></div>";
						out+=next;
					}
					multiplexIdxPre = data.scheduleList[i].multiplexIdx;
				}
				 jQuery("#time_info").html(out);
			}
		}, 
		error:function(e) {
			console.log(e.responseText);
		}
	});
};
</script>

<!-- step1 -->
<div class="step step1" style="height: 595px; display: block;">


	<!-- MOVIE 섹션 -->
	<div class="section section-movie" style="height: 593px;">
		<!-- col-head -->
		<div class="col-head" id="skip_movie_list">
			<h3 class="sreader">영화</h3>
		</div>
		
		<!-- col-body -->
		<div class="col-body" style="height: 560px;">
			<!-- 영화선택 -->
			<div class="movie-select">
			
				<div class="tabmenu">
					<span class="side on"></span> 
					<a href="#" class="button menu1 selected">전체</a> 
					<span class="side on"></span>
				</div>
				
				<div class="sortmenu">
					<a href="#" onclick="return false;" id="movieSortRankBtn" class="button btn-rank selected">예매율순</a>
					<a href="#" onclick="return false;" id="movieSortNameBtn" class="button btn-abc">가나다순</a>
				</div>
				
				<div class="movie-list nano" id="movie_list" style="height: 462px;">
					<ul class="content" tabindex="-1" style="right: -17px;">
						
						<!-- db에 데이터 넣고 테스트 하기 !!!!!!!!!!! -->
						
						<c:forEach var="movie" items="${movieList}" varStatus="stat">
						
							<li data-index="${movie.movieIdx}" class="${movie.gradeName}${movie.movieIdx==dto.getMovieIdx() ? ' selected' : '' }">
								<a href="#" class="btnMovie" onclick="return false;">
									<span class="icon">&nbsp;</span>
									<span class="text">${movie.movieName}</span>
									<span class="sreader"></span>
								</a>
							</li>
							
							<c:if test="${stat.last}">
								<c:forEach var="none" items="${noneMovies}">
									<li class="${none.gradeName} dimmed">
										<a href="#" class="btnMovie" onclick="return false;">
											<span class="icon">&nbsp;</span>
											<span class="text">${none.movieName}</span>
											<span class="sreader"></span>
										</a>
									</li>
								</c:forEach>
							</c:if>
							
						</c:forEach>
						
					</ul>
					
					
					
				</div>
				 
			</div>
		</div>
	</div>
	
	
	<!-- THEATER 섹션 -->
	<div class="section section-theater" style="height: 593px;">
		<!-- col-head -->
		<div class="col-head" id="skip_theater_list">
			<h3 class="sreader">극장</h3>
		</div>
		
		<!-- col-body -->
		<div class="col-body" style="height: 560px;">
		
			<!-- 극장선택 -->
			<div class="theater-select">
			
				<div class="tabmenu">
					<span class="side on"></span> 
					<a href="#" onclick="return false;" class="button menu1 selected">전체</a>
					<span class="side"></span>
				</div>
				
				<div class="theater-list" style="height: 388px;">
				
					<div class="theater-area-list" id="theater_area_list">
						<ul>
							<c:forEach var="city" items="${cityList}" varStatus="city_stat">	
								<li class="${city.cityIdx==dto.getCityIdx() ? 'selected' : '' }" data-index="${city.cityIdx}">
									<a href="#" class="btnCity" onclick="return false;">	<!-- 지역 선택. AJAX로 처리 -->
										<span class="name">${city.cityName}</span>
										<span class="count">(${city.cinemaCount})</span>
									</a>
									<div class="area_theater_list nano" style="height: 388px;">
										<ul class="content" style="right: -17px;">
																					
											<c:if test="${city.cityIdx==dto.getCityIdx()}">
												<c:forEach var="cinema" items="${cinemaList}" varStatus="stat">
													<li class="${cinema.cinemaIdx==dto.getCinemaIdx() ? 'selected' : '' }" 
														data-index="${cinema.cinemaIdx}" 
														style="display: list-item;">		<!-- 극장 선택. AJAX로 처리 -->
														<a href="#" class="btnCinema" onclick="return false;">${cinema.cinemaName}
															<span class="sreader"></span>
														</a>
													</li>
													
													<c:if test="${stat.last}">
														<c:forEach var="none" items="${noneCinemas}">
															<li class="dimmed" style="display: list-item;">		
																<a href="#" class="btnCinema" onclick="return false;">${none.cinemaName}
																	<span class="sreader"></span>
																</a>
															</li>
														</c:forEach>
													</c:if>
													
												</c:forEach>
											</c:if>
										</ul>
									</div>
								</li>
							</c:forEach>
						</ul>
					</div>
					
				</div>
			</div>
		</div>
	</div>
	
	
	<!-- DATE 섹션 -->
	<div class="section section-date" style="height: 593px;">
		<div class="col-head" id="skip_date_list">
			<h3 class="sreader">날짜</h3>
		</div>
		<div class="col-body" style="height: 560px;">
			<!-- 날짜선택 -->
			<div class="date-list nano" id="date_list" style="height: 522px;">
				<ul class="content" style="right: -17px;">
				
					<c:forEach var="date" items="${dateList}" varStatus="stat">
					
						<c:if test="${stat.first || date.getDates().getMonth() != nextMonth}">
							<li class="month dimmed">
								<div>
									<span class="year">${date.getDates().getYear()+1900}</span>
									<span class="month">${date.getDates().getMonth()+1}</span>
									<div></div>
								</div>
							</li>
						</c:if>
						
						<li data-index="${stat.index}" data-date="${date.getDates().getYear()+1900}.${date.getDates().getMonth()+1}.${date.getDates().getDate()} (${date.getDay()})" 
								class="${date.getDates().getDay()==0 ? 'day day-sun' : 
																		date.getDates().getDay()==6 ? 'day day-sat' : 'day'} ${stat.index==dateIdx ? ' selected' : ''}">
							<a href="#" class="btnDate" onclick="return false;">
								<span class="dayweek">${date.getDay()}</span>
								<span class="day">${date.getDates().getDate()}</span>
								<span class="sreader"></span>
							</a>
						</li>
						<c:set var="nextMonth" value="${date.getDates().getMonth()}"/>
					</c:forEach>
						
				</ul>
			</div>
		</div>
	</div>
	
	
	<!-- TIME 섹션 -->
	<div class="section section-time" style="height: 593px;">
		<div class="col-head" id="skip_time_list">
			<h3 class="sreader">시간</h3>
		</div>
		<div class="col-body" style="height: 560px;">
			<!-- 시간선택 -->
			<div class="time-option">
				<span class="morning">조조</span><span class="night">심야</span>
			</div>
			<div class="placeholder">영화, 극장, 날짜를 선택해주세요.</div>
			
			
			
			<div class="time-list nano">
				<div id="time_info" class="content scroll-y" tabindex="-1" style="right: -17px;"></div>
			</div>	
			
			
		</div>
	</div>
</div>
<!-- //step1 -->



						