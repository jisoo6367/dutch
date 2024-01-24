<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<c:set var="contextPath" value="${pageContext.request.contextPath }"/>

<%@include file="../pageinclude/header.jsp" %>

<style>
 th {text-align: center;}
 p {white-space:pre-wrap;}
</style>  

<div id="page-wrapper">
    <div class="row">
        <div class="col-lg-6">
            <h3 class="page-header"style="white-space: nowrap;" >기본 회원정보</h3>
        </div><%-- /.col-lg-12 --%>
    </div><%-- /.row --%>
                 
    <div class="row">
        <div class="col-lg-6">
        <form role="form" method="post" name="frmModify" id="frmModify"><!-- 변경된 정보들 담을 form -->
        <input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }"/> <!-- 403 forbidden 에러 안나도록 -->
            <div class="panel panel-default">
               <div class="panel-heading">
               <div class="row">
                  <div class="col-md-2" style="white-space: nowrap; height: 45px; padding-top:11px;">
                     <strong style="font-size:16px;"> ${memberData.nickname }님의 회원정보 </strong>
                  </div>
                  <div class="col-md-3" style="white-space: nowrap; height: 45px; padding-top:16px;">
                     <span class="text-primary" style="font-size: smaller; height: 45px; padding-top: 19px;">

                     </span>
                  </div>
                  <div class="col-md-7" style="height: 45px; padding-top:6px;"><%-- vertical-align: middle; --%>
                     <div class="button-group pull-right">
                        <button type="button" id="btnModify" data-oper="modify"
                              class="btn btn-primary"><span>수정</span></button>
                              
                        <button type="button" id="btnToInfo" data-oper="list"
                              class="btn btn-warning"><span>취소</span></button>
                     </div>
                  </div>
               </div>
                </div><!-- /.panel-heading -->
                
                <div class="panel-body form-horizontal">
               <div class="form-group">
                   <label class="col-sm-2 control-label" style="white-space: nowrap;">닉네임</label>
                   <div class="col-sm-8">
                      <input class="form-control" name="nickname" id="nickname" 
                            value="${memberData.nickname }" readonly="readonly">
                      <label id="label1"></label>
                  </div>
               </div>
               <div class="form-group">
                   <label class="col-sm-2 control-label" style="white-space: nowrap;">비밀번호</label>
                   <div class="col-sm-8">
                      <input class="form-control" name="password" id="password" 
                            value="" type="password">
                  </div>
               </div>
               <div class="form-group">
                   <label class="col-sm-2 control-label" style="white-space: nowrap;">은행명</label>
                   <div class="col-sm-8">
                      <input class="form-control" name="bank" id="bank" 
                            value="${memberData.bank }" >
                  </div>
               </div>
               <div class="form-group">
                   <label class="col-sm-2 control-label" style="white-space: nowrap;">계좌번호</label>
                   <div class="col-sm-8">
                      <input class="form-control" name="bankAccount" id="bankAccount" 
                            value="${memberData.bankAccount }" >
                  </div>
               </div>
               <div class="form-group">
                   <label class="col-sm-2 control-label" style="white-space: nowrap;">실명</label>
                   <div class="col-sm-8">
                      <input class="form-control" name="username" id="username" 
                            value="${memberData.username }" readonly="readonly">
                  </div>
               </div>
               <div class="form-group">
                   <label class="col-sm-2 control-label" style="white-space: nowrap;">이메일</label>
                   <div class="col-sm-8">
                      <input class="form-control" name="email" id="email" 
                            value="${memberData.email }" >
                  </div>
               </div>
               <div class="form-group">
                   <label class="col-sm-2 control-label" style="white-space: nowrap;">휴대폰번호</label>
                   <div class="col-sm-8">
                      <input class="form-control" name="cellphone" id="cellphone" 
                            value="${memberData.cellphone }" >
                  </div>
               </div>
               <div class="form-group">
					<label class="col-sm-2 control-label" style="white-space: nowrap;">가입일자</label>
					<div class="col-sm-8">
					<span class="form-control" name="regDate" id="regDate"  readonly="readonly">
						   	<fmt:formatDate value="${memberData.regDate }" pattern="yyyy-MM-dd"/></span>
					</div>
               </div>
               <div class="form-group">
                   <label class="col-sm-2 control-label" style="white-space: nowrap;">정보 수정일자</label>
                   <div class="col-sm-8">
                   	<span class="form-control" name="modDate" id="modDate"  readonly="readonly">
						   <fmt:formatDate value="${memberData.modDate }" pattern="yyyy-MM-dd"/></span>
                   </div>
               </div>
               
                </div><%-- /.panel-body --%>

            </div><%-- /.panel --%>
        </form> <%-- panel헤더&바디 들어있는 폼 --%>
        
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
            <div class="modal-body" id="yourModal-body">mypageModify메세지</div>
            
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" data-dismiss="modal">Close</button>
            </div>
        </div><%-- /.modal-content --%>
    </div><%-- /.modal-dialog --%>
</div><%-- /.modal --%>



<form id="frmSendNickname">
<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }"/><!-- 403 forbidden 에러 안나도록 -->
   <input type="hidden" name="nickname" value="${memberData.nickname }" >
</form>


<script>

var frmSendNickname = $("#frmSendNickname") ;
<%-- 취소버튼 누르면 상세정보 보기로 이동 --%>
$("#btnToInfo").on("click", function(){
<%--
   window.location.href="${contextPath}/myboard/list" ;
--%>
frmSendNickname.attr("action", "${contextPath}/mypage/info").attr("method", "get") ;
frmSendNickname.submit() ;
});

<%-- 수정된 정보를 post방식으로 modify 컨트롤러로 넘기기 --%>
var frmModify = $("#frmModify") ;

$("#btnModify").on("click", function(){
   //frmModify.action="${contextPath}/mypage/modify" ;
   frmModify.attr("action", "${contextPath}/mypage/modify") ;
   frmModify.submit() ;

});





</script>




