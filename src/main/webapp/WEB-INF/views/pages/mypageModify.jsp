<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<c:set var="contextPath" value="${pageContext.request.contextPath }"/>

<%@include file="../pageinclude/header.jsp" %>



<!-- JSP 폼 입니다 아래 공간 안에서 코딩하시면 됩니다 -->


<h1> My page - Modify </h1>


<br>

<style>
 th {text-align: center;}
 p {white-space:pre-wrap;}
</style>  

<div id="page-wrapper">
    <div class="row">
        <div class="col-lg-6">
            <h3 class="page-header"
				style="white-space: nowrap;" >기본 회원정보
			</h3>
        </div><%-- /.col-lg-12 --%>
    </div><%-- /.row --%>
   
    <div class="row">
        <div class="col-lg-6">
            <div class="panel panel-default">
            <form role="form" method="post" name="frmModify" id="frmModify"> <!-- 변경된 정보들 담을 form -->
            <input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }"/> <!-- 403 forbidden 에러 안나도록 -->
                <div class="panel-heading">
                	<div class="row">
						<div class="col-md-2" style="white-space: nowrap; height: 45px; padding-top:11px;">
							<strong style="font-size:16px;">회원번호 : ${memberData.mno}번</strong>
						</div>
						<div class="col-md-3" style="white-space: nowrap; height: 45px; padding-top:16px;">
							<span class="text-primary" style="font-size: smaller; height: 45px; padding-top: 19px;">

							</span>
						</div>
						<div class="col-md-7" style="height: 45px; padding-top:6px;"><%-- vertical-align: middle; --%>
							<div class="button-group pull-right">
								<button type="button" id="btnModify" data-oper="modify"
										class="btn btn-primary"><span>수정</span></button>
										
								<button type="button" id="btnToMypage" data-oper="list"
										class="btn btn-warning"><span>취소</span></button>
							</div>
						</div>
					</div>
                </div><!-- /.panel-heading --><%-- /.panel-heading --%>
                
                <div class="panel-body form-horizontal">
					<div class="form-group">
					    <label class="col-sm-2 control-label" style="white-space: nowrap;">닉네임</label>
					    <div class="col-sm-10">
					    	<input class="form-control" name="nickname" id="nickname" 
					    		   value="${memberData.nickname }" >
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
</div>


<%-- Modal --%>
<div class="modal fade" id="yourModal" tabindex="-1" role="dialog" aria-labelledby="yourModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="yourModalLabel">Modal title</h4>
            </div>
            <div class="modal-body" id="yourModal-body">메시지</div>
            
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" data-dismiss="modal">Close</button>
            </div>
        </div><%-- /.modal-content --%>
    </div><%-- /.modal-dialog --%>
</div><%-- /.modal --%>



<form id="frmSendMno">
	<input type="hidden" name="mno" value="${memberData.mno }" >
</form>


<script>

var frmSendMno = $("#frmSendMno") ;
<%-- 취소버튼 누르면 처음 마이페이지로 이동 --%>
$("#btnToMypage").on("click", function(){
<%--
	window.location.href="${contextPath}/myboard/list" ;
--%>
	frmSendMno.attr("action", "${contextPath}/mypage/home").attr("method", "get") ;
	frmSendMno.submit() ;
});

<%-- 수정된 정보를 post방식으로 modify 컨트롤러로 넘기기 --%>
var frmModify = $("#frmModify") ;

$("#btnModify").on("click", function(){
	frmModify.action="${contextPath}/mypage/modify" ;
	//frmModify.attr("action", "${contextPath}/mypage/modify") ;
	frmModify.submit() ;

});


<%-- 모달 호출 함수--%><%--
function runModal(result) {
	
	if (result.length == 0) {
		return ;
	
	} else if ( result == "successModify" ) {
		var myMsg =  "회원정보 수정 완료 " ;
		
	} else if ( result == "failModify" ) {
		var myMsg =  "회원정보 수정 불가" ;
		
	} 
	
	//$(".modal-body").html(myMsg) ;
	$("#yourModal-body").html(myMsg) ;
	
	$("#yourModal").modal("show") ;
	
	myMsg = "" ;
}

$(document).ready(function(){
	runModal(result) ;
});--%>
 
</script>








