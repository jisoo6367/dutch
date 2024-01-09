<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<c:set var="contextPath" value="${pageContext.request.contextPath }"/>

<%@include file="../pageinclude/header.jsp" %>


<!-- login container -->
<div class="container">

      <form role="form" class="form-signin" method="post" action="${contextPath }/loginProcess">
      	<fieldset>
	        <h2 class="form-signin-heading">로그인</h2>
	        
	        <label for="inputNickname" class="sr-only">닉네임</label>
	        <input type="text" id="inputNickname" class="form-control" name="nickname"
	        		placeholder="닉네임을 입력하세요" required autofocus>
	        <label for="inputPassword" class="sr-only">비밀번호</label>
	        <input type="password" id="inputPassword" class="form-control" name="password"
	        		placeholder="비밀번호를 입력하세요." required>
	        <input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }"/>
	        <div class="checkbox">
	          <label>
	            <input type="checkbox" value="remember-me">자동 로그인
	          </label>
	        </div>
	        
	        <button class="btn btn-lg btn-primary btn-block" type="submit">로그인</button>
	        <button class="btn btn-lg btn-primary btn-block" type="button" id="moveRegisterPage">회원가입</button>
	        <button class="btn btn-lg btn-primary btn-block" type="button" id="moveFinder">아이디/비밀번호 찾기</button>
        </fieldset>
        
      </form>
      
      <script type="text/javascript">
      		$("#moveRegisterPage").on("click", function(){
      			window.location.href="${contextPath}/memberregister";
      		});
      		
      		$("#moveFinder").on("click", function(){
      			window.location.href="${contextPath}/finder"
      		});
      </script>
	<div></div>
    </div> <!-- /container -->













<%@include file="../pageinclude/footer.jsp" %> 