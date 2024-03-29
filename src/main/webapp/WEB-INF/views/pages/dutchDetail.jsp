<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>

<c:set var="contextPath" value="${pageContext.request.contextPath }" />

<%@include file="../pageinclude/header.jsp"%>

<style>
th {
	text-align: center;
}

p {
	white-space: pre-wrap;
}
</style>

<div id="page-wrapper">
	
	<div class="row">
		<div class="col-lg-12">
			<h3 class="page-header" style="white-space: nowrap;">
				<span class="glyphicon glyphicon-tags"></span>&nbsp; ${dto.dutchboard.ptitle}
			</h3>
		</div>
		<%-- /.col-lg-12 --%>
	</div>
	<%-- /.row --%>
	<div class="row">
		<div class="col-lg-12">
			<div class="panel panel-default">
				<div class="panel-heading">
					<div class="row">
						<div class="col-md-2"
							style="white-space: nowrap; height: 45px; padding-top: 11px;">
							<strong style="font-size: 16px;">${dto.dutchboard.nickname}
								님의 더치페이</strong>
						</div>
						<div class="col-md-3"
							style="white-space: nowrap; height: 45px; padding-top: 16px;">
							<span class="text-primary"
								style="font-size: smaller; height: 45px; padding-top: 19px;">
								<span> <span>등록일:&nbsp;</span> <strong><fmt:formatDate
											pattern="yyyy-MM-dd HH:mm:ss"
											value="${dto.dutchboard.pregDate}" /></strong> <span>&nbsp;&nbsp;</span>
							</span> <span>카테고리:&nbsp;<strong><c:out
											value="${dto.dutchboard.category}" /></strong></span>
							</span>
						</div>
						<div class="col-md-7" style="height: 45px; padding-top: 6px;">
							<%-- vertical-align: middle; --%>
							<div class="button-group pull-right">
								<button type="button" id="btnToList" data-oper="list"
									class="btn btn-warning">
									<span>목록</span>
								</button>
								<sec:authorize access="isAuthenticated()">
									<sec:authentication property="principal.username"
										var="username" />
										<c:if test="${username != dto.dutchboard.nickname }">
										<button type="button" id="btnReport" data-oper="report"
											class="btn btn-danger">
											<span>신고</span>
										</button>
										</c:if>
							
								</sec:authorize>
							</div>
						</div>
					</div>
					<%-- /.row--%>
				</div>
				<%-- /.panel-heading --%>

				<div class="panel-body form-horizontal">
					<!-- panel-body -->
					<div class="form-group">
						<label class="col-sm-2 control-label" style="white-space: nowrap;">글
							제목</label>
						<div class="col-sm-10">
							<input class="form-control" name="btitle" id="btitle"
								value="${dto.dutchboard.ptitle }" readonly="readonly">
						</div>
					</div>

					<div class="form-group">
						<label class="col-sm-2 control-label" style="white-space: nowrap;">글내용</label>
						<div class="col-sm-10">
							<textarea class="form-control" rows="3" name="pcontent"
								id="pcontent" style="resize: none;" readonly="readonly"><c:out
									value="${dto.dutchboard.pcontent}" /></textarea>
						</div>
					</div>
					
					<%-- <div class="form-group">
						<label class="col-sm-2 control-label" style="white-space: nowrap;">입금 은행</label>
						<div class="col-sm-10">
							<input class="form-control" id="bank"
								value="${bank}" readonly="readonly">
						</div>
					</div>
					
					<div class="form-group">
						<label class="col-sm-2 control-label" style="white-space: nowrap;">입금 계좌</label>
						<div class="col-sm-10">
							<input class="form-control" id="bankAccount"
								value="${bankAccount}" readonly="readonly">
						</div>
					</div> --%>

					<div class="form-group">
						<label class="col-sm-2 control-label" style="white-space: nowrap;">참여자
							목록</label>
						<div class="col-sm-10">
							<c:forEach var="user" items="${dto.partiList }">
								<c:if test="${user.nickname == dto.dutchboard.nickname}">
									<input class="form-control" name="partiMember" id="partiMember"
										value="${user.nickname} (총무)" readonly="readonly" />
								</c:if>
								<c:if test="${user.nickname != dto.dutchboard.nickname}">
									<input class="form-control" name="partiMember" id="partiMember"
										value="${user.nickname}" readonly="readonly" />
								</c:if>
							</c:forEach>
						</div>
					</div>

					<div class="form-group">
						<label class="col-sm-2 control-label" style="white-space: nowrap;">전체
							금액</label>
						<div class="col-sm-10">
							<input class="form-control" name="ptotalPayment"
								id="ptotalPayment" value="${dto.dutchboard.ptotalPayment }"
								readonly="readonly">
						</div>
					</div>

					<div class="form-group">
						<label class="col-sm-2 control-label" style="white-space: nowrap;">개인부담금액</label>
						<div class="col-sm-10">
							<input class="form-control" name="ppersonal" id="ppersonal"
								value="${dto.dutchboard.ppersonal }" readonly="readonly">
						</div>
					</div>

					<div class="form-group">
						<label class="col-sm-2 control-label" style="white-space: nowrap;">최종
							수정일</label>
						<div class="col-sm-10">
							<input class="form-control" name="bmodDate" id="bmodDate"
								value='<fmt:formatDate pattern="yyyy/MM/dd HH:mm:ss" value="${dto.dutchboard.pmodDate }"/>'
								readonly="readonly">
						</div>
					</div>
					<sec:authorize access="isAuthenticated()">
									<sec:authentication property="principal.username"
										var="username" />
									
									<c:if test="${username == dto.dutchboard.nickname || username == 'ADMIN'}">
										<c:choose>
											<c:when test="${dto.dutchboard.pcalculated == 0 }">
												<button type="button" id="btnToModify" data-oper="modify"
													class="btn btn-primary">
													<span>수정</span>
												</button>
												<button type="button" id="btnUpdatePcal" data-oper="modify"
													class="btn btn-success">
													<span>정산완료</span>
												</button>
											</c:when>
										</c:choose>
										<button type="button" id="btnToDelete" data-oper="delete"
											class="btn btn-danger">
											<span>삭제</span>
										</button>

									</c:if>
								</sec:authorize>
				</div>
				<%-- /.panel-body --%>
			</div>
			<%--  /.panel --%>
		</div>
		<%--  /.col-lg-12 --%>
	</div>
	<%-- .row --%>



	<%-- 첨부파일 결과 표시 --%>
	<div class="row">
		<div class="col-lg-12">
			<div class="panel panel-default">
				<div class="panel-heading">
					<strong style="font-size: 16px;">첨부 파일</strong>
				</div>
				<!-- /.panel-heading -->
				<div class="panel-body">
					<div class="form-group fileUploadResult">
						<ul style="list-style-type: none;">
							<c:choose>
								<c:when test="${empty attachFileList }">
									<li style="font-size: 12pt;">첨부파일이 없습니다</li>
								</c:when>
								<c:otherwise>
									<c:forEach var="attachFile" items="${attachFileList }">
										<c:choose>
											<c:when test="${attachFile.fileType == 'F' }">
												<li class="attachLi" data-repopath="${attachFile.repoPath }"
													data-uploadpath="${attachFile.uploadPath }"
													data-uuid="${attachFile.uuid }"
													data-filename="${attachFile.fileName }" data-filetype="F"
													style="margin-top: 6px;">
													<img src='${contextPath}/resources/img/icon-attach.png'
													style='width: 25px;'>
													&nbsp;&nbsp;${attachFile.fileName}
												</li>
											</c:when>
											<c:otherwise>
												<c:set var="thumbnail"
													value="${attachFile.repoPath}/${attachFile.uploadPath}/s_${attachFile.uuid}_${attachFile.fileName}" />
												<li class="attachLi" data-repopath="${attachFile.repoPath }"
													data-uploadpath="${attachFile.uploadPath }"
													data-uuid="${attachFile.uuid }"
													data-filename="${attachFile.fileName }" data-filetype="I"
													style="margin-top: 6px;">
													<img
													src='${contextPath}/dutchDisplayThumbnail?fileName=${thumbnail}'
													style='width: 25px;'>
													&nbsp;&nbsp;${attachFile.fileName}
												</li>
												<c:remove var="thumbnail" />
											</c:otherwise>
										</c:choose>
									</c:forEach>
								</c:otherwise>
							</c:choose>
						</ul>
					</div>
					<%-- /.fileUploadResult --%>
				</div>
				<!-- /.panel-body -->
			</div>
			<!-- /.panel -->
		</div>
		<!-- /.col-lg-12 -->
	</div>
	<!-- /.row -->

	<%-- Modal --%>
	<div class="modal fade" id="yourModal" tabindex="-1" role="dialog"
		aria-labelledby="yourModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
					<h4 class="modal-title" id="yourModalLabel">Modal title</h4>
				</div>
				<div class="modal-body" id="yourModal-body">dutch detail 메시지</div>

				<div class="modal-footer">
					<button type="button" class="btn btn-primary" data-dismiss="modal">Close</button>
				</div>
			</div><%-- /.modal-content --%>
		</div><%-- /.modal-dialog --%>
	</div><%-- /.modal --%>
	
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
	</div><%-- /#page-wrapper --%>


	<form id="frmSendValue">
		<input type="hidden" name="pno" id="pno" value="${dto.dutchboard.pno}" />

	</form>


	<%-- 댓글 요소 시작 --%>
	<div class="row">
		<div class="col-lg-12">
			<div class="panel panel-default">
				<div class="panel-heading">
					<div style="margin-bottom: 0px; font-size: 16px;">
						<strong style="padding-top: 2px;"> <span id="replyTotal"></span>
							<span>&nbsp;</span> <sec:authorize access="isAuthenticated()">
								<button type="button" id="btnChgCmtReg"
									class="btn btn-info btn-sm">댓글 작성</button>

								<button type="button" id="btnRegCmt"
									class="btn btn-warning btn-sm" style="display: none">댓글
									등록</button>
								<button type="button" id="btnCancelRegCmt"
									class="btn btn-warning btn-sm" style="display: none">취소</button>&nbsp;&nbsp;&nbsp;
</sec:authorize> <sec:authorize access="isAuthenticated()">
								<span id="spanLoginUser" style="display: none"> <strong><sec:authentication
											property="principal.username" /> 님 작성</strong>
								</span>
							</sec:authorize>


						</strong>
					</div>
				</div>
				<%-- /.panel-heading --%>
				<div class="panel-body">

					<sec:authorize access="isAuthenticated()">
						<%-- 댓글 입력창 div 시작 --%>
						<div class="form-group" style="margin-bottom: 5px;">
							<textarea class="form-control txtBoxCmt" name="rcontent"
								placeholder="댓글작성을 원하시면,&#10;댓글 작성 버튼을 클릭해주세요."
								readonly="readonly"></textarea>
						</div>
					</sec:authorize>
					<hr style="margin-top: 10px; margin-bottom: 10px;">
					<%-- 댓글 입력창 div 끝 --%>

					<ul class="chat" id="chat" style="list-style-type: none;">

						<%-- 댓글 목록 표시 영역 - JavaScript로 내용이 생성되어 표시됩니다.--%>

					</ul>
					<%-- /.chat --%>

				</div>
				<%-- /.panel-body --%>
				<div class="panel-footer text-center" id="showCmtPagingNums">
					<%-- 댓글 목록의 페이징 번호 표시 영역 - JavaScript로 내용이 생성되어 표시됩니다.--%>
				</div>
			</div>
			<%-- /.panel --%>
		</div>
		<%-- .col-lg-12 --%>
	</div>
	<%-- .row : 댓글 화면 표시 끝 --%>

	<form id="frmCmtPagingValue">
		<input type="hidden" name="pageNum" value=""> <input
			type="hidden" name="rowAmountPerPage" value="">
	</form>


<%-- page-wrapper--%>







<script>

var frmSendValue = $("#frmSendValue") ;
var pno = "<c:out value='${dto.dutchboard.pno}'/>" ;

<%-- 게시물 목록 페이지로 이동 --%>
$("#btnToList").on("click", function(){
	
	frmSendValue.attr("action", "${contextPath}/pay/list").attr("method", "get");
	frmSendValue.submit();
	
});

<%-- 게시물 수정-삭제 페이지로 이동 --%>
$("#btnToModify").on("click", function(){
	
	frmSendValue.append("<input type='hidden' name='pno' value=' " + pno + " '/>");
	frmSendValue.attr("action", "${contextPath}/pay/modify").attr("method", "get");
	frmSendValue.submit();
	
});

<%-- 게시글 삭제 버튼 눌렀을 때--%>
$("#btnToDelete").on("click", function(){
	
 	if(confirm("삭제 하시겠습니까?")){
 		frmSendValue.attr("action", "${contextPath}/pay/delete").attr("method", "get") ;
 		frmSendValue.submit() ;
	} 
});


<%-- 정산 완료 버튼 눌렀을 때--%>
$("#btnUpdatePcal").on("click", function(){
	
 	if(confirm("정산완료처리 하시겠습니까?")){
 		frmSendValue.attr("action", "${contextPath}/pay/finish").attr("method", "get") ;
 		frmSendValue.submit() ;
	} 
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

<%-- 신고 버튼 눌렀을 때--%>
$("#btnReport").on("click", function(){
	
 	if(confirm("신고 하시겠습니까?")){
 		frmSendValue.attr("action", "${contextPath}/pay/report").attr("method", "get") ;
 		frmSendValue.submit() ;
	} 
});
</script>




<%-- 댓글/답글 자바스크립트 시작--%>
<script type="text/javascript"
	src="${contextPath }/resources/js/dutchComment.js"></script>
<script type="text/javascript">

var myCsrfHeaderName = "${_csrf.headerName}" ;
var myCsrfToken = "${_csrf.token}" ;

$(document).ajaxSend(function(e, xhr){
	xhr.setRequestHeader(myCsrfHeaderName, myCsrfToken) ;
		
});



var pnoValue = '<c:out value="${dto.dutchboard.pno}"/>' ;

var commentUL = $("#chat") ;

var frmCmtPagingValue = $("#frmCmtPagingValue") ;

var loginUser = "" ;

<sec:authorize access="isAuthenticated()">
	loginUser = '<sec:authentication property="principal.username"/>' ;
</sec:authorize>

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

<%-- 선택된 페이징 번호 클릭 시, 댓글목록 가져오는 함수: 이벤트 전파 이용 --%>
<%-- #showCmtPagingNums > div > ul > li:nth-child(2) > a --%>
$("#showCmtPagingNums").on("click","div ul li a", function(e){
	e.preventDefault() ;
	var targetPageNum = $(this).attr("href") ;
	showCmtList(targetPageNum) ;
});


<%--댓글목록 표시 함수: 서버로부터 전달된 데이터를 이용해서 댓글 목록을 표시하는 JS 함수--%>
function showCmtList(pageNum){
	
	dutchReplyClsr.getCmtList(
		{pno: pnoValue, pageNum: pageNum || 1} ,
		
		function(dutchReplyPagingCreator){
			
			$("#replyTotal").html("댓글&nbsp;" + dutchReplyPagingCreator.replyTotCnt + "개") ;
			
			frmCmtPagingValue.find("input[name='pageNum']").val(pageNum) ;
			frmCmtPagingValue.find("input[name='rowAmountPerPage']").val(dutchReplyPagingCreator.myreplyPaging.rowAmountPerPage) ;
			
			var str = '' ;
			
			if(!dutchReplyPagingCreator.myreplyList || dutchReplyPagingCreator.myreplyList.length == 0){
				str += '<li class="left clearfix commentLi" '
					+ ' 	style="text-align: center; background-color: lightCyan;'
					+ ' 	height: 35px;margin-bottom: 0px;padding-bottom:0px;'
					+ ' 	padding-top:6px;border: 1px dotted;">'
					+ ' 	<strong>등록된 댓글이 없습니다.</strong></li>';
				
				commentUL.html(str) ;
				return ;
			} 
			
			for(var i = 0, len = dutchReplyPagingCreator.myreplyList.length; i < len ; i++) {
				if(dutchReplyPagingCreator.myreplyList[i].rdelFlag == 1) {
				str +='<li class="left clearfix commentLi">'
					+ ' <div style="background-color: Moccasin; text-align: center">'
				    + '     <em>삭제된 글입니다.</em>'
					+ ' </div>'
					+ '</li>';
				
				} else {
				str +='<li class="left clearfix commentLi" '
				    + '    data-pno="' + pnoValue + '" '
				    + '    data-rno="' + dutchReplyPagingCreator.myreplyList[i].rno + '" '
				    + '    data-nickname="' + dutchReplyPagingCreator.myreplyList[i].nickname + '" '
				    + '    data-rdelFlag="' + dutchReplyPagingCreator.myreplyList[i].rdelFlag + '">' ;
					<%-- 댓글 답글 들여쓰기 --%>
					if(dutchReplyPagingCreator.myreplyList[i].lvl == 1){
				
				str += '<div>' ;
				
					} else if (dutchReplyPagingCreator.myreplyList[i].lvl == 2){
				str += '<div style="padding-left: 25px;">' ;
					
					} else if (dutchReplyPagingCreator.myreplyList[i].lvl == 3){
				str += '<div style="padding-left: 50px;">' ;		
					
					} else if (dutchReplyPagingCreator.myreplyList[i].lvl == 4){
				str += '<div style="padding-left: 70px;">' ;
					
					} else { <%-- 답글의 레벨이 5이상이면 동일한 들여쓰기 --%>
				str += '<div style="padding-left: 100px;">' ;
						
					}
				<%-- 답글에 대한 아이콘 표시  --%>	
				if(dutchReplyPagingCreator.myreplyList[i].lvl > 1) {
				str += '    <span class="glyphicon glyphicon-share-alt"></span>&nbsp;';
				
				}	

				str +='    <span class="header info-nickname">'
				    + '        <strong class="primary-font">' + dutchReplyPagingCreator.myreplyList[i].nickname + '</strong>&nbsp;&nbsp;'
				    + '        <small class="text-muted">' 
				    +             dutchReplyClsr.myDateTimeFmt(dutchReplyPagingCreator.myreplyList[i].rregDate)
				    + '        </small>'
				    <sec:authorize access="isAuthenticated()">

					 str+='    <button type="button" style="display:in-block;" ' 
					    + '            class="btn btn-primary btn-xs btnChgReplyReg">답글 달기<span class="glyphicon glyphicon-pencil"></span></button>' ;
					</sec:authorize>
				str +='    </span>'<%-- 
				    + '    <p style="white-space:pre-wrap;" data-pno="' + dutchReplyPagingCreator.myreplyList[i].pno + '"' --%> 
				    + '    <p class="rcontent-p" style="white-space:pre-wrap;"'
				    + '       data-pno="' + dutchReplyPagingCreator.myreplyList[i].pno + '"'
				    + '       data-rno="' + dutchReplyPagingCreator.myreplyList[i].rno + '">'
				    +         dutchReplyPagingCreator.myreplyList[i].rcontent + '</p>'
				    + '</div>' ;

				

				 str+='</li>' ;
				}

			}<%--for-end--%>
			
			commentUL.html(str) ;
			
			showCmtPagingNums(dutchReplyPagingCreator.replyTotCnt, 
							  dutchReplyPagingCreator.myreplyPaging.pageNum,
							  dutchReplyPagingCreator.myreplyPaging.rowAmountPerPage);
			
		}<%--callback-function-end --%>
			
	); <%--dutchReplyClsr.getCmtList(); 완료--%>
	
	
}<%--showCmtList-end --%>

<%--댓글 추가 초기화 함수 --%>
function resetCmtRegElements(){
	$("#btnChgCmtReg").attr("style", "display:in-block;") ;
	$("#btnRegCmt").attr("style", "display:none") ;
	$("#btnCancelRegCmt").attr("style", "display:none;") ;
	$(".txtBoxCmt").val("")
				   .attr("readonly", true)
				   .attr("placeholder", "댓글작성을 원하시면,\n댓글 작성 버튼을 클릭해주세요.") ;
	
	$("#spanLoginUser").attr("style", "display:none;") ;

}

<%-- 댓글 작성 버튼 클릭 처리 --%>
$("#btnChgCmtReg").on("click", function(){
	
	resetRelyRegElements() ;
	resetReplyModElements() ;
	
	$(this).attr("style", "display:none;") ;
	$("#btnRegCmt").attr("style", "display:in-block; margin-right:2px") ;
	$("#btnCancelRegCmt").attr("style", "display:in-block;") ;
	$(".txtBoxCmt").attr("placeholder", "").attr("readonly", false) ;
	$("#spanLoginUser").attr("style", "display:in-block") ;
	
});

<%-- 댓글 등록 버튼 클릭 처리: 이벤트 전파 --%>
$("#btnRegCmt").on("click", function(){
	
	var rcontent = $(".txtBoxCmt").val() ;
		
	var reply = {pno: pnoValue, rcontent: rcontent, nickname: loginUser } ;
	
	dutchReplyClsr.registerCmt(
			reply,
			function(result){
				if (result != null) {
					alert("댓글이 등록되었습니다.") ;	
				} else {
					alert("서버 장애로 댓글 등록이 취소되었습니다.") ;
				}
				
				resetCmtRegElements() ;
				
				showCmtList(-10) ;
			}
	);
	
});

<%-- 댓글 등록 "취소" 버튼 클릭 처리 --%>
$("#btnCancelRegCmt").on("click", "", function(){

	resetCmtRegElements() ;
	
});


<%--답글 작성 초기화 함수 --%>
function resetRelyRegElements() {
	$(".btnRegReply").remove() ;
	$(".btnCancelRegReply").remove() ;
	$(".txtBoxReply").remove() ;
	$(".btnChgReplyReg").attr("style", "display: in-block;") ;
	$("#replyloginUserSpan").attr("style", "display: none;") ;
}

<%--답글 작성 버튼 클릭 처리--%>
$("#chat").on("click","li .btnChgReplyReg" , function(){
	
	resetCmtRegElements(); <%--댓글 등록 작업 초기화 --%>
	resetRelyRegElements() ; <%--다른 답글 등록 작업 초기화 --%>
	resetReplyModElements() ; <%--다른 답글 수정 작업 초기화 --%>
	
<%--로그인 하지 않은 경우--%>
	if(!loginUser) {
		return ;
	}
	
<%--로그인 계정이 자신의 댓글/답글에 답글 등록을 하려는 경우를 방지 --%>	
	var nickname = $(this).closest("li").data("nickname") ;
	
	if (loginUser == nickname) {
		return ;
	}
	
	var strTxtBoxReply = "" ;
	
	<sec:authorize access="isAuthenticated()">
	strTxtBoxReply
		+='<span id="replyloginUserSpan" style="display:in-block">'  
		+ '    <strong><sec:authentication property="principal.username"/>님 작성</strong>'
		+ '</span>' ;
	</sec:authorize>
	strTxtBoxReply
		+='<textarea class="form-control txtBoxReply" name="rcontent" style="margin-bottom:10px;"'
		+ '		 placeholder="답글작성을 원하시면, &#10;답글 작성 버튼을 클릭해주세요."'
		+ '			></textarea>'
		+ '<button type="button" class="btn btn-warning btn-xs btnRegReply">답글 등록</button>'
		+ '<button type="button" class="btn btn-danger btn-xs btnCancelRegReply"'
		+ ' 	   style="margin-left:4px;">취소</button>';

	$(this).after(strTxtBoxReply);
	$(this).attr("style", "display:none;")
		
});

<%-- 답글 등록 취소 버튼 클릭 처리--%>
$("#chat").on("click", "li .btnCancelRegReply", function(){
	$(".btnRegReply").remove() ;
	$(".btnCancelRegReply").remove() ;
	$(".txtBoxReply").remove() ;
	$(".btnChgReplyReg").attr("style", "display: in-block;") ;

});


<%-- 답글 등록 버튼 클릭 처리--%>
$("#chat").on("click", "li .btnRegReply", function(){
	
	var rcontent = $(this).prev().val() ;
//	var loginUser = "홍길동" ;
	var rcno = $(this).closest("li").data("rno") ;

	
	var reply = {pno: pnoValue, rcontent: rcontent, nickname: loginUser, rcno: rcno } ;
	
	dutchReplyClsr.registerReply(
			reply,
			function(result){
				alert("답글이 등록되었습니다.") ;
				var pageNum = frmCmtPagingValue.find('input[name="pageNum"]').val() ;
				showCmtList(pageNum) ;
			}
	);
});

<%--댓글-답글 수정 초기화 --%>
function resetReplyModElements() {
	
	$("p").attr("style", "display:in-block;white-space:pre;") ;
	$(".btnModCmt").remove() ;
	$(".btnDelCmt").remove() ;
	$(".btnCancelCmt").remove() ;
	$(".txtBoxMod").remove() ;
}


$("#chat").on("click","li div p", function(){
<%-- textarea, 수정버튼, 삭제버튼, 취소버튼 표시
	 textarea에 기존 값이 표시되고, 수정거친 후 ajax로 전송
	 답글작성 버튼 감추기 --%>
	resetCmtRegElements() ;
	resetRelyRegElements() ;
	resetReplyModElements();
	
<%--로그인 하지 않은 경우--%>
	if(!loginUser) {
		alert("로그인 후 수정이 가능합니다.") ;
		return ;
	}
	
<%--로그인 계정과 작성자가 다른 경우--%>	
	var nickname = $(this).closest("li").data("nickname") ;
	
	if (loginUser != nickname) {
		alert("작성자만 수정할 수 있습니다.") ;
		return ;
	}

	
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
	
}) ;

$("#chat").on("click","li div button.btnCancelCmt", function(){

	$(this).parents("li").find("button.btnChgReplyReg").attr("style","in-block" );
	$(this).parents("li").find("p").attr("style", "display:in-block;white-space:pre-wrap;") ;
	$(this).siblings(".btnModCmt").remove();
	$(this).siblings(".btnDelCmt").remove();
	$(this).siblings(".txtBoxMod").remove();
	$(this).remove() ;

});

$("#chat").on("click", "li div button.btnModCmt", function(){
	
	var rcontent = $(this).prev().val() ;
	var rno = $(this).siblings("p").data("rno") ;
	var nickname = $(this).parents("li").data("nickname") ;
	
	var cmtReply = {pno: pnoValue, rno: rno, rcontent: rcontent, nickname: nickname} ;
	
	dutchReplyClsr.modifyCmtReply(
			cmtReply,
			function(result){
				alert("댓글(답글)이 수정되었습니다.") ;
				var _pageNum = frmCmtPagingValue.find("input[name='pageNum']").val() ;
				showCmtList(_pageNum) ;
			}
	
	);
});

$("#chat").on("click","li div button.btnDelCmt", function(){
	if(!confirm("삭제하시겠습니까?")){
		return ;
	}
	var rno = $(this).closest("li.commentLi").data("rno") ;
	var nickname = $(this).parents("li.commentLi").data("nickname") ;
	
	var myReplyCmt ={pno: pnoValue, rno: rno, nickname: nickname} ;

	dutchReplyClsr.removeCmtReply(
			myReplyCmt,
			function(){
				alert("글이 삭제되었습니다.") ;
				
				var _pageNum = frmCmtPagingValue.find("input[name='pageNum']").val() ;
				showCmtList(_pageNum) ;
			}
	);
	
});

</script>


<script>

var modifyResult = '<c:out value="${modifyResult}" />' ;
<%-- 수정시 모달 호출 함수--%>
function runModal(modifyResult) {
	
	console.log(modifyResult);
	if (modifyResult.length == 0) {
		return ;
	
	} else if ( modifyResult == "true" ) {
		var myMsg =  "수정 되었습니다. " ;

		
	} else if ( modifyResult == "false" ) {
		var myMsg =  "수정 실패하였습니다." ;
		
	} 
	$("#yourModal-body").html(myMsg) ;
	
	$("#yourModal").modal("show") ;
	
	myMsg = "" ;
}

$(document).ready(function(){

	runModal(modifyResult) ;
	
	window.addEventListener("popstate", function (event) {
		history.pushState(null, null, location.href) ;
	}) ;
	
	history.pushState(null, null, location.href) ;

	showCmtList(1) ;
	console.log("readyend")
});
 
 
 
</script>


<%-- 첨부파일 이미지 표시 --%>
<script>
$(".attachLi").on("click", function(){
	var objLi = $(this) ;
	
	var myFileName = objLi.data("repopath") + "/" + objLi.data("uploadpath") + "/" 
				   + objLi.data("uuid") + "_" + objLi.data("filename") ;
	
	var myFileType = objLi.data("filetype") ;
	
	if(myFileType == "I") {
		$("#attachModal-body").html("<img src='${contextPath}/dutchFileDownloadAjax?fileName=" 
										      + encodeURI(myFileName) 
										      + "' style='width:100%;'>") ;
		$("#attachModal").modal("show") ;
	
	} else {
		self.location.href ="${contextPath}/dutchFileDownloadAjax?fileName="  + encodeURI(myFileName) ;
	}
	
});

<%-- 표시된 이미지 모달 감추기 --%>
$("#attachModal").on("click", function(){
	$("#attachModal").modal("hide") ;
});

</script>











<%@include file="../pageinclude/footer.jsp"%>
