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
		<button type="button" class="btn btn-primary mybtns" id="btnRemove" data-oper="remove">삭제</button>
	
	
	<button type="button" class="btn btn-warning mybtns" id="btnList" data-oper="list">취소</button>
 	
 	<input type="hidden" id="pageNum" name="pageNum" value="${noticePagingDTO.pageNum }" >
	<input type="hidden" id="rowAmountPerPage" name="rowAmountPerPage" value="${noticePagingDTO.rowAmountPerPage }" >
	<input type="hidden" id="keyword" name="keyword" value="${noticePagingDTO.keyword }" >
	<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }"/>
</form>

                </div><%-- /.panel-body --%>
                
            </div><%-- /.panel --%>
        </div><%-- /.col-lg-12 --%>
    </div><%-- /.row --%>
  

</div><%-- /#page-wrapper --%>


<%-- 스크립트 시작 --%>
<script>

var frmModify = $("#frmModify") ;

$(".mybtns").on("click", function(){
	
	var operation = $(this).data("oper") ;
	
	if (operation == "modify") {
		frmModify.attr("action", "${contextPath}/notice/modify") ;
	
	} else if (operation == "remove"){
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

</script>

<%@include file="../pageinclude/footer.jsp" %> 