<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<c:set var="contextPath" value="${pageContext.request.contextPath }"/>

<%@include file="../pageinclude/header.jsp" %>




<script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js" charset="utf-8"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
<script type="text/javascript">
  var naver_id_login = new naver_id_login("yxF4sXjfBGa0l2dQ3JtV", "http://localhost:8080/dutch/naverCallback");
  // 접근 토큰 값 출력
  alert(naver_id_login.oauthParams.access_token);
  // 네이버 사용자 프로필 조회
  naver_id_login.get_naver_userprofile("naverSignInCallback()");
  // 네이버 사용자 프로필 조회 이후 프로필 정보를 처리할 callback function
  function naverSignInCallback() {
    alert(naver_id_login.getProfileData('email'));
    alert(naver_id_login.getProfileData('nickname'));
    alert(naver_id_login.getProfileData('age'));
    alert(naver_id_login.getProfileData('gender'));
    console.log(naver_id_login);
    
    var naverData = {
  		  nickname: naver_id_login.getProfileData('nickname'),
  		  email: naver_id_login.getProfileData('email'),
  		  age: naver_id_login.getProfileData('age'),
  		  gender: naver_id_login.getProfileData('gender')
    };
    
    /*$.ajax({
    	type: "POST",
    	url: "${contextPath}/loginProcess",
    	data: JSON.stringify(naverData),
    	success: function(result){
    		alert("yee");
    	}
    });*/
    
    
  }
  
  
  
  
  
</script>





<%@include file="../pageinclude/footer.jsp" %> 