<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<c:set var="contextPath" value="${pageContext.request.contextPath }"/>

<%@include file="../pageinclude/header.jsp" %>


<form role="form" name="frmSendMember" id="frmSendMember" 
		method="post" action="${contextPath}/sendmember">
		
	<input type="text" name="nickname" placeholder="nickname">
	<input type="text" name="bank" placeholder="bank">
	<input type="number" name="bankAccount" placeholder="bankAccount">
	<input type="text" name="username" placeholder="username">
	<input type="email" name="email" placeholder="email">
	<input type="number" name="hp" placeholder="hp">
	<input type="number" name="cellphone" placeholder="cellphone">
	<input type="text" name="loginType" placeholder="loginType">
	<input type="text" name="gender" placeholder="gender">
	<input type="text" name="age" placeholder="age">
	
	<button type="submit" id="sendMemberBtn">submit</button>
	
</form>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script>
	
</script>










<%@include file="../pageinclude/footer.jsp" %> 