<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="contextPath" value="${pageContext.request.contextPath }"/>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>접근제한</title>
</head>
<body>
<script>
	alert("회원님은 해당 페이지를 이용하실 수 없습니다.");
	location.href="${contextPath}/dutch/" ;
	
</script>
</body>
</html>