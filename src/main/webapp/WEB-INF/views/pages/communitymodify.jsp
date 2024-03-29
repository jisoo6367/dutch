<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<c:set var="contextPath" value="${pageContext.request.contextPath }"/>

<%@include file="../pageinclude/header.jsp" %>



<!-- JSP 폼 입니다 아래 공간 안에서 코딩하시면 됩니다 -->
 
<div id="page-wrapper">
   <!--  <div class="row">
        <div class="col-lg-12">
            <h3 class="page-header">Community - Modify</h3>
        </div>
    </div> -->
    
    <div class="row">
        <div class="col">
        
            <div class="panel panel-default">
               <div class="panel-heading" style="background-color: transparent">
	                <div class="container">
					  <div class="row row-cols-2">
					   <div class="col-sm-10" ><h4>게시물 수정</h4></div> 					
						<div class="col-sm-2" >	       						 
							<button type="button" class="btn btn-link mybtns" style="color:black" id="btnModify" data-oper="modify">등록</button>
							<!-- <button type="button" class="btn btn-link mybtns" style="color:black" id="btnRemove" data-oper="remove">삭제</button> -->
							<button type="button" class="btn btn-link mybtns" style="color:black" id="btnList" data-oper="list">취소</button>
						</div>  
					  </div>
					</div>
				</div>
                
                <div class="panel-body">

<form role="form" method="post" name="frmModify" id="frmModify">
  <input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }"/>
	<div class="form-group" style="display:none;">
	    <label>글번호</label>
	    <input class="form-control" name="tno" id="tno" 
	           value='<c:out value="${community.tno }"/>' readonly="readonly">
	</div>
	
	
	<div class="form-group">
	<!--     <label>카테고리</label> -->
	    <!-- <input class="form-control" name="tcategory" id="tcategory" value="${community.tcategory }"> -->	           
        <select class="form-control" id="tcategory" name="tcategory">
    		<option value="커뮤니티">커뮤니티</option>
    		<option value="거지방">거지방</option>
    		<option value="맛집">맛집</option>
    		<option value="운동">운동</option>
    		<option value="게임">게임</option>
    		<option value="공동구매">공동구매</option>
    	</select>
	</div>
	
	<div class="form-group">
	<!--     <label>글제목</label> -->
	    <input class="form-control" name="ttitle" id="ttitle" 
	    	   value="${community.ttitle }" >
	</div>
	<div class="form-group">
<!-- 	    <label>글내용</label> -->
	    <textarea class="form-control" rows="15" name="tcontent" id="tcontent" style="resize: vertical;"
	    		  >${community.tcontent}</textarea>
	</div>
	<div class="form-group" style="display:none;">
	    <label>작성자</label>
	    <input class="form-control" name="nickname" id="nickname" 
	      	  value="${community.nickname }" readonly="readonly">
	</div>
	<div class="form-group" style="display:none;">
	    <label>최종수정일</label> [등록일시: <fmt:formatDate value="${community.tregDate }" pattern="yyyy/MM/dd HH:mm" />]
	    <input class="form-control" name="bmodDate" id="bmodDate" 
	      	   value='<fmt:formatDate pattern="yyyy/MM/dd HH:mm" value="${community.tmodDate }"/>' 
	      	   disabled="disabled">
	</div>
	
<!-- 	<button type="button" class="btn btn-primary mybtns" id="btnModify" data-oper="modify">수정</button>
	<button type="button" class="btn btn-primary mybtns" id="btnRemove" data-oper="remove">삭제</button>
	<button type="button" class="btn btn-warning mybtns" id="btnList" data-oper="list">취소</button> -->
 	
 	<input type="hidden" id="pageNum" name="pageNum" value="${communityPagingDTO.pageNum }" >
	<input type="hidden" id="rowAmountPerPage" name="rowAmountPerPage" value="${communityPagingDTO.rowAmountPerPage }" >
	<input type="hidden" id="scope" name="scope" value="${communityPagingDTO.scope }" >
	<input type="hidden" id="keyword" name="keyword" value="${communityPagingDTO.keyword }" >
	<input type="hidden" id="beginDate" name="beginDate" value="${communityPagingDTO.beginDate }" >
	<input type="hidden" id="endDate" name="endDate" value="${communityPagingDTO.endDate }" >
	<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }"/>
</form>

                </div><%-- /.panel-body --%>
                
            </div><%-- /.panel --%>
        </div><%-- /.col-lg-12 --%>
    </div><%-- /.row --%>
  



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
</div><%-- /#page-wrapper --%>



<script>
var myCsrfHeaderName = "${_csrf.headerName}" ;
var myCsrfToken = "${_csrf.token}" ;

$(document).ajaxSend(function(e, xhr){
   xhr.setRequestHeader(myCsrfHeaderName, myCsrfToken) ;
      
});



var frmModify = $("#frmModify") ;

<%--수정된 게시물 입력값 유무 확인 함수--%>
function checkCommunityValues(){
	
	var tcategory = document.getElementById("tcategory").value ;
	var ttitle = document.getElementById("ttitle").value ;
	var tcontent = document.getElementById("tcontent").value ;
	
	if( tcategory.length==0 || ttitle.length==0 || tcontent.length==0  ){
		return false ;

	} else {
		return true ;
	}
}

$(".mybtns").on("click", function(){
	
	if (!checkCommunityValues()){
		alert("글제목/글내용을 모두 입력해야 합니다.");
		return ;
	}	
	
	var operation = $(this).data("oper") ;
	
	if (operation == "modify") {
		
		var attachFileInputHTML = "";
	 	var emptyLi = $(".fileUploadResult ul li") ;

		if(emptyLi.data("filename") == undefined){
		
			/* emptyLi.remove() ; */
		}
 
		$("div.fileUploadResult ul li").each(function(i, obj){
			
			var objLi = $(obj) ;

	 		if(objLi == null){
				return ;
			} 
			
	 		attachFileInputHTML 
				+="<input type='hidden' name='attachFileList[" + i + "].uuid' value='" + objLi.data("uuid") + "'>" 
				+ "<input type='hidden' name='attachFileList[" + i + "].uploadPath' value='" + objLi.data("uploadpath") + "'>" 
				+ "<input type='hidden' name='attachFileList[" + i + "].fileName' value='" + objLi.data("filename") + "'>" 
				+ "<input type='hidden' name='attachFileList[" + i + "].fileType' value='" + objLi.data("filetype") + "'>" ;
	});<%--each-end--%>
		
		if (attachFileInputHTML != ""){
			frmModify.append(attachFileInputHTML) ;	
		}
		alert("수정되었습니다.");			
		frmModify.attr("action", "${contextPath}/community/modify") ;
	
	} else if (operation == "remove"){
		
		frmModify.attr("action", "${contextPath}/community/remove") ;
	
	} else {  
		
    	var pageNumInput = $("#pageNum").clone() ;
		var rowAmountPerPageInput = $("input[name='rowAmountPerPage']").clone() ;
		var scopeInput = $("#scope").clone() ;
		var keywordInput = $("#keyword").clone() ;
		var beginDateInput = $("#beginDate").clone() ;
		var endDateInput = $("#endDate").clone() ;
		
		frmModify.empty() ;
		
		frmModify.append(pageNumInput) ;
		frmModify.append(rowAmountPerPageInput) ;
		frmModify.append(scopeInput) ;
		frmModify.append(keywordInput) ;
		frmModify.append(beginDateInput) ;
		frmModify.append(endDateInput) ;
		
     	frmModify.attr("action", "${contextPath}/community/list").attr("method", "get") ;  

	}

	frmModify.submit() ;
});
</script>

<%-- <<<<<< 첨부파일 관련 코드 >>>>>> --%>
<script>

var tno = '<c:out value="${community.tno }"/>' ;

<%-- 수정페이지의 게시물 표시 후, ajax로 첨부파일 정보를 가져오는 함수를 작성 --%>
function getAttachFileInfo(){
	
	$.ajax({
		
		type:"get" ,
		url: "${contextPath}/community/getFiles" ,
		data: {tno: tno} ,
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
				+ "    <a href='${contextPath}/fileDownloadAjax?fileName=" + fullFileName +"'>"
				+ "        <img src='${contextPath}/resources/img/icon-attach.png' style='width:25px;'>"
				+ "        &nbsp;&nbsp;" + attachFile.fileName 
				+ "    </a>"
				+  "  <button type='button' class='btn btn-danger btn-xs' data-filename='" + fullFileName + "' data-filetype='F'>X</button>"
				+ "</li>" ;
				
			} else { 
				
				var thumbnail = encodeURI(attachFile.repoPath + "/" +
										  attachFile.uploadPath + "/s_" +
										  attachFile.uuid + "_" +
										  attachFile.fileName ) ;
				
			
				htmlStr 
				+="<li data-uploadpath='" + attachFile.uploadPath + "'" 
				+ "    data-uuid='" + attachFile.uuid + "'" 
				+ "    data-filename='" + attachFile.fileName + "'" 
				+ "    data-filetype='I'>"
				+ "    <a href='${contextPath}/fileDownloadAjax?fileName=" + fullFileName +"'>" //다운로드
	//			+ "    <a href=\"javascript:showImage('" + fullFileName + "')\">"
				+ "        <img src='${contextPath}/communityDisplayThumbnail?fileName=" + thumbnail + "'>"
				+ "        &nbsp;&nbsp;" + attachFile.fileName 
				+ "    </a>"
				+  "  <button type='button' class='btn btn-danger btn-xs' data-filename='" + thumbnail + "' data-filetype='I'>X</button>"
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
		console.log("첨부파일 내용 바뀜")
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
		url: "${contextPath}/communityFileUploadAjaxAction" ,
		data: formData ,
		contentType: false , <%--contentType에 MIME 타입을 지정하지 않음.--%>
		processData: false , <%--contentType에 설정된 형식으로 data를 처리하지 않음. --%>
		dataType: "json" ,
		beforeSend: function(xhr){
			xhr.setRequestHeader(myCsrfHeaderName, myCsrfToken)
		} ,
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

	var parentLi = $(this).closest("li") ;

	if(confirm("이 파일을 삭제하시겠습니까 ?") ) {
		parentLi.remove() ;
		
		alert("파일이 삭제되었습니다.") ;	
	}
	
	var parentUL = $(".fileUploadResult ul") ;
	console.log(parentUL.children("li").length);
	//alert(parentUL.children("li").length);
	if (parentUL.children("li").length == 0){
		parentUL.append("<li style='font-size: 12pt;'>첨부파일이 없습니다</li>") ;
	}
	
	
});


$(document).ready(function(){
	
	getAttachFileInfo() ;
	
}) ;

</script>










<%@include file="../pageinclude/footer.jsp" %> 