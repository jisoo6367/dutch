<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<c:set var="contextPath" value="${pageContext.request.contextPath }" />

<%@include file="../pageinclude/header.jsp"%>


<div class="container">
	<div class="row">
		<div class="col-md-4 col-md-offset-4">
			<div class="login-panel panel panel-default" style="margin-top: 10%;">
				<div class="panel-heading">
					<h2 class="panel-title">로그아웃 하시겠습니까?</h2>
				</div>
				<div class="panel-body">
					<form role="form" id="frmMyLogout" method="post"
						action="${contextPath }/logoutProcess">
						<input type="hidden" name="${_csrf.parameterName }"
							value="${_csrf.token }" />
						<fieldset>
							<div>
								<button type="button" id="btnMyLogout"
									class="btn btn-lg btn-success btn-block">로그아웃</button>
							</div>
						</fieldset>
					</form>
				</div>
			</div>
		</div>
	</div>
</div>


<script>
	var frmMyLogout = $("#frmMyLogout");

	$("#btnMyLogout").on("click", function() {
		var logoutDecision = confirm("로그아웃 하시겠습니까?");

		if (!logoutDecision) {
			alert("로그아웃이 취소되었습니다.");
			return;
		} else {
			frmMyLogout.submit();
			alert("로그아웃 페이지에서 로그아웃 되었습니다.");
		}
	});
</script>










<%@include file="../pageinclude/footer.jsp"%>
