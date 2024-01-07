<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<c:set var="contextPath" value="${pageContext.request.contextPath }"/>

<%@include file="../pageinclude/header.jsp" %>


		<h3 class="page-header">
         <!-- 로그인 하지 않은 경우 -principle: anonymousUser String 객체-->
         <!-- 로그인 한 경우 -principle: 로그인 사용자의 Authentication 객체 -->
            <sec:authentication property="principal" var="principal"/>
            <c:choose>
               <c:when test="${principal eq 'anonymousUser' }">
                  <span>반갑습니다.</span>
               </c:when>
               <c:otherwise>
                  <span>${principal.username}님, 반갑습니다.</span>
                  <hr>
                  <span>principal: ${principal}</span>
                  <hr>
                  <span>authentication: ${authentication}</span>
                  <hr>
               </c:otherwise>
            </c:choose>
         </h3>












<%@include file="../pageinclude/footer.jsp" %> 