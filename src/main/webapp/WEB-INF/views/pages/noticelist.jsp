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
            <h3 class="page-header">공지사항</h3>
        </div><%-- /.col-lg-12 --%>
    </div><%-- /.row --%>
    <div class="row">
        <div class="col-lg-12">
        
            <div class="panel panel-default">
                <div class="panel-heading">
					<div class="row">
						<!-- <div class="col-md-6" style="font-size:20px; height: 45px; padding-top:10px;">공지사항</div> -->
						
			        <%--<div class="panel-body">
                 		  <div class="input-group"><!-- 검색어 입력 -->
						<input class="form-control" id="keyword" name="keyword" type="text" 
						       placeholder="검색어를 입력하세요"
							   value='<c:out value="${noticeCreator.noticePaging.keyword}" />' />
						<span class="input-group-btn"><!-- 전송버튼 -->
							<button class="btn btn-warning" type="button" id="btnSearchGo"
									><i class="fa fa-search">검색</i>
							</button> --%>
						<div class="col-md-6" style="padding-top:8px;">
							<button type="button" id="btnToRegister" class="btn btn-primary btn-sm pull-right">새글 등록</button>
						</div>
						<!-- </span> -->
					</div>
<!-- 					<div class="input-group">
						<button id="btnReset" class="btn btn-info" type="button">
							<span class="glyphicon glyphicon-remove"></span>
						</button>
						</div>
					</div> -->
						

					</div>
				</div><%-- /.panel-heading --%>
                

                
 <form class="form-inline" id="frmSendValue" name="frmSendValue" action="${contextPath }/pages/noticelist" method="get" >
	<div class="form-group">
		<label class="sr-only">frmSendValues</label>
 	<select class="form-control" id="selectAmount" name="rowAmountPerPage">
			<option value="10" ${(noticeCreator.noticePaging.rowAmountPerPage == 10) ? "selected" : "" }>10개</option>
			<option value="20" ${(noticeCreator.noticePaging.rowAmountPerPage == 20) ? "selected" : "" }>20개</option>
			<option value="50" ${(noticeCreator.noticePaging.rowAmountPerPage == 50) ? "selected" : "" }>50개</option>
			<option value="100" ${(noticeCreator.noticePaging.rowAmountPerPage == 100) ? "selected" : "" }>100개</option>
	</select>
		
	
		<input type="hidden" id="pageNum" name="pageNum" value="${noticeCreator.noticePaging.pageNum }" ><%-- 
		<input type="hidden" id="rowAmountPerPage" name="rowAmountPerPage" value="${noticeCreator.noticePaging.rowAmountPerPage }" > --%>
		<input type="hidden" id="lastPageNum" name="lastPageNum" value="${noticeCreator.lastPageNum }">
	 </div>
</form>
 
		<table class="table table-striped table-bordered table-hover" 
		       style="width:100%;text-align: center;">
		<thead>
		    <tr>
		    	<!-- <th>카테고리</th> -->
		        <th>글번호</th>
		        <th>제목</th>
		        <th>작성자</th>
		        <th>작성일</th>
		        <th>조회수</th>
		    </tr>
		</thead>
		<tbody>

<c:choose>
<c:when test="${not empty noticeCreator.noticeList}">
	<c:forEach var="notice" items="${noticeCreator.noticeList}">
		<%-- <c:choose> --%>
			<%-- <c:when test="${notice.cdelFlag == 1 }">
				<tr style="background-color: Moccasin; text-align: center">
				    <td>${notice.cno }</td>
				    <td colspan="6"><em>작성자에 의해서 삭제된 게시글입니다.</em></td>
				</tr>
			</c:when> --%>
			<%-- <c:otherwise>	 --%>	
				<tr class="moveDetail" data-cno="${notice.cno }">
				<%-- <td><c:out value="${notice.ccategory }"/></td> --%>
					<td><c:out value="${notice.cno }"/></td>
					<td style="text-align: left">
						<c:out value="${notice.ctitle }"/>
						<%-- <small>[첨부파일: <strong><c:out value="${notice.attachFileList}"/></strong>]</small> --%>
					</td>
					<td>${notice.nickname }</td>
					<td class="center"><fmt:formatDate value="${notice.cregDate }" pattern="yyyy/MM/dd HH:mm:ss"/></td>
				 	<td class="center"><c:out value="${notice.cviewCnt }"/></td>
				 
				 </tr>
			<%-- </c:otherwise> --%>
		<%-- </c:choose> --%>
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
		<c:if test="${noticeCreator.prev }">
			<li class="pagination-button">
				<a href="1" aria-label="Previous">
					<span aria-hidden="true">&laquo</span>
				</a>
			</li>
		</c:if>
		<c:if test="${noticeCreator.prev }">
			<li class="pagination-button">
				<a href="${noticeCreator.startPagingNum - 1 }" aria-label="Previous">
					<span aria-hidden="true">이전</span>
				</a>
			</li>
		</c:if>
		<c:forEach begin="${noticeCreator.startPagingNum }" 
		           end="${noticeCreator.endPagingNum }" 
		           var="pagingNum">
			
			<li class='pagination-button ${(pagingNum == noticeCreator.noticePaging.pageNum) ? "active" : ""}'>
				<a href="${pagingNum }">${pagingNum }</a>
			</li>     
		</c:forEach>
		<c:if test="${noticeCreator.next }">
			<li class="pagination-button">
				<a href="${noticeCreator.endPagingNum + 1 }" aria-label="Next">
					<span aria-hidden="true">다음</span>
				</a>
			</li>
		</c:if>
		<c:if test="${noticeCreator.next }">
			<li class="pagination-button">
				<a href="${noticeCreator.lastPageNum }" aria-label="Next">
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
<div class="modal fade" id="noticeModal" tabindex="-1" role="dialog" aria-labelledby="noticeModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="noticeModalLabel">Modal title</h4>
            </div>
            <div class="modal-body" id="noticeModal-body">메시지</div>
            
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" data-dismiss="modal">Close</button>
            </div>
        </div><%-- /.modal-content --%>
    </div><%-- /.modal-dialog --%>
</div><%-- /.modal --%>

<script>

var frmSendValue = $("#frmSendValue");
var result = '<c:out value="${result}" />' ;

<%-- 등록페이지 이동 --%>
$("#btnToRegister").on("click", function(){
	window.location.href = "${contextPath}/pages/noticeregister" ;
});


<%-- 상세페이지 이동 --%>
$(".moveDetail").on("click", function(){
	var cno = $(this).data("cno");
	
	window.location.href = "${contextPath}/pages/noticedetail?cno=" + cno ;
	
/* 	frmSendValue.append("<input type='hidden' name='cno' value='" + cno +"'/>");
	frmSendValue.attr("action", "${contextPath}/pages/noticedetail").attr("method", "get") ;
	frmSendValue.submit() ;
	frmSendValue.find('input[name="cno"]').remove() ; */  	//웹 브라우저 뒤로가기 후, 다른 게시물 상세 이동 시에
														//bno값이 계속 url에 추가되는 현상 해결
});

<%-- 모달 호출 함수 --%>
function runModal(result) {
	
	if (result.length == 0) {
		return ;
	
	} else if ( result == "successRemove" ) {
		var noticeMsg =  "게시글이 삭제되었습니다. " ;
		
	} else if ( parseInt(result) > 0 ) {
		var noticeMsg =  result + "번 게시글이 등록되었습니다. "
	
	} 

	//$(".modal-body").html(noticeMsg) ;
	$("#noticeModal-body").html(noticeMsg) ;
	
	$("#noticeModal").modal("show") ;
	
	noticeMsg = "" ;
}


<%-- 페이징 처리: 검색 목록 페이지 이동 --%>
$("li.pagination-button a").on("click", function(e){
	e.preventDefault() ;
	frmSendValue.find("input[name='pageNum']").val($(this).attr("href")) ;
	console.log(frmSendValue.find("input[name='pageNum']").val());
	frmSendValue.attr("action", "${contextPath}/pages/noticelist") ;
	frmSendValue.attr("method", "get") ;
	
	frmSendValue.submit() ;
	
});

<%-- 검색 관련 요소 --%>
<%--표시행수 변경 이벤트 처리--%>
$("#selectAmount").on("change", function(){
	frmSendValue.find("input[name='pageNum']").val(1) ;
	frmSendValue.submit() ;
} );

<%--키워드 검색버튼 클릭 이벤트 처리 --%>
$("#btnSearchGo").on("click", function() {
   
   var keyword = $("#keyword").val() ;
   
   if(!keyword || keyword.length == 0){
      alert("검색어를 입력해주세요.");
      return ;      
   }
   
   frmSendValue.find("input[name='pageNum']").val(1);
   frmSendValue.submit();
});

 $("#selectScope").on("change", function(){
	
	var keyword = $("#keyword").val() ;
	   
	if(keyword || keyword.length != 0){
		$("#pageNum").val(1) ;
		frmSendValue.submit() ;      
	} 

});

<%--검색초기화 버튼 이벤트처리, 버튼 초기화 시, 1페이지에 목록 정보 다시 표시 --%>
$("#btnReset").on("click", function(){
	$("#selectAmount").val(10) ;
    $("#selectScope").val("") ; 
	$("#keyword").val("") ;
	$("#pageNum").val(1) ;
	
	frmSendValue.submit() ;

});

$(document).ready(function(){
	runModal(result) ;
	
	window.addEventListener("popstate", function(event){
		history.pushState(null, null, location.href) ;
		
	});
	
	history.pushState(null, null, location.href) ;
	
});


</script>

<%@include file="../pageinclude/footer.jsp"%>