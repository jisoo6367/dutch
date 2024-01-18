<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<c:set var="contextPath" value="${pageContext.request.contextPath }"/>

<%@include file="../pageinclude/header.jsp" %>

<style>
 th {text-align: center;}
 p {white-space:pre-wrap;}
</style>  

<div id="page-wrapper">
    <div class="row">
        <div class="col-lg-12">
            <h3 class="page-header"
				style="white-space: nowrap;" >Board - Detail
				 <small>
				 	&nbsp;&nbsp;&nbsp;<c:out value="${dutchboard.pno}"/>번 게시물
				 </small>
			</h3>
        </div><%-- /.col-lg-12 --%>
    </div><%-- /.row --%>
    <div class="row">
        <div class="col-lg-12">
    <div class="panel panel-default">
                <div class="panel-heading">
                	<div class="row">
						<div class="col-md-2" style="white-space: nowrap; height: 45px; padding-top:11px;">
							<strong style="font-size:16px;"><%-- ${dutchboard.bwriter} --%>아직표현안함 님 작성</strong>
						</div>
						<div class="col-md-3" style="white-space: nowrap; height: 45px; padding-top:16px;">
							<span class="text-primary" style="font-size: smaller; height: 45px; padding-top: 19px;">
								<span>
									<span>등록일:&nbsp;</span>
									<strong><fmt:formatDate 
												pattern="yyyy-MM-dd HH:mm:ss"
												value="${dutchboard.pregDate}"
											 /></strong>
									<span>&nbsp;&nbsp;</span>
								</span>
								<span>카테고리:&nbsp;<strong><c:out value="${dutchboard.category}"/></strong>
								</span>
							</span>
						</div>
						<div class="col-md-7" style="height: 45px; padding-top:6px;"><%-- vertical-align: middle; --%>
							<div class="button-group pull-right">
							
						<button type="button" id="btnToModify" data-oper="modify"
								class="btn btn-primary"><span>수정페이지로 이동</span></button>
    				
    					<button type="button" id="btnToList" data-oper="list"
									class="btn btn-warning"><span>목록페이지로 이동</span></button>
							</div>
						</div>
    				</div>
                </div><!-- /.panel-heading --><%-- /.panel-heading --%>
    
<div class="panel-body form-horizontal">   <!-- panel-body -->  
    
  	<div class="form-group">
	    <label class="col-sm-2 control-label" style="white-space: nowrap;">글제목</label>
	    <div class="col-sm-10">
	    	<input class="form-control" name="btitle" id="btitle" 
	    		   value="${dutchboard.ptitle }" readonly="readonly">
		</div>
	</div>
	
	<div class="form-group">
	    <label class="col-sm-2 control-label" style="white-space: nowrap;">방작성자</label>
	    <div class="col-sm-10">
	    	<input class="form-control" name="pwriter" id="pwriter" 
	    		   <%-- value="${member.pwriter }" --%> readonly="readonly">
		</div>
	</div>
	
<%-- 	<div class="form-group">
	    <label class="col-sm-2 control-label" style="white-space: nowrap;">글내용</label>
	    <textarea>와 </textarea>는 표시 내용과 붙어있어야 필요없는 공백이 포함되지 않음
	    <div class="col-sm-10">
	    	<textarea class="form-control" rows="3" name="pcontent" id="pcontent"
	    			  style="resize: none;"
	    			  readonly="readonly"><c:out value="${dutchboard.pcontent}"/></textarea>
		</div>	    			  
	</div> --%>
	
	<div class="form-group">
	    <label class="col-sm-2 control-label" style="white-space: nowrap;">전체금액</label>
	    <div class="col-sm-10">
	    	<input class="form-control" name="ptotalPayment" id="ptotalPayment" 
	    		   value="${dutchboard.ptotalPayment }" readonly="readonly">
		</div>
	</div>
	
	<div class="form-group">
	    <label class="col-sm-2 control-label" style="white-space: nowrap;">개인부담금액</label>
	    <div class="col-sm-10">
	    	<input class="form-control" name="ppersonal" id="ppersonal" 
	    		   value="${dutchboard.ppersonal }" readonly="readonly">
	    	<button type="button" id="btnPayment" data-oper="Payment"
							class="btn btn-primary"><span>결제하기</span></button>
		</div>
	</div>

	<div class="form-group">
	    <label class="col-sm-2 control-label" style="white-space: nowrap;">최종수정일</label>
	    <div class="col-sm-10">
	    	<input class="form-control" name="bmodDate" id="bmodDate" 
	      		   value='<fmt:formatDate pattern="yyyy/MM/dd HH:mm:ss" value="${dutchboard.pmodDate }"/>' readonly="readonly">
		</div>
	</div>
    
    
    
   		 </div>
</div><!-- /.panel-body -->
  	</div><!-- /.panel --> 

    
</div><%-- /#page-wrapper --%>
</div>

<form id="frmSendValue">



</form>

<script>

var frmSendValue = $("#frmSendValue") ;

<%-- 게시물 목록 페이지로 이동 --%>
$("#btnToList").on("click", function(){
	
	frmSendValue.attr("action", "${contextPath}/pay/list").attr("method", "get");
	frmSendValue.submit();
	
});

<%-- 게시물 수정-삭제 페이지로 이동 --%>
$("#btnToModify").on("click", function(){
	
	frmSendValue.attr("action", "${contextPath}/pay/modify").attr("method", "get");
	frmSendValue.submit();
	
	
});





</script>





<%@include file="../pageinclude/footer.jsp" %> 