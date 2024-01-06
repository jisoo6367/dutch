<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<c:set var="contextPath" value="${pageContext.request.contextPath }"/>

<%@include file="../pageinclude/header.jsp" %>



<form role="form" name="frmSendCard" id="frmSendCard" 
		method="post" action="${contextPath}/sendcard">
		
	<input type="text" name="category" placeholder="category">
	<input type="text" name="kname" placeholder="cardname">
	<input type="text" name="kcontent" placeholder="carddescription">
	<input type="text" name="kcompany" placeholder="company">
	
	<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }"/>
	
	<button type="submit" id="sendCardBtn">submit</button>
	
</form>




<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script>
	
</script>



<%@include file="../pageinclude/footer.jsp" %> 