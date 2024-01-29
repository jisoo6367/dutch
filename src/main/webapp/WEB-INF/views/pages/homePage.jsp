<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>

<c:set var="contextPath" value="${pageContext.request.contextPath }" />

<%@include file="../pageinclude/header.jsp"%>
<style>
.container-margin {
	margin-top: 15px;
}
;
</style>

<h3 class="page-header">
	<!-- 로그인 하지 않은 경우 -principle: anonymousUser String 객체-->
	<!-- 로그인 한 경우 -principle: 로그인 사용자의 Authentication 객체 -->
	<sec:authentication property="principal" var="principal" />
	<c:choose>
		<c:when test="${principal eq 'anonymousUser' }">
			<span>반갑습니다. 수정</span>
		</c:when>
		<c:otherwise>
			<span>${principal.username}님, 반갑습니다.</span>
			<%--   <hr>
                 <span>principal: ${principal}</span>
                  <hr>
                  <span>authentication: ${authentication}</span>
                  <hr> --%>
		</c:otherwise>
	</c:choose>
</h3>

<h2><a href="${contextPath }/admin/page">로그인페이지로이동</a></h2>
<div class="container">
<div id="carousel-example-generic" class="carousel slide"
	data-ride="carousel">
	<ol class="carousel-indicators">
		<li data-target="#carousel-example-generic" data-slide-to="0"
			class="active"></li>
		<li data-target="#carousel-example-generic" data-slide-to="1"></li>
		<li data-target="#carousel-example-generic" data-slide-to="2"></li>
	</ol>
	<div class="carousel-inner" role="listbox">
		<div class="item active">
			<img src="resources/img/1140img1.jpg" alt="First slide">
		</div>
		<div class="item">
			<img src="resources/img/1140img1.jpg" alt="Second slide">
		</div>
		<div class="item">
			<img src="resources/img/1140img1.jpg" alt="Third slide">
		</div>
	</div>
	<a class="left carousel-control" href="#carousel-example-generic"
		role="button" data-slide="prev"> <span
		class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span> <span
		class="sr-only">Previous</span>
	</a> <a class="right carousel-control" href="#carousel-example-generic"
		role="button" data-slide="next"> <span
		class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span> <span
		class="sr-only">Next</span>
	</a>
</div>
</div>
<div class="container container-margin" style="margin-top: 30px;">
	<div class="row">
		<div class="col-md-6">
			<div class="panel panel-default">
				<div class="panel-heading">
					<h3 class="panel-title">공지사항
						<button type="button" class="btn btn-xs btn-link" style="float:right;">
							<a href="${contextPath }/notice/list">더보기</a></button></h3>
				</div>
				<div class="panel-body">
					<table class="table table-striped table-bordered table-hover" 
		          			style="width:100%;text-align: center;">
		          		<thead>
		          			<tr>
		          				<th>제목</th>
		          				<th class="text-center">공지 일자</th>
		          			</tr>
		          		</thead>
						<tbody>
							<c:forEach var="notice" items="${data.notiList }">
								<tr id="moveNotiDetail" data-cno="${notice.cno }">
									<td class="col-md-8 text-left">${notice.ctitle}</td>
									<td class="col-md-4"><fmt:formatDate value="${notice.cregDate }" pattern="yyyy-MM-dd"/></td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
		</div>
		<div class="col-md-6">
			<div class="panel panel-default">
				<div class="panel-heading">
					<h3 class="panel-title">인기 커뮤니티
						<button type="button" class="btn btn-xs btn-link" style="float:right;">
							<a href="${contextPath }/community/list">더보기</a></button></h3>
				</div>
				<div class="panel-body">
					<table class="table table-striped table-bordered table-hover" 
		          			style="width:100%;text-align: center;">
		          		<thead>
		          			<tr>
		          				<th>카테고리</th>
		          				<th>제목</th>
		          				<th class="text-center">개설자</th>
		          				<th class="text-center">개설 일자</th>
		          			</tr>
		          		</thead>
						<tbody>
							<c:forEach var="community" items="${data.commuList }">
								<tr id="moveCommuDetail" data-tno="${community.tno }">
									<td class="col-md-3 text-left">${community.tcategory}</td>
									<td class="col-md-4 text-left">${community.ttitle}</td>
									<td class="col-md-2">${community.nickname}</td>
									<td class="col-md-3"><fmt:formatDate value="${community.tregDate }" pattern="yyyy-MM-dd"/></td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
		</div>
		<div class="col-md-6">
			<div class="panel panel-default">
				<div class="panel-heading">
					<h3 class="panel-title">인기 카드
						<button type="button" class="btn btn-xs btn-link" style="float:right;">
							<a href="${contextPath }/card/list">더보기</a></button></h3>
				</div>
				<div class="panel-body">
					<table class="table table-striped table-bordered table-hover" 
		          			style="width:100%;text-align: center;">
		          		<thead>
		          			<tr>
		          				<th>카드명</th>
		          				<th class="text-center">추천수</th>
		          			</tr>
		          		</thead>
						<tbody>
							<c:forEach var="card" items="${data.cardList }">
								<tr id="moveCardDetail" data-kno="${card.kno }">
									<td class="col-md-10 text-left">${card.kname}</td>
									<td class="col-md-2">${card.kcomment}</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
		</div>
		<div class="col-md-6">
			<div class="panel panel-default">
				<div class="panel-heading">
					<h3 class="panel-title">최근 더치페이
						<button type="button" class="btn btn-xs btn-link" style="float:right;">
							<a href="${contextPath }/dutch/list">더보기</a></button></h3>
				</div>
				<div class="panel-body">
					<table class="table table-striped table-bordered table-hover" 
		          			style="width:100%;text-align: center;">
		          		<thead>
		          			<tr>
		          				<th>카테고리</th>
		          				<th>제목</th>
		          				<th class="text-center">개설자</th>
		          				<th class="text-center">개설 일자</th>
		          			</tr>
		          		</thead>
						<tbody>
							<c:forEach var="dutch" items="${data.dutchList }">
								<tr id="moveDutchDetail" data-pno="${dutch.pno }">
									<td class="col-md-3 text-left">${dutch.category}</td>
									<td class="col-md-4 text-left">${dutch.ptitle}</td>
									<td class="col-md-2">${dutch.nickname}</td>
									<td class="col-md-3"><fmt:formatDate value="${dutch.pregDate }" pattern="yyyy-MM-dd"/></td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
		</div>

	</div>

</div>

<form role="form" id="frmSendValue" method="get" name="frmSendValue">

</form>


<script>
	var frmSendValue = $("#frmSendValue");

	<%-- dutchdetail 페이지로 이동--%>
	$("#moveDutchDetail").on("click", function(){
		
		var pno = $(this).data("pno");
		
		frmSendValue.append("<input type='hidden' name='pno' value=' " + pno + " '/>");
		frmSendValue.attr("action", "${contextPath}/pay/detail").attr("method", "get");
		frmSendValue.submit();
		frmSendValue.find('input[name="pno"]').remove();
		
	});
	
	<%-- noticeDetail 페이지로 이동--%>
	$("#moveNotiDetail").on("click", function(){
		
		var cno = $(this).data("cno");
		
		frmSendValue.append("<input type='hidden' name='cno' value=' " + cno + " '/>");
		frmSendValue.attr("action", "${contextPath}/notice/detail").attr("method", "get");
		frmSendValue.submit();
		frmSendValue.find('input[name="cno"]').remove();
		
	});
	
	<%-- communityDetail 페이지로 이동--%>
	$("#moveCommuDetail").on("click", function(){
		
		var tno = $(this).data("tno");
		
		frmSendValue.append("<input type='hidden' name='tno' value=' " + tno + " '/>");
		frmSendValue.attr("action", "${contextPath}/community/detail").attr("method", "get");
		frmSendValue.submit();
		frmSendValue.find('input[name="tno"]').remove();
		
	});
	
	<%-- cardDetail 페이지로 이동--%>
	$("#moveCardDetail").on("click", function(){
		
		var kno = $(this).data("kno");
		
		frmSendValue.append("<input type='hidden' name='kno' value=' " + kno + " '/>");
		frmSendValue.attr("action", "${contextPath}/card/detail").attr("method", "get");
		frmSendValue.submit();
		frmSendValue.find('input[name="kno"]').remove();
		
	});
</script>


<%@include file="../pageinclude/footer.jsp"%>
