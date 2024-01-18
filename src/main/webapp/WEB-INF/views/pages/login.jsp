<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<c:set var="contextPath" value="${pageContext.request.contextPath }"/>

<%@include file="../pageinclude/header.jsp" %>
<style>
	.h4-color {color: red;};
</style>

<!-- login container -->
<div class="container">

      <form role="form" class="form-signin" method="post" action="${contextPath }/loginProcess">
      	<fieldset>
            <h4 class="text-muted h4-color"><c:out value="${error }"/></h4>
            <h4 class="text-muted h4-color"><c:out value="${logout }"/></h4>
            <c:if test="${not empty result }">
            	<h4 class="text-muted h4-color"><c:out value="${result }"/>님, 반갑습니다!</h4>
            </c:if>
        </fieldset>
      	<fieldset>
	        <h2 class="form-signin-heading">닉네임 로그인</h2>
	        
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
        <fieldset>
            <hr>
               <h6 class="text-muted text-center"><c:out value="${normal }"/></h6>
                            
        </fieldset>
      </form>
      
      <script type="text/javascript">
      		$("#moveRegisterPage").on("click", function(){
      			window.location.href="${contextPath}/member/register";
      		});
      		
      		$("#moveFinder").on("click", function(){
      			window.location.href="${contextPath}/finder"
      		});
      		
      		var result = "<c:out value='${result}'/>";
      		
      		/* if(result != null){
      			console.log(result)
      			alert("회원가입이 완료 되었습니다.");
      		} else {
      			window.location.href="${contextPath}/dutch/memberregister";
      		} */
      		
      	
      </script>
      
      
      
      
	<div></div>
    </div> <!-- /container -->

<%@include file="../pageinclude/footer.jsp" %> 