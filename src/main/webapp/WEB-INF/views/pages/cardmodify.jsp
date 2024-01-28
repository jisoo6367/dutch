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
            <h3 class="page-header">카드 수정</h3>
        </div><%-- /.col-lg-12 --%>
    </div><%-- /.row --%>
    <div class="row">
        <div class="col-lg-12">
        
            <div class="panel panel-default">
                <div class="panel-heading"><h4>카드 수정</h4></div><%-- /.panel-heading --%>
                
                <div class="panel-body">

<form role="form" method="post" name="cardModify" id="cardModify">
	
	<div class="form-group">
	    <label>카드번호</label>
	    <input class="form-control" name="kno" id="kno" 
	           value='<c:out value="${card.kno }"/>' readonly="readonly">
	</div>
	
	<div class="form-group">
	    <label>카드이름</label>
	    <input class="form-control" name="kname" id="kname" 
	    	   value="${card.kname }" >
	</div>
	<div class="form-group">
	    <label>카드설명</label>
	    <textarea class="form-control" rows="3" name="kcontent" id="kcontent"
	    		  >${card.kcontent}</textarea>
	</div>
	<div class="form-group">
	    <label>카드회사</label>
	    <input class="form-control" name="kcompany" id="kcompany" 
	      	  value="${card.kcompany}">
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
	
	<button type="button" class="btn btn-primary mybtns" id="btnModify" data-oper="modify">수정</button>
	<button type="button" class="btn btn-warning mybtns" id="btnList" data-oper="list">취소</button>
 	
 	<input type="hidden" id="pageNum" name="pageNum" value="${cardPagingDTO.pageNum }" >
	<input type="hidden" id="rowAmountPerPage" name="rowAmountPerPage" value="${cardPagingDTO.rowAmountPerPage }" >
	<input type="hidden" id="scope" name="scope" value="${cardPagingDTO.scope }" >
	<input type="hidden" id="keyword" name="keyword" value="${cardPagingDTO.keyword }" > 
	<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }"/>
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
                <div class="panel-heading">카드이미지 업로드</div><!-- /.panel-heading -->
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


<script>

/* var myCsrfHeaderName = "${_csrf.headerName}" ;
var myCsrfToken = "${_csrf.token}" ;  */
<%-- 
$(document).ajaxSend(function(e, xhr){
	xhr.setRequestHeader(myCsrfHeaderName, myCsrfToken) ;
		
}); 
--%>

var cardModify = $("#cardModify") ;

/* var loginUser = "";

<sec:authorize access="isAuthenticated()">
	loginUser = '<sec:authentication property="principal.username"/>';
</sec:authorize>  */

<%--수정된 게시물 입력값 유무 확인 함수--%>
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

$(".mybtns").on("click", function(){
	
	if (!checkBoardValues()){
		alert("글제목/글내용을 모두 입력해야 합니다.");
		return ;
	}	
	
	var operation = $(this).data("oper") ;
	
	if (operation == "modify") {
		var emptyLi = $(".fileUploadResult ul li") ;
		
		if(emptyLi.data("filename") == undefined){
			emptyLi.remove() ;
		}
		
		var attachFileInputHTML = "";
		
		$("div.fileUploadResult ul li").each(function(i, obj){
			
			var objLi = $(obj) ;

	 		if(objLi == null){
				return ;
			} 
			
			attachFileInputHTML 
				+="<input type='hidden' name='attachFileList[" + i + "].uuid' value='" + objLi.data("uuid") + "'>" 
				+ "<input type='hidden' name='attachFileList[" + i + "].uploadPath' value='" + objLi.data("uploadpath") + "'>" 
				+ "<input type='hidden' name='attachFileList[" + i + "].fileName' value='" + objLi.data("filename") + "'>" ;
		});<%--each-end--%>
		
		if (attachFileInputHTML != ""){
			cardModify.append(attachFileInputHTML) ;	
		}
		
		
	
		cardModify.attr("action", "${contextPath}/card/modify") ;
	
	} else {  //else if (operation == "list"){
		
		var pageNumInput = $("#pageNum").clone() ;
		var rowAmountPerPageInput = $("input[name='rowAmountPerPage']").clone() ;
		var scopeInput = $("#scope").clone() ;
		var keywordInput = $("#keyword").clone() ;
		
		cardModify.empty() ;
		
		cardModify.append(pageNumInput) ;
		cardModify.append(rowAmountPerPageInput) ;
		cardModify.append(scopeInput) ;
		cardModify.append(keywordInput) ;
		
		cardModify.attr("action", "${contextPath}/card/list").attr("method", "get") ; 
	}
	
	cardModify.submit() ;
});
</script>

<%-- <<<<<< 첨부파일 관련 코드 >>>>>> --%>
<script>

var kno = '<c:out value="${card.kno }"/>' ;

<%-- 수정페이지의 게시물 표시 후, ajax로 첨부파일 정보를 가져오는 함수를 작성 --%>
function getAttachFileInfo(){
	
	$.ajax({
		
		type:"get" ,
		url: "${contextPath}/card/getFiles" ,
		data: {kno: kno} ,
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
		
		htmlStr +="<li style='font-size: 12pt;'>카드이미지가 없습니다</li>"

	} else {
	
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
			+ "        &nbsp;&nbsp;" + attachFile.fileName ;
			
			htmlStr 
			+=  "  <button type='button' class='btn btn-danger btn-xs' data-filename='" + thumbnail + "'>X</button>"
			+ "</li>" ;
				
		}); <%--foreach-end--%>
	
	}<%-- if-else --%>
		
	fileUploadResult.append(htmlStr) ;
	
}<%-- function --%>

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
		url: "${contextPath}/cardFileUploadAjaxAction" ,
		data: formData ,
		contentType: false , <%--contentType에 MIME 타입을 지정하지 않음.--%>
		processData: false , <%--contentType에 설정된 형식으로 data를 처리하지 않음. --%>
		dataType: "json" ,
		success: function(uploadResult, status){
			$(".inputFile").val("") ;
			
			showUploadResult(uploadResult);
		}
	});
	
}) ;	

<%-- 업로드 파일 삭제: 취소 기능을 고려해서 화면의 삭제를 클릭 시에는 화면의 항목만 삭제되도록 수정 --%>
<%-- body > div.fileUploadResult > ul > li:nth-child(2) > span --%>
$(".fileUploadResult ul").on("click","li button", function(){
	
	var parentLi = $(this).parent() ;  //UL이 지워짐
<%--
	var parentLi = $(this).closest("li") ;
--%>
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

<%@include file="../pageinclude/footer.jsp"%>