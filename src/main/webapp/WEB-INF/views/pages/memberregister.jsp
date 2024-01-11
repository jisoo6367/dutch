<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<c:set var="contextPath" value="${pageContext.request.contextPath }"/>

<%@include file="../pageinclude/header.jsp" %>
<style>
	.p-color-font{
		color: red;
		font-size: 12px;
		margin-left: 10px;
	}
</style>

<form role="form" name="frmSendMember" id="frmSendMember" 
	  method="post" action="${contextPath}/sendmember">
		
	<div class="row">
        <div class="col-lg-6">
            <div class="panel panel-default">
				<div class="panel-body form-horizontal">
					<div class="form-group">
					    <label class="col-sm-2 control-label" style="white-space: nowrap;">닉네임</label>
					    <div class="col-sm-10">
					    	<input class="form-control" name="nickname" id="nickname" placeholder="닉네임을 입력하세요">
					    	<p class="p-color-font">4~20자의 영문 소문자, 숫자만 사용 가능합니다</p>
						</div>
						
						
					</div>
					<div class="form-group">
					    <label class="col-sm-2 control-label" style="white-space: nowrap;">비밀번호</label>
					    <div class="col-sm-10">
					    	<input type="password" class="form-control" name="password" id="password" placeholder="비밀번호를 입력하세요">
					    	<p class="p-color-font">4~16자의 영문 대/소문자, 숫자, 특수문자(!,@,#)를 사용해 주세요.</p>
						</div>
					</div>
					<div class="form-group">
					    <label class="col-sm-2 control-label" style="white-space: nowrap;">은행명</label>
					    <div class="col-sm-10">
					    	<select class="form-control" id="bank" name="bank">
					    		<option value="국민">국민은행</option>
					    		<option value="신한">신한은행</option>
					    		<option value="농협">농협은행</option>
					    		<option value="우리">우리은행</option>
					    		<option value="기업">기업은행</option>
					    	</select>
						</div>
					</div>
					<div class="form-group">
					    <label class="col-sm-2 control-label" style="white-space: nowrap;">계좌번호</label>
					    <div class="col-sm-10">
					    	<input type="number" class="form-control" name="bankAccount" id="bankAccount" placeholder="' - ' 기호를 빼고 입력하세요">
						</div>
					</div>
					<div class="form-group">
					    <label class="col-sm-2 control-label" style="white-space: nowrap;">실명</label>
					    <div class="col-sm-10">
					    	<input class="form-control" name="username" id="username" placeholder="성함을 입력하세요">
						</div>
					</div>
					<div class="form-group">
					    <label class="col-sm-2 control-label" style="white-space: nowrap;">이메일</label>
					    <div class="col-sm-10">
					    	<input type="email" class="form-control" name="email" id="email" placeholder="이메일을 입력하세요">
						</div>
					</div>
					<div class="form-group">
					    <label class="col-sm-2 control-label" style="white-space: nowrap;">휴대폰번호</label>
					    <div class="col-sm-10">
					    	<input type="number" class="form-control" name="cellphone" id="cellphone" placeholder="휴대폰번호를 입력하세요">
						</div>
					</div>
					<div class="form-group">
					    <label class="col-sm-2 control-label" style="white-space: nowrap;">성별</label>
					    <div class="col-sm-10">
					    	<select class="form-control" name="gender" id="gender">
					    		<option value="남성">남성(Male)</option>
					    		<option value="여성">여성(Female)</option>
					    	</select>
						</div>
					</div>
					<div class="form-group">
					    <label class="col-sm-2 control-label" style="white-space: nowrap;">나이</label>
					    <div class="col-sm-10">
					    	<select class="form-control" name="age" id="age">
					    		<option value="10">10대</option>
					    		<option value="20">20대</option>
					    		<option value="30">30대</option>
					    		<option value="40">40대</option>
					    		<option value="50">50대</option>
					    		<option value="60">60대</option>
					    		<option value="70">70대</option>
					    		<option value="80">80대</option>
					    	</select>
						</div>
					</div>
                </div><%-- /.panel-body --%>
			</div><%-- /.panel --%>
        </div><%-- /.col-lg-12 --%>
    </div><%-- /.row --%>
	
	<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }"/>
	
	<button type="button" id="sendMemberBtn" class="btn btn-primary">회원가입</button>
	
</form>


<script>

	var frmSendMember = $("#frmSendMember");
	
	$("#nickname").on("change", function(){
		var nickname = $("#nickname").val();
		var regExpNick = /^[A-Za-z0-9]{4,20}$/;
		
		if(regExpNick.test(nickname)){
			$(this).siblings("p").attr("style", "display: none;")
		} else {
			$(this).siblings("p").attr("style", "display: in-block;")
		}
	});
	
	$("#password").on("change", function(){
		var password = $("#password").val();
		var regExpPw = /^[A-Za-z0-9!@#]{4,16}$/;
		
		if(regExpPw.test(password)){
			$(this).siblings("p").attr("style", "display: none;")
		} else {
			$(this).siblings("p").attr("style", "display: in-block;")
		}
		
	});
	
	$("#bankAccount").on("change", function(){
		var bankAccount = $("#bankAccount").val();
		var regExpBa = /^[0-9]{11,14}$/;
		
		if(!regExpBa.test(bankAccount)){
			$(this).attr("style", "border-color: red;")
		} else {
			$(this).attr("style", "border-color: none;")
		}
	});
	
	$("#username").on("change", function(){
		var username = $("#username").val();
		var regExpName = /^[가-힣A-Za-z]{2,10}$/;
		
		if(!regExpName.test(username)){
			$(this).attr("style", "border-color: red;")
		} else {
			$(this).attr("style", "border-color: none;")
		}
		
	})

	$("#email").on("change", function(){
		var email = $("#email").val();
		var regExpEmail = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
		
		if(!regExpEmail.test(email)){
			$(this).attr("style", "border-color: red;")
		} else {
			$(this).attr("style", "border-color: none;")
		}
	});
	
	$("#cellphone").on("change", function(){
		var cellphone = $("#cellphone").val();
		var regExpCp = /^01([0|1|6|7|8|9])-?([0-9]{3,4})-?([0-9]{4})$/;
		
		if(!regExpCp.test(cellphone)){
			$(this).attr("style", "border-color: red;")
		} else {
			$(this).attr("style", "border-color: none;")
		}
	});

	$("#sendMemberBtn").on("click", function(){
		frmSendMember.submit();
	});
	
	
	
	
	
	
	
	
	
</script>










<%@include file="../pageinclude/footer.jsp" %> 