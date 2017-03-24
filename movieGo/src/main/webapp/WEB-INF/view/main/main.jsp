<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String cp = request.getContextPath();
%>

<link rel="stylesheet" href="<%=cp%>/res/css/swiper.min.css" >
<script type="text/javascript" src="<%=cp%>/res/js/swiper.min.js"></script>
<style>
    .swiper-container {
        width: 100%;
        height: 100%;
    }
    .swiper-slide {
        text-align: center;
        font-size: 18px;
        background: #fff;
        /* Center slide text vertically */
        display: -webkit-box;
        display: -ms-flexbox;
        display: -webkit-flex;
        display: flex;
        -webkit-box-pack: center;
        -ms-flex-pack: center;
        -webkit-justify-content: center;
        justify-content: center;
        -webkit-box-align: center;
        -ms-flex-align: center;
        -webkit-align-items: center;
        align-items: center;
    }
    #layer_fixed
	{
		padding-top:29px;
		padding-left:150px;
	    width:100%;
	    position:absolute;
	    font-size: 20px;
	 	color: #37474f;
	 	font-weight: bold;
	 	letter-spacing: -0.03em;
  }
  
  /*image grid*/
  #carousel {
  display: block;
  height: auto;
  margin: 0 auto;
  -webkit-perspective: 80px;
  perspective: 800px;
  position: relative;
  top: 150px;
  width: 800px;
}

#container {
  display: block;
  height: 200px;
  margin: 0 auto;
  transform: rotateY(0deg);
  -webkit-transform-origin: center bottom 0;
  transform-origin: center bottom 0;
  -webkit-transform-style: preserve-3d;
  transform-style: preserve-3d;
  -webkit-transition: all 1s ease-in-out;
  transition: all 1s ease-in-out;
  width: 300px;
}

item {
  display: block;
  margin: 0;
  padding: 0;
  width: 200px;
  transform: translateZ(300px);
  position: absolute;
}

item img { width: 100%; }

.tc-btn-container {
  display: block;
  float: left;
  height: 35px;
  margin-top: -12.5px;
  position: absolute;
  top: 50%;
  width: 100%;
}

.tc-next {
  background-color: #333;
  color: white;
  display: block;
  float: right;
  font-size: 12px;
  padding: 10px;
  width: auto;
  cursor: pointer;
}

.tc-prev {
  background-color: #333;
  color: white;
  display: block;
  float: left;
  font-size: 12px;
  padding: 10px;
  width: auto;
  cursor: pointer;
}

</style>

<script type="text/javascript">

// 메인 슬라이드 ************************************************************//


$(function(){
	var swiper = new Swiper('.swiper-container', {
	    pagination: '.swiper-pagination',
	    nextButton: '.swiper-button-next',
	    prevButton: '.swiper-button-prev',
	    paginationClickable: true,
	    spaceBetween: 30,
	    centeredSlides: true,
	    autoplay: 1500,
	    autoplayDisableOnInteraction: false
	});
});



// 이미지 그리드 ************************************************************//
$(document).ready(function($){

  var crotation;
  var rotateto = 0;
  var halfrotation = 180;
  
  function tcRotate(deg){  
      $('#container').css({
          'transform'         	 : 'rotateY('+ deg +'deg)',
          '-webkit-transform' : 'rotateY('+ deg +'deg)'
      });
  }
  
  $('item').on('click', function(e){
      e.preventDefault();
      
      crotation = $('#container').attr('tcc-rotation');
      rotation = $(this).attr('tc-rotation');       
      rotateto = crotation - rotation;
      tcRotate(rotateto);
      crotation = rotateto;
      
  });
  
  $('.tc-next').on('click', function(e){
      e.preventDefault();
      rotateto -= 60;
      tcRotate(rotateto);
  });
  $('.tc-prev').on('click', function(e){
      e.preventDefault();
      rotateto += 60;
      tcRotate(rotateto);
  });

});

</script>


			<!-- 공간 만들어줌 허전해서 -->
	<div id="ctl00_sect_txt_banner" class="sect_txt_banner">
		<c:if test="${empty sessionScope.member}">
			<div class="inner">
				<img src="<%=cp%>/res/images/main_season_bn(1).jpg" border="0">
			</div>
		</c:if>
		<c:if test="${not empty sessionScope.member}">
			<div class="inner">
				<label id="layer_fixed">
						    		${member.name} 님</label>
				<img src="<%=cp%>/res/images/main_season_bn(1).jpg" border="0">
			</div>
		</c:if>
	</div>

	<!-- Contaniner -->
	<div id="contaniner" class="bg-bricks main bg-bricks"><!-- 벽돌 배경이미지 사용 시 class="bg-bricks" 적용 / 배경이미지가 없을 경우 class 삭제  -->
		<div id="contents" >
            
            <!-- Contents Start -->
			<div class="swiper-container">
        		<div class="swiper-wrapper">
        		<c:forEach var="movie" items="${movieList}" varStatus="stat">
		            <div class="swiper-slide">
		            	<img src="<%=cp%>/res/images/${movie.movieIdx}_main.png" alt="" style="width: 100%; height: 100%;"></img>
		            </div>
            	</c:forEach>
        		</div>
        <!-- Add Pagination -->
        	<div class="swiper-pagination"></div>
        <!-- Add Arrows -->
        	<div class="swiper-button-next"></div>
        	<div class="swiper-button-prev"></div>
    	</div>




		<%-- <h3><img src="<%=cp%>/res/images/h3_movie_selection.gif" alt="MOVIE SELECTION"></img></h3>
		<div class="cols-movie">
			<!-- <div id="Selection_L" class="col-slider"></div>
			<div id="Selection_R" class="col-ad"></div> -->			
		</div> --%>


		<h3><img src="<%=cp%>/res/images/h3_movie_selection.gif" alt="MOVIE SELECTION"></img></h3>
<ul class="tab-menu">
	<!-- <li class="on">
        <a href="#" data-filter-type="08" title="현재 선택됨">MOVIEGO</a>
    </li> -->
	<li>
        <a  data-filter-type="02">&nbsp;</a>
    </li>
	<li>
        <a  data-filter-type="03">Best Movie Cut</a>
    </li>
	<li class="last">
        <a data-filter-type="04">&nbsp;</a>
    </li>
</ul>
<div class="sect-event">
	<ul>
    
		    <li>
                <a>
                    <img src="<%=cp%>/res/images/22_best.png"></img>
                </a>
            </li>
        
		    <li>
                <a>
                    <img src="<%=cp%>/res/images/3_best.png"></img>
                </a>
            </li>
        
		    <li>
                <a>
                    <img src="<%=cp%>/res/images/16_best.png"></img>
                </a>
            </li>
        
		    <li>
                <a>
                    <img src="<%=cp%>/res/images/17_best.png"></img>
                </a>
            </li>
        
	</ul>
</div>
<div class="cols-banner">
	<div class="col-ad">
		<div class="box-com">
		    <div class="box-inner">
                <a href="#"><img src="<%=cp%>/res/images/mainfooter_banner_left.png"></img></a>
            </div>
		</div>
	</div>
	<div class="col-hd">
		<a href="#"><img src="<%=cp%>/res/images/main_moviecollage.jpg"></img></a>
	</div>
	<div class="col-collage">
		<div class="box-com">
		    <div id="Branding_R" class="box-inner">
		    	<a href="#"><img src="<%=cp%>/res/images/mainfooter_banner_right.png"></img></a>
            </div>
		</div>
	</div>
</div>

<div id="ctl00_PlaceHolderContent_wrap_notice" class="sect-notice-info cf">
	<h3>공지사항</h3>
    <div class="sect-notice-list cf">
        <div class="inner" style="overflow: hidden; position: relative; height: 35px;">
            <ul style="position: absolute; margin: 0px; padding: 0px; top: 0px;">
       			<li class="cf" style="margin: 0px; padding: 0px; height: 35px;">
	                <a href="<%=cp%>/notice/article?noticeIdx=${notice.noticeIdx}">
                    ${notice.subject}</a>
                    <span>${notice.regdate}</span>
                </li>
            </ul>
        </div>
    </div>
</div>
		</div>
	</div>
	
	
	
	