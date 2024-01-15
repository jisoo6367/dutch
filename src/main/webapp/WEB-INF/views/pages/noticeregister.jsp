<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

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

<form role="form" action="${contextPath }/pages/noticeregister" 
      method="post" name="frmNotice" id="frmNotice">
	<div class="form-group">
	<%--	<label>카테고리</label>
	<select name="noticeCategory">
        <option value="notice">알림</option>
        <option value="briefing">브리핑</option>
    </select> 
    <select class="form-control" id="selectScope" name="scope">
			<option value="N" ${(noticeCreator.noticePaging.scope == "N" ) ? "selected" : "" }>알림</option>
			<option value="B" ${(noticeCreator.noticePaging.scope == "T" ) ? "selected" : "" }>브리핑</option>
	</select> --%>
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
	    <input class="form-control" name="nickname" id="nickname" placeholder="작성자의 아이디를 입력하세요..."><!-- 
	    <input class="form-control" name="nickname" id="nickname" readonly="readonly" 
	    	   value='<sec:authentication property="principal.username"/>'/>-->
	    	   
	</div>
	<!-- 
	<button type="button" class="btn btn-primary" onclick="sendBoard();" id="btnRegister">등록</button> -->
	<button type="button" class="btn btn-primary" id="btnRegister">등록</button>
	<button type="button" class="btn btn-warning" 
	        onclick="location.href='${contextPath}/pages/noticelist';">취소</button>
	<%-- 
	<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }"/> 
	<sec:csrfInput/>--%>
	
</form>                  
                </div><!-- /.panel-body -->
            </div><!-- /.panel -->
        </div><!-- /.col-lg-12 -->
    </div><!-- /.row -->
</div>

<%-- 첨부파일 결과 표시 --%> <%--    
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
  

</div><%-- /#page-wrapper --%>

<script>
function sendBoard(){
	var frmNotice = document.getElementById("frmNotice") ;
	var ctitle = document.getElementById("ctitle").value ;
	var ccontent = document.getElementById("ccontent").value ;
	var nickname = document.getElementById("nickname").value ;
	
	if( ctitle.length==0 || ccontent.length==0 || nickname.length==0 ){
		alert("글제목/글내용/작성자를 모두 입력해야 합니다.");
	} else {
//		frmBoard.method="post";
//		frmBoard.action="${contextPath}/pages/noticeregister";
		frmNotice.submit();
	}

}

$("#btnRegister").on("click", function(){
	sendBoard() ;
});

</script>


</script>
<%@include file="../pageinclude/footer.jsp" %> 