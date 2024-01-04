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
	        <h2 class="form-signin-heading">Please sign in</h2>
	        
	        <label for="inputEmail" class="sr-only">Email address</label>
	        <input type="email" id="inputEmail" class="form-control" name="userEmail"
	        		placeholder="Email address" required autofocus>
	        <label for="inputPassword" class="sr-only">Password</label>
	        <input type="password" id="inputPassword" class="form-control" name="password"
	        		placeholder="Password" required>
	        <input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }"/>
	        <div class="checkbox">
	          <label>
	            <input type="checkbox" value="remember-me"> Remember me
	          </label>
	        </div>
	        
	        <button class="btn btn-lg btn-primary btn-block" type="submit">Sign in</button>
	        <button class="btn btn-lg btn-primary btn-block" type="button" id="moveRegisterPage">회원가입</button>
        </fieldset>
        
      </form>
      
      <script type="text/javascript">
      		$("#moveRegisterPage").on("click", function(){
      			window.location.href="${contextPath}/memberregister";
      		});
      </script>
	<div></div>
    </div> <!-- /container -->













<%@include file="../pageinclude/footer.jsp" %> 