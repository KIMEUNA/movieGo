<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
       
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
    <meta name="viewport" content="width=1024"/>

    <title>MovieGo</title>
    
    <link rel="stylesheet" media="all" type="text/css" href="<%=cp%>/res/css/reset.css"/>
    <link rel="stylesheet" media="all" type="text/css" href="<%=cp%>/res/css/layout.css"/>
    <link rel="stylesheet" media="all" type="text/css" href="<%=cp%>/res/css/module.css"/>
    <link rel="stylesheet" media="all" type="text/css" href="<%=cp%>/res/css/common.css"/>
    <link rel="stylesheet" media="all" type="text/css" href="<%=cp%>/res/css/eggupdate.css"/>
    <link rel="stylesheet" media="print" type="text/css" href="<%=cp%>/res/css/print.css"/>  
    <link rel="stylesheet" type="text/css" href="<%=cp%>/res/css/jquery-ui-1.10.4.custom.min.css"/>
    <link rel="stylesheet" type="text/css" href="<%=cp%>/res/css/content_1207.css"/>
     
    <script type="text/javascript" src="<%=cp%>/res/js/jquery-1.10.2.min.js"></script>
    <script type="text/javascript" src="<%=cp%>/res/js/jquery-ui-1.10.4.custom.min.js"></script>
     
    <script type="text/javascript"  src="<%=cp%>/res/js/analytics.js"></script>
    <script type="text/javascript" src="<%=cp%>/res/js/jquery.utils.js"></script>
    <script type="text/javascript" src="<%=cp%>/res/js/util.js"></script>
	
<script type="text/javascript">
jQuery(function() {
	document.title = "${title} | MOVIEGO";
});
	//화면 중앙에 위치
	jQuery.fn.center = function () {
	    this.css("position","absolute");
	    this.css("top", Math.max(0, (($(window).height() - $(this).outerHeight()) / 2) + 
	                                                $(window).scrollTop()) + "px");
	    this.css("left", Math.max(0, (($(window).width() - $(this).outerWidth()) / 2) + 
	                                                $(window).scrollLeft()) + "px");
	    return this;
	}

	// ajax 가 실행될 때.
	jQuery(document).ajaxStart(function() {
		jQuery("#loading").center();
		jQuery("#loadingLayout").fadeTo("slow", 0.5);	// loadingLayout를 애니메이션 효과를 주면서 보이게 하기. 투명도 0.5
	}).ajaxComplete(function() {
		jQuery("#loadingLayout").hide();
	});
</script>
	
</head>

<body>

<div class="skipnaiv">
	<a href="#" id="skipHeader">메인 컨텐츠 바로가기</a>
</div>

<div id="cgvwrap">

    <tiles:insertAttribute name="header"/>

    <tiles:insertAttribute name="body"/>

    <tiles:insertAttribute name="footer"/>
    
    	<!-- loading -->
	<div id="loadingLayout" style="display: none; position: absolute; left: 0px; top: 0px; 
										width: 100%; height: 100%; background: #eee; z-index: 9000;">
		<img id="loading" src="<%=cp%>/res/images/ajax-loader-w.gif" border="0" alt="로딩 애니메이션">
	</div>
    
	
    <!-- Aside Banner :  -->
	<div id="ctl00_sect_person_right" class="sect-aside-banner" style="padding: 0px; margin: 0px; position: fixed; z-index: 1; left: 1184.5px; top: 239px;">
		<div class="aside-content-top">
			<div class="aside-content-btm">
				<a href="<%=cp%>/reserve"><img src="<%=cp%>/res/images/btn_person_theater.gif" alt="CGV THEATER"></img></a>
				<a href="#" class="required-login" ><img src="<%=cp%>/res/images/btn_person_ticket.gif" alt="CGV TICKET INFO"></img></a>
				<a href="<%=cp%>/gpa/gpa"><img src="<%=cp%>/res/images/btn_person_arthouse.gif" alt="CGV arthouse"></img></a>
				<a href="#"><img src="<%=cp%>/res/images/btn_person_discount.gif" alt="CGV DISCOUNT INFO"></img></a>
			</div>
		</div>
		<div class="btn-top">
			<a href="#" onclick="scrollTo(0,0);return false;"><span>최상단으로 이동</span></a>
		</div>
	</div>
	<!-- //Aside Banner -->
    
</div>

<script type="text/javascript">

   /*  function closeBanner(){
        $('#cgv_main_ad').remove();     
        for(var i = 0; i < 2; i++) {
            window.setTimeout(function(){
                $(window).resize()                
            }, 30)
        }
    } */
   /*  function showPlayEndEvent() {
        $('#pop_player_relation_wrap').show();
        $('#btn_movie_replay').focus();
    } */

    (function ($) {
        $(function () {

            /* side menu move script */
            var isBricks = true;
            $('.sect-aside-banner').asideMenu({ isMain:true,'isBricks': isBricks }); 
            
            
            // 검색 auto validate version.
           /*  $('.btn-go-search').on('click', function () {
                var $frmSearch = $(this).parent().parent('form');
                $frmSearch.submit();
                return false;
            }); */

            //검색 입력창 클릭 시 placeholder 값 reset
            $('#header_keyword').on('click', function() {
                $(this).attr('placeholder', '');
            });

            //통합검색 상단 검색 버튼
            $('#btn_header_search').on('click', function() {
                    goSearch($('#header_keyword'));
                return false;
            });

            //통합검색 검색어 입력창
            $('#header_keyword').keyup(function(e) {
                if (e.keyCode == 13) goSearch($('#header_keyword'));        
            });

            //통합검색
            function goSearch($objKeyword) {
                
                if(! $objKeyword.val()) {
                    alert("검색어를 입력해 주세요");
                    $objKeyword.focus();
                    return false;
                }

                location = "/search/?query=" + escape($objKeyword.val());
            }
			
            //메인스킵네비
   /*          $('#skipHeader').on('click', function(){
                var $ctn = $('#contents');
                $ctn.attr({
                    tabIndex : -1
                }).focus();				
                return false;
            });
 */
            //현재 URL 해당파라미터 교체
            function updateQueryStringParameter(uri, key, value) {
                var re = new RegExp("([?|&])" + key + "=.*?(&|#|$)", "i");
                if (uri.match(re)) {
                    return uri.replace(re, '$1' + key + "=" + value + '$2');
                } else {
                    var hash =  '';
                    var separator = uri.indexOf('?') !== -1 ? "&" : "?";    
                    if( uri.indexOf('#') !== -1 ){
                        hash = uri.replace(/.*#/, '#');
                        uri = uri.replace(/#.*/, '');
                    }
                    return uri + separator + key + "=" + value + hash;
                }
            }
                      
        });
    })(jQuery);
	/* 
    function goFamilySite() {
        var famulySiteURL = $(familysite).val();
        if (famulySiteURL != "") {
            var win = window.open(famulySiteURL, 'winFamilySite')
            win.focus();
        }
    }
     */
</script>


</body></html>


