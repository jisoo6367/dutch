<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<c:set var="contextPath" value="${pageContext.request.contextPath }"/>

<%@include file="../pageinclude/header.jsp" %>


		<div class="row">
		  <div class="panel panel-default">
            <div class="panel-heading">
              <h3 class="panel-title">Panel title</h3>
            </div>
            <div class="panel-body">
              <button type="button" class="btn btn-lg btn-default" id="moveRegiPage">
              	일반 회원가입 페이지로 이동</button>
              
            </div>
          </div>
		</div>



<<script type="text/javascript">
	$("#moveRegiPage").on("click", function(){
		window.location.href="${contextPath}/member/normalRegister";
	});
</script>






<%@include file="../pageinclude/footer.jsp" %> 