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
            <h3 class="page-header">${nickname}님의 더치페이 내역
            <button type="button" id="btnToBack" style="margin-bottom: 8px;"
				class="btn btn-primary pull-right" ><span>이전페이지로 이동</span></button></h3>
            
        </div><%-- /.col-lg-12 --%>
    </div><%-- /.row --%>
    <div class="row">
        <div class="col-lg-12">
            <div class="panel panel-default">
                <div class="panel-heading">
					<div class="row">
						<div class="col-md-6" style="font-size:20px; height: 45px; padding-top:10px;">진행중인 내역</div>
					</div>
				</div><%-- /.panel-heading --%>

<form class="form-inline" id="frmSendValue_0" action="${contextPath }/pages/mypageDutchHistory" method="get" name="frmSendValue_0">
		
	<input type="hidden" id="pageNum_0" name="pageNum_0" value="${pagingCreator_0.mypagePaging.pageNum_0 }" >
	<input type="hidden" id="rowAmountPerPage" name="rowAmountPerPage" value="${pagingCreator_0.mypagePaging.rowAmountPerPage }" >
	<input type="hidden" id="lastPageNum_0" name="lastPageNum_0" value="${pagingCreator_0.lastPageNum_0 }" >
	
</form>  
                <div class="panel-body">
					<table class="table table-striped table-bordered table-hover" id="table_0"
					       style="width:100%;text-align: center;">
					    <thead>
					        <tr>
					            <th>방 번호</th>
					            <th>제목</th>
					            <th>날짜</th>
					            <th>내가 낸 금액</th>
					        </tr>
					    </thead>
					    <tbody>
					    	<c:choose>
						    <c:when test="${not empty pagingCreator_0.dutchlist}">
								<c:forEach var="personal" items="${pagingCreator_0.dutchlist}">
									<c:if test="${personal.pcalculated == 0 }">
										<tr class="history" style="text-align: center" data-pno="${personal.pno }">
											<td><c:out value="${personal.pno }"/></td>
											<td><c:out value="${personal.ptitle }"/></td>
											<td><fmt:formatDate value="${personal.pregDate }" pattern="yyyy-MM-dd"/></td>
											<td><c:out value="${personal.ppersonal }"/></td>
										</tr>
									</c:if>
								</c:forEach>
							</c:when>
							<c:otherwise>
								<tr class="odd gradeX">
									<td colspan="6">진행중인 더치페이 내역이 없습니다.</td>
								</tr>
							</c:otherwise>	    	
					    	</c:choose>
						</tbody>
                	</table><%-- /.table-responsive --%>
					<div style="text-align: center;">
						<ul class="pagination pagination-sm" id="ul_0" >
							<c:if test="${pagingCreator_0.prev_0 }">
								<li class="pagination-button">
									<a href="1" aria-label="Previous">
										<span aria-hidden="true">&laquo</span>
									</a>
								</li>
							</c:if>
							<c:if test="${pagingCreator_0.prev_0 }">
								<li class="pagination-button">
									<a href="${pagingCreator_0.startPagingNum_0 - 1 }" aria-label="Previous">
										<span aria-hidden="true">이전</span>
									</a>
								</li>
							</c:if>
							<c:forEach begin="${pagingCreator_0.startPagingNum_0 }" 
							           end="${pagingCreator_0.endPagingNum_0 }" 
							           var="pagingNum">
								
								<li class='pagination-button ${(pagingNum == pagingCreator_0.mypagePaging.pageNum_0) ? "active" : ""}'>
									<a href="${pagingNum }">${pagingNum }</a>
								</li>     
							</c:forEach>
							<c:if test="${pagingCreator_0.next_0 }">
								<li class="pagination-button">
									<a href="${pagingCreator_0.endPagingNum_0 + 1 }" aria-label="Next">
										<span aria-hidden="true">다음</span>
									</a>
								</li>
							</c:if>
							<c:if test="${pagingCreator_0.next_0 }">
								<li class="pagination-button">
									<a href="${pagingCreator_0.lastPageNum_0 }" aria-label="Next">
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

<br>

<div id="page-wrapper">
    <div class="row">
        <div class="col-lg-12">
            <div class="panel panel-default">
                <div class="panel-heading">
					<div class="row">
						<div class="col-md-6" style="font-size:20px; height: 45px; padding-top:10px;">정산완료 내역</div>
					</div>
				</div><%-- /.panel-heading --%>
				
								
<form class="form-inline" id="frmSendValue_1" name="frmSendValue_1">
		
	<input type="hidden" id="pageNum_1" name="pageNum_1" value="${pagingCreator_1.mypagePaging.pageNum_1 }" >
	<input type="hidden" id="rowAmountPerPage" name="rowAmountPerPage" value="${pagingCreator_1.mypagePaging.rowAmountPerPage }" >
	<input type="hidden" id="lastPageNum_1" name="lastPageNum_1" value="${pagingCreator_1.lastPageNum_1 }" >
	
</form>  				
                <div class="panel-body">
					<table class="table table-striped table-bordered table-hover" id="table_1" 
					       style="width:100%;text-align: center;">
					    <thead>
					        <tr>
					            <th>방 번호</th>
					            <th>제목</th>
					            <th>날짜</th>
					            <th>내가 낸 금액</th>
					        </tr>
					    </thead>
						<tbody>
					    	<c:choose>
						    <c:when test="${not empty pagingCreator_1.dutchlist}">
								<c:forEach var="personal" items="${pagingCreator_1.dutchlist}">
									<c:if test="${personal.pcalculated == 1 }">
										<tr class="history" style="text-align: center" data-pno="${personal.pno }">
											<td><c:out value="${personal.pno }"/></td>
											<td><c:out value="${personal.ptitle }"/></td>
											<td><fmt:formatDate value="${personal.pregDate }" pattern="yyyy-MM-dd"/></td>
											<td><c:out value="${personal.ppersonal }"/></td>
										</tr>
									</c:if>
								</c:forEach>
							</c:when>
							<c:otherwise>
								<tr class="odd gradeX">
									<td colspan="6">완료한 더치페이 내역이 없습니다.</td>
								</tr>
							</c:otherwise>	    	
					    	</c:choose>
						</tbody>
                	</table><%-- /.table-responsive --%>
					<div style="text-align: center;" >
						<ul class="pagination pagination-sm" id="ul_1" >
							<c:if test="${pagingCreator_1.prev_1 }">
								<li class="pagination-button">
									<a href="1" aria-label="Previous">
										<span aria-hidden="true">&laquo</span>
									</a>
								</li>
							</c:if>
							<c:if test="${pagingCreator_1.prev_1 }">
								<li class="pagination-button">
									<a href="${pagingCreator_1.startPagingNum_1 - 1 }" aria-label="Previous">
										<span aria-hidden="true">이전</span>
									</a>
								</li>
							</c:if>
							<c:forEach begin="${pagingCreator_1.startPagingNum_1 }" 
							           end="${pagingCreator_1.endPagingNum_1 }" 
							           var="pagingNum">
								
								<li class='pagination-button ${(pagingNum == pagingCreator_1.mypagePaging.pageNum_1) ? "active" : ""}'>
									<a href="${pagingNum }">${pagingNum }</a>
								</li>     
							</c:forEach>
							<c:if test="${pagingCreator_1.next_1 }">
								<li class="pagination-button">
									<a href="${pagingCreator_1.endPagingNum_1 + 1 }" aria-label="Next">
										<span aria-hidden="true">다음</span>
									</a>
								</li>
							</c:if>
							<c:if test="${pagingCreator_1.next_1 }">
								<li class="pagination-button">
									<a href="${pagingCreator_1.lastPageNum_1 }" aria-label="Next">
										<span aria-hidden="true">&raquo</span>
									</a>
								</li>
							</c:if>
						</ul>
					</div><%-- 페이징 div --%>               	
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
            <div class="modal-body" id="yourModal-body">메시지</div>
            
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" data-dismiss="modal">Close</button>
            </div>
        </div><%-- /.modal-content --%>
    </div><%-- /.modal-dialog --%>
</div><%-- /.modal --%>



<script>

<%-- 회원정보 상세 페이지 이동 --%>
$("#btnToBack").on("click", function(){

	window.location.href = "${contextPath}/mypage/home";
});


var frmSendValue_0 = $("#frmSendValue_0");
var frmSendValue_1 = $("#frmSendValue_1");


<%--진행중인 목록 페이징 버튼에 대한 클릭 이벤트를 처리--%>
$("#ul_0 li.pagination-button a").on("click", function(e) {
	e.preventDefault() ;
	frmSendValue_0.find("input[name='pageNum_0']").val($(this).attr("href")) ;
	console.log(frmSendValue_0.find("input[name='pageNum_0']").val());
	frmSendValue_0.attr("action", "${contextPath}/mypage/history") ;
	frmSendValue_0.attr("method", "get") ;
	
	frmSendValue_0.submit() ;
});

<%--완료된 목록 페이징 버튼에 대한 클릭 이벤트를 처리--%>
$("#ul_1 li.pagination-button a").on("click", function(e) {
	e.preventDefault() ;
	frmSendValue_1.find("input[name='pageNum_1']").val($(this).attr("href")) ;
	console.log(frmSendValue_1.find("input[name='pageNum_1']").val());
	frmSendValue_1.attr("action", "${contextPath}/mypage/history") ;
	frmSendValue_1.attr("method", "get") ;
	
	frmSendValue_1.submit() ;
});
	
	
<%-- dutchdetail.jsp 페이지로 이동--%>
$(".history").on("click", function(){
	var pno = $(this).data("pno");
	
	frmSendValue_0.append("<input type='hidden' name='pno' value=' " + pno + " '/>");
	frmSendValue_0.attr("action", "${contextPath}/pay/detail").attr("method", "get");
	frmSendValue_0.submit();
	frmSendValue_0.find('input[name="pno"]').remove(); 
	
});



</script>



<%@include file="../pageinclude/footer.jsp" %> 