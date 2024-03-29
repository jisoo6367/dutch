<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<c:set var="contextPath" value="${pageContext.request.contextPath }" />

<%@include file="../pageinclude/header.jsp"%>

<style>
 th {text-align: center;}
</style>  

<div id="page-wrapper">
    <div class="row">
        <div class="col-lg-12">
            <h3 class="page-header">1:1문의</h3>
        </div><%-- /.col-lg-12 --%>
    </div><%-- /.row --%>
    <div class="row">
        <div class="col-lg-12">
        
            <div class="panel panel-default">
                <div class="panel-heading">
					<div class="row">
						<div class="col-md-6" style="font-size:20px; height: 45px; padding-top:10px;">문의 목록</div>
						<div class="col-md-6" style="padding-top:8px;">
							<button type="button" id="btnToRegister" class="btn btn-primary btn-sm pull-right">새 문의 등록</button>
						</div>
					</div>
				</div><%-- /.panel-heading --%>
                
             <div class="panel-body"> 

	<form class="form-inline" id="frmSendValue" name="frmSendValue" action="${contextPath }/qna/list" method="get" >
		<div class="form-group">
			<label class="sr-only">frmSendValues</label>
				<select class="form-control" id="selectAmount" name="rowAmountPerPage">
					<option value="10" ${(qnaCreator.qnaPaging.rowAmountPerPage == 10) ? "selected" : "" }>10개</option>
					<option value="20" ${(qnaCreator.qnaPaging.rowAmountPerPage == 20) ? "selected" : "" }>20개</option>
					<option value="30" ${(qnaCreator.qnaPaging.rowAmountPerPage == 30) ? "selected" : "" }>30개</option>
					<option value="50" ${(qnaCreator.qnaPaging.rowAmountPerPage == 50) ? "selected" : "" }>50개</option>
				</select>

	
	<input type="hidden" id="pageNum" name="pageNum" value="${qnaCreator.qnaPaging.pageNum }" > 
	<input type="hidden" id="lastPageNum" name="lastPageNum" value="${qnaCreator.lastPageNum }" >
  
	</div>
	<div class="form-group pull-right">
		<input class="form-control" id="beginDate" name="beginDate" type="date"
			   value="${qnaCreator.qnaPaging.beginDate}" 
			   />
		<input class="form-control" id="endDate" name="endDate" type="date"
			   value="${qnaCreator.qnaPaging.endDate}" 
			   />

		<button type="button" class="btn btn-primary mybtns" 
				id="btnIntervalSearch" >작성일 기간검색</button>
	</div>
	               
<hr>  
	</form>  
               
<table class="table table-striped table-bordered table-hover" 
       style="width:100%;text-align: center;">
<thead>
    <tr>
      <th>글번호</th>
      <th>제목</th>
      <th>닉네임</th>
      <th>작성일</th>
      <th>수정일</th>
      <!-- <th>답변</th> -->
      <th>문의상황</th>
    </tr>
</thead>
<tbody>
<c:choose>
<c:when test="${not empty qnaCreator.qnaList }">
	<c:forEach var="qna" items="${qnaCreator.qnaList}">
		<c:choose>
			<c:when test="${qna.qdelFlagAdmin == 1 }">
				<tr style="background-color: Moccasin; text-align: center">
				    <td>${qna.qno }</td>
				    <td colspan="6"><em>삭제된 게시글입니다.</em></td>
				</tr>
			</c:when>
			<c:when test="${qna.qsignal == 2 }">
				<tr style="background-color: skyblue; text-align: center">
				    <td>${qna.qno }</td>
				    <td colspan="6"><em>문의 완료된 게시글입니다.</em></td>
				</tr>
			</c:when>
			<c:otherwise>
				<tr class="moveDetail" data-qno="${qna.qno }">
					<td><c:out value="${qna.qno }"/></td>
					<td style="text-align: left;">
						<c:out value="${qna.qtitle }"/>
					</td>
					<td>${qna.nickname }</td>
					<td class="center"><fmt:formatDate value="${qna.qregDate }" pattern="yyyy/MM/dd  HH:mm:ss"/></td>
					<td class="center"><fmt:formatDate value="${qna.qmodDate }" pattern="yyyy/MM/dd  HH:mm:ss"/></td>
				 	<%-- <td style="text-align: center;">
						<small><strong><c:out value="${qna.qreplyCnt}"/></strong></small>
					</td> --%>
				 	<td style="text-align: center;">
				 		<c:choose>
				 			<c:when test="${qna.qsignal == 0}">
				 				<small><b>문의 중</b></small>
				 			</c:when>
				 			<c:when test="${qna.qsignal == 1}">
				 				<small><b>답변 완료</b></small>
				 			</c:when>
				 			<c:otherwise>
				 				<small><b>문의 완료</b></small>
				 			</c:otherwise>
				 		</c:choose>
					</td>
				 </tr>
			</c:otherwise>
		</c:choose>
	</c:forEach>
</c:when>
	<c:otherwise>
		<tr class="odd gradeX">
			<td colspan="6">등록된 게시물이 없습니다.</td>
		 </tr>
	</c:otherwise>
</c:choose>                        

    </tbody>
</table><%-- /.table-responsive --%>
<div style="text-align: center;">
	<ul class="pagination pagination-sm" >
		<c:if test="${qnaCreator.prev }">
			<li class="pagination-button">
				<a href="1" aria-label="Previous">
					<span aria-hidden="true">&laquo</span>
				</a>
			</li>
		</c:if>
		<c:if test="${qnaCreator.prev }">
			<li class="pagination-button">
				<a href="${qnaCreator.startPagingNum - 1 }" aria-label="Previous">
					<span aria-hidden="true">이전</span>
				</a>
			</li>
		</c:if>
		<c:forEach begin="${qnaCreator.startPagingNum }" 
		           end="${qnaCreator.endPagingNum }" 
		           var="pagingNum">
			
			<li class='pagination-button ${(pagingNum == qnaCreator.qnaPaging.pageNum) ? "active" : ""}'>
				<a href="${pagingNum }">${pagingNum }</a>
			</li>     
		</c:forEach>
		<c:if test="${qnaCreator.next }">
			<li class="pagination-button">
				<a href="${qnaCreator.endPagingNum + 1 }" aria-label="Next">
					<span aria-hidden="true">다음</span>
				</a>
			</li>
		</c:if>
		<c:if test="${qnaCreator.next }">
			<li class="pagination-button">
				<a href="${qnaCreator.lastPageNum }" aria-label="Next">
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
<div class="modal fade" id="qnaModal" tabindex="-1" role="dialog" aria-labelledby="qnaModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="qnaModalLabel">Modal title</h4>
            </div>
            <div class="modal-body" id="qnaModal-body">메시지</div>
            
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" data-dismiss="modal">Close</button>
            </div>
        </div><%-- /.modal-content --%>
    </div><%-- /.modal-dialog --%>
</div><%-- /.modal --%>

<%-- 리스트 자바스크립트 시작 --%>
<script>

var frmSendValue = $("#frmSendValue");
var result = '<c:out value="${result}" />' ;

<%-- 등록페이지 이동 --%>
$("#btnToRegister").on("click", function(){
	window.location.href = "${contextPath}/qna/register" ;
});

<%-- 상세페이지 이동 --%>
$(".moveDetail").on("click", function(){
	var qno = $(this).data("qno");
	
	window.location.href = "${contextPath}/qna/detail?qno=" + qno ;
});

<%-- 모달 호출 함수 --%>
function runModal(result) {
	
	if (result.length == 0) {
		return ;
	
	} else if ( result == "successRemove" ) {
		var qnaMsg =  "게시글이 삭제되었습니다. " ;
		
	} else if ( parseInt(result) > 0 ) {
		var qnaMsg =  result + "번 게시글이 등록되었습니다. "
	
	} 
	
	$("#qnaModal-body").html(qnaMsg) ;
	
	$("#qnaModal").modal("show") ;
	
	qnaMsg = "" ;
}

<%-- 페이징 처리: 검색 목록 페이지 이동 --%>
$("li.pagination-button a").on("click", function(e){
	e.preventDefault() ;
	frmSendValue.find("input[name='pageNum']").val($(this).attr("href")) ;
 	console.log(frmSendValue.find("input[name='pageNum']").val());
	frmSendValue.attr("action", "${contextPath}/qna/myQna") ;
	frmSendValue.attr("method", "get") ;
	
	frmSendValue.submit() ;
	
});

<%-- 검색 관련 요소 --%>
<%--표시행수 변경 이벤트 처리--%>
$("#selectAmount").on("change", function(){
	frmSendValue.find("input[name='pageNum']").val(1) ;
	frmSendValue.submit() ;
} );

$(document).ready(function(){
	runModal(result) ;
	
	window.addEventListener("popstate", function(event){
		history.pushState(null, null, location.href) ;
		
	});
	
	history.pushState(null, null, location.href) ;
	
});

<%--기간 검색버튼 클릭 이벤트 처리 --%>
$("#btnIntervalSearch").on("click", function(){
	
	var beginDate = $("#beginDate").val() ;
	var endDate = $("#endDate").val() ;
	
	if (!beginDate || beginDate == "" || !endDate || endDate == "") {
		alert("시작날짜와 끝날짜를 모두 선택하세요") ;
		return ;
	}

	frmSendValue.find("input[name='pageNum']").val(1) ;
	frmSendValue.submit() ;
	
});

/* $(document).ready(function(){
	runModal(result) ;
	
	window.addEventListener("popstate", function(event){
		history.pushState(null, null, location.href) ;
		
	});
	
	history.pushState(null, null, location.href) ;
	
}); */
</script>

<%@include file="../pageinclude/footer.jsp"%>