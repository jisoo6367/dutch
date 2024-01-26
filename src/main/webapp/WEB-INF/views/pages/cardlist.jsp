<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<c:set var="contextPath" value="${pageContext.request.contextPath }" />

<%@include file="../pageinclude/header.jsp"%>
<style>
	.container-margin {
						margin: 10px;
					  };
</style>


<div class="container" style="margin-top: 60px;">


<div id="page-wrapper">
    <div class="row">
        <div class="col-lg-12">
            <h3 class="page-header">추천 카드</h3>
        </div><%-- /.col-lg-12 --%>
    </div><%-- /.row --%>
    <div class="row">
        <div class="col-lg-12">
        
            <div class="panel panel-default">
                <div class="panel-heading">
					<div class="row">
						<div class="col-md-6" style="font-size:20px; height: 45px; padding-top:10px;">추천 카드 목록</div>
						<div class="col-md-6" style="padding-top:8px;">
							<button type="button" id="btnToRegister" class="btn btn-primary btn-sm pull-right">카드 등록</button>
						</div>
					</div>
				</div><%-- /.panel-heading --%>

<div class="row row-offcanvas row-offcanvas-right">

	<div class="col-xs-12">

		<form class="form-inline" id="frmSendValue" name="frmSendValue"
			action="${contextPath }/card/list" method="get">
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


				<div class="input-group" style="">
					<!-- 검색어 입력 -->
					<input class="form-control" id="keyword" name="keyword" type="text"
						placeholder="검색어를 입력하세요"
						value='<c:out value="${listData.cardPaging.keyword}" />' /> 
						<span class="input-group-btn"> 
						<!-- 전송버튼 -->
							<button class="btn btn-warning" type="button" id="btnSearchGo">검색</button>
						</span>
						<!-- 카드등록버튼 -->
						<span class="input-group-btn"> 
							<button class="btn btn-warning" type="button" id="moveCardRegisterPageBtn">카드등록</button>
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

		</form>
		
		
			<input type="hidden" id="lastPageNum" name="lastPageNum"
				value="${listData.lastPageNum }">
			<input type="hidden" id="rowAmountPerPage" name="rowAmountPerPage" 
				value="${listData.cardPaging.rowAmountPerPage }" >

		<div class="row">
			<div class="col-lg-4">
			<c:choose>
				<c:when test="${not empty listData.cardList }">
					<c:forEach var="card" items="${listData.cardList }">
						<div class="col-xs-6 col-lg-4 moveDetail"  data-kno="${card.kno }">
							<!-- 카드이미지공간 -->
							<h3>${card.kname }</h3>
							<p>${card.kcontent }</p>
							<p>${card.kcompany }</p>
							<sec:authorize access="isAuthenticated()">
								<!-- <button id="removeCard" type="button">삭제</button> -->
							</sec:authorize>
						</div>
						<!--/.col-xs-6.col-lg-4-->
					</c:forEach>
				</c:when>
				<c:otherwise><!-- 상세페이지 클릭 -->
				<tr class="moveDetail" data-kno="${card.kno }">
					<td><c:out value="${card.kname }"/></td><%-- 
					<td style="text-align: left"><a href="${contextPath }/myboard/detail?bno=${myboard.bno}" ><c:out value="${myboard.btitle }"/></a></td> --%>
				 	<td><c:out value="${card.kcontent }"/></td>
				 	<td><c:out value="${card.kcompany }"/></td>
				 </tr>
			</c:otherwise>
			</c:choose>
			</div>
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

</div><%-- /.panel --%>
        </div><%-- /.col-lg-12 --%>
    </div><%-- /.row --%>
    
    

  

</div><%-- /#page-wrapper --%>
</div> <!-- body-container -->
<script>

var frmSendValue = $("#frmSendValue");

<%-- 페이지징 처리: 검색 목록 페이지 이동 --%>
	$("li.pagination-button a").on("click", function(e) {
		e.preventDefault();
		frmSendValue.find("input[name='pageNum']").val($(this).attr("href"));
		console.log(frmSendValue.find("input[name='pageNum']").val());
		frmSendValue.attr("action", "${contextPath}/card/list");
		frmSendValue.attr("method", "get");

		frmSendValue.submit();

	});

<sec:authorize access="isAuthenticated()">
	
<%-- 카드 등록 페이지로 이동 --%>
	$("#moveCardRegisterPageBtn").on("click", function(){
		window.location.href="${contextPath}/card/register";
	});
	
</sec:authorize>

<%-- 상세페이지 이동 --%>
$(".moveDetail").on("click", function(){
	var kno = $(this).data("kno");
	
	 /* 
	window.location.href = "${contextPath}/carddetail?kname=" + kname ; */
	 
    frmSendValue.append("<input type='hidden' name='kno' value='" + kno +"'/>");
	frmSendValue.attr("action", "${contextPath}/card/detail").attr("method", "get") ;
	frmSendValue.submit() ;
	frmSendValue.find('input[name="kno"]').remove() ;   //웹 브라우저 뒤로가기 후, 다른 게시물 상세 이동 시에
														//kno값이 계속 url에 추가되는 현상 해결
});	
	
<%--표시행수 변경 이벤트 처리--%>
	$("#selectAmount").on("change", function() {
		frmSendValue.find("input[name='pageNum']").val(1);
		frmSendValue.submit();
	});
	
	
<%--키워드 검색버튼 클릭 이벤트 처리 --%>
	$("#btnSearchGo").on("click", function() {

		var scope = $("#selectScope").find("option:selected").val();

		if (!scope || scope == '') {
			alert("검색범위를 선택해주세요.");
			return false;
		}

		var keyword = $("#keyword").val();

		if (!keyword || keyword.length == 0) {
			alert("검색어를 입력해주세요.");
			return;
		}

		frmSendValue.find("input[name='pageNum']").val(1);
		frmSendValue.submit();
	});

	$("#selectScope").on("change", function() {

		var keyword = $("#keyword").val();

		if (keyword || keyword.length != 0) {
			$("#pageNum").val(1);
			frmSendValue.submit();
		}

	});

<%--검색초기화 버튼 이벤트처리, 버튼 초기화 시, 1페이지에 목록 정보 다시 표시 --%>
	$("#btnReset").on("click", function() {
		$("#selectAmount").val(10);
		$("#selectScope").val("");
		$("#keyword").val("");
		$("#pageNum").val(1);

		frmSendValue.submit();

	});

</script>


<!-- offcanvas JS -->
<script src="${contextPath}/resources/docs/examples/offcanvas/offcanvas.js"></script>

<%@include file="../pageinclude/footer.jsp"%>
