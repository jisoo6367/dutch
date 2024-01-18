<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>

<c:set var="contextPath" value="${pageContext.request.contextPath }" />

<%@include file="../pageinclude/header.jsp"%>

<style>
	.input-margin {
					margin: 4px;
				  };
</style>

<div id="page-wrapper">
	<div class="row">
		<div class="col-lg-12">
			<h3 class="page-header">DuctPay등록</h3>
			
		</div>
		<!-- /.col-lg-12 -->
		
	</div>
	<!-- /.row -->
	<div class="row">
		<div class="col-lg-12">
			<div class="panel panel-default">

				<div class="panel-heading">
					<h4>더치페이 등록</h4>
				</div>
				<!-- /.panel-heading -->

				<div class="panel-body">
					
					<form role="form" action="${contextPath }/pay/register"
						method="post" name="frmBoard" id="frmBoard">
						<div class="form-group">
							<label>방제목</label> <input class="form-control" name="ptitle"
								id="ptitle" placeholder="제목을 입력하세요.">
						</div>
						<!-- <div class="form-group">
							<label>카테고리</label> <input class="form-control" name="category"
								id="category" placeholder="카데고리를 검색하세요.">
							<select >
								
							</select>
						</div> -->
						<div class="form-group">
						    <label>카테고리</label>
						    	<select class="form-control" id="category" name="category">
						    		<option value="기타">기타</option>
						    		<option value="회식">회식</option>
						    		<option value="카페">카페</option>
						    		<option value="식사">식사</option>
						    		<option value="공동구매">공동구매</option>
						    	</select>
						</div>
						<div class="form-group">
							<label>방내용</label> <input class="form-control" name="pcontent"
								id="pcontent" placeholder="내용을 입력하세요.">
						</div>
						<div>
							
						</div>
						<div class="btnAdd" id="btnAdd">
							<label>참여자</label>
							<div class="form-inline">
								<input class="form-control" type="number" name="userCnt" id="userCnt" placeholder="참여자수를 입력하세요">
								<button class="btn btn-default" type="button" id="userCntBtn">참여자 수 입력</button>
							</div>
							
						</div>

						<div class="form-group">
							<label>전체금액</label> <input class="form-control"
								name="ptotalPayment" id="ptotalPayment"
								placeholder="전체금액을 입력하세요.">
						</div>
						<div class="form-group">
							<label>개인부담금액</label> <input class="form-control"
								name="ppersonal" id="ppersonal" placeholder="개인부담금액을 입력하세요.">
						</div>
						<input type="hidden" name="${_csrf.parameterName }"
							value="${_csrf.token }" />
						<button type="button" class="btn btn-primary" id="btnRegister">게시물
							등록</button>
						<button type="button" class="btn btn-warning"
							onclick="location.href='${contextPath}/pay/list';">취소</button>
					</form>

				</div>
			</div>
		</div>
	</div>


</div>

<form id="frmSendValue"></form>


<script>
	var frmBoard = $("#frmBoard");
<%-- 더치페이 게시물에 입력값 유무 확인 함수 --%>
	function checkBoardValues() {

		var ptitle = $("#ptitle").val();
		var category = $("#category").val();
		var pcontent = $("#pcontent").val();
		var ptotalPayment = $("#ptotalPayment").val();
		var ppersonal = $("#ppersonal").val();

		if (ptitle.length == 0 || category.length == 0
				|| ptotalPayment.length == 0 || ppersonal.length == 0
				|| pcontent.length == 0) {

			return false;
		} else {
			return true;
		}

	}
	
<%-- 참여자수 확정 버튼--%>
	$("#userCntBtn").on("click", function() {
		
		var userCnt = parseInt($("#userCnt").val());
		
		if (userCnt.length == 0) {
			alert("참여자 수를 입력하세요");
			return;
		} else if (userCnt > 10) {
			alert("참여자 수는 10명이하로 입력해주세요")
			return;
		} else {
			$(this).parent("div").siblings("input").remove();
			
			for (var i = 0; i < userCnt; i++) {
				$(this).parents("div .btnAdd").append("<input type='text' name='participants[" + i + "].nickname' class='form-control input-margin'>");
			}
		}

		
	});

<%-- 더치페이 게시글 내용 등록버튼 --%>
$("#btnRegister").on("click", function(){
	
	 if(!checkBoardValues()){
	 	alert("모든 항목을 전부 입력해주셔야 합니다.");
	 	return ; 
	 }
	 
	 frmBoard.submit();
});
</script>



<%@include file="../pageinclude/footer.jsp"%>
