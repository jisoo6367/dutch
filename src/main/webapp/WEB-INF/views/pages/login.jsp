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
<div class="container row">
	<div class="col-md-3">
      <form role="form" class="form-signin" method="post" action="${contextPath }/loginProcess">
      	<fieldset>
      		<c:if test="${not empty naverResult }">
            	<h4 class="text-muted h4-color"><c:out value="${naverResult }"/></h4>
            </c:if>
            <h4 class="text-muted h4-color"><c:out value="${error }"/></h4>
            <h4 class="text-muted h4-color"><c:out value="${logout }"/></h4>
            <c:if test="${not empty result }">
            	<h4 class="text-muted h4-color"> 반갑습니다! 로그인 해주세요.</h4>
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
	            <input type="checkbox" name="remember-me">자동로그인
	          </label>
	        </div>
	        
	        <button class="btn btn-lg btn-primary btn-block" type="submit">로그인</button>
	        <button class="btn btn-lg btn-primary btn-block" type="button" id="moveRegisterPage">회원가입</button><!-- 
	        <button class="btn btn-lg btn-primary btn-block" type="button" id="moveFinder">아이디/비밀번호 찾기</button> -->
        </fieldset>
      </form>
      <!-- 네이버로그인 버튼 -->
	<div class="row" style="margin-top: 6px;">
		<div class="col" id="naver_id_login">
			<a href="${naver_url }"></a>
		</div>
	</div>
	
	<!-- 구글로그인 버튼 -->
	<%-- <div class="text-center">
		<a href="${google_url }"><img src="/resources/img/googleLoginBotton.png" alt="구글로 로그인"/></a>
	</div>
  </div> --%>
</div> <!-- /container -->
    
<script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js" charset="utf-8">
</script>
    
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
      		
      		var naver_id_login = new naver_id_login("yxF4sXjfBGa0l2dQ3JtV", "http://localhost:8080/dutch/naverCallback");
      		var state = naver_id_login.getUniqState();
      		
      		naver_id_login.setButton("white", 3, 40);
      		naver_id_login.setDomain(".service.com");
      		naver_id_login.setState(state);
      		naver_id_login.init_naver_id_login();
      		
      		//https://nid.naver.com/oauth2.0/token?grant_type=delete&client_id=yxF4sXjfBGa0l2dQ3JtV&client_secret=0WoM6DNYYj&access_token=AAAANbnhuKoUSYZTn6lbs4Dlh7eXYi3UneQQ4_wHU727D6c1Zmftg7mN2tSEnpCMf5umLvlHFdeFhmV8v-9pSFoGqeg&service_provider=NAVER
      	
</script>   
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

<%@include file="../pageinclude/footer.jsp" %> 