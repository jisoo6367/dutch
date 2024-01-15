<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<c:set var="contextPath" value="${pageContext.request.contextPath }"/>

<%@include file="../pageinclude/header.jsp" %>

<style>
 th {text-align: center;}
 p {white-space:pre-wrap;}
</style>  

<div id="page-wrapper">
    <div class="row">
        <div class="col-lg-6">
            <h3 class="page-header"style="white-space: nowrap;" >기본 회원정보</h3>
        </div><%-- /.col-lg-12 --%>
    </div><%-- /.row --%>
                 
    <div class="row">
        <div class="col-lg-6">
            <div class="panel panel-default">
	            <div class="panel-heading">
	            <form role="form" method="post" name="frmModify" id="frmModify"><!-- 변경된 정보들 담을 form -->
				<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }"/> <!-- 403 forbidden 에러 안나도록 -->
                	<div class="row">
						<div class="col-md-2" style="white-space: nowrap; height: 45px; padding-top:11px;">
							<strong style="font-size:16px;"> ${memberData.nickname }님의 회원정보 </strong>
						</div>
						<div class="col-md-3" style="white-space: nowrap; height: 45px; padding-top:16px;">
							<span class="text-primary" style="font-size: smaller; height: 45px; padding-top: 19px;">

							</span>
						</div>
						<div class="col-md-7" style="height: 45px; padding-top:6px;"><%-- vertical-align: middle; --%>
							<div class="button-group pull-right">
								<button type="button" id="btnModify" data-oper="modify"
										class="btn btn-primary"><span>수정</span></button>
										
								<button type="button" id="btnToInfo" data-oper="list"
										class="btn btn-warning"><span>취소</span></button>
							</div>
						</div>
					</div>
				</form> <!-- form end -->
                </div><!-- /.panel-heading -->
                
                

                
                
                
                <div class="panel-body form-horizontal">
                    <div class="form-group">
					    <label class="col-sm-2 control-label" style="white-space: nowrap;">프로필 사진</label>
					</div>
					<div class="form-group">
					    <label class="col-sm-2 control-label" style="white-space: nowrap;">닉네임</label>
					    <div class="col-sm-10">
					    	<input class="form-control" name="nickname" id="nickname" 
					    		   value="${memberData.nickname }" readonly="readonly">
						</div>
					</div>
					<div class="form-group">
					    <label class="col-sm-2 control-label" style="white-space: nowrap;">비밀번호</label>
					    <div class="col-sm-10">
					    	<input class="form-control" name="password" id="password" 
					    		   value="${memberData.password }" type="password">
						</div>
					</div>
					<div class="form-group">
					    <label class="col-sm-2 control-label" style="white-space: nowrap;">은행명</label>
					    <div class="col-sm-10">
					    	<input class="form-control" name="bank" id="bank" 
					    		   value="${memberData.bank }" readonly="readonly">
						</div>
					</div>
					<div class="form-group">
					    <label class="col-sm-2 control-label" style="white-space: nowrap;">계좌번호</label>
					    <div class="col-sm-10">
					    	<input class="form-control" name="bankAccount" id="bankAccount" 
					    		   value="${memberData.bankAccount }" readonly="readonly">
						</div>
					</div>
					<div class="form-group">
					    <label class="col-sm-2 control-label" style="white-space: nowrap;">실명</label>
					    <div class="col-sm-10">
					    	<input class="form-control" name="username" id="username" 
					    		   value="${memberData.username }" readonly="readonly">
						</div>
					</div>
					<div class="form-group">
					    <label class="col-sm-2 control-label" style="white-space: nowrap;">이메일</label>
					    <div class="col-sm-10">
					    	<input class="form-control" name="email" id="email" 
					    		   value="${memberData.email }" readonly="readonly">
						</div>
					</div>
					<div class="form-group">
					    <label class="col-sm-2 control-label" style="white-space: nowrap;">전화번호</label>
					    <div class="col-sm-10">
					    	<input class="form-control" name="hp" id="hp" 
					    		   value="${memberData.hp }" >
						</div>
					</div>
					<div class="form-group">
					    <label class="col-sm-2 control-label" style="white-space: nowrap;">휴대폰번호</label>
					    <div class="col-sm-10">
					    	<input class="form-control" name="cellphone" id="cellphone" 
					    		   value="${memberData.cellphone }" >
						</div>
					</div>
					<div class="form-group">
					    <label class="col-sm-2 control-label" style="white-space: nowrap;">가입일자</label>
					    <div class="col-sm-10">
					    	<input class="form-control" name="regDate" id="regDate" 
					    		   value="${memberData.regDate }" readonly="readonly">
						</div>
					</div>
					
                </div><%-- /.panel-body --%>
                </form> <%-- panel헤더&바디 들어있는 폼 --%>
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

                

<%-- Modal --%>
<div class="modal fade" id="yourModal" tabindex="-1" role="dialog" aria-labelledby="yourModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="yourModalLabel">Modal title</h4>
            </div>
            <div class="modal-body" id="yourModal-body">mypageModify메세지</div>
            
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" data-dismiss="modal">Close</button>
            </div>
        </div><%-- /.modal-content --%>
    </div><%-- /.modal-dialog --%>
</div><%-- /.modal --%>



<form id="frmSendNickname">
<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }"/><!-- 403 forbidden 에러 안나도록 -->
	<input type="hidden" name="nickname" value="${memberData.nickname }" >
</form>


<script>

var frmSendNickname = $("#frmSendNickname") ;
<%-- 취소버튼 누르면 상세정보 보기로 이동 --%>
$("#btnToInfo").on("click", function(){
<%--
	window.location.href="${contextPath}/myboard/list" ;
--%>
frmSendNickname.attr("action", "${contextPath}/mypage/info").attr("method", "get") ;
frmSendNickname.submit() ;
});

<%-- 수정된 정보를 post방식으로 modify 컨트롤러로 넘기기 --%>
var frmModify = $("#frmModify") ;

$("#btnModify").on("click", function(){
	//frmModify.action="${contextPath}/mypage/modify" ;
	frmModify.attr("action", "${contextPath}/mypage/modify") ;
	frmModify.submit() ;

});


</script>










<script>

<%--수정된 게시물 입력값 유무 확인 함수--%>
function checkBoardValues(){
	
	var btitle = document.getElementById("btitle").value ;
	var bcontent = document.getElementById("bcontent").value ;
	var bwriter = document.getElementById("bwriter").value ;
	
	if( btitle.length==0 || bcontent.length==0 || bwriter.length==0 ){
		return false ;

	} else {
		return true ;
	}
}

<%-- 게시물 등록 시에 업로드 된 첨부파일 데이터들도  DB에 저장되도록 수정 --%> 
$("#btnRegister").on("click", function(){
	
	if (!checkBoardValues()){
		alert("글제목/글내용/작성자를 모두 입력해야 합니다.");
		return ;
	}
<%--	
	var frmBoard = document.getElementById("frmBoard") ; //제이쿼리 append() 동작 않됨, 자바스크립트 객체를 이용해서는 JQuery 메서드를 사용할 수 없습니다.
--%>
	var frmBoard = $("#frmBoard") ;
	var attachFileInputHTML = "";
	
	<%-- li요소의 값들을 읽어와서 hidden input을 생성하는 택스트를 만드는 함수 --%>
	<%--div.form-group.fileUploadResult > ul > li:nth-child(1)--%>
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
<%--//form에 설정되어 있으므로 실행할 필요가 없습니다.	
	frmBoard.method="post";
	frmBoard.action="${contextPath}/myboard/register";
--%>
	frmBoard.submit();
	
});

</script>


<%-- <<<<<< 첨부파일 관련 코드 >>>>>> --%>
<script>

<%--input 초기화: div 요소의 "비어있는 input 요소를 복사"해서 저장함.--%>
<%--
	var cloneFileInput = $(".uploadDiv").clone(); //clone(): 선택된 요소의 자식요소가 복사됨 
--%>
<%--복사된 것을 사용하는 경우, 첨부파일 삭제 및 추가 시에는, 동작하지 않음--%>

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
			+ "        <img src='${contextPath}/displayThumbnail?fileName=" + thumbnail + "'>"
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
		type: "post" ,
		url: "${contextPath}/fileUploadAjaxAction" ,
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


<%-- 업로드 파일 삭제: 서버에 업로드된 파일이 삭제되고, 이를 화면에 반영해 주어야 함 --%>
<%-- body > div.fileUploadResult > ul > li:nth-child(2) > span --%>
$(".fileUploadResult ul").on("click","li span", function(e){
	var fileName = $(this).data("filename") ;
	var fileType = $(this).data("filetype") ;
	
	var parentLi = $(this).parent() ;
	
	$.ajax({
		type: "post" ,
		url: "${contextPath}/deleteFile" ,
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




