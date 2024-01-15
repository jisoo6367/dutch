<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<c:set var="contextPath" value="${pageContext.request.contextPath }"/>

<%@include file="../pageinclude/header.jsp" %>

<div id="page-wrapper">
    <div class="row">
        <div class="col-lg-12">
            <h3 class="page-header">1:1문의</h3>
        </div><%-- /.col-lg-12 --%>
    </div><%-- /.row --%>
    <div class="row">
        <div class="col-lg-12">
        
            <div class="panel panel-default">
                <div class="panel-heading"><h4>문의 등록</h4></div><%-- /.panel-heading --%>
                
                <div class="panel-body">

					<form role="form" action="${contextPath }/pages/qnaregister" 
					      method="post" name="frmQna" id="frmQna">
						<div class="form-group">
						    <label>문의제목</label>
						    <input class="form-control" name="qtitle" id="qtitle" placeholder="제목을 입력해주세요.">
						</div>
						<div class="form-group">
						    <label>문의내용</label>
						    <textarea class="form-control" rows="3" name="qcontent" id="qcontent"
						    		  placeholder="내용을 입력해주세요."></textarea>
						</div>
						<div class="form-group">
						    <label>닉네임</label>
						    <input class="form-control" name="nickname" id="nickname" placeholder="작성자의 아이디를 입력하세요..."><%--  --> 
						    <input class="form-control" name="nickname" id="nickname" readonly="readonly" 
						    	   value='<sec:authentication property="principal.username"/>'/> --%>
						    	   
						</div>
						<button type="button" class="btn btn-primary" id="btnRegister">등록</button>
						<button type="button" class="btn btn-warning" 
						        onclick="location.href='${contextPath}/pages/qnalist';">취소</button>
						<%-- 
						<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }"/> 
						<sec:csrfInput/>
						--%>
					</form>                  
                </div><!-- /.panel-body -->
            </div><!-- /.panel -->
        </div><!-- /.col-lg-12 -->
    </div><!-- /.row -->
</div>
<%-- 첨부파일 결과 표시 --%>    
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
	                        <%-- 업로드 후 처리결과가 표시될 영역 --%>
	                    </ul>
	                </div>
                </div><!-- /.panel-body -->
            </div><!-- /.panel -->
        </div><!-- /.col-lg-12 -->
    </div><!-- /.row -->
    
<%-- 등록 자바스크립트 시작 --%>
<script>

function sendBoard(){
	
	var frmQna = document.getElementById("frmQna") ;
	var qtitle = document.getElementById("qtitle").value ;
	var qcontent = document.getElementById("qcontent").value ;
	var nickname = document.getElementById("nickname").value ;
	
	if( qtitle.length==0 || qcontent.length==0 || nickname.length==0 ){
		alert("글제목/글내용/작성자를 모두 입력해야 합니다.");
	} else {
//		frmBoard.method="post";
//		frmBoard.action="${contextPath}/pages/noticeregister";
		frmQna.submit();
	}

}

$("#btnRegister").on("click", function(){
	sendBoard() ;
});

</script>


<%@include file="../pageinclude/footer.jsp" %> 