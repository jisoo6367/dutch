<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<c:set var="contextPath" value="${pageContext.request.contextPath }"/>

<%@include file="../pageinclude/header.jsp" %>


<form role="form" id="frmNaver" name="frmNaver" method="get" action="${contextPath }/naverAfter">
	<%-- <input type="hidden" name="nickname" value="${naver_id_login.getProfileData('nickname')}"> --%>
</form>



<script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js" charset="utf-8"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
<script type="text/javascript">
  var frmNaver = $("#frmNaver");
  var naver_id_login = new naver_id_login("yxF4sXjfBGa0l2dQ3JtV", "http://localhost:8080/dutch/naverCallback");
  // 접근 토큰 값 출력
  alert(naver_id_login.oauthParams.access_token);
  // 네이버 사용자 프로필 조회
  naver_id_login.get_naver_userprofile("naverSignInCallback()");
  // 네이버 사용자 프로필 조회 이후 프로필 정보를 처리할 callback function
  function naverSignInCallback() {
    
    var nickname = naver_id_login.getProfileData('nickname');
    var email = naver_id_login.getProfileData('email');
    var gender = naver_id_login.getProfileData('gender');
    
    frmNaver.append("<input type='hidden' name='nickname' value='" + nickname + "'>");
    frmNaver.append("<input type='hidden' name='email' value='" + email + "'>");
    frmNaver.append("<input type='hidden' name='gender' value='" + gender + "'>");
    
    frmNaver.submit();
    
  }
  
  
  
  
  
</script>





<%@include file="../pageinclude/footer.jsp" %> 