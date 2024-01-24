<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<c:set var="contextPath" value="${pageContext.request.contextPath }"/>

<%@include file="../pageinclude/header.jsp" %>

<style>
th {text-align: center;}
</style>

<!-- JSP 폼 입니다 아래 공간 안에서 코딩하시면 됩니다 -->

<div id="page-wrapper">
    <div class="row">
        <div class="col-lg-12">
            <h3 class="page-header">DutchPay - List</h3>
        </div><%-- /.col-lg-12 --%>
    </div><%-- /.row --%>
    <div class="row">
        <div class="col-lg-12">
            <div class="panel panel-default">
                <div class="panel-heading">
					<div class="row">
						<div class="col-md-6" style="font-size:20px; height: 45px; padding-top:10px;">더치페이 목록</div>
						<div class="col-md-6" style="padding-top:8px;">
							<button type="button" id="btnToRegister" class="btn btn-primary btn-sm pull-right">더치페이 등록</button>
						</div>
					</div>
				</div><%-- /.panel-heading --%>
   
<form class="form-inline" id="frmSendValue" action="${contextPath }/pay/list" method="get" name="frmSendValue">
<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }"/> <!-- 403 forbidden 에러 안나도록 -->
		
	<input type="hidden" id="pageNum" name="pageNum" value="${pagingCreator.dutchPaging.pageNum }" >
	<input type="hidden" id="rowAmountPerPage" name="rowAmountPerPage" value="${pagingCreator.dutchPaging.rowAmountPerPage }" >
	<input type="hidden" id="lastPageNum" name="lastPageNum" value="${pagingCreator.lastPageNum }" >
	
</form>     
                <div class="panel-body">
                    <table class="table table-striped table-bordered table-hover" style="width:100%;text-align: center;">
                    <thead>
                        <tr >
                            <th>방 번호</th>
                            <th>제목</th>
                            <th>전체 금액</th>
                            <th>개인부담금액</th>
                            <th>방 생성일</th>
                            <th>방 수정일</th>
				            <th>정산 여부</th>
                        </tr>
                    </thead>
                    
					<tbody>              
					<c:choose>
					<c:when test="${not empty pagingCreator.dutchlist }">
						<c:forEach var="dutchlist" items="${pagingCreator.dutchlist}">
							<c:choose>
								<c:when test="${dutchlist.pdelFlag == 1 }">
									<tr style="background-color: Moccasin; text-align: center">
					             		<td>${dutchlist.pno }</td>
					             		<td colspan="7"><em>작성자에 의해서 삭제된 게시글입니다.</em></td>
					         		</tr>
								</c:when>
								<c:otherwise>
									<tr class="moveDetail" data-pno="${dutchlist.pno }">
										<td><c:out value="${dutchlist.pno }"/></td><%-- 
										<td style="text-align: left"><a href="${contextPath }/myboard/detail?bno=${myboard.pno}" ><c:out value="${myboard.ptitle }"/></a></td> --%>
										<td style="text-align: left">
											<c:out value="${dutchlist.ptitle }"/>
											<%-- <small>[댓글수: <strong><c:out value="${myboard.breplyCnt}"/></strong>]</small> --%>	
										</td>
										<td>${dutchlist.ptotalPayment }</td>
										<td>${dutchlist.ppersonal }</td>
										<td class="center"><fmt:formatDate value="${dutchlist.pregDate }" pattern="yyyy/MM/dd HH:mm:ss"/></td>
										<td class="center"><fmt:formatDate value="${dutchlist.pmodDate }" pattern="yyyy/MM/dd HH:mm:ss"/></td>
										<td class="center">
											<c:if test="${dutchlist.pcalculated == 1}">정산 완료</c:if>
											<c:if test="${dutchlist.pcalculated == 0}">정산중</c:if>
										</td>
										
							 		</tr>
								</c:otherwise>		
							</c:choose>			
						</c:forEach>
					</c:when>
					<c:otherwise>
						<tr class="odd gradeX">
							<td colspan="7">등록된 게시물이 없습니다.</td>
						</tr>
					</c:otherwise>
					</c:choose>                                     
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

<%--dutchRegister.jsp 페이지로 이동 --%>
$("#btnToRegister").on("click", function(){
	window.location.href = "${contextPath}/pay/register" ;
	
	
});

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
	frmSendValue.attr("action", "${contextPath}/pages/dutchList")
	frmSendValue.attr("method", "get");
	
	frmSendValue.submit();
	
});





var deleteResult = '<c:out value="${deleteResult}" />' ;
<%-- 삭제시 모달 호출 함수--%>
function runModal(deleteResult) {
	console.log(deleteResult);
	if (deleteResult.length == 0) {
		return ;
	
	} else if ( deleteResult == "successDelete" ) {
		var myMsg =  "게시글이 삭제 되었습니다. " ;

		
	} else if ( deleteResult == "failDelete" ) {
		var myMsg =  "게시글 삭제에 실패하였습니다." ;
		
	} 
	//$(".modal-body").html(myMsg) ;
	$("#yourModal-body").html(myMsg) ;
	
	$("#yourModal").modal("show") ;
	
	myMsg = "" ;
}

$(document).ready(function(){
	runModal(deleteResult) ;
});


</script>










<%@include file="../pageinclude/footer.jsp" %> 