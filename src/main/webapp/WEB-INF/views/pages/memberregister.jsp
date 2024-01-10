<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<c:set var="contextPath" value="${pageContext.request.contextPath }"/>

<%@include file="../pageinclude/header.jsp" %>


<form role="form" name="frmSendMember" id="frmSendMember" 
	  method="post" action="${contextPath}/sendmember">
		
	<div class="row">
        <div class="col-lg-6">
            <div class="panel panel-default">
				<div class="panel-body form-horizontal">
					<div class="form-group">
					    <label class="col-sm-2 control-label" style="white-space: nowrap;">닉네임</label>
					    <div class="col-sm-10">
					    	<input class="form-control" name="nickname" id="nickname">
						</div>
					</div>
					<div class="form-group">
					    <label class="col-sm-2 control-label" style="white-space: nowrap;">비밀번호</label>
					    <div class="col-sm-10">
					    	<input type="password" class="form-control" name="password" id="password">
						</div>
					</div>
					<div class="form-group">
					    <label class="col-sm-2 control-label" style="white-space: nowrap;">은행명</label>
					    <div class="col-sm-10">
					    	<input class="form-control" name="bank" id="bank">
						</div>
					</div>
					<div class="form-group">
					    <label class="col-sm-2 control-label" style="white-space: nowrap;">계좌번호</label>
					    <div class="col-sm-10">
					    	<input type="number" class="form-control" name="bankAccount" id="bankAccount">
						</div>
					</div>
					<div class="form-group">
					    <label class="col-sm-2 control-label" style="white-space: nowrap;">실명</label>
					    <div class="col-sm-10">
					    	<input class="form-control" name="username" id="username">
						</div>
					</div>
					<div class="form-group">
					    <label class="col-sm-2 control-label" style="white-space: nowrap;">이메일</label>
					    <div class="col-sm-10">
					    	<input type="email" class="form-control" name="email" id="email">
						</div>
					</div>
					<div class="form-group">
					    <label class="col-sm-2 control-label" style="white-space: nowrap;">휴대폰번호</label>
					    <div class="col-sm-10">
					    	<input type="number" class="form-control" name="cellphone" id="cellphone">
						</div>
					</div>
					<div class="form-group">
					    <label class="col-sm-2 control-label" style="white-space: nowrap;">성별</label>
					    <div class="col-sm-10">
					    	<input class="form-control" name="gender" id="gender" placeholder="남성 혹은 여성으로만 입력해주세요">
						</div>
					</div>
					<div class="form-group">
					    <label class="col-sm-2 control-label" style="white-space: nowrap;">나이</label>
					    <div class="col-sm-10">
					    	<input class="form-control" name="age" id="age">
						</div>
					</div>
                </div><%-- /.panel-body --%>
			</div><%-- /.panel --%>
        </div><%-- /.col-lg-12 --%>
    </div><%-- /.row --%>
	
	<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }"/>
	
	<button type="submit" id="sendMemberBtn" class="btn btn-primary">회원가입</button>
	
</form>




<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script>
	
</script>










<%@include file="../pageinclude/footer.jsp" %> 