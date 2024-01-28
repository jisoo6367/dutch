<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>

<c:set var="contextPath" value="${pageContext.request.contextPath }" />

<%@include file="../pageinclude/header.jsp"%>

<style>
	.input-margin {
					margin: 4px;
				  };
</style>

<div id="page-wrapper">
	<div class="row">
		<div class="col-lg-12">
			<h3 class="page-header">DutchPay Register</h3>
			
		</div>
		<!-- /.col-lg-12 -->
		
	</div>
	<!-- /.row -->
	<div class="row">
		<div class="col-lg-12">
			<div class="panel panel-default">

				<div class="panel-heading">
					<h4>더치페이 등록</h4>
				</div>
				<!-- /.panel-heading -->

				<div class="panel-body">
					
					<form role="form" action="${contextPath }/pay/register" method="post" name="frmRegister" id="frmRegister">
						<div class="form-group">
							<label>방제목</label> <input class="form-control" name="ptitle"
								id="ptitle" placeholder="제목을 입력하세요.">
						</div>
						<div class="form-group">
						    <label>카테고리</label>
						    	<select class="form-control" id="category" name="category">
						    		<option value="기타">기타</option>
						    		<option value="회식">회식</option>
						    		<option value="카페">카페</option>
						    		<option value="식사">식사</option>
						    		<option value="공동구매">공동구매</option>
						    	</select>
						</div>
						<div class="form-group">
							<label>방내용</label> <input class="form-control" name="pcontent"
								id="pcontent" placeholder="내용을 입력하세요.">
						</div>

						<div class="btnAdd" id="btnAdd">
							<label>나를 제외한 참여자 수</label>
							<div class="form-inline">
								<input class="form-control" type="number" min="1" name="userCnt" id="userCnt" placeholder="참여자 수를 입력하세요">
								<button class="btn btn-default" type="button" id="userCntBtn">입력</button>
							</div>
						</div>
						
						<br>
						
						<div class="form-group partiContainer">
							<label>참여자 닉네임</label>
						</div>

						<div class="form-group">
							<label>전체금액</label> <input class="form-control"
								name="ptotalPayment" id="ptotalPayment"
								placeholder="전체금액을 입력하세요.">
						</div>
						<div class="form-group">
							<label>개인부담금액</label> <input class="form-control"
								name="ppersonal" id="ppersonal" placeholder="개인부담금액을 입력하세요.">
						</div>
						
						<button type="button" class="btn btn-primary" id="btnRegister">게시물
							등록</button>
						<button type="button" class="btn btn-warning"
							onclick="location.href='${contextPath}/pay/list';">취소</button>
						<sec:csrfInput/>
					</form>

				</div>
			</div>
		</div>
	</div>
</div><%--page-wrapper end--%> 

<%-- 첨부파일 결과 표시 --%> 
    <div class="row">
        <div class="col-lg-12">
            <div class="panel panel-default">
            	<div class="panel-heading">영수증 첨부</div><!-- /.panel-heading -->
				
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



<form id="frmSendValue"></form>


<script>
	var frmRegister = $("#frmRegister");
<%-- 더치페이 게시물에 입력값 유무 확인 함수 --%>
	function checkBoardValues() {

		var ptitle = $("#ptitle").val();
		var category = $("#category").val();
		var pcontent = $("#pcontent").val();
		var ptotalPayment = $("#ptotalPayment").val();
		var ppersonal = $("#ppersonal").val();

		if (ptitle.length == 0 || category.length == 0
				|| ptotalPayment.length == 0 || ppersonal.length == 0
				|| pcontent.length == 0) {

			return false;
		} else {
			return true;
		}

	}
	
<%-- 참여자수 확정 버튼--%>
	$("#userCntBtn").on("click", function() {
		
		var userCnt = parseInt($("#userCnt").val());
		
		if (userCnt.length == 0) {
			alert("참여자 수를 입력하세요");
			return;
		} else if (userCnt > 10) {
			alert("참여자 수는 10명이하로 입력해주세요")
			return;
		} else {
			$(this).parent("div").siblings("input").remove();
			
			for (var i = 0; i < userCnt; i++) {
//				$(this).parents("div .btnAdd").append("<input type='text' name='participants[" + i + "].nickname' class='form-control input-margin'>");
				$(".partiContainer").append("<input type='text' name='participants[" + i + "].nickname' class='form-control col-md-3 input-margin'>");
			}
		}
	});

<%-- 더치페이 게시글 내용 버튼 --%>
	$("#btnRegister").on("click", function(){
		
		 if(!checkBoardValues()){
		 	alert("모든 항목을 전부 입력해주셔야 합니다.");
		 	return ; 
		 }
		 
		 frmRegister.submit();
	});

<%-- 전체금액을 참여자 수 + 1명(총무) 로 나눈 값 개인부담금액에 넣는 식 --%>
	$("#ptotalPayment").on("change", function(){
	   $("#ppersonal").val("");
	   
	    var total = parseInt($(this).val());
	    var partiCnt = parseInt($("#userCnt").val());
	    partiCnt += 1;
	    var result = Math.floor(total / partiCnt) ;
	    var modulo = total % partiCnt ;
	    $(this).val();
	    $("#ppersonal").val(result);
	    $("#modulo").val(modulo);
	   
	    partiCnt = null;
	});


<%-- 게시물 등록 시에 업로드 된 첨부파일 데이터들도  DB에 저장되도록 수정 --%> 
	$("#btnRegister").on("click", function(){
		
		if (!checkBoardValues()){
			alert("사항을 모두 입력해야 합니다.");
			return ;
		}
		
		var frmBoard = $("#frmRegister") ;
		var attachFileInputHTML = "";
		
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
			frmBoard.append(attachFileInputHTML) ;	
		}
		frmBoard.submit();
		
	});

<%-- <<<<<< 첨부파일 관련 코드 >>>>>> --%>

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

function showUploadResult(uploadResult) {
	
	if(!uploadResult || uploadResult.length == 0) {
		return ;
	}
	
	var fileUploadResult = $(".fileUploadResult ul") ;
	var htmlStr = "";
	
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
			+  "  <span data-filename='" + fullFileName + "' data-filetype='F'>[삭제]</span>"
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
//			+ "    <a href='${contextPath}/fileDownloadAjax?fileName=" + fullFileName +"'>" //다운로드
//			+ "    <a href=\"javascript:showImage('" + fullFileName + "')\">"
			+ "        <img src='${contextPath}/dutchDisplayThumbnail?fileName=" + thumbnail + "'>"
			+ "        &nbsp;&nbsp;" + attachFile.fileName 
//			+ "    </a>"
			+  "  <span data-filename='" + thumbnail + "' data-filetype='I'>[삭제]</span>"
			+ "</li>" ;
		}
			
	}); <%--foreach-end--%>
	
	fileUploadResult.append(htmlStr) ;
	
}

var myCsrfHeaderName = "${_csrf.headerName}" ;
var myCsrfToken = "${_csrf.token}" ;

/* 
$(document).ajaxSend(function(e, xhr){
	xhr.setRequestHeader(myCsrfHeaderName, myCsrfToken) ;
}); */
	
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
		type: "POST" ,
		url: "${contextPath}/dutchFileUploadAjaxAction" ,
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


<%-- 업로드 파일 삭제: 서버에 업로드된 파일이 삭제되고, 이를 화면에 반영해 주어야 함 --%>
<%-- body > div.fileUploadResult > ul > li:nth-child(2) > span --%>
$(".fileUploadResult ul").on("click","li span", function(e){
	var fileName = $(this).data("filename") ;
	var fileType = $(this).data("filetype") ;
	
	var parentLi = $(this).parent() ;
	
	$.ajax({
		type: "post" ,
		url: "${contextPath}/deleteDutchFile" ,
		data: {fileName: fileName, fileType: fileType} ,
		dataType: "text" , 
		beforeSend: function(xhr){
			xhr.setRequestHeader(myCsrfHeaderName, myCsrfToken) ;
		} ,
		success: function(result){
			if(result == "S") {
				alert("파일이 삭제되었습니다.") ;
				parentLi.remove() ;
				
			} else {
				if(confirm("파일이 존재하지 않습니다. 해당 항목을 삭제하시겠습니까 ?") ) {
					parentLi.remove() ;
					alert("파일이 삭제되었습니다.") ;	
				
				}
			}
		} <%--success-end--%>
		
	});  <%--ajax-end--%>
	
});


</script>




<%@include file="../pageinclude/footer.jsp"%>
