<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<c:set var="contextPath" value="${pageContext.request.contextPath }" />

<%@include file="../pageinclude/header.jsp"%>

<div class="row row-offcanvas row-offcanvas-right">

	<div class="col-xs-12 col-sm-9">

		<form class="form-inline" id="frmSendValue" name="frmSendValue"
			action="${contextPath }/card" method="get">
			<div class="form-group">
				<label class="sr-only">frmSendValues</label> <select
					class="form-control" id="selectAmount" name="rowAmountPerPage">
					<option value="4"
						${(listData.cardPaging.rowAmountPerPage == 4) ? "selected" : "" }>4개</option>
					<option value="8"
						${(listData.cardPaging.rowAmountPerPage == 8) ? "selected" : "" }>8개</option>
					<option value="12"
						${(listData.cardPaging.rowAmountPerPage == 12) ? "selected" : "" }>12개</option>
				</select> <select class="form-control" id="selectScope" name="scope">
					<option value=""
						${(listData.cardPaging.scope == null ) ? "selected" : "" }>범위선택</option>
					<option value="T"
						${(listData.cardPaging.scope == "T" ) ? "selected" : "" }>카테고리</option>
					<option value="C"
						${(listData.cardPaging.scope == "C" ) ? "selected" : "" }>카드이름</option>
					<option value="W"
						${(listData.cardPaging.scope == "W" ) ? "selected" : "" }>금융사</option>
					<option value="TC"
						${(listData.cardPaging.scope == "TC" ) ? "selected" : "" }>카테고리&카드이름</option>
					<option value="TCW"
						${(listData.cardPaging.scope == "TCW" ) ? "selected" : "" }>카테고리&카드이름$금융사</option>
				</select>


				<div class="input-group" style="margin-top: 20px;">
					<!-- 검색어 입력 -->
					<input class="form-control" id="keyword" name="keyword" type="text"
						placeholder="검색어를 입력하세요"
						value='<c:out value="${listData.cardPaging.keyword}" />' /> <span
						class="input-group-btn"> <!-- 전송버튼 -->
						<button class="btn btn-warning" type="button" id="btnSearchGo">검색
						</button>
					</span>
				</div>

				<div class="input-group">
					<!-- 검색 초기화 버튼 -->
					<button id="btnReset" class="btn btn-info" type="button">
						<span class="glyphicon glyphicon-remove"></span>
					</button>
				</div>
			</div>

			<input type="hidden" id="pageNum" name="pageNum"
				value="${listData.cardPaging.pageNum }">
			<input type="hidden" id="lastPageNum" name="lastPageNum"
				value="${listData.lastPageNum }">
			<input type="hidden" id="rowAmountPerPage" name="rowAmountPerPage" 
				value="${listData.cardPaging.rowAmountPerPage }" >

		</form>

		<div class="row">
			<c:choose>
				<c:when test="${not empty listData.cardList }">
					<c:forEach var="card" items="${listData.cardList }">

						<div class="col-xs-6 col-lg-4" data-kno="${card.kno }">
							<!-- 카드이미지공간 -->
							<h2>${card.kname }</h2>
							<p>${card.kcontent }</p>
							<p>${card.kcompany }</p>
						</div>
						<!--/.col-xs-6.col-lg-4-->

					</c:forEach>
				</c:when>
			</c:choose>
		</div>
		<!--/row-->

		<div style="text-align: center;">
			<ul class="pagination pagination-sm">
				<c:if test="${listData.prev }">
					<li class="pagination-button">
						<a href="1" aria-label="Previous"> 
							<span aria-hidden="true">&laquo</span>
						</a>
					</li>
				</c:if>
				<c:if test="${listData.prev }">
					<li class="pagination-button">
						<a href="${listData.startPagingNum - 1 }" aria-label="Previous">
							<span aria-hidden="true">이전</span>
						</a>
					</li>
				</c:if>
				<c:forEach begin="${listData.startPagingNum }"
							end="${listData.endPagingNum }" var="pagingNum">

					<li class='pagination-button ${(pagingNum == listData.cardPaging.pageNum) ? "active" : ""}'>
						<a href="${pagingNum }">${pagingNum }</a>
					</li>
				</c:forEach>
				<c:if test="${listData.next }">
					<li class="pagination-button">
						<a href="${listData.endPagingNum + 1 }" aria-label="Next"> 
							<span aria-hidden="true">다음</span>
						</a>
					</li>
				</c:if>
				<c:if test="${listData.next }">
					<li class="pagination-button">
						<a href="${listData.lastPageNum }" aria-label="Next"> 
							<span aria-hidden="true">&raquo</span>
						</a>
					</li>
				</c:if>

			</ul>
		</div>


	</div>
	<!--/.col-xs-12.col-sm-9-->

</div>

<script>

var frmSendValue = $("#frmSendValue");

<%-- 페이지징 처리: 검색 목록 페이지 이동 --%>
	$("li.pagination-button a").on("click", function(e) {
		e.preventDefault();
		frmSendValue.find("input[name='pageNum']").val($(this).attr("href"));
		console.log(frmSendValue.find("input[name='pageNum']").val());
		frmSendValue.attr("action", "${contextPath}/card");
		frmSendValue.attr("method", "get");

		frmSendValue.submit();

	});

</script>


<!-- offcanvas JS -->
<script src="${contextPath}/resources/docs/examples/offcanvas/offcanvas.js"></script>

<%@include file="../pageinclude/footer.jsp"%>
