<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String cp = request.getContextPath();
%>

<script>
$(function(){	
	$(".btn_notify").click(function(){
		//alert($(this).attr("class"));
		if($(this).hasClass("on")) {
			$(".btn_notify.on").removeClass("on");
		} else {
			$(this).addClass("on");
		}
	});
});

// 삭제  *********************************************************************//
function deleteGpa(memberIdx,scoreIdx) {
	var mid="${sessionScope.member.memberIdx}";
	console.log("${sessionScope.member.memberIdx}");
	console.log(memberIdx);
	
	if(mid==memberIdx) {
		/* ajax */
		var url="<%=cp%>/gpa/deleteGpa";
		var query="scoreIdx="+scoreIdx;
		
		//alert(query);
		
		$.ajax({
			type:"POST"
			,url:url
			,data:query
			,dataType:"JSON"
			,success:function(data){
				var state=data.state;
				if(state="true") {
					alert("평점을 삭제 하시겠습니까?");					
				}
				listGpaPage("${page}");
			}
			,error:function(e){
				console.log(e);
			}
		});
		
	} else if(mid!=memberIdx) {
		alert("해당 평점을 삭제하실 수 없습니다.");
	}
}

//평점좋아요  *********************************************************************//
function gpaLike(scoreIdx) {
	var mid="${sessionScope.member.memberIdx}";		
	if(!mid){
		if(confirm("로그인이 필요한 서비스입니다.\n확인을 누르시면 로그인 창으로 이동합니다.")){login();};
		return;
	}	
		var url="<%=cp%>/gpa/gpaLike";
		var query="scoreIdx="+scoreIdx;
		query+="&memberIdx="+mid;
		
		//alert(query);
		
		$.ajax({
			type:"POST"
			,url:url
			,data:query
			,dataType:"JSON"
			,success:function(data){
				var state=data.state;
				
				 if(state=="only") {
					alert("이미 좋아요를 누르신 평점입니다.");
				}
				 listGpaPage("${page}");
			}
			,error:function(e){
				console.log(e);
			}
		});
}

//신고  *********************************************************************//
function writeReport(scoreIdx){	
	var url="<%=cp%>/gpa/gpaReport";
	var mid="${sessionScope.member.memberIdx}";
	var content=$.trim($("#reportContent").val());
	
	var query="scoreIdx="+scoreIdx;
	query+="&memberIdx="+mid;
	query+="&content="+content;
	
	alert(query);
	
	if(! content) {
		alert("내용을 입력해 주세요.");
		$("#reportContent").focus();
	}
	
	$.ajax({
		type:"POST"
		,url:url
		,data:query
		,dataType:"JSON"
		,success:function(data){
			$("#reportContent").html(data);
			
			var state=data.state;
			if(state=="only"){
				alert("신고접수는 한번만 가능합니다");
				return;
			}
			
			alert("신고접수가 완료되었습니다.");
			listGpaPage("${page}");
			$("#reportContent").val("");	
		}
		,error:function(e){
			console.log(e);
		}
	});
}


var reportDialog;
$(function(){

	reportDialog = $("#reportForm").dialog({
		autoOpen: false,
		height: 300,
		width: 300,
		modal: true,
		buttons: {
			"신고 전송" : function(){
				var scoreIdx=$("#reportScoreIdx").val();
				writeReport(scoreIdx);
				reportDialog.dialog("close");
			}
			,"취소" : function(){
				$("#reportContent").val("");	
		          reportDialog.dialog( "close" );
			}
		}
	});
	
});

function reportWriteForm(scoreIdx){

	var mid="${sessionScope.member.memberIdx}";
	if(!mid){
		if(confirm("로그인이 필요한 서비스입니다.\n확인을 누르시면 로그인 창으로 이동합니다.")){login();};
		return;
	}	
	
	$("#reportScoreIdx").val(scoreIdx);

	reportDialog.dialog("open");	
}

// 수정  *********************************************************************//


function updateWrite(scoreIdx){
	var url="<%=cp%>/gpa/updateGpa";
	var content=$.trim($("#updateContent").val());
	
	var query="scoreIdx="+scoreIdx;
	query+="&content="+content;
	
	alert(query);
	
	$.ajax({
		type:"POST"
		,url:url
		,data:query
		,dataType:"JSON"
		,success:function(data){
			$("#updateContent").html(data);
			
			var state=data.state;
			
			if(state=="true"){
				alert("평점 수정이 완료되었습니다.");
				listGpaPage("${page}");
				$("#updateContent").val("");	
			} else if(state=="false") {
				alert("평점 수정에 실패하였습니다.");
				return;
			}
		}
		,error:function(e){
			console.log(e);
		}
	});
}

var upadateDialog;
$(function(){

	updateDialog = $("#updateForm").dialog({
		autoOpen: false,
		height: 300,
		width: 300,
		modal: true,
		buttons: {
			"수정" : function(){
				var scoreIdx=$("#updateScoreIdx").val();
				updateWrite(scoreIdx); 
				updateDialog.dialog("close");
			}
			,"취소" : function(){
				$("#updateContent").val("");	
		          updateDialog.dialog( "close" );
			}
		}
	});
	
});


function updateGpaForm(scoreIdx) {
	var mid="${sessionScope.member.memberIdx}";
	if(!mid){
		if(confirm("로그인이 필요한 서비스입니다.\n확인을 누르시면 로그인 창으로 이동합니다.")){login();};
		return;
	}
	
	$("#updateScoreIdx").val(scoreIdx);

	updateDialog.dialog("open");	
}

</script>				
					
					<!-- 리스트 dataCount 시작 -->
					
						<div class="egg-grade">
							<div class="massagebox">
								<c:if test="${dataCount!=0}">
									<p>
										<span class="msg-em"><strong id="cgvEggCountTxt">${dataCount}</strong>명의</span>
										<em>MovieGo 실람관객이</em> 평가해주셨습니다.
									</p>
								</c:if>
								<c:if test="${dataCount==0}">
								<p>
									<!-- <span class="msg-em"><strong id="cgvEggCountTxt">제일 먼저 평점을 남겨주세요~</strong></span> -->
									<span class="msg-em" style="font-family: Malgun Gothic; color: gray;"> 평점을 남겨주세요~</span>
								</p>
								</c:if>
							</div>
							<!-- 차트 -->
							<div class="radar-graph" id="chart2">
								<canvas id="charmScore2" width="200" height="200"
									style="width: 200px; height: 200px;"></canvas>
							</div>
							<!-- 차트 끝 -->
						</div>
						
						<!-- 초기값 첫번쨰꺼 선택하면 class="on" 넣는다  / 탭 활성화 -->
						<!-- <form name="likeForm" method="post"> -->
							<ul class="sort" id="sortTab">
								<li class="on" id="sortTab1"><a href="#">최신순<span class="arrow-down"></span></a></li>
								<li id="sortTab2"><a onclick="javascript:location.href='<%=cp%>/gpa/orderLike';">추천순<span class="arrow-down"></span></a></li>
							</ul>
						<!-- </form> -->
						

						<div id="my_point_area"></div>
						<!-- 라인 -->

						<!-- 평점댓글 -->
						<div class="wrap-persongrade">

							<ul id="movie_point_list_container" class="point_col2">
								
								<c:forEach var="dto" items="${list}">
								
								<li class="write" id="${dto.scoreIdx}"><a href="javascript:return false;"
									class="screen_spoiler">&nbsp;${dto.scoreIdx}</a>
									<div class="box-image">
										<span class="thumb-image"> 
										<img src="<%=cp%>/res/images/default_profile.gif" alt="사용자 프로필"/>
										<span class="profile-mask"></span>
											<div class="theater-sticker"></div>
										</span>
									</div>
									<div class="box-contents">
										<ul class="writerinfo">

											<li class="writer-name"><a href="#"
												onclick=""><span
													class="egg-icon good"></span>${dto.userId}
											</a></li>
											<li class="writer-etc"><span class="vip"></span> <span
												class="day">${dto.regdate}</span> <span class="like point_like"
												id="${dto.memberIdx}"> 
												<a class="btn_point_like" onclick="gpaLike('${dto.scoreIdx}');">
														<span> <img
															src="<%=cp%>/res/images/ico_point_default.png" alt="like"
															class="like_red"/></span>
															<span id="idLikeValue">${dto.likeCount}</span>
												</a>
											</span></li>
											
											<li class="point_notify" id="notify"><a class="btn_notify " style="cursor: pointer;"></a>
												<div class="notify_wrap" id="wrap">
													<ul>
													<c:if test="${sessionScope.member.memberIdx==dto.memberIdx}">	
														<li><a class="ico_spoiler" href="javascript:updateGpaForm(${dto.scoreIdx});"><span>수정</span></a></li>
														<li><a class="ico_swearword" onclick="deleteGpa('${dto.memberIdx}','${dto.scoreIdx}');">
															<span>삭제</span></a></li>
													</c:if>
													
													<c:if test="${sessionScope.member.memberIdx!=dto.memberIdx}">	
													<li><a class="ico_spoiler"  href="javascript:reportWriteForm(${dto.scoreIdx});"><span >신고 작성하기</span></a></li>
													<!-- <li><a class="ico_swearword"><span>신고 작성하기</span></a></li> -->
													</c:if>

													</ul>
												</div></li>
										</ul>
									</div>
									<div class="box-comment">
										<p>${dto.content}</p>
										<span  id="content"></span>	
									</div></li>

								</c:forEach>
														

							</ul>
						</div>
						
						
						<!-- 페이징 -->
						<div class="paging">
							<ul id="paging_point">
								<li class=" on" style="cursor: pointer;">
               						${paging}
								</li>
							</ul>
						</div>
					
  <!-- 신고 폼 -->
<div id="reportForm">
<input type="hidden" id="reportScoreIdx">	
	<!-- <div class="write_box"> -->
		<textarea id="reportContent" style="width:240px;height:130px;
                         text-align:center;" placeholder="신고하실 내용을 입력해 주세요."></textarea>
</div>
 
 
<!-- 수정폼 --> 
 <div id="updateForm">
<input type="hidden" id="updateScoreIdx">	
	<!-- <div class="write_box"> -->
		<textarea id="updateContent" style="width:240px;height:130px;
                         text-align:center;" placeholder="평점을 다시 작성하시려나봐요."></textarea>
</div>
