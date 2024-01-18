<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<c:set var="contextPath" value="${pageContext.request.contextPath }"/>

<%@include file="../pageinclude/header.jsp" %>

<style>
 th {text-align: center;}
</style>  

<div id="page-wrapper">
    <div class="row">
        <div class="col-lg-12">
            <h3 class="page-header">Notice - Modify</h3>
        </div><%-- /.col-lg-12 --%>
    </div><%-- /.row --%>
    <div class="row">
        <div class="col-lg-12">
        
            <div class="panel panel-default">
                <div class="panel-heading"><h4>수정 및 삭제</h4></div><%-- /.panel-heading --%>
                
                <div class="panel-body">

<form role="form" method="post" name="frmModify" id="frmModify">
	
	<div class="form-group">
	    <label>번호</label>
	    <input class="form-control" name="cno" id="cno" 
	           value='<c:out value="${notice.cno }"/>' readonly="readonly">
	</div>
	
	<div class="form-group">
	    <label>제목</label>
	    <input class="form-control" name="ctitle" id="ctitle" 
	    	   value="${notice.ctitle }" >
	</div>
	<div class="form-group">
	    <label>내용</label>
	    <textarea class="form-control" rows="3" name="ccontent" id="ccontent"
	    		  >${notice.ccontent}</textarea>
	</div>
	<div class="form-group">
	    <label>닉네임</label>
	    <input class="form-control" name="nickname" id="nickname" 
	      	  value="${notice.nickname}" readonly="readonly">
	</div>
	<div class="form-group">
	    <label>등록일</label>
	    <input class="form-control" name="cregDate" id="cregDate" 
	      	   value='<fmt:formatDate pattern="yyyy/MM/dd HH:mm:ss" value="${notice.cregDate}"/>' 
	      	   disabled="disabled">
	</div>

		<button type="button" class="btn btn-primary mybtns" id="btnModify" data-oper="modify">수정</button>
		<button type="button" class="btn btn-primary mybtns" id="btnRemove" data-oper="Noticeremove">삭제</button>
	
	
	<button type="button" class="btn btn-warning mybtns" id="btnList" data-oper="list">취소</button>
 	
 	<input type="hidden" id="pageNum" name="pageNum" value="${noticePagingDTO.pageNum }" >
	<input type="hidden" id="rowAmountPerPage" name="rowAmountPerPage" value="${noticePagingDTO.rowAmountPerPage }" ><%-- 
	<input type="hidden" id="scope" name="scope" value="${noticePagingDTO.scope }" > --%>
	<input type="hidden" id="keyword" name="keyword" value="${noticePagingDTO.keyword }" ><%-- 
	<input type="hidden" id="beginDate" name="beginDate" value="${noticePagingDTO.beginDate }" >
	<input type="hidden" id="endDate" name="endDate" value="${noticePagingDTO.endDate }" > --%>
<%-- 	<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }"/> --%>
</form>

                </div><%-- /.panel-body --%>
                
            </div><%-- /.panel --%>
        </div><%-- /.col-lg-12 --%>
    </div><%-- /.row --%>
  

</div><%-- /#page-wrapper --%>

<%-- 첨부파일 결과 표시 --%><%--    
    <div class="row">
        <div class="col-lg-12">
            <div class="panel panel-default">
                <div class="panel-heading">파일첨부</div><!-- /.panel-heading -->
                <div class="panel-body">
                    <div class="form-group uploadDiv">
                        <input id="inputFile" class="btn btn-primary inputFile" type="file" name="uploadFiles" multiple="multiple" /><br>
                    </div>
	                <div class="form-group fileUploadResult">
	                    <ul>
	                     업로드 후 처리결과가 표시될 영역
	                    </ul>
	                </div>
                </div><!-- /.panel-body -->
            </div><!-- /.panel -->
        </div><!-- /.col-lg-12 -->
    </div><!-- /.row --> --%>

<%-- 스크립트 시작 --%>
<script>

var frmModify = $("#frmModify") ;

$(".mybtns").on("click", function(){
	
	var operation = $(this).data("oper") ;
	//alert("operation: " + operation) ;
	
	if (operation == "modify") {
		frmModify.attr("action", "${contextPath}/notice/modify") ;
	
	} else if (operation == "Noticeremove"){
		frmModify.attr("action", "${contextPath}/notice/remove") ;
	
	} else {  //else if (operation == "list"){
		
		var pageNumInput = $("#pageNum").clone() ;
		var rowAmountPerPageInput = $("input[name='rowAmountPerPage']").clone() ;
		var keywordInput = $("#keyword").clone() ;
		
		frmModify.empty() ;
		
		frmModify.append(pageNumInput) ;
		frmModify.append(rowAmountPerPageInput) ;
		frmModify.append(keywordInput) ;
		
		frmModify.attr("action", "${contextPath}/notice/list").attr("method", "get") ; 
	}
	
	frmModify.submit() ;
});


<%-- 
var frmModify = $("#frmModify") ;

/* var myCsrfHeaderName = "${_csrf.headerName}" ;
var myCsrfToken = "${_csrf.token}" ; 

var frmModify = $("#frmModify") ;
var loginUser = "";

<sec:authorize access="isAuthenticated()">
	loginUser = '<sec:authentication property="principal.username"/>';
</sec:authorize> */

/* 수정된 게시물 입력값 유무 확인 함수 */
function checkNoticeValues(){
	
	var ctitle = document.getElementById("ctitle").value ;
	var ccontent = document.getElementById("ccontent").value ;
	
	if( ctitle.length==0 || ccontent.length==0  ){
		return false ;

	} else {
		return true ;
	}
}

$(".mybtns").on("click", function(){
	
	if (!checkNoticeValues()){
		alert("제목/내용을 모두 입력해야 합니다.");
		return ;
	}	
	
	var operation = $(this).data("oper") ;
	//alert("operation: " + operation) ;
	
	if (operation == "modify") {

		
		var emptyLi = $(".fileUploadResult ul li") ;
//		console.log(emptyLi)  ;
//		alert(emptyLi);
		if(emptyLi.data("filename") == undefined){
			//$(".fileUploadResult ul li").remove() ;
			emptyLi.remove() ;
		}
		
		frmModify.attr("action", "${contextPath}/pages/noticemodify") ;
	
	} else if (operation == "Noticeremove"){
		
		frmModify.attr("action", "${contextPath}/pages/remove") ;
	
	} else {  //else if (operation == "list"){
		
		var pageNumInput = $("#pageNum").clone() ;
		var rowAmountPerPageInput = $("input[name='rowAmountPerPage']").clone() ;/* 
		var scopeInput = $("#scope").clone() ; */
		var keywordInput = $("#keyword").clone() ;
		
		frmModify.empty() ;
		
		frmModify.append(pageNumInput) ;
		frmModify.append(rowAmountPerPageInput) ;/* 
		frmModify.append(scopeInput) ; */
		frmModify.append(keywordInput) ;
		
		frmModify.attr("action", "${contextPath}/pages/noticelist").attr("method", "get") ; 
	}
	
	frmModify.submit() ;
}); --%>
</script>

<%@include file="../pageinclude/footer.jsp" %> 