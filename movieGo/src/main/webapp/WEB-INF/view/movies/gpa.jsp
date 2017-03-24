<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
   String cp = request.getContextPath();
%>

<style>
a {
   cursor: pointer;
}

 .reportForm {
   margin: 0 auto;
   width:300px;
   height:300px;

   text-align:center;

   margin-top:-150px; 
   margin-left:-100px;
   border:1px solid #333;
} 

.write_box input {
   position: relative;
   margin: 0 auto;
   margin-top:20%;
    width: 250px;
    height: 150px;
    line-height: 13px;
    border-right: solid 1px #999;
    border-left: 0;
    border-top: 0;
    border-bottom: 0;
    background-color: #fdfcf0;
   text-align:center;
   overflow:auto;
}
.header_text {
   margin-top:10%;
   color:#FFF;
   display: block;
    font-size: 22px;
    font-family: 'NanumGothicBold', sans-serif;
    font-weight: normal;
}
#reportbutton {
   margin-top:10%;
   width:300px;
   height:20%;   
}
#reporticon {
   width:30px;
   height:30px;
}

</style>
   <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
     <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
   
   <script type="text/javascript" src="<%=cp%>/res/js/gtm.js"></script>
   <script type="text/javascript" src="<%=cp%>/res/js/Chart.custom.js"></script>
   <script type="text/javascript" src="<%=cp%>/res/js/jquery.bxslider.min.js"></script>
   


<script type="text/javascript">

var $movieIdx = -1;

$(function(){
   movieList(1);
});

// 평점 리스트    ******************************************************************//
var sMemberIdx="-1";
function listGpa(movieIdx) {
   $movieIdx = movieIdx;
   sMemberIdx="-1";
   
   listGpaPage(1);
}


// 평점 리스트 넣기 ***************************************************************//

function listGpaPage(page){
   var url="<%=cp%>/gpa/list";
   
   $.get(url,{movieIdx:$movieIdx, page:page, memberIdx:sMemberIdx},function(data){
      $("#gpalist").html(data);
   });
}


//내평점 *********************************************************************//
function myGpa() {
      var mid="${sessionScope.member.memberIdx}";
      if(!mid){
         if(confirm("로그인이 필요한 서비스입니다.\n확인을 누르시면 로그인 창으로 이동합니다.")){login();};
         return;
      }             
       
      sMemberIdx=mid;
      listGpaPage(1);
} 


// 무비리스트 페이징 *************************************************************//
function movieList(pageNo) {
   // ajax paging 부분
   var url="<%=cp%>/gpa/movielist";
   var query="pageNo="+pageNo;
   
   
   $.ajax({
      type:"post"
      ,url:url
      ,data:query
      ,success:function(data){
         printMovieList(data);
      }
      ,error:function(e){
         console.log(e.responseText);
      }
   });

}

// 무비리스트 넣기 *************************************************************//
function printMovieList(data) {   
   $("#movielist").html(data);
}

// 무비슬라이드 **************************************************************//
function slideMovie() {
   $( function () {
       var movieSlider = $( '#slide_banner' ).bxSlider( {
           mode: 'horizontal',   
//           speed: 500,        
           pager: false,            
           moveSlides: 4,       
           slideWidth: 225,   
           minSlides: 4,         
           maxSlides: 4,         
           slideMargin: 5,       
           auto: false,           
           autoHover: true,     
           controls: false
       });
       

      //이전 버튼을 클릭하면 이전 슬라이드로 전환
       $(".btn-prev dim").on( "click", function () {
          movieSlider.goToPrevSlide(); 
           return false;  
       } );

      //다음 버튼을 클릭하면 다음 슬라이드로 전환
       $( "#btn-next" ).on( "click", function () {
          movieSlider.goToNextSlide(); 
           return false;
       } );
   });

}



// 영화 클릭 시 이벤트처리    ****************************************************************//
$(function(){
     var btn = $(".sect-chart gradelist > ul");
     btn.find(".activemovie").click(function(){ 
      btn.removeClass(".on");
      $(this).parent().addClass(".on");
    });
});


// 로그인창 이동 **********************************************************************//
function login() {
   location.href="<%=cp%>/member/login";
}

// writeGpa berforeSend ************************************************************//
function check() {
   
   if(! $.trim($("#textContent").val()) ) {
      $("#textContent").focus();
      return false;
   }    
   return true;
} 

// 멤버로 뺀것들 **********************************************************************//
var $mid;
var $cinemaName;
var $starttime;
var $reserveIdx;


// dialog success -> 평점작성 **********************************************************// 
function writeGpa(){
   
   var content=$.trim($("#textContent").val());
   mid="${sessionScope.member.memberIdx}";
   
   var query= "movieIdx="+$movieIdx;
   query+="&memberIdx="+mid;
   query+="&content="+content;
   query+="&reserveIdx="+$reserveIdx;
   
   alert(query);
   
   if(! content) {
      alert("내용을 입력해 주세요.");
      $("#textContent").focus();
      return false;
   }


   $.ajax({
      type:"POST"
      ,url:"<%=cp%>/gpa/writeGpa"
      ,data:query
      ,dataType:"JSON"
      ,success:function(data){
         //$content=data.content;
         $("#textContent").html(data);
         $content= $("#textContent").html(data);         
         
         var state=data.state;
         if(state=="false") {
            alert("평점게시는 한사람당 한개만 가능합니다.");
            $("#textContent").val("");
            return false;
         }            
         
         listGpaPage(1);
         $("#textContent").val("");    
         
         
      }
      ,beforeSend:check
      ,error:function(e){
         console.log(e);
      }
   });
}


//var movieName;
// 모달 dialog *********************************************************************//
$(function() {
   var dialog;
   
    dialog = $( ".diary-register-wrap" ).dialog({
      autoOpen: false,
      height: 420,
      width: 750,
      modal: true,
      buttons: {
      
        "게시" : function() {
           writeGpa();
           dialog.dialog( "close" );
        }
        ,"취소": function() {
          $("#textContent").val("");   
          dialog.dialog( "close" );
          
        }
      }
    });
   
    // 평점작성 버튼 클릭
    $( ".link-gradewrite" ).on( "click", function() {
       var mid="${sessionScope.member.memberIdx}";
       if(!mid){
          if(confirm("로그인이 필요한 서비스입니다.\n확인을 누르시면 로그인 창으로 이동합니다.")){login();};
          //alert("로그인이 필요한 서비스입니다.");
          return;
       }      
       // ajax로 내가 이 영화를 봤는지 안봤는지
       mid="${sessionScope.member.memberIdx}";
       movieIdx=$movieIdx ;
       
       var query= "movieIdx="+movieIdx;
       query+="&memberIdx="+mid;
       
       alert(query);
       
       $.ajax({
          type:"POST"
          ,url:"<%=cp%>/gpa/myMovie"
          ,data:query
          ,dataType:"JSON"
          ,success:function(data){
             var state=data.state;
             if(state=="true") {
                $cinemaName = data.dto.cinemaName;
                $multiplexName=data.dto.multiplexName;
                $starttime = data.dto.starttime;
                $reserveIdx=data.reserveIdx;
                $cnt=data.dto.cnt;
                $movieName=data.dto.movieName;
                $poster=data.dto.poster;
                $reserveIdx=data.dto.reserveIdx;
                
                $("#starttime").html($starttime);
                $("#cinemaName").html($cinemaName);
                $("#multiplexName").html($multiplexName);
                $("#cnt").html($cnt);
                $("#movieName").html($movieName);
                $("#poster").html($poster);

                //alert("movieName "+movieName);
                
                dialog.dialog( "open" );
             } else if (state=="false") {
                alert("영화를 관람 하신 후에 평점게시가 가능합니다.");
             } else if(state=="only") {
                alert("평점게시는 한사람당 한개만 가능합니다.");
             }
          }
          ,error:function(e) {
             alert(e);
          }
       });
    });
  });
 

   
</script>

<div id="contaniner" class="bg-bricks main bg-bricks">
   <!-- 벽돌 배경이미지 사용 시 class="bg-bricks" 적용 / 배경이미지가 없을 경우 class 삭제  -->

   <!-- LineMap -->

   <div id="ctl00_navigation_line" class="linemap-wrap">
      <div class="sect-linemap">
         <div class="sect-bcrumb">
            <ul>
               <li><a href="<%=cp%>"><img alt="home"
                     src="<%=cp%>/res/images/btn_home.png"></img></a></li>

               <li><a href="">영화</a></li>

               <li class="last">차트/평점</li>
            </ul>
         </div>
      </div>
   </div>
   <!-- //LineMap -->


   <div id="contents" class="">
      <div class="wrap-grade" id="select_main">
         
            <div class="tit-heading-wrap">
               <h3>차트/평점</h3>
            </div>
         <!-- </form> -->

               <!-- movieList forwarding -->
               <div id="movielist"></div>
         
               <!-- gpaList forwarding -->
   
         <div class="cols-content">
            <div class="col-detail">
               <div class="sect-grade">
               
               <!-- <form name="searchForm" method="post"> -->
                  <div class="heading-new">
                     <a class="goto-link"><h4>실관람객 평점</h4></a>
                     <p class="txt-write">
                        <!-- 관람일로부터 7일 이내 관람평을 남기시면 <strong>CJ ONE 20P</strong>가 적립됩니다.  -->
                        <a class="link-gradewrite"><span>평점작성</span></a>
                        <a class="link-reviewwrite" onclick="myGpa();"><span>내 평점</span></a>
                        
                     </p>
                  </div>
               <!-- </form> -->
               
               <div id="gpalist"></div>
               
                  
               </div>
            </div>
            <!-- .col-detail -->
         
            <!-- 사이드 광고자리 인데 허전해서 그냥 내비둠 우리가 채워넣자 ㅎ -->
            <div class="col-aside">
               <div class="ad-external01">
                  <img src="<%=cp%>/res/images/0913_160x300.jpg" />
               </div>
               <div class="ad-external01"></div>
            </div>
            <!-- 사이드광고 끝 -->
            
            
         
         </div>
      
      
      </div>


   </div>
</div>


<!-- modal popup -->
<form name="writeGpaForm" method="post">
   <div class="diary-register-wrap">
      <div class="sect-diary-register">
         <h4 class="hidden">평점 작성</h4>
         <!-- 어떤 영화를 보셨나요? -->
         <div class="article-any-movie">
            <div class="movie-select">
               <div class="box-image">
                  <span class="thumb-image"> <img
                     src="<%=cp%>/res/images/${movie.movieIdx}_185.jpg"> 
                  <span
                      class="ico-grade grade-12">12세 이상</span>
                  </span>
               </div>
               <div class="box-contents" style="height: 50%;">
                  <div class="title">
                  <p style="color:blue;">영화 이름</p>
                     <strong><span  id="movieName"></span></strong>
                     
                  </div>
                  <p class="date">
                     <p style="color:blue;">개봉 일자</p>
                     <strong><span  id="starttime" style="font-size: 12px;"></span></strong>
                  </p>
                  <p class="theater">
                     <p style="color:blue;">예매 정보</p>
                     <strong style="font-size: 12px;">MovieGo <span  id="cinemaName"></span>  
                                          <span  id="multiplexName"></span> / <span  id="cnt"></span>명
                     </strong>
                   </p>
               </div>
            </div>
         </div>
         <!-- //어떤 영화를 보셨나요? -->

         <!-- 영화 어떻게 보셨나요? -->
         <div class="article-how-see">
            <label for="textContent">영화 감상평</label>
            <textarea id="textContent" name="textContent" required="required"
               cols="55" rows="5" placeholder="영화 감상평을 남겨주세요."></textarea>
         </div>
         <!-- //영화 어떻게 보셨나요? -->
      </div>

   </div>
</form>
<!--  -->


 
 
 