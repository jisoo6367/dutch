<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>   
<%-- <%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %> --%>

<c:set var="contextPath" value="${pageContext.request.contextPath }"/>

<%@include file="../pageinclude/header.jsp" %>

<div id="page-wrapper"> 
    <div class="row">
        <div class="col-lg-12">
            <h3 class="page-header">DuctPay 글등록</h3>
        </div>
        <!-- /.col-lg-12 -->
    </div>
    <!-- /.row -->
    <div class="row">
        <div class="col-lg-12">
            <div class="panel panel-default">

                <div class="panel-heading"><h4>더치페이 등록</h4></div>
                <!-- /.panel-heading -->

                <div class="panel-body">

<form role="form" action="${contextPath }/pages/dutchregister" 
      method="post" name="frmBoard" id="frmBoard">
	<div class="form-group">
	    <label>방제목</label>
	    <input class="form-control" name="ptitle" id="ptitle" placeholder="제목을 입력하세요.">
	</div>
	<div class="form-group">
		<label>카테고리</label>
	    <input class="form-control" name="category" id="category" placeholder="카데고리를 검색하세요.">
	</div>
	<div class="form-group">
		<label>회원고유번호</label>
	    <input class="form-control" name="mno" id="mno" placeholder="회원고유번호를 검색하세요.">
	</div>
	<div class="form-group">
        <label>방내용</label>
        <textarea class="form-control" rows="3" name="pcontent" id="pcontent" placeholder="내용을 입력하세요."></textarea>
    </div>
    <div class="form-group">
 		<label>전체금액</label>
	    <input class="form-control" name="ptotalPayment" id="ptotalPayment" placeholder="전체금액을 입력하세요.">
	</div>
	<div class="form-group">
 		<label>개인부담금액</label>
	    <input class="form-control" name="ppersonal" id="ppersonal" placeholder="개인부담금액을 입력하세요.">
	</div>  
   <!--<label>작성자</label>
	    <input class="form-control" name="pwriter" id="pwriter" placeholder="작성자를 입력하세요."> -->
	    <!-- <input class="form-control" name="bwriter" id="bwriter" readonly="readonly"/> --> 
	           <%-- value='<sec:authentication property="principal.username"/>' />--%>


	<button type="button" class="btn btn-primary" id="btnRegister">등록</button>
	<button type="button" class="btn btn-warning"
			onclick="location.href='${contextPath}/pages/dutchlist';">취소</button>


</form>

	</div>
	</div>
	</div>
	</div>


</div>
        <!-- /#page-wrapper -->

<script>
<%-- 더치페이 게시물에 입력값 유무 확인 함수 --%>
function checkBoardValues(){
	
	var ptitle = document.getElementById("ptitle").value ;
	var category = document.getElementById("category").value ;
	var mno = document.getElementById("mno").value ;
	var pcontent = document.getElementById("pcontent").value ;
	var ptotalPayment = document.getElementById("ptotalPayment").value ;
	var ppersonal = document.getElementById("ppersonal").value ;
	
	if (ptitle.length == 0 || category.length == 0 || mno.length == 0 || pcontent.length == 0 || ptotalPayment.length == 0 || ppersonal.length == 0) {
		
		return false;
	} else {
		return true ;
	}
	
}
<%-- 더치페이 등록버튼 값 --%>
$("#btnRegister").on("click", function(){
	
	if(!checkBoardValues()){
		alert("모든 항목을 전부 입력해주셔야 합니다.");
		return ; 
	}
	
	var frmBoard = $("#frmBoard") ;
	
	frmBoard.submit();
	
});
</script>



<%@include file="../pageinclude/footer.jsp" %> 