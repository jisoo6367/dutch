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
            <h3 class="page-header" style="white-space: nowrap;" >Dutchpay Modify
				 <small>
				 	&nbsp;&nbsp;&nbsp;<c:out value="${dutchboard.dutchboard.pno}"/>번 게시물
				 </small>
			</h3>
        </div><%-- /.col-lg-12 --%>
    </div><%-- /.row --%>
	<div class="row">
		<div class="col-lg-12">
			<div class="panel panel-default">
                <div class="panel-heading">
                	<div class="row">
						<div class="col-md-2" style="white-space: nowrap; height: 45px; padding-top:11px;">
							<strong style="font-size:16px;">${dutchboard.dutchboard.nickname} 님 작성</strong>
						</div>
						<div class="col-md-3" style="white-space: nowrap; height: 45px; padding-top:16px;">
							<span class="text-primary" style="font-size: smaller; height: 45px; padding-top: 19px;">
								<span>
									<span>등록일:&nbsp;</span>
									<strong><fmt:formatDate pattern="yyyy-MM-dd" value="${dutchboard.dutchboard.pregDate}"/></strong>
								</span>
							</span>
						</div>
						<div class="col-md-7" style="height: 45px; padding-top:6px;"><%-- vertical-align: middle; --%>
							<div class="button-group pull-right">
	    						<button type="button" id="btnToList" data-oper="list"
										class="btn btn-warning"><span>목록페이지로 이동</span></button>
							</div>
						</div>
    				</div><%-- /.row--%>
                </div><%-- /.panel-heading --%>

				<div class="panel-body form-horizontal">
					<form role="form" method="post" name="frmModify" id="frmModify">
					<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }"/> <!-- 403 forbidden 에러 안나도록 -->
						<div class="form-group">
						    <label class="col-sm-2 control-label" style="white-space: nowrap;">글 제목</label>
						    <div class="col-sm-10">
					    		<input class="form-control" name="ptitle" id="ptitle" value="${dutchboard.dutchboard.ptitle }" >
							</div>
						</div>
						<!-- <div class="form-group">
							<label>카테고리</label> <input class="form-control" name="category"
								id="category" placeholder="카데고리를 검색하세요.">
							<select >
								
							</select>
						</div> -->
						<div class="form-group">
						    <label class="col-sm-2 control-label" style="white-space: nowrap;">카테고리</label>
						    <div class="col-sm-10">
						    	<select class="form-control" id="category" name="category" >
						    		<option value="기타" ${(dutchboard.dutchboard.category == '기타') ? "selected" : "" }>기타</option>
						    		<option value="회식" ${(dutchboard.dutchboard.category == '회식') ? "selected" : "" }>회식</option>
						    		<option value="카페" ${(dutchboard.dutchboard.category == '카페') ? "selected" : "" }>카페</option>
						    		<option value="식사" ${(dutchboard.dutchboard.category == '식사') ? "selected" : "" }>식사</option>
						    		<option value="공동구매" ${(dutchboard.dutchboard.category == '공동구매') ? "selected" : "" }>공동구매</option>
						    	</select>
						    </div>
						</div>

						<div class="form-group">
						    <label class="col-sm-2 control-label" style="white-space: nowrap;">글 내용</label>
						    <div class="col-sm-10">
						    	<textarea class="form-control" rows="3" name="pcontent" id="pcontent"
						    			  style="resize: none;" ><c:out value="${dutchboard.dutchboard.pcontent}"/></textarea>
							</div>	    			  
						</div>
												
						<div class="form-group btnAdd" id="btnAdd">
						    <label class="col-sm-2 control-label" style="white-space: nowrap;">변경할 참여자 목록</label>
							<div class="col-sm-10 ">
								<input class="form-control " type="number" min="1" name="userCnt" id="userCnt" placeholder="참여자수를 입력하세요">
								<button class="btn btn-default" type="button" id="userCntBtn">참여자 수 변경</button>
							</div>  	  
						</div>
						
						<div class="form-group">
						    <label class="col-sm-2 control-label" style="white-space: nowrap;">전체 금액</label>
						    <div class="col-sm-10">
						    	<input class="form-control" name="ptotalPayment" id="ptotalPayment" 
						    		   value="${dutchboard.dutchboard.ptotalPayment }" >
							</div>
						</div>
						
						<div class="form-group">
						    <label class="col-sm-2 control-label" style="white-space: nowrap;">개인부담금액</label>
						    <div class="col-sm-10">
						    	<input class="form-control" name="ppersonal" id="ppersonal" 
						    		   value="${dutchboard.dutchboard.ppersonal }" >
							</div>
						</div>

						<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }" />
						<button type="button" class="btn btn-primary" id="btnModify">수정</button>
                        <button type="button" id="btnToDetail" data-oper="detail"
                              class="btn btn-warning"><span>취소</span></button>

<input type="hidden" name="pno" id="pno" value="${dutchboard.dutchboard.pno}"/>
<input type="hidden" name="nickname" id="nickname" value="${dutchboard.dutchboard.nickname}"/>

					</form><%-- 펜넬바디만 들어있는 폼 --%>
				</div><%-- /.panel-body --%>
			</div><%--  /.panel --%>
		</div><%--  /.col-lg-12 --%>
	</div><%-- .row --%>
</div><%-- page-wrapper--%>

<%-- 첨부파일 결과 표시 --%>    
    <div class="row">
        <div class="col-lg-12">
            <div class="panel panel-default">
                <div class="panel-heading">
                	<strong style="font-size:16px;">첨부 파일</strong>
                </div><!-- /.panel-heading -->
                <div class="panel-body"><!-- 
                    <div class="form-group uploadDiv">
                        <input id="inputFile" class="btn btn-primary inputFile" type="file" name="uploadFiles" multiple="multiple" /><br>
                    </div> -->
	                <div class="form-group fileUploadResult">
	                    <ul>
<%-- 업로드 후 처리결과가 표시될 영역 --%>
						<c:choose>
						<c:when test="${empty attachFileList }">
							<li style="font-size: 12pt;">첨부파일이 없습니다</li>
						</c:when>
						<c:otherwise>
							<c:forEach var="attachFile" items="${attachFileList }">
								<c:choose>
								<c:when test="${attachFile.fileType == 'F' }">
									<li class="attachLi" 
										data-repopath = "${attachFile.repoPath }"
										data-uploadpath = "${attachFile.uploadPath }" 
										data-uuid = "${attachFile.uuid }" 
										data-filename = "${attachFile.fileName }" 
										data-filetype = "F" >
								    <img src='${contextPath}/resources/img/attach.png' style='width:25px;'>
											&nbsp;&nbsp;${attachFile.fileName}
									</li>
								</c:when>
								<c:otherwise>
									<c:set var="thumbnail" value="${attachFile.repoPath}/${attachFile.uploadPath}/s_${attachFile.uuid}_${attachFile.fileName}"/>
									<li class="attachLi" 
										data-repopath = "${attachFile.repoPath }"
										data-uploadpath = "${attachFile.uploadPath }" 
										data-uuid = "${attachFile.uuid }" 
										data-filename = "${attachFile.fileName }" 
										data-filetype = "I" >
								    <img src='${contextPath}/displayThumbnail?fileName=${thumbnail}' style='width:25px;'>
											&nbsp;&nbsp;${attachFile.fileName}
									</li>
									<c:remove var="thumbnail"/>
								</c:otherwise>
								</c:choose>
							</c:forEach>
						</c:otherwise>
						</c:choose>
					    </ul>
					</div><%-- /.fileUploadResult --%>
                </div><!-- /.panel-body -->
            </div><!-- /.panel -->
        </div><!-- /.col-lg-12 -->
    </div><!-- /.row -->

<script>
	var frmModify = $("#frmModify");

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
				
				$(this).parents("div .btnAdd").append("<input type='text' name='participants[" + i + "].nickname' class='form-inline input-margin'>");
			}
		}

		
	});


<%-- 취소버튼 누르면 디테일로 이동 --%>
$("#btnToDetail").on("click", function(){
	frmModify.attr("action", "${contextPath}/pay/detail").attr("method", "get") ;
	frmModify.submit() ;
});

<%-- 게시물 목록 페이지로 이동 --%>
$("#btnToList").on("click", function(){
	
	frmModify.attr("action", "${contextPath}/pay/list").attr("method", "get");
	frmModify.submit();
	
});
	
<%-- 수정된 정보를 post방식으로 modify 컨트롤러로 넘기기 --%>

$("#btnModify").on("click", function(){

	 if(!checkBoardValues()){
		 	alert("모든 항목을 전부 입력해주셔야 합니다.");
		 	return ; 
		 }

	frmModify.attr("action", "${contextPath}/pay/modify") ;
	frmModify.submit() ;

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

















</script>





<%-- <<<<<< 첨부파일 관련 코드 >>>>>> --%>
<script>
var frmModify = $("#frmModify");

var emptyLi = $(".fileUploadResult ul li") ;
//console.log(emptyLi)  ;
//alert(emptyLi);
if(emptyLi.data("filename") == undefined){
	//$(".fileUploadResult ul li").remove() ;
	emptyLi.remove() ;
}

<%-- #wrapper > div.row > div > div > div.panel-body > div.fileUploadResult ul  li:nth-child(1) --%>

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




<%--이게뭐지???????
if (attachFileInputHTML != ""){
	frmModify.append(attachFileInputHTML) ;	

	 frmModify.attr("action", "${contextPath}/pay/modify") ;
	
} else if (operation == "remove"){
	
			if(!loginUser || ${dutchboard.dutchboard.nickname} != loginUser){
				return ;
			}
	
			frmModify.attr("action", "${contextPath}/myboard/remove") ;
	
} else {  //else if (operation == "list"){
	
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
	
	frmModify.attr("action", "${contextPath}/myboard/list").attr("method", "get") ; 
	}
	
	frmModify.submit() ;
});
--%>



<%-- 수정페이지의 게시물 표시 후, ajax로 첨부파일 정보를 가져오는 함수를 작성 --%>
function getAttachFileInfo(){

$.ajax({

type:"get" ,
url: "${contextPath}/pay/getFiles" ,
data: {pno: pno} ,
dataType: "json" ,
beforeSend: function(xhr){
	xhr.setRequestHeader(myCsrfHeaderName, myCsrfToken);
},
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
		+ "  <button type='button' class='btn btn-danger btn-xs' data-filename='" + fullFileName + "' data-filetype='F'>X</button>"
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
		+ "        &nbsp;&nbsp;" + attachFile.fileName ;
		
		<sec:authorize access="isAuthenticated()">
			<sec:authentication property="principal.username" var="username"/>
				<c:if test="${username == myboard.bwriter }">
		htmlStr
		+=" 	 <button type='button' class='btn btn-danger btn-xs' data-filename='" + thumbnail + "' data-filetype='I'>X</button>";
				</c:if>
			</sec:authorize>
			
		htmlStr
		+="</li>" ;
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
beforeSend: function(xhr){
	xhr.setRequestHeader(myCsrfHeaderName, myCsrfToken);
},
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
