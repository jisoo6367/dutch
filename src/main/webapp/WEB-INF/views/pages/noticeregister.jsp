<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<c:set var="contextPath" value="${pageContext.request.contextPath }"/>

<%@include file="../pageinclude/header.jsp" %>

<div id="page-wrapper">
    <div class="row">
        <div class="col-lg-12">
            <h3 class="page-header">공지사항</h3>
        </div><%-- /.col-lg-12 --%>
    </div><%-- /.row --%>
    <div class="row">
        <div class="col-lg-12">
        
            <div class="panel panel-default">
                <div class="panel-heading"><h4></h4></div><%-- /.panel-heading --%>
                
                <div class="panel-body">

<form role="form" action="${contextPath }/notice/register" 
      method="post" name="frmNotice" id="frmNotice">
	<div class="form-group">
	    <label>제목</label>
	    <input class="form-control" name="ctitle" id="ctitle" placeholder="제목을 입력해주세요.">
	</div>

	<div class="form-group">
	    <label>내용</label>
	    <textarea class="form-control" rows="3" name="ccontent" id="ccontent"
	    		  placeholder="내용을 입력해주세요."></textarea>
	</div>
	<div class="form-group">
	    <label>닉네임</label> 
	    <input class="form-control" name="nickname" id="nickname" value="${nickname }" readonly="readonly">
	    	   
	</div>
	<button type="button" class="btn btn-primary" id="btnRegister">등록</button>
	<button type="button" class="btn btn-warning" 
	        onclick="location.href='${contextPath}/notice/list';">취소</button>
	<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }"/> 
	<%-- <sec:csrfInput/> --%>
	
</form>                  
                </div><!-- /.panel-body -->
            </div><!-- /.panel -->
        </div><!-- /.col-lg-12 -->
    </div><!-- /.row -->
</div>

<script>
function sendBoard(){
	var frmNotice = document.getElementById("frmNotice") ;
	var ctitle = document.getElementById("ctitle").value ;
	var ccontent = document.getElementById("ccontent").value ;
	var nickname = document.getElementById("nickname").value ;
	
	if( ctitle.length==0 || ccontent.length==0 || nickname.length==0 ){
		alert("글제목/글내용을 모두 입력해야 합니다.");
	} else {
		frmNotice.submit();
	}

}

$("#btnRegister").on("click", function(){
	sendBoard() ;
});

</script>


<%@include file="../pageinclude/footer.jsp" %> 