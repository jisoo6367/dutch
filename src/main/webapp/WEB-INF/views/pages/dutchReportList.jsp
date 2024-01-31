<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<c:set var="contextPath" value="${pageContext.request.contextPath }"/>

<%@include file="../pageinclude/header.jsp" %>

<style>
th {text-align: center;}
</style>

<div id="page-wrapper">
    <div class="row">
        <div class="col-lg-12">
            <h3 class="page-header">[관리자] DutchPay - 신고된 목록</h3>
        </div><%-- /.col-lg-12 --%>
    </div><%-- /.row --%>
    <div class="row">
        <div class="col-lg-12">
            <div class="panel panel-default">
                <div class="panel-heading">
					<div class="row">
						<div class="col-md-6" style="font-size:20px; height: 45px; padding-top:10px;">더치페이 목록</div>
					</div>
				</div><%-- /.panel-heading --%>
   
					<form class="form-inline" id="frmSendValue" name="frmSendValue"
						action="${contextPath }/pay/reportedList" method="get">
						<div class="form-group">
							<label class="sr-only">frmSendValues</label> <select
								class="form-control" id="selectAmount" name="rowAmountPerPage">
								<option value="5"
									${(pagingCreator.dutchPaging.rowAmountPerPage == 10) ? "selected" : "" }>5개</option>
								<option value="10"
									${(pagingCreator.dutchPaging.rowAmountPerPage == 20) ? "selected" : "" }>10개</option>
								<option value="15"
									${(pagingCreator.dutchPaging.rowAmountPerPage == 50) ? "selected" : "" }>15개</option>
								<option value="20"
									${(pagingCreator.dutchPaging.rowAmountPerPage == 100) ? "selected" : "" }>20개</option>
							</select> <select class="form-control" id="selectScope" name="scope">
								<option value=""
									${(pagingCreator.dutchPaging.scope == null ) ? "selected" : "" }>범위선택</option>
								<option value="T"
									${(pagingCreator.dutchPaging.scope == "T" ) ? "selected" : "" }>제목</option>
								<option value="C"
									${(pagingCreator.dutchPaging.scope == "C" ) ? "selected" : "" }>내용</option>
								<option value="W"
									${(pagingCreator.dutchPaging.scope == "W" ) ? "selected" : "" }>개설자</option>
								<option value="TC"
									${(pagingCreator.dutchPaging.scope == "TC" ) ? "selected" : "" }>제목+내용</option>
							</select>


							<div class="input-group">
								<!-- 검색어 입력 -->
								<input class="form-control" id="keyword" name="keyword"
									type="text" placeholder="검색어를 입력하세요"
									value='<c:out value="${pagingCreator.dutchPaging.keyword}" />' />
								<span class="input-group-btn"> <!-- 전송버튼 -->
									<button class="btn btn-warning" type="button" id="btnSearchGo">
										<i class="fa fa-search"></i>
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

						<div class="form-group pull-right">
							<input class="form-control" id="beginDate" name="beginDate"
								type="date" value="${pagingCreator.dutchPaging.beginDate}" />
							<input class="form-control" id="endDate" name="endDate"
								type="date" value="${pagingCreator.dutchPaging.endDate}" />

							<button type="button" class="btn btn-primary mybtns"
								id="btnIntervalSearch">기간검색</button>
						</div>

						<input type="hidden" id="pageNum" name="pageNum"
							value="${pagingCreator.dutchPaging.pageNum }">
						
						<input type="hidden" id="lastPageNum" name="lastPageNum"
							value="${pagingCreator.lastPageNum }">
				</form>
					<hr>  
                <div class="panel-body">
                    <table class="table table-striped table-bordered table-hover" style="width:100%;text-align: center;">
                    <thead>
                        <tr >
                            <th>방 번호</th>
                            <th>제목</th>
                            <th>전체 금액</th>
                            <th>개인부담금액</th>
                            <th>방 생성일</th>
                            <th>개설자</th>
				            <th>정산 여부</th>
                        </tr>
                    </thead>
                    
					<tbody>              

					<c:forEach var="dutchlist" items="${pagingCreator.dutchlist}">
						<c:choose>
						<c:when test="${dutchlist.preport == 1 }">
							<c:choose>
								<c:when test="${dutchlist.pdelFlag == 1 }">
									<tr style="background-color: Moccasin; text-align: center">
					             		<td>${dutchlist.pno }</td>
					             		<td colspan="7"><em>작성자에 의해서 삭제된 게시글입니다.</em></td>
					         		</tr>
								</c:when>
								<c:otherwise>
									<tr class="moveDetail" data-pno="${dutchlist.pno }">
										<td><c:out value="${dutchlist.pno }"/></td>
										<td style="text-align: left"><c:out value="${dutchlist.ptitle }"/></td>
										<td>${dutchlist.ptotalPayment }</td>
										<td>${dutchlist.ppersonal }</td>
										<td class="center"><fmt:formatDate value="${dutchlist.pregDate }" pattern="yyyy/MM/dd HH:mm:ss"/></td>
										<td>${dutchlist.nickname }</td>
										<td class="center">
											<c:if test="${dutchlist.pcalculated == 1}">정산 완료</c:if>
											<c:if test="${dutchlist.pcalculated == 0}">정산중</c:if>
										</td>
							 		</tr>
								</c:otherwise>		
							</c:choose>	
						</c:when>	
						</c:choose> 	
					</c:forEach>
					                                    
                    </tbody>
                    </table><%-- /.table-responsive --%>

					<div style="text-align: center;">
						<ul class="pagination pagination-sm" >
							<c:if test="${pagingCreator.prev }">
								<li class="pagination-button">
									<a href="1" aria-label="Previous">
										<span aria-hidden="true">&laquo</span>
									</a>
								</li>
							</c:if>
							<c:if test="${pagingCreator.prev }">
								<li class="pagination-button">
									<a href="${pagingCreator.startPagingNum - 1 }" aria-label="Previous">
										<span aria-hidden="true">이전</span>
									</a>
								</li>
							</c:if>
							<c:forEach begin="${pagingCreator.startPagingNum }" 
							           end="${pagingCreator.endPagingNum }" 
							           var="pagingNum">
								
								<li class='pagination-button ${(pagingNum == pagingCreator.dutchPaging.pageNum) ? "active" : ""}'>
									<a href="${pagingNum }">${pagingNum }</a>
								</li>     
							</c:forEach>
							<c:if test="${pagingCreator.next }">
								<li class="pagination-button">
									<a href="${pagingCreator.endPagingNum + 1 }" aria-label="Next">
										<span aria-hidden="true">다음</span>
									</a>
								</li>
							</c:if>
							<c:if test="${pagingCreator.next }">
								<li class="pagination-button">
									<a href="${pagingCreator.lastPageNum }" aria-label="Next">
										<span aria-hidden="true">&raquo</span>
									</a>
								</li>
							</c:if>
						</ul>
					</div>
                </div><%-- /.panel-body --%>
            </div><%-- /.panel --%>
        </div><%-- /.col-lg-12 --%>
    </div><%-- /.row --%>
</div><%-- /#page-wrapper --%>

<%-- Modal --%>
<div class="modal fade" id="yourModal" tabindex="-1" role="dialog" aria-labelledby="yourModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="yourModalLabel">Modal title</h4>
            </div>
            <div class="modal-body" id="yourModal-body">dutch list 메시지</div>
            
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" data-dismiss="modal">Close</button>
            </div>
        </div><%-- /.modal-content --%>
    </div><%-- /.modal-dialog --%>
</div><%-- /.modal --%>


<script>

var frmSendValue = $("#frmSendValue");



<%-- dutchdetail.jsp 페이지로 이동--%>
$(".moveDetail").on("click", function(){
	var pno = $(this).data("pno");
	
<%-- window.location.href = "${contextPath}/pages/dutchDetail?pno=" + pno ; --%>
	
	frmSendValue.append("<input type='hidden' name='pno' value=' " + pno + " '/>");
	frmSendValue.attr("action", "${contextPath}/pay/detail").attr("method", "get");
	frmSendValue.submit();
	frmSendValue.find('input[name="pno"]').remove(); //웹 브라우저 뒤로가기 후, 다른 게시물 상세 이동, pno값이 계속 url에 추가됨
	
});


<%-- 페이징 처리: 검색 목록 페이지 이동 --%>
$("li.pagination-button a").on("click", function(e){
	e.preventDefault();
	
	frmSendValue.find("input[name='pageNum']").val($(this).attr("href"));
	console.log(frmSendValue.find("input[name='pageNum']").val());
	frmSendValue.attr("action", "${contextPath}/pages/reportedList")
	frmSendValue.attr("method", "get");
	
	frmSendValue.submit();
	
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
<%--기간 검색버튼 클릭 이벤트 처리 --%>
$("#btnIntervalSearch").on("click", function() {

	var beginDate = $("#beginDate").val();
	var endDate = $("#endDate").val();

	//	alert("변환전 endDate: " + endDate);

	if (!beginDate || beginDate == "" || !endDate || endDate == "") {
		alert("시작날짜와 끝날짜를 모두 선택하세요");
		return;
	}
	
	frmSendValue.find("input[name='pageNum']").val(1);
	frmSendValue.submit();

});
<%--검색초기화 버튼 이벤트처리, 버튼 초기화 시, 1페이지에 목록 정보 다시 표시 --%>
$("#btnReset").on("click", function() {
	$("#selectAmount").val(10);
	$("#selectScope").val("");
	$("#keyword").val("");
	$("#beginDate").val("");
	$("#endDate").val("");
	$("#pageNum").val(1);

	frmSendValue.submit();

});



</script>










<%@include file="../pageinclude/footer.jsp" %> 