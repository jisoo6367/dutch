<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<c:set var="contextPath" value="${pageContext.request.contextPath }"/>

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>DutchPay template</title>

    <!-- Bootstrap -->
    <link href="${contextPath}/resources/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap navbar css -->
	<link href="${contextPath}/reources/docs/examples/navbar-fixed-top/navbar-fixed-top.css" rel="stylesheet">
	<!-- Bootstrap signin css -->
	<link href="${contextPath}/reources/docs/examples/signin/signin.css" rel="stylesheet">
	<!-- Bootstrap navbar-static-top css -->
	<link href="${contextPath}/reources/docs/examples/navbar-static-top/navbar-static-top.css" rel="stylesheet">
	<!-- Bootstrap offcanvas css -->
	<link href="${contextPath}/reources/docs/examples/offcanvas/offcanvas.css" rel="stylesheet">
	<!-- jQuery -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <!-- Bootstrap JS -->
    <script src="${contextPath}/resources/dist/js/bootstrap.min.js"></script>
    
  </head>
  <body>
	<!-- Fixed navbar -->
    <nav class="navbar navbar-default navbar-fixed-top">
      <div class="container">
        <div class="navbar-header">
          <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <a class="navbar-brand homeBtn">더치페이</a>
        </div>
        <div id="navbar" class="navbar-collapse collapse">
          <ul class="nav navbar-nav">
            <li class="active homeBtn"><a href="${contextPath }/">홈</a></li>
            <li><a href="${contextPath }/mypage/home">마이페이지</a></li>
            <li><a href="${contextPath }/pay/list">더치페이 게시판</a></li>
            <li><a href="${contextPath }/community/list">커뮤니티</a></li>
            <li id="moveCard"><a href="${contextPath }/card/list">추천카드</a></li>
            <li class="dropdown">
              <a href="#" class="dropdown-toggle" data-toggle="dropdown" 
                 role="button" aria-haspopup="true" aria-expanded="false">고객센터 
                 <span class="caret"></span></a>
              <ul class="dropdown-menu">
                <li><a href="${contextPath }/notice/list">공지사항</a></li>
                <li><a href="${contextPath }/qna/list">1:1문의</a></li>
                <!-- <li role="separator" class="divider"></li>
                <li class="dropdown-header">Nav header</li>
                <li><a href="#">Separated link</a></li>
                <li><a href="#">One more separated link</a></li> -->
              </ul>
            </li>
          </ul>
          <ul class="nav navbar-nav navbar-right" id="loginLogoutUl">
          
          	<li><a href="${contextPath }/member/register">회원가입</a></li>
          	
          </ul>
          
        </div><!--/.nav-collapse -->
      </div>
    </nav>
    
    <script>
    
    	
    	var strInnerUl = "";
    	
    	strInnerUl = '<li id="loginBtn"><a href="${contextPath }/loginPage">로그인</a></li>';
    	
    	<sec:authorize access="isAuthenticated()">
    		strInnerUl = '<li id="logoutBtn"><a href="${contextPath }/logoutPage">로그아웃</a></li>';
    	</sec:authorize>
    	
    	$("#loginLogoutUl").append(strInnerUl);
    	
    	$("#loginBtn").on("click", function(){
    		window.location.href="${contextPath}/loginPage";
    	});
    	
    	$(".homeBtn").on("click", function(){
    		window.location.href="${contextPath}/";
    	});
    	
    	$("#moveCard").on("click", function(){
    		window.location.href="${contextPath}/card"
    	});
    	
    	$("#logoutBtn").on("click", function(){
    		window.location.href="${contextPath}/logoutPage";
    	});
    	
    </script>

<div class="container" style="margin-top: 90px;">