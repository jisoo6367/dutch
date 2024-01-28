<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>

<c:set var="contextPath" value="${pageContext.request.contextPath }" />

<%@include file="../pageinclude/header.jsp"%>

<style>
	.fileUploadResult ul {
							list-style-type: none;
						 };
	.fileUploadResult ul li {
								margin-bottom: 10px;
							};
</style> 


<div id="page-wrapper">
    <div class="row">
        <div class="col-lg-12">
            <h3 class="page-header">카드 등록</h3>
        </div><%-- /.col-lg-12 --%>
    </div><%-- /.row --%>
    <div class="row">
        <div class="col-lg-12">
        
            <div class="panel panel-default">
                <div class="panel-heading">
                	<h4>카드 등록</h4>
                </div><%-- /.panel-heading --%>
                	
                <div class="panel-body">

<form role="form" action="${contextPath }/card/sendcard" 
      method="post" name="frmBoard" id="frmBoard">
	<div class="form-group">
	    <label>카드이름</label>
	    <input class="form-control" name="kname" id="kname" placeholder="카드이름을 입력하세요">
	</div>
	<div class="form-group">
	    <label>카드설명</label>
	    <textarea class="form-control" rows="3" name="kcontent" id="kcontent"
	    		  placeholder="카드설명을 입력하세요"></textarea>
	</div>
	<div class="form-group">
	    <label>카드사</label>
	    <input class="form-control" name="kcompany" id="kcompany"/>
	</div>
	<div class="form-group">
	    <label>카테고리</label>
	    <!-- <input class="form-control" name="category" id="category" placeholder="카테고리 브로"> -->
	    <select class="form-control" name="category" id="category">
	    	<option value="회식">회식</option>
	    	<option value="카페">카페</option>
	    	<option value="식사">식사</option>
	    	<option value="공동구매">공동구매</option>
	    </select>
	</div>
	<div class="form-group">
	    <label>추천수</label>
	    <input type="number" class="form-control" name="kcomment" id="kcomment" readonly="readonly" value="0">
	</div>
	<button type="button" class="btn btn-success" id="btnRegister">등록</button>
	<button type="button" class="btn btn-warning" 
	        onclick="location.href='${contextPath}/card/list';">취소</button>
	
	<sec:csrfInput/>
	
</form>                  
                </div><!-- /.panel-body -->
            </div><!-- /.panel -->
        </div><!-- /.col-lg-12 -->
    </div><!-- /.row -->

<%-- 첨부파일 결과 표시 --%>    
    <div class="row">
        <div class="col-lg-12">
            <div class="panel panel-info">
                <div class="panel-heading">
                	<h3 class="panel-title">카드 이미지 업로드</h3>
                </div><!-- /.panel-heading -->
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
  

</div><%-- /#page-wrapper --%>



<script type="text/javascript">
var myCsrfHeaderName = "${_csrf.headerName}" ;
var myCsrfToken = "${_csrf.token}" ;

<%--게시물 입력값 유무 확인 함수--%>
function checkBoardValues(){
	
	var kname = $("#kname").val() ;
	var kcontent = $("#kcontent").val() ;
	var kcompany = $("#kcompany").val() ;
	var category = $("#category").val() ;
	
	if( kname.length==0 || kcontent.length==0 || kcompany.length==0 || category.length==0){
		return false ;

	} else {
		return true ;
	}
}

<%-- 게시물 등록 시에 업로드 된 첨부파일 데이터들도 DB에 저장--%> 
$("#btnRegister").on("click", function(){
	
	if (!checkBoardValues()){
		alert("카드이름/카드설명/카드사/카테고리를 모두 입력해야 합니다.");
		return ;
	}

	var frmBoard = $("#frmBoard") ;
	var attachFileInputHTML = "";
	
	$("div.fileUploadResult ul li").each(function(i, obj){
		
		var objLi = $(obj) ;

 		if(objLi == null){
			return ;
		} 
		
		attachFileInputHTML 
			+="<input type='hidden' name='attachFileList[" + i + "].uuid' value='" + objLi.data("uuid") + "'>" 
			+ "<input type='hidden' name='attachFileList[" + i + "].uploadPath' value='" + objLi.data("uploadpath") + "'>" 
			+ "<input type='hidden' name='attachFileList[" + i + "].fileName' value='" + objLi.data("filename") + "'>";
	});<%--each-end--%>
	
	if (attachFileInputHTML != ""){
		frmBoard.append(attachFileInputHTML) ;	
	}
	
	
	frmBoard.submit();
	
});

<%-- 업로드 파일에 대한 확장자 및 크기 제한 --%>
function checkUploadFile(fileName, fileSize) {
	
	var allowedMaxSize = 104857600 ;
	var regExpForbiddenFileExtension = /((\.(jpg|jpeg|png|gif)$)|^[^.]+$|(^\..{1,}$))/i ;
	
	if (fileSize > allowedMaxSize) {
		alert("업로드 파일의 제한된 크기(1MB)를 초과했습니다.") ;
		return false ;
	}

	if(!regExpForbiddenFileExtension.test(fileName)){
		alert("확장명이 없거나 [jpg,jpeg,png,gif] 형식 파일 외에는\n업로드 할 수 없습니다.") ;
		return false ;
		
	}
	
	return true ;
}

/* 파일 업로드 보여주기 */
function showUploadResult(uploadResult) {
	
	if(!uploadResult || uploadResult.length == 0) {
		return ;
	}
	
	var fileUploadResult = $(".fileUploadResult ul") ;
	var htmlStr = "";
	
	$(uploadResult).each(function(i, attachFile){

			
		var thumbnail = encodeURI(attachFile.repoPath + "/" +
								  attachFile.uploadPath + "/s_" +
								  attachFile.uuid + "_" +
								  attachFile.fileName ) ;
		
	
		htmlStr 
		+="<li data-uploadpath='" + attachFile.uploadPath + "'" 
		+ "    data-uuid='" + attachFile.uuid + "'" 
		+ "    data-filename='" + attachFile.fileName + "'" 
		+ "    data-filetype='I'>"
		+ "        <img src='${contextPath}/cardDisplayThumbnail?fileName=" + thumbnail + "'>"
		+ "        &nbsp;&nbsp;" + attachFile.fileName 
		+ "  <span data-filename='" + thumbnail + "' data-filetype='I'>[삭제]</span>"
		+ "</li>" ;
		
			
	}); <%--foreach-end--%>
	
	fileUploadResult.append(htmlStr) ;
	
}
	
<%-- 업로드 처리 --%>
<%--파일 업로드 처리: 파일 input 요소의 "내용이 바뀌면" 업로드가 수행되도록 수정 --%>
$("#inputFile").on("change", function(){
	
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
		url: "${contextPath}/cardFileUploadAjaxAction" ,
		data: formData ,
		contentType: false , <%--contentType에 MIME 타입을 지정하지 않음.--%>
		processData: false , <%--contentType에 설정된 형식으로 data를 처리하지 않음. --%>
		dataType: "json" ,
		beforeSend: function(xhr){
			xhr.setRequestHeader(myCsrfHeaderName, myCsrfToken)
		} ,
		success: function(uploadResult, status){			
			$(".inputFile").val("") ;
			
			showUploadResult(uploadResult);
		}
	});
	
}) ;
</script>






<%@include file="../pageinclude/footer.jsp"%>