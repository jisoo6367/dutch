<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<c:set var="contextPath" value="${pageContext.request.contextPath }"/>

<%@include file="../pageinclude/header.jsp" %>



<!-- JSP 폼 입니다 아래 공간 안에서 코딩하시면 됩니다 -->

<div id="page-wrapper">
    <div class="row"> 
        <div class="col-lg-12">
            <h3 class="page-header">[관리자] Community - 신고된 목록</h3>
        </div>
    </div>
    
    <div class="row">
        <div class="col-lg-12">
        
            <div class="panel panel-default">
                <div class="panel-heading">
					<div class="row">
						<div class="col-md-6" style="font-size:20px; height: 45px; padding-top:10px;">커뮤니티</div>
					</div>
				</div><%-- /.panel-heading --%>
                
                <div class="panel-body">
 
					<form class="form-inline" id="frmSendValue" name="frmSendValue" action="${contextPath }/community/reportedList" method="get" >
					   <input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }"/>
					   
						<div class="form-group">
						<label class="sr-only">frmSendValues</label>
					 		<select class="form-control" id="selectAmount" name="rowAmountPerPage">
								<option value="10" ${(pagingCreator.communityPaging.rowAmountPerPage == 10) ? "selected" : "" }>10개</option>
								<option value="20" ${(pagingCreator.communityPaging.rowAmountPerPage == 20) ? "selected" : "" }>20개</option>
								<option value="30" ${(pagingCreator.communityPaging.rowAmountPerPage == 30) ? "selected" : "" }>30개</option>
								<option value="40" ${(pagingCreator.communityPaging.rowAmountPerPage == 40) ? "selected" : "" }>40개</option>
								<option value="50" ${(pagingCreator.communityPaging.rowAmountPerPage == 50) ? "selected" : "" }>50개</option>
							</select>
							
							
							<select class="form-control" id="selectScope" name="scope">
								<option value="" ${(pagingCreator.communityPaging.scope == null ) ? "selected" : "" }>범위선택</option>
								<option value="T" ${(pagingCreator.communityPaging.scope == "T" ) ? "selected" : "" }>제목</option>
								<option value="W" ${(pagingCreator.communityPaging.scope == "W" ) ? "selected" : "" }>작성자</option>
							</select>
							
							
							<div class="input-group" style="margin-top: px;">
										<!-- 검색어 입력 -->
										<input class="form-control" id="keyword" name="keyword" type="text"
											placeholder="검색어를 입력하세요"
											value='<c:out value="${pagingCreator.communityPaging.keyword}" />' /> <span
											class="input-group-btn"> <!-- 전송버튼 -->
											<button class="btn btn-warning" type="button" id="btnSearchGo">검색
											</button><i class="fa fa-search"></i>
										</span>
							</div>
									
							<!-- 검색 초기화 버튼 -->
							<div class="input-group">
								<button id="btnReset" class="btn btn-info" type="button">
									<span class="glyphicon glyphicon-repeat"></span>
								</button>
							</div>	
						</div>
						
						<input type="hidden" id="pageNum" name="pageNum" value="${pagingCreator.communityPaging.pageNum }" >
						<input type="hidden" id="rowAmountPerPage" name="rowAmountPerPage" value="${pagingCreator.communityPaging.rowAmountPerPage }" >
						<input type="hidden" id="lastPageNum" name="lastPageNum" value="${pagingCreator.lastPageNum }" >
						
					</form><br>               

		   <table class="table table-striped table-bordered table-hover" 
		          style="width:100%;text-align: center;">
		       <thead>
		           <tr>
					   <th>방번호</th>
		               <th>카테고리</th>
		               <th>방제목</th>
		               <th>작성자</th>
		               <th>게시글 작성일</th>
		               <th>게시글 수정일</th>
		               <th>조회수</th>
		           </tr>
		       </thead>
		       <tbody>

				<c:forEach var="community" items="${pagingCreator.communityList}">
					<c:choose>
					<c:when test="${community.treport == 1 }">
						<c:choose>
						<c:when test="${community.tdelFlag == 1 }">
							<tr style="background-color: Moccasin; text-align: center">
								<td>${community.tno }</td> 
							    <td colspan="6"><em>삭제된 게시글입니다.</em></td>
							</tr>
						</c:when>
						<c:otherwise>
							<tr class="moveDetail" data-tno="${community.tno }">
								<td><c:out value="${community.tno }"/></td>	
								<td><c:out value="${community.tcategory }"/></td>
								<td style="text-align: left"><c:out value="${community.ttitle}"/>
								  <small>[<strong><c:out value="${community.treplyCnt}"/></strong>]</small> 
								</td>					
								<td>${community.nickname }</td>
								<td class="center"><fmt:formatDate value="${community.tregDate }" pattern="yyyy/MM/dd HH:mm"/></td>
								<td class="center"><fmt:formatDate value="${community.tmodDate }" pattern="yyyy/MM/dd HH:mm:ss"/></td>
								<td class="center"><c:out value="${community.tviewCnt }"/></td>
							 </tr>
						</c:otherwise>
						</c:choose>
					</c:when>
					</c:choose>
				</c:forEach>

    			</tbody>
			</table><%-- /.table-responsive --%>
				      
				<!-- 번호 이전 다음 페이지 처리 -->
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
							
							<li class='pagination-button ${(pagingNum == pagingCreator.communityPaging.pageNum) ? "active" : ""}'>
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
        </div><%-- /.col-lg-12 --%>
    </div><%-- /.row --%>

</div><%-- /#page-wrapper --%>
</div>




<script>

var frmSendValue = $("#frmSendValue");

//상세페이지 이동
$(".moveDetail").on("click", function(){
	console.log(${pagingCreator.communityPaging.pageNum });
	
	var tno = $(this).data("tno") ;
	
	frmSendValue.append("<input type='hidden' name='tno' value='" + tno + "'/>")
	frmSendValue.attr("action", "${contextPath}/community/detail").attr("method", "get") ;
	frmSendValue.submit() ;
	frmSendValue.find('input[name="tno"]').remove() ;  	
	
});




	
<%-- 페이지징 처리: 검색 목록 페이지 이동 --%>
	$("li.pagination-button a").on("click", function(e){
		e.preventDefault() ;
		frmSendValue.find("input[name='pageNum']").val($(this).attr("href")) ;
		console.log(frmSendValue.find("input[name='pageNum']").val());
		frmSendValue.attr("action", "${contextPath}/community/reportedList") ;
		frmSendValue.attr("method", "get") ;
		
		frmSendValue.submit() ;
		
	});
	
	
<%--키워드 검색버튼 클릭 이벤트 처리 --%>
$("#btnSearchGo").on("click", function() {
   
   var scope = $("#selectScope").find("option:selected").val();
   
   if(!scope || scope == '' ){
      alert("검색범위를 선택해주세요.");
      return false;
   }
   
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
	
<%--검색초기화 버튼 이벤트처리, 버튼 초기화 시, 1페이지에 목록 정보 다시 표시 --%>
$("#btnReset").on("click", function(){
	$("#selectAmount").val(10) ;
	$("#selectScope").val("") ;
	$("#keyword").val("") ;
	$("#beginDate").val("") ;
	$("#endDate").val("") ;
	$("#pageNum").val(1) ;
	
	frmSendValue.submit() ;

});	
<%--
$(document).ready(function(){
	runModal(result) ;
	
	window.addEventListener("popstate", function(event){
		history.pushState(null, null, location.href) ;
		
	});
	
	history.pushState(null, null, location.href) ;
	
});	
--%>
	
	
	
	
	
	
	
</script>





<%@include file="../pageinclude/footer.jsp" %> 