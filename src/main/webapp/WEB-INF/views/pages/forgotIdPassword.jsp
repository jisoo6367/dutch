<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<c:set var="contextPath" value="${pageContext.request.contextPath }"/>

<%@include file="../pageinclude/header.jsp" %>


<!-- form findEmail -->
<form role="form" name="frmFindEmail" id="frmFindEmail" 
		method="post" action="${contextPath}/sendmember">
		
	<input type="text" name="nickname" placeholder="nickname" id="nickname">
	
	<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }"/>
	
	<button type="button" id="findEmailBtn">찾기</button>
	
</form>
<br>

<!-- form findPassword -->
<form role="form" name="frmFindPassword" id="frmFindPassword" 
		method="post" action="${contextPath}/sendmember">
		
	<input type="email" name="email" placeholder="email">
	<input type="text" name="nickname" placeholder="nickname">
	
	<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }"/>
	
	<button type="submit" id="findPasswordBtn">찾기</button>
	
</form>


<%-- find email Modal --%>
<div class="modal fade" id="emailModal" tabindex="-1" role="dialog"
	aria-labelledby="yourModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true">&times;</button>
				<h4 class="modal-title" id="emailModalLabel">고객님의 이메일은</h4>
			</div>
			<div class="modal-body" id="Modal-message">메시지</div>

			<div class="modal-footer">
				<button type="button" class="btn btn-primary" data-dismiss="modal">닫기</button>
			</div>
		</div>
		<%-- /.modal-content --%>
	</div>
	<%-- /.modal-dialog --%>
</div>
<%-- /.modal --%>

<script>
	var frmFindEmail = $("#frmFindEmail");
	var nickname = $("#nickname").val();
	
	$("#findEmailBtn").on("click", function(){
		console.log("findemail()start");
		$.ajax({
		
			type: "post",
			url: "${contextPath}/findEmail",
			data: {nickname: nickname },
			dataType: "json",
			success: function(result){
				showEmailModal(result);
				console.log("findemail().modal.start");
			}
			
		});/* ajax-end */
		
		console.log("findemail()end");
	});/* findEmailBtn-end */
	
	function showEmailModal(result){
		console.log("modal.start");
		if (result.length == 0) {
			return;

		} else {
			var myEmail = result;
		}
		
		$("#Modal-message").html(myEmail);

		$("#emailModal").modal("show");

		myMsg = "";
		console.log("modal.end");
		
	}/* showEmailModal-end */
	
	
	
	
	
	
</script>




<%@include file="../pageinclude/footer.jsp" %> 