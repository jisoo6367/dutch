<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<c:set var="contextPath" value="${pageContext.request.contextPath }"/>

<%@include file="../pageinclude/header.jsp" %>


<!-- JSP 폼 입니다 아래 공간 안에서 코딩하시면 됩니다 -->

<div id="page-wrapper">
    <div class="row">
        <div class="col-lg-12">
            <h3 class="page-header"
				style="white-space: nowrap;" >community - Detail
				 <small>
				 	&nbsp;&nbsp;&nbsp;<c:out value="${community.tno}"/>번 게시물
				 </small>
			</h3>
        </div><%-- /.col-lg-12 --%>
    </div><%-- /.row --%>
    
    
    <div class="row">
        <div class="col-lg-12">
        
            <div class="panel panel-default">
                <div class="panel-heading">
                	<div class="row">
						<div class="col-md-2" style="white-space: nowrap; height: 45px; padding-top:11px;">
							<strong style="font-size:16px;">${community.nickname}님 작성</strong>
						</div>
						<div class="col-md-3" style="white-space: nowrap; height: 45px; padding-top:16px;">
							<span class="text-primary" style="font-size: smaller; height: 45px; padding-top: 19px;">
								<span>
									<span>등록일:&nbsp;</span>
									<strong><fmt:formatDate 
												pattern="yyyy-MM-dd HH:mm:ss"
												value="${community.tregDate}"
											 /></strong>
									<span>&nbsp;&nbsp;</span>
								</span>
								<span>조회수:&nbsp;<strong><c:out value="${community.tviewCnt}"/></strong>
								</span>
							</span>
						</div>
						<div class="col-md-7" style="height: 45px; padding-top:6px;"><%-- vertical-align: middle; --%>
							<div class="button-group pull-right">


<%-- <sec:authorize access="isAuthenticated()">
	<sec:authentication property="principal.username" var="username"/>
		<c:if test="${username eq myboard.bwriter }">
							<button type="button" id="btnToModify" data-oper="modify"
									class="btn btn-primary"><span>수정페이지로 이동</span></button>
		</c:if>
</sec:authorize> --%>
							<button type="button" id="btnToModify" 
									class="btn btn-primary"><span>수정페이지로 이동</span></button>

									
							<button type="button" id="btnToList" 
									class="btn btn-warning"><span>목록페이지로 이동</span></button>
							</div>
						</div>
					</div>
                </div><!-- /.panel-heading --><%-- /.panel-heading --%>

                
                <div class="panel-body form-horizontal">
	
	<div class="form-group">
	    <label class="col-sm-2 control-label" style="white-space: nowrap;">글제목</label>
	    <div class="col-sm-10">
	    	<input class="form-control" name="ttitle" id="ttitle" 
	    		   value="${community.ttitle }" readonly="readonly">
		</div>
	</div>
	
	
	<div class="form-group">
	    <label class="col-sm-2 control-label" style="white-space: nowrap;">글내용</label>

	    <div class="col-sm-10">
	    	<textarea class="form-control" rows="3" name="tcontent" id="tcontent"
	    			  style="resize: none;"
	    			  readonly="readonly"><c:out value="${community.tcontent}"/></textarea>
		</div>	    			  
	</div>


	<div class="form-group">
	    <label class="col-sm-2 control-label" style="white-space: nowrap;">최종수정일</label>
	    <div class="col-sm-10">
	    	<input class="form-control" name="tmodDate" id="tmodDate" 
	      		   value='<fmt:formatDate pattern="yyyy/MM/dd HH:mm:ss" value="${community.tmodDate }"/>' readonly="readonly">
		</div>
	</div class="form-group">

	<div>
		<button type="button" id="trecommend" onclick="toggleRecommend" >
			<span>추천</span>
		</button>

	</div>



	<%-- Modal: 게시물 수정 후, 수정 결과 표시 모달 --%>
	<div class="modal fade" id="yourModal" tabindex="-1" role="dialog" aria-labelledby="yourModalLabel" aria-hidden="true">
	    <div class="modal-dialog">
	        <div class="modal-content">
	            <div class="modal-header">
	                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
	                <h4 class="modal-title" id="yourModalLabel">Modal title</h4>
	            </div>
	            <div class="modal-body" id="yourModal-body">메시지</div>
	            
	            <div class="modal-footer">
	                <button type="button" class="btn btn-primary" data-dismiss="modal">Close</button>
	            </div>
	        </div><%-- /.modal-content --%>
	    </div><%-- /.modal-dialog --%>
	</div><%-- /.modal --%>

		
		<form id="frmSendValue">
		 <input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }"/>
			<input type="hidden" name="pageNum" value="${communityPaging.pageNum }" >
			<input type="hidden" name="rowAmountPerPage" value="${communityPaging.rowAmountPerPage }" >
			<input type="hidden" name="scope" value="${communityPaging.scope }" >
			<input type="hidden" name="keyword" value="${communityPaging.keyword }" >
			<input type="hidden" name="beginDate" value="${communityPaging.beginDate }" >
			<input type="hidden" name="endDate" value="${communityPaging.endDate }" >
		</form>
            </div><%-- /.panel-body --%>
            
        </div><%-- /.panel --%>
    </div><%-- /.col-lg-12 --%>
</div><%-- /.row --%>

<%-- 첨부파일 결과 표시 --%>    
    <div class="row">
        <div class="col-lg-12">
            <div class="panel panel-default">
                <div class="panel-heading">
                	<strong style="font-size:16px;">첨부 파일</strong>
                </div><!-- /.panel-heading -->
                
                <div class="panel-body">
<div class="form-group fileUploadResult">
	<ul>
		<%-- 업로드 후 처리결과가 표시될 영역 --%>
		<c:choose>
		<c:when test="${empty community.attachFileList }">
			<li style="font-size: 12pt;">첨부파일이 없습니다</li>
		</c:when>
		<c:otherwise>
			<c:forEach var="attachFile" items="${community.attachFileList }">
				<c:choose>
				
				<c:when test="${attachFile.fileType == 'F' }">
					<li class="attachLi" 
						data-repopath = "${attachFile.repoPath }"
					    data-uploadpath = "${attachFile.uploadPath }" 
					    data-uuid = "${attachFile.uuid }" 
					    data-filename = "${attachFile.fileName }" 
					    data-filetype = "F" >
					        <img src='${contextPath}/resources/img/icon-attach.png' style='width:25px;'>
					        &nbsp;&nbsp;${attachFile.fileName}
					</li>
				</c:when>
				
				<c:otherwise>
					<c:set var="thumbnail" value="${attachFile.repoPath}/${attachFile.uploadPath}/s_${attachFile.uuid}_${attachFile.fileName}"/>
					<li class="attachLi" 
						data-repopath = "${attachFile.repoPath }"
					    data-uploadpath = "${attachFile.uploadPath }" 
					    data-uuid = "${attachFile.uuid }" 
					    data-filename = "${attachFile.fileName }" 
					    data-filetype = "I" >
					        <img src='${contextPath}/displayThumbnail?fileName=${thumbnail}' style='width:25px;'>
					        &nbsp;&nbsp;${attachFile.fileName}
					</li>
					<c:remove var="thumbnail"/>
					</c:otherwise>
					</c:choose>
				</c:forEach>
			</c:otherwise>
		</c:choose>
	</ul>
	                </div>
                </div><!-- /.panel-body -->
            </div><!-- /.panel -->
        </div><!-- /.col-lg-12 -->
    </div><!-- /.row -->

<%-- Modal: 첨부파일 이미지 표시 --%>
<div class="modal fade" id="attachModal" tabindex="-1" role="dialog" aria-labelledby="attachModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-body" id="attachModal-body">
            	<%--이미지표시 --%>
            </div>
        </div><%-- /.modal-content --%>
    </div><%-- /.modal-dialog --%>
</div><%-- /.modal --%>

    
<%-- 댓글 요소 시작 --%>
<div class="form-group" class="row">
	<div class="col-lg-12">
		<div class="panel panel-default" >
			<div class="panel-heading">
				<div style="margin-bottom: 0px; font-size: 16px;">
				
					<strong style="padding-top: 2px;">
						<span>댓글&nbsp;<c:out value="${community.treplyCnt}"/>개</span>
						<span id="replyTotal"></span>
						<span>&nbsp;</span>
						
						<button type="button" id="btnChgCmtReg" class="btn btn-info btn-sm">댓글 작성</button>
												
						<button type="button" id="btnRegCmt" class="btn btn-warning btn-sm"
								style="display:none">댓글 등록</button>
						<button type="button" id="btnCancelRegCmt" class="btn btn-warning btn-sm"
								style="display:none">취소</button>&nbsp;&nbsp;&nbsp;
					</strong>
				</div>
			</div> <%-- /.panel-heading --%>
			<div class="panel-body">

			<%-- 댓글 입력창 div 시작 --%>
				<div class="form-group" style="margin-bottom: 5px;">
					<textarea class="form-control txtBoxCmt" name="rcontent"
							  placeholder="댓글작성을 원하시면,&#10;댓글 작성 버튼을 클릭해주세요."
							  readonly="readonly"
							 ></textarea>
				</div>
				<hr style="margin-top: 10px; margin-bottom: 10px;"><%-- 댓글 입력창 div 끝 --%>


<ul class="chat" id="chat">
<%-- 댓글 목록 표시 영역 - JavaScript로 내용이 생성되어 표시됩니다.--%>
	<li class="left clearfix commentLi" data-tno="${communityReply.tno }" data-trno="${communityReply.trno }">
		<div>
			<div>
				<span class="header info-rwriter">
					<strong class="primary-font"><c:out value="${communityReply.nickname} "/>user00</strong>
					<span>&nbsp;</span>
					<small class="text-muted"><c:out value="${communityReply.trregDate} "/>2018-01-01 13:13</small>
				</span>
				<p><c:out value="${communityReply.trcontent} "/>앞으로 사용할 댓글 표시 기본 템플릿입니다.</p>
			</div>
			
			<div class="btnsComment" style="margin-bottom:10px">
				<button type="button" style="display:in-block"
						class="btn btn-primary btn-xs btnChgReg">답글 작성</button>
				<button type="button" style="display:none"
						class="btn btn-warning btn-xs btnRegCmt">답글 등록</button>
				<hr class="txtBoxCmtHr" style="margin-top:10px; margin-bottom:10px">
				<textarea class="form-control txtBoxCmtMod" name="rcontent" 
						  style="margin-bottom:10px"
						  placeholder="답글작성을 원하시면,&#10;답글 작성 버튼을 클릭해주세요."
						 ></textarea>
			</div>
		</div>
	</li>




</ul><%-- /.chat --%>

	</div><%-- /.panel-body --%>
			<div class="panel-footer text-center" id="showCmtPagingNums">
				<%-- 댓글 목록의 페이징 번호 표시 영역 - JavaScript로 내용이 생성되어 표시됩니다.--%>
			</div>
		</div><%-- /.panel --%>
	</div><%-- .col-lg-12 --%>
</div><%-- .row : 댓글 화면 표시 끝 --%>

<form id = "frmCmtPagingValue">
  <input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }"/>
	<input type="hidden" name="pageNum" value="">
	<input type="hidden" name="rowAmountPerPage" value="">
</form>

</div><%-- /#page-wrapper --%>


<%-- 게시물 상세 자바스크립트 시작 --%>
<script>

	var frmSendValue = $("#frmSendValue") ;

	<%-- 게시물 목록 페이지 이동 --%>
	$("#btnToList").on("click", function(){
	
		 frmSendValue.attr("action", "${contextPath}/community/list").attr("method", "get") ;
		frmSendValue.submit() ; 
		
	});
	
	
	<%-- 게시물 수정-삭제 페이지 이동 --%>
	$("#btnToModify").on("click", function(){
	console.log('작동확인용');
	
		 var tno = '<c:out value="${community.tno}"/>' ;
		
		frmSendValue.append("<input type='hidden' name='tno' value='" + tno + "'/>") ;
		frmSendValue.attr("action", "${contextPath}/community/modify").attr("method", "get") ;
		frmSendValue.submit() ; 
	});
	
	
	var result = '<c:out value="${result}" />' ;
	
	function runModal(result) {
		if (result.length == 0) {
			return ;
		
		} else if ( result == "successModify" ) {
			var myMsg =  "게시글이 수정되었습니다. " ;
			
		}  

		$("#yourModal-body").html(myMsg) ;
		
		$("#yourModal").modal("show") ;
		
		myMsg = "" ;
	} 
	
	<%-- 첨부파일 이미지 표시 --%>
	<script>
	$(".attachLi").on("click", function(){
		var objLi = $(this) ;
		
		var myFileName = objLi.data("repopath") + "/" + objLi.data("uploadpath") + "/" 
					   + objLi.data("uuid") + "_" + objLi.data("filename") ;
		
		var myFileType = objLi.data("filetype") ;
		
		if(myFileType == "I") {
			$("#attachModal-body").html("<img src='${contextPath}/fileDownloadAjax?fileName=" 
											      + encodeURI(myFileName) 
											      + "' style='width:100%;'>") ;
			$("#attachModal").modal("show") ;
		
		} else {
			self.location.href ="${contextPath}/fileDownloadAjax?fileName="  + encodeURI(myFileName) ;
		}
		
		
		
		
	});	
	
	<%-- 표시된 이미지 모달 감추기 --%>
	/* $("#attachModal").on("click", function(){
		$("#attachModal").modal("hide") ;
	}); */

</script>


<%-- 추천 버튼 추가 --%>
<script>
    function toggleRecommend() {
        var itemId = document.getElementById("itemId").value;
        var recommendButton = document.getElementById("recommendButton");
        var recommendCountSpan = document.getElementById("recommendCount");


        // 예시: 추천 버튼이 이미 눌려있는지 여부를 확인
        var isRecommended = recommendButton.classList.contains("recommended");

        // 서버에 전송 후 성공적으로 처리되면 추천 여부 및 추천 수 업데이트
        // 실제로는 AJAX나 fetch 등을 사용하여 서버에 데이터를 전송하고 응답을 받아와야 합니다.
        // 아래는 가상의 함수입니다.

        // 서버에 전송하고, 성공적으로 처리되면 아래 코드 실행
        if (toggleRecommendOnServer(itemId, !isRecommended)) {
            if (isRecommended) {
                recommendButton.classList.remove("recommended");
                recommendCountSpan.innerText = "총 추천 수: " + (parseInt(recommendCountSpan.innerText.split(":")[1]) - 1);
            } else {
                recommendButton.classList.add("recommended");
                recommendCountSpan.innerText = "총 추천 수: " + (parseInt(recommendCountSpan.innerText.split(":")[1]) + 1);
            }
        }
    }

    // 가상의 함수: 서버에 추천 상태 전송
    function toggleRecommendOnServer(itemId, isRecommended) {
        // 실제로는 AJAX 또는 fetch 등을 사용하여 서버에 데이터를 전송하고 응답을 받아와야 합니다.
        // 아래는 가상의 함수로, 실제 구현에 맞게 수정해야 합니다.
        // 반환값으로 서버에서 처리 결과를 전달하도록 합니다.
        console.log("서버에 전송: 아이템 ID " + itemId + ", 추천 여부 " + isRecommended);
        return true; // 가상의 성공적인 처리
    }
</script>

<%-- 댓글/답글 자바스크립트 시작--%>
<script src="${contextPath }/resources/js/mycomment.js"></script>
<script>

var tnoValue = '<c:out value="${community.tno}"/>' ;

var commentUL = $("#chat") ;

var frmCmtPagingValue = $("#frmCmtPagingValue") ;


<%-- 댓글 페이징 번호 표시 --%>
function showCmtPagingNums(replyTotCnt, pageNum, rowAmountPerPage) {
	
	var pagingNumCnt = 3 ;
	
	var endPagingNum = Math.ceil(pageNum / pagingNumCnt) * pagingNumCnt ;

	var startPagingNum = endPagingNum - (pagingNumCnt-1) ;
	
	var lastPagingNum = Math.ceil(replyTotCnt/rowAmountPerPage) ;
	
	if(lastPagingNum < endPagingNum) {
		endPagingNum = lastPagingNum ;
	}
	
	var prev = startPagingNum > 1 ;
	var next = endPagingNum < lastPagingNum ;
	
	var pagingDisplayHTML
		= '<div style="text-align: center;">'
		+ '   <ul class="pagination pagination-sm" >' ;
                
	if(prev) {
               
	pagingDisplayHTML 
		<%-- 맨 앞으로 --%>
	    +='        <li class="pagination-button">'
		+ '            <a href="1" aria-label="Previous">'
		+ '                <span aria-hidden="true">&laquo</span>'
		+ '            </a>'
		+ '        </li>'
		<%-- 이전 페이징 번호 그룹 --%>
		+ '        <li class="pagination-button">'
		+ '            <a href="' + (startPagingNum-1) + '" aria-label="Previous">'
		+ '                <span aria-hidden="true">이전</span>'
		+ '            </a>'
		+ '        </li>' ;
	}      
	        
	for(var i = startPagingNum ; i <= endPagingNum ; i++) {
		    
		var active = ((pageNum == i) ? "active" : "") ;
	pagingDisplayHTML
	   += '        <li class="pagination-button ' + active + '" >'  
	   +  '            <a href="' + i + '">' + i + '</a>'
       +  '        </li>' ;
	}
	
	if(next) {
        
	pagingDisplayHTML
		<%-- 다음 페이징 번호 그룹 --%>
		+='        <li class="pagination-button">'
		+ '            <a href="' + (endPagingNum + 1) + '" aria-label="Next">'
		+ '                <span aria-hidden="true">다음</span>'
		+ '            </a>'
		+ '        </li>' 
		<%-- 맨 뒤로 --%>
	    + '        <li class="pagination-button">'
		+ '            <a href="' + lastPagingNum + '" aria-label="Next">'
		+ '                <span aria-hidden="true">&raquo</span>'
		+ '            </a>'
		+ '        </li>' ;
		}
	
	pagingDisplayHTML 
        +='    </ul>'
        + '</div>' ;
            
		$("#showCmtPagingNums").html(pagingDisplayHTML);
}

<%-- 선택된 페이징 번호 클릭 시, 게시물목록 가져오는 함수: 이벤트 전파 이용 --%>
<%-- #showCmtPagingNums > div > ul > li:nth-child(2) > a --%>
$("#showCmtPagingNums").on("click","div ul li a", function(e){
	e.preventDefault() ;
	var targetPageNum = $(this).attr("href") ;
	showCmtList(targetPageNum) ;
});


<%--댓글목록 표시 함수: 서버로부터 전달된 데이터를 이용해서 댓글 목록을 표시하는 JS 함수--%>
function showCmtList(pageNum){
	
	myReplyClsr.getCmtList(
		{tno: tnoValue, pageNum: pageNum || 1} ,
		
		function(communityReplyPagingCreator){
			
			$("#replyTotal").html("댓글&nbsp;" + communityReplyPagingCreator.replyTotCnt + "개") ;
			
			frmCmtPagingValue.find("input[name='pageNum']").val(pageNum) ;
			frmCmtPagingValue.find("input[name='rowAmountPerPage']").val(communityReplyPagingCreator.communityreplyPaging.rowAmountPerPage) ;
			
			var str = '' ;
			
			if(!communityReplyPagingCreator.communityreplyList || communityReplyPagingCreator.communityreplyList.length == 0){
				str += '<li class="left clearfix commentLi" '
					+ ' 	style="text-align: center; background-color: lightCyan;'
					+ ' 	height: 35px;margin-bottom: 0px;padding-bottom:0px;'
					+ ' 	padding-top:6px;border: 1px dotted;">'
					+ ' 	<strong>등록된 댓글이 없습니다.</strong></li>';
				
				commentUL.html(str) ;
				return ;
			} 
			
			for(var i = 0, len = communityReplyPagingCreator.communityreplyList.length; i < len ; i++) {
				if(communityReplyPagingCreator.communityreplyList[i].trdelFlag == 1) {
				str +='<li class="left clearfix commentLi">'
					+ ' <div style="background-color: Moccasin; text-align: center">'
				    + '     <em>작성자에 의해서 삭제글입니다.</em>'
					+ ' </div>'
					+ '</li>';
				
				} else {
				str +='<li class="left clearfix commentLi" '
				    + '    data-tno="' + tnoValue + '" '
				    + '    data-trno="' + communityReplyPagingCreator.communityreplyList[i].trno + '" '
				    + '    data-nickname="' + communityReplyPagingCreator.communityreplyList[i].nickname + '" '
				    + '    data-rdelflag="' + communityReplyPagingCreator.communityreplyList[i].trdelFlag + '">' ;
					<%-- 댓글 답글 들여쓰기 --%>
					if(communityReplyPagingCreator.communityreplyList[i].lvl == 1){
				
				str += '<div>' ;
				
					} else if (communityReplyPagingCreator.communityreplyList[i].lvl == 2){
				str += '<div style="padding-left: 25px;">' ;
					
					} else if (communityReplyPagingCreator.communityreplyList[i].lvl == 3){
				str += '<div style="padding-left: 50px;">' ;		
					
					} else if (communityReplyPagingCreator.communityreplyList[i].lvl == 4){
				str += '<div style="padding-left: 70px;">' ;
					
					} else { <%-- 답글의 레벨이 5이상이면 동일한 들여쓰기 --%>
				str += '<div style="padding-left: 100px;">' ;
						
					}
				<%-- 답글에 대한 아이콘 표시  --%>	
				if(communityReplyPagingCreator.communityreplyList[i].lvl > 1) {
				str += '    <i class="fa fa-reply fa-fw"></i>&nbsp;';
				
				}	

				str +='    <span class="header info-rwriter">'
				    + '        <strong class="primary-font">' + communityReplyPagingCreator.communityreplyList[i].trwriter + '</strong>&nbsp;&nbsp;'
				    + '        <small class="text-muted">' 
				    +              myReplyClsr.myDateTimeFmt(communityReplyPagingCreator.communityreplyList[i].trmodDate) 
				    + '        </small>'
				    + '    </span>'<%-- 
				    + '    <p style="white-space:pre-wrap;" data-tno="' + myReplyPagingCreator.myreplyList[i].tno + '"' --%> 
				    + '    <p class="rcontent-p" style="white-space:pre-wrap;"'
				    + '       data-tno="' + communityReplyPagingCreator.communityreplyList[i].tno + '"'
				    + '       data-trno="' + communityReplyPagingCreator.communityreplyList[i].trno + '">'
				    +         communityReplyPagingCreator.communityreplyList[i].trcontent + '</p>'
				    + '</div>'
				    + '    <button type="button" style="display:in-block;" ' 
				    + '            class="btn btn-primary btn-xs btnChgReplyReg">답글작성</button>'
					+ '</li>' ;
				}

			}<%--for-end--%>
			
			commentUL.html(str) ;
			
			showCmtPagingNums(communityReplyPagingCreator.replyTotCnt, 
							  communityReplyPagingCreator.communityreplyPaging.pageNum,
							  communityReplyPagingCreator.communityreplyPaging.rowAmountPerPage);
			
		}<%--callback-function-end --%>
			
	); <%--communityReplyClsr.getCmtList(); 완료--%>
	
	
}<%--showCmtList-end --%>

<%--댓글 추가 초기화 함수 --%>
function resetCmtRegElements(){
	$("#btnChgCmtReg").attr("style", "display:in-block;") ;
	$("#btnRegCmt").attr("style", "display:none") ;
	$("#btnCancelRegCmt").attr("style", "display:none;") ;
//	$("#spanLoginUser").attr("style", "display:none;") ;
	$(".txtBoxCmt").val("")
				   .attr("readonly", true)
				   .attr("placeholder", "댓글작성을 원하시면,\n댓글 작성 버튼을 클릭해주세요.") ;

}

<%-- 댓글 작성 버튼 클릭 처리 --%>
$("#btnChgCmtReg").on("click", function(){
	
	resetRelyRegElements() ;
	resetReplyModElements() ;
	
	$(this).attr("style", "display:none;") ;
	$("#btnRegCmt").attr("style", "display:in-block; margin-right:2px") ;
	$("#btnCancelRegCmt").attr("style", "display:in-block;") ;
	$(".txtBoxCmt").attr("placeholder", "").attr("readonly", false) ;
	
});

<%-- 댓글 등록 버튼 클릭 처리: 이벤트 전파 --%>
$("#btnRegCmt").on("click", function(){
	
	var rcontent = $(".txtBoxCmt").val() ;
	var loginUser = "슈퍼맨" ;
		
	var reply = {tno: tnoValue, trcontent: trcontent, nickname: loginUser } ;
	
	myReplyClsr.registerCmt(
			reply,
			function(result){
				if (result != null) {
					alert(result + "번 댓글이 등록되었습니다.") ;	
				} else {
					alert("서버 장애로 댓글 등록이 취소되었습니다.") ;
				}
				
				resetCmtRegElements() ;
				
				showCmtList(-10) ;
			}
	);//
	
});

<%-- 댓글 등록 "취소" 버튼 클릭 처리 --%>
$("#btnCancelRegCmt").on("click", "", function(){
<%--
	$("#btnChgCmtReg").attr("style", "display:in-block;") ;
	$("#btnRegCmt").attr("style", "display:none") ;
	$("#btnCancelRegCmt").attr("style", "display:none;") ;
	$(".txtBoxCmt").val("")
				   .attr("readonly", true)
				   .attr("placeholder", "댓글작성을 원하시면,\n댓글 작성 버튼을 클릭해주세요.") ; 
--%>
	resetCmtRegElements() ;
	
});


<%--답글 작성 초기화 함수 --%>
function resetRelyRegElements() {
	$(".btnRegReply").remove() ;
	$(".btnCancelRegReply").remove() ;
	$(".txtBoxReply").remove() ;
	$(".btnChgReplyReg").attr("style", "display: in-block;") ;
}

<%--답글 작성 버튼 클릭 처리:이벤트 전파
   #chat > li:nth-child(1) > button  --%>
$("#chat").on("click","li .btnChgReplyReg" , function(){
	
	resetCmtRegElements(); <%--댓글 등록 작업 초기화 --%>
	resetRelyRegElements() ; <%--다른 답글 등록 작업 초기화 --%>
	resetReplyModElements() ; <%--다른 답글 수정 작업 초기화 --%>
	
	var strTxtBoxReply =
		  "<textarea class='form-control txtBoxReply' name='rcontent' style='margin-bottom:10px;'"
		+ " 		 placeholder='답글작성을 원하시면, &#10;답글 작성 버튼을 클릭해주세요.'"
		+ "			></textarea>"
		+ "<button type='button' class='btn btn-warning btn-xs btnRegReply'>답글 등록</button>"
		+ "<button type='button' class='btn btn-danger btn-xs btnCancelRegReply'"
		+ " 	   style='margin-left:4px;'>취소</button>";

	$(this).after(strTxtBoxReply);
	$(this).attr("style", "display:none;")
		
});

<%-- 답글 등록 취소 버튼 클릭 처리: 이벤트 전파 --%>
<%-- #chat > li:nth-child(1) > button.btn.btn-danger.btn-xs.btnCancelRegReply--%><%--
$(".btnCancelRegReply").on("click", function(){--%>
$("#chat").on("click", "li .btnCancelRegReply", function(){
	$(".btnRegReply").remove() ;
	$(".btnCancelRegReply").remove() ;
	$(".txtBoxReply").remove() ;
	$(".btnChgReplyReg").attr("style", "display: in-block;") ;

});


<%-- 답글 등록 버튼 클릭 처리: 이벤트 전파 
#chat > li:nth-child(1) > button.btn.btn-warning.btn-xs.btnRegReply  --%>
$("#chat").on("click", "li .btnRegReply", function(){
	
	var rcontent = $(this).prev().val() ;
	var loginUser = "홍길동" ;
	var prno = $(this).closest("li").data("rno") ;
	
	var reply = {tno: tnoValue, trcontent: trcontent, nickname: loginUser, trcno:trcno } ;
	
	myReplyClsr.registerReply(
			reply,
			function(result){
				alert(result + "번 답글이 등록되었습니다.") ;
				var pageNum = frmCmtPagingValue.find('input[name="pageNum"]').val() ;
				showCmtList(pageNum) ;
			}
	);
});

<%--댓글-답글 수정 초기화 --%>
function resetReplyModElements() {
	
	$("tr").attr("style", "display:in-block;white-space:pre;") ;
	$(".btnModCmt").remove() ;
	$(".btnDelCmt").remove() ;
	$(".btnCancelCmt").remove() ;
	$(".txtBoxMod").remove() ;
}



<%-- 댓글/답글 수정: 글내용이 표시된 p를 클릭 시 입력창, 수정, 삭제, 취소 버튼 화면 표시,  --%>
<%-- #chat > li:nth-child(1) > div > p --%><%--
$(".rcontent-p").on("click", function(){  //동작하지 않음 --%>
$("#chat").on("click","li div tr", function(){ <%-- 이벤트전파 --%>
<%-- textarea, 수정버튼, 삭제버튼, 취소버튼 표시
	 textarea에 기존 값이 표시되고, 수정거친 후 ajax로 전송
	 답글작성 버튼 감추기 --%>
	resetCmtRegElements() ;
	resetRelyRegElements() ;
	resetReplyModElements();
	
	$(this).parents("li").find(".btnChgReplyReg").attr("style", "display:none") ;
	
	var rcontent = $(this).text() ;

	var strTxtBoxReply =
		  "<textarea class='form-control txtBoxMod' name='rcontent' style='margin-bottom:10px;'"
		+ "         ></textarea>"
		+ "<button type='button' class='btn btn-warning btn-sm btnModCmt'>수정</button> "
		+ "<button type='button' class='btn btn-danger btn-sm btnDelCmt'>삭제</button>"
		+ "<button type='button' class='btn btn-info btn-sm btnCancelCmt' style='margin-left: 4px;'>취소</button>";
	
	$(this).after(strTxtBoxReply) ;
	$(".txtBoxMod").val(rcontent);
	$(this).attr("style", "display:none");
	
<%--예, div#id1 > div#id2 > ul > li > p : $("tr").closest("div") : div#id2--%>
<%--예, div#id1 > div#id2 > ul > li > p : $("tr").parents() : div#id1, div#id2, ul, li--%>
<%--예, div#id1 > div#id2 > ul > li > p : $("tr").parents("div") : div#id1, div#id2--%>
<%--예, div#id1 > div#id2 > ul > li > p : $("tr").parent() : li--%>
<%--	
//	잘못된 코드: $(this).closest(button): 선택된 tr를 기준으로 tr의 조상들(부모 포함) 중에 가장 가까운 button 을 찾음
//	$(this).closest("button").attr("style", "display:none") ; 
--%>
}) ;

<%-- 댓글-답글 수정 취소 --%>
<%-- #chat > li:nth-child(1) > div > button.btn.btn-info.btn-sm.btnCancelCmt --%>
$("#chat").on("click","li div button.btnCancelCmt", function(){

	<%--서버로 요청이 전달됨--%><%--
	var _pageNum = frmCmtPagingValue.find("input[name='pageNum']").val() ;
	showCmtList(_pageNum) ; --%>
	
	<%--브라우저에서 처리(서버 요청 없음)--%>
	$(this).parents("li").find("button.btnChgReplyReg").attr("style","in-block" );
	$(this).parents("li").find("p").attr("style", "display:in-block;white-space:pre-wrap;") ;
	$(this).siblings(".btnModCmt").remove();
	$(this).siblings(".btnDelCmt").remove();
	$(this).siblings(".txtBoxMod").remove();
	$(this).remove() ;

});


<%-- 댓글-답글 수정 --%>
<%-- #chat > li:nth-child(1) > div > button.btn.btn-warning.btn-sm.btnModCmt --%>
$("#chat").on("click", "li div button.btnModCmt", function(){
	
	var trcontent = $(this).prev().val() ;
	var trno = $(this).siblings("tr").data("trno") ;
	
	var cmtReply = {tno: tnoValue, trno: trno, trcontent: trcontent} ;
	
	myReplyClsr.modifyCmtReply(
			cmtReply,
			function(result){
				alert("댓글(답글)이 수정되었습니다.") ;
				var _pageNum = frmCmtPagingValue.find("input[name='pageNum']").val() ;
				showCmtList(_pageNum) ;
			}
	
	);
});

	
<%-- 댓글-답글 삭제 --%>
<%-- #chat > li:nth-child(1) > div > button.btn.btn-danger.btn-sm.btnDelCmt --%>
$("#chat").on("click","li div button.btnDelCmt", function(){
	if(!confirm("삭제하시겠습니까?")){
		return ;
	}
<%--	
	var trno = $(this).parents("li.commentLi").data("trno"); --%>
	var trno = $(this).closest("li.commentLi").data("trno") ;
	
	var tnoAndRno ={tno: tnoValue, trno: trno} ;
	
	myReplyClsr.removeCmtReply(
			tnoAndTrno,
			function(){
				alert("글이 삭제되었습니다.") ;
				
				var _pageNum = frmCmtPagingValue.find("input[name='pageNum']").val() ;
				showCmtList(_pageNum) ;
			}
	);
	
});

</script>


<script>
$(document).ready(function(){
	runModal(result) ;
	
	window.addEventListener("popstate", function (event) {
		history.pushState(null, null, location.href) ;
	}) ;
	
	history.pushState(null, null, location.href) ;

	showCmtList(1) ;<%--댓글-답글 표시 --%>
});
</script>











<%@include file="../pageinclude/footer.jsp" %> 