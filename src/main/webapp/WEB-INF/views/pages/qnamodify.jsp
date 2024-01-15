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
            <h3 class="page-header">Qna - Modify</h3>
        </div><%-- /.col-lg-12 --%>
    </div><%-- /.row --%>
    <div class="row">
        <div class="col-lg-12">
        
            <div class="panel panel-default">
                <div class="panel-heading"><h4>문의 수정-삭제</h4></div><%-- /.panel-heading --%>
                
                <div class="panel-body">

<form role="form" method="post" name="frmModify" id="frmModify">
	
	<div class="form-group">
	    <label>문의번호</label>
	    <input class="form-control" name="qno" id="qno" 
	           value='<c:out value="${qna.qno }"/>' readonly="readonly">
	</div>
	
	<div class="form-group">
	    <label>문의제목</label>
	    <input class="form-control" name="qtitle" id="qtitle" 
	    	   value="${qna.qtitle }" >
	</div>
	<div class="form-group">
	    <label>문의내용</label>
	    <textarea class="form-control" rows="3" name="qcontent" id="qcontent"
	    		  >${qna.qcontent}</textarea>
	</div>
	<div class="form-group">
	    <label>닉네임</label>
	    <input class="form-control" name="nickname" id="nickname" 
	      	  value="${qna.nickname}" readonly="readonly">
	</div>
	<div class="form-group">
	    <label>최종수정일</label><%--  [등록일시: <fmt:formatDate value="${qna.qregDate }" pattern="yyyy/MM/dd HH:mm:ss" />] --%>
	    <input class="form-control" name="qmodDate" id="qmodDate" 
	      	   value='<fmt:formatDate pattern="yyyy/MM/dd HH:mm:ss" value="${qna.qmodDate }"/>' 
	      	   disabled="disabled">
	</div>

	
	<button type="button" class="btn btn-primary qnabtns" id="btnModify" data-oper="Qnamodify">수정</button>
	<button type="button" class="btn btn-primary qnabtns" id="btnRemove" data-oper="Qnaremove">삭제</button>

	
	<button type="button" class="btn btn-warning qnabtns" id="btnList" data-oper="list">취소</button>
 	
 	<input type="hidden" id="pageNum" name="pageNum" value="${qnaPagingDTO.pageNum }" >
	<input type="hidden" id="rowAmountPerPage" name="rowAmountPerPage" value="${qnaPagingDTO.rowAmountPerPage }" ><%-- 
	<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }"/> --%>
</form>

                </div><%-- /.panel-body --%>
                
            </div><%-- /.panel --%>
        </div><%-- /.col-lg-12 --%>
    </div><%-- /.row --%>
  

</div><%-- /#page-wrapper --%>

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
    
    
<%-- 스크립트 시작 --%>
<script>

var frmModify = $("#frmModify") ;

$(".qnabtns").on("click", function(){
	
	var operation = $(this).data("oper") ;
	//alert("operation: " + operation) ;
	
	if (operation == "Qnamodify") {
		frmModify.attr("action", "${contextPath}/pages/qnamodify") ;
	
	} else if (operation == "Qnaremove"){
		frmModify.attr("action", "${contextPath}/pages/qnaremove") ;
	
	} else {  //else if (operation == "list"){
		
		var pageNumInput = $("#pageNum").clone() ;
		var rowAmountPerPageInput = $("input[name='rowAmountPerPage']").clone() ;
		
		frmModify.empty() ;
		
		frmModify.append(pageNumInput) ;
		frmModify.append(rowAmountPerPageInput) ;
		
		frmModify.attr("action", "${contextPath}/pages/qnalist").attr("method", "get") ; 
	}
	
	frmModify.submit() ;
});

</script>

<%-- <<<<<< 첨부파일 관련 코드 >>>>>> --%>
<script>

var qno = '<c:out value="${qna.qno }"/>' ;

<%-- 수정페이지의 게시물 표시 후, ajax로 첨부파일 정보를 가져오는 함수를 작성 --%>
function getAttachFileInfo(){
	
	$.ajax({
		
		type:"get" ,
		url: "${contextPath}/pages/getFiles" ,
		data: {qno: qno} ,
		dataType: "json" ,
		success: function(uploadResult){
			showUploadResult(uploadResult) ;
		}
	})<%--ajax-end--%>
	
}<%--getAttachFileInfo-end--%>


function showUploadResult(uploadResult) {
	
	var fileUploadResult = $(".fileUploadResult ul") ;
	
	var htmlStr = "";
	
	
	if(!uploadResult || uploadResult.length == 0) {
		
		htmlStr +="<li style='font-size: 12pt;'>첨부파일이 없습니다</li>"

	} else {
	
	
		$(uploadResult).each(function(i, attachFile){
			
			var fullFileName = encodeURI(attachFile.repoPath + "/" +
										 attachFile.uploadPath + "/" +
										 attachFile.uuid + "_" +
										 attachFile.fileName ) ;
			
			if(attachFile.fileType == "F") {
				htmlStr 
				+="<li data-uploadpath='" + attachFile.uploadPath + "'" 
				+ "    data-uuid='" + attachFile.uuid + "'" 
				+ "    data-filename='" + attachFile.fileName + "'" 
				+ "    data-filetype='F'>"
	//			+ "    <a href='${contextPath}/fileDownloadAjax?fileName=" + fullFileName +"'>"
				+ "        <img src='${contextPath}/resources/img/icon-attach.png' style='width:25px;'>"
				+ "        &nbsp;&nbsp;" + attachFile.fileName 
	//			+ "    </a>"
				+  "  <button type='button' class='btn btn-danger btn-xs' data-filename='" + fullFileName + "' data-filetype='F'>X</button>"
				+ "</li>" ;
				
			} else { //else if(attachFile.fileType == "I") {
				
				var thumbnail = encodeURI(attachFile.repoPath + "/" +
										  attachFile.uploadPath + "/s_" +
										  attachFile.uuid + "_" +
										  attachFile.fileName ) ;
				
			
				htmlStr 
				+="<li data-uploadpath='" + attachFile.uploadPath + "'" 
				+ "    data-uuid='" + attachFile.uuid + "'" 
				+ "    data-filename='" + attachFile.fileName + "'" 
				+ "    data-filetype='I'>"
				+ "        <img src='${contextPath}/displayThumbnail?fileName=" + thumbnail + "'>"
				+ "        &nbsp;&nbsp;" + attachFile.fileName 
				
				htmlStr
				+=  "  <button type='button' class='btn btn-danger btn-xs' data-filename='" + thumbnail + "' data-filetype='I'>X</button>"
				+ "</li>" ;
			}
				
		}); <%--foreach-end--%>
	
	}
		
	fileUploadResult.append(htmlStr) ;
	
}

<%-- 업로드 파일에 대한 확장자 및 크기 제한 --%>
function checkUploadFile(fileName, fileSize) {
	
	var allowedMaxSize = 104857600 ;
	var regExpForbiddenFileExtension = /((\.(exe|dll|sh|c|zip|alz|tar)$)|^[^.]+$|(^\..{1,}$))/i ;
	
	if (fileSize > allowedMaxSize) {
		alert("업로드 파일의 제한된 크기(1MB)를 초과했습니다.") ;
		return false ;
	}

	if(regExpForbiddenFileExtension.test(fileName)){
		alert("확장명이 없거나 [exe,dll,sh,c,zip,alz,tar] 형식 파일들은\n업로드 할 수 없습니다.") ;
		return false ;
		
	}
	
	return true ;
}
	
<%-- 업로드 처리 --%>
<%--파일 업로드 처리: 파일 input 요소의 "내용이 바뀌면" 업로드가 수행되도록 수정 --%>
$("#inputFile").on("change", function(){
	
	var emptyLi = $(".fileUploadResult ul li") ;
	
	if(emptyLi.data("filename") == undefined){
		//$(".fileUploadResult ul li").remove() ;
		emptyLi.remove() ;
	}
	
	var formData = new FormData() ;
	
	var fileInputs = $("input[name='uploadFiles']") ;
	
	var yourFiles = fileInputs[0].files ;
	
	console.log(yourFiles) ;
	
	if(yourFiles == null || yourFiles.length == 0) {
		alert("파일을 선택하세요");
		return ;
	}
	
	<%--FormData() 객체에 input의 파일을 모두 저장함--%>
	for(var i = 0 ; i < yourFiles.length ; i++) {
		
		<%--업로드 파일의 파일 크기/확장자 제한 검사--%>
		if(!checkUploadFile(yourFiles[i].name, yourFiles[i].size)){
			console.log("파일이름: " + yourFiles[i].name) ;
			console.log("파일크기: " + yourFiles[i].size) ;
			return ;
		}
		
		formData.append("yourUploadFiles", yourFiles[i])
		
	}
	
<%--FormData() 객체(formData)를 서버로 전송(By Ajax)
	url 키에 명시된 주소의 컨트롤러에게 formData 객체를 POST 방식으로 전송.--%>
	$.ajax({
		type: "post" ,
		url: "${contextPath}/fileUploadAjaxAction" ,
		data: formData ,
		contentType: false , <%--contentType에 MIME 타입을 지정하지 않음.--%>
		processData: false , <%--contentType에 설정된 형식으로 data를 처리하지 않음. --%>
		dataType: "json" ,
		success: function(uploadResult, status){
			
<%--		//복사된 file-input을 삽입하는 경우, 첨부파일 삭제/추가 시에는, 초기화 되지 않음.
			$(".uploadDiv").html(cloneFileInput.html()) ;
--%>			
			$(".inputFile").val("") ;
			
			showUploadResult(uploadResult);
		}
	});
	
}) ;	

<%-- 업로드 파일 삭제: 취소 기능을 고려해서 화면의 삭제를 클릭 시에는 화면의 항목만 삭제되도록 수정 --%>
<%-- body > div.fileUploadResult > ul > li:nth-child(2) > span --%>
$(".fileUploadResult ul").on("click","li button", function(){
	
	var parentLi = $(this).parent() ;  //UL이 지워짐

	if(confirm("이 파일을 삭제하시겠습니까 ?") ) {
		parentLi.remove() ;
		
		alert("파일이 삭제되었습니다.") ;	
	}
	
	var parentUL = $(".fileUploadResult ul") ;
	console.log(parentUL.children("li").length);
	alert(parentUL.children("li").length);
	if (parentUL.children("li").length == 0){
		parentUL.append("<li style='font-size: 12pt;'>첨부파일이 없습니다</li>") ;
	}
	
	
});


$(document).ready(function(){
	
	getAttachFileInfo() ;
	
}) ;


</script>
    
<%@include file="../pageinclude/footer.jsp" %> 