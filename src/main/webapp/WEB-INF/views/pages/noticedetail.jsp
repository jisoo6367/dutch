<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<c:set var="contextPath" value="${pageContext.request.contextPath }"/>

<%@include file="../pageinclude/header.jsp" %>

<style>
 th {text-align: center;}
 p {white-space:pre-wrap;}
</style>  

<div id="page-wrapper">
    <div class="row">
        <div class="col-lg-12">
            <h3 class="page-header"
				style="white-space: nowrap;">공지사항
				 <small>
				 	&nbsp;&nbsp;&nbsp;<c:out value="${notice.cno}"/>번 게시물
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
							<strong style="font-size:16px;">${notice.nickname}님 작성</strong>
						</div>
						<div class="col-md-3" style="white-space: nowrap; height: 45px; padding-top:16px;">
							<span class="text-primary" style="font-size: smaller; height: 45px; padding-top: 19px;">
								<span>
									<span>등록일:&nbsp;</span>
									<strong><fmt:formatDate 
												pattern="yyyy-MM-dd HH:mm:ss"
												value="${notice.cregDate}"
											 /></strong>
									<span>&nbsp;&nbsp;</span>
								</span>
								<span>조회수:&nbsp;<strong><c:out value="${notice.cviewCnt}"/></strong>
								</span>
							</span>
						</div>
						<div class="col-md-7" style="height: 45px; padding-top:6px;"><%-- vertical-align: middle; --%>
							<div class="button-group pull-right">


<!-- <sec:authorize access="isAuthenticated()">
	<sec:authentication property="principal.username" var="username"/> -->
		<%-- <c:if test="${username eq notice.mno }"> --%>
							<button type="button" id="btnToModify" data-oper="noticemodify"
									class="btn btn-primary"><span>수정</span></button>
		<%-- </c:if> --%>
<!-- </sec:authorize> -->
									
							<button type="button" id="btnToList" data-oper="noticelist"
									class="btn btn-warning"><span>목록</span></button>
							</div>
						</div>
					</div>
                </div><!-- /.panel-heading --><%-- /.panel-heading --%>
                
                <div class="panel-body form-horizontal">

	
	<div class="form-group">
	    <label class="col-sm-2 control-label" style="white-space: nowrap;">제목</label>
	    <div class="col-sm-10">
	    	<input class="form-control" name="ctitle" id="ctitle" 
	    		   value="${notice.ctitle }" readonly="readonly">
		</div>
	</div>
	<div class="form-group">
	    <label class="col-sm-2 control-label" style="white-space: nowrap;">내용</label>
	    <%-- <textarea>와 </textarea>는 표시 내용과 붙어있어야 필요없는 공백이 포함되지 않음 --%>
	    <div class="col-sm-10">
	    	<textarea class="form-control" rows="3" name="ccontent" id="ccontent"
	    			  style="resize: none;"
	    			  readonly="readonly"><c:out value="${notice.ccontent}"/></textarea>
		</div>	    			  
	</div>
<%-- 
<div class="form-group">
	    <label class="col-sm-2 control-label" style="white-space: nowrap;">최종수정일</label>
	    <div class="col-sm-10">
	    	<input class="form-control" name="cmodDate" id="cmodDate" 
	      		   value='<fmt:formatDate pattern="yyyy/MM/dd HH:mm:ss" value="${myboard.bmodDate }"/>' readonly="readonly">
		</div> --%>
	</div><%-- 여기까지 noticedetail복사 2024 01 05 --%>

<%-- Modal: 게시물 수정 후, 수정 결과 표시 모달 --%>
<div class="modal fade" id="NoticeModal" tabindex="-1" role="dialog" aria-labelledby="NoticeModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="NoticeModalLabel">Modal title</h4>
            </div>
            <div class="modal-body" id="yourModal-body">메시지</div>
            
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" data-dismiss="modal">Close</button>
            </div>
        </div><%-- /.modal-content --%>
    </div><%-- /.modal-dialog --%>
</div><%-- /.modal --%>

<form id="frmSendValue">
	<input type="hidden" name="pageNum" value="${noticePaging.pageNum }" >
	<input type="hidden" name="rowAmountPerPage" value="${noticePaging.rowAmountPerPage }" >
	<input type="hidden" name="keyword" value="${noticePaging.keyword }" >
</form>
                </div><%-- /.panel-body --%>
                
            </div><%-- /.panel --%>
        </div><%-- /.col-lg-12 --%>
    </div><%-- /.row --%>

<%-- 첨부파일 결과 표시 --%><%--     
    <div class="row">
        <div class="col-lg-12">
            <div class="panel panel-default">
                <div class="panel-heading">
                	<strong style="font-size:16px;">첨부 파일</strong>
                </div>/.panel-heading
                <div class="panel-body">
                    <div class="form-group uploadDiv">
                        <input id="inputFile" class="btn btn-primary inputFile" type="file" name="uploadFiles" multiple="multiple" /><br>
                    </div>
	                <div class="form-group fileUploadResult">
	                    <ul> --%>
<%-- 업로드 후 처리결과가 표시될 영역 --%><%-- 
<c:choose>
<c:when test="${empty notice.attachFileList }">
	<li style="font-size: 12pt;">첨부파일이 없습니다</li>
</c:when>
<c:otherwise>
	<c:forEach var="attachFile" items="${notice.attachFileList }">
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
    </div><!-- /.row --> --%>

<%-- Modal: 첨부파일 이미지 표시 --%><!--  
<div class="modal fade" id="attachModal" tabindex="-1" role="dialog" aria-labelledby="attachModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-body" id="attachModal-body">
            	이미지표시
            </div>
        </div><%-- /.modal-content --%>
    </div><%--/.modal-dialog --%>
</div><%--/.modal --%>-->

<form id = "frmCmtPagingValue">
	<input type="hidden" name="pageNum" value="">
	<input type="hidden" name="rowAmountPerPage" value="">
</form>

</div><%-- /#page-wrapper --%>

<%-- 상세 자바스크립트 시작 --%>
<script>

var frmSendValue = $("#frmSendValue") ;

<%-- 게시물 목록 페이지 이동 --%>
$("#btnToList").on("click", function(){

	/* window.location.href="${contextPath}/pages/noticelist" */ ;

 	frmSendValue.attr("action", "${contextPath}/notice/list").attr("method", "get") ;
	frmSendValue.submit() ; 
});

<%-- 게시물 수정-삭제 페이지 이동 --%>
$("#btnToModify").on("click", function(){
	
	window.location.href='${contextPath}/notice/modify?cno=<c:out value="${notice.cno}"/>' ;
	
	/* var cno = '<c:out value="${notice.cno}"/>' ;
	
	frmSendValue.append("<input type='hidden' name='cno' value='" + cno + "'/>") ;
	frmSendValue.attr("action", "${contextPath}/notice/noticemodify").attr("method", "get") ;
	frmSendValue.submit() ; */
});

var result = '<c:out value="${result}" />' ;

function runModal(result) {
//	if (result.length == 0|| history.state) {
	if (result.length == 0) {
		return ;
	
	} else if ( result == "successModify" ) {
		var noticeMsg =  "게시글이 수정되었습니다. " ;
		
	}  
//모달 사용 시
	$("#NoticeModal-body").html(noticeMsg) ;
	
	$("#NoticeModal").modal("show") ;
	
	noticeMsg = "" ;
}
</script>

<%@include file="../pageinclude/footer.jsp" %> 