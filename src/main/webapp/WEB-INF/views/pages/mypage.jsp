<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<c:set var="contextPath" value="${pageContext.request.contextPath }"/>

<%@include file="../pageinclude/header.jsp" %>

<style>
 th {text-align: center;}
 p {white-space:pre-wrap;}
 .btnfix {
 	margin-top: -6px;
 }
</style>  

<div id="page-wrapper">
	<div class="row">
	    <div class="col-lg-12">
	        <h1 class="page-header">My page</h1>
	    </div><!-- /.col-lg-12 -->
	</div><!-- /.row -->
	<div class="row">
	    <div class="col-md-4">
	        <div class="panel panel-default" style="height: 180px;">
	            <div class="panel-heading">
	            	<div>회원정보 변경
	            	   	<button class="btn btn-primary btnfix" style="float:right" onclick="location.href='${contextPath}/mypage/info'">상세보기</button>
	            	</div>
	          </div><!-- /.panel-heading -->
	            <div class="panel-body">
	                <div class="table-responsive">
	                	<table class="table table-striped table-bordered table-hover">
	                        <tbody>
	                            <tr>
	                                <td>이미지</td>
	                                <td>닉네임</td>
	                                <td><button type="button" class="btn btn-warning pull-right" >로그아웃</button></td>
	                            </tr>
	                        </tbody>
	                    </table>
	                </div><!-- /.table-responsive -->
	            </div><!-- /.panel-body -->
	        </div><!-- /.panel -->
	    </div><!-- /.col-lg-6 -->
	    <div class="col-md-4">
	        <div class="panel panel-default" style="height: 180px;">
	            <div class="panel-heading">
	                더치페이 내역
                	<button class="btn btn-primary pull-right btnfix" onclick="location.href='${contextPath}/mypage/history'">상세보기</button>
	            </div><!-- /.panel-heading -->
	            <div class="panel-body">
	                <div class="table-responsive">
	                	<div class="col-md-6">
		                	<div class="panel-heading" style="font-size:xx-large; text-align: center;"><c:out value="${dutchCount[0].count }"/></div>
		                	<div class="panel-heading">정산중인방</div>
		                </div>
	                    <div class="col-md-6">
	                    	<div class="panel-heading" style="font-size:xx-large; text-align: center;"><c:out value="${dutchCount[1].count }"/></div>
	                    	<div class="panel-heading">정산완료방</div>
	                    </div>
	                </div><!-- /.table-responsive -->
	            </div><!-- /.panel-body -->
	        </div><!-- /.panel -->
	    </div><!-- /.col-lg- -->
	    <div class="col-md-4">
	        <div class="panel panel-default" style="height: 180px;">
	            <div class="panel-heading">
	                1:1 문의내역
	                <button class="btn btn-primary btnfix" style="float:right" onclick="location.href='${contextPath}/qna/qnalist'">상세보기</button>
	            </div><!-- /.panel-heading -->
	            <div class="panel-body">
	                <div class="table-responsive">
	                    <div class="col-md-6" style="text-align: center;">문의 갯수</div>
	                    <div class="col-md-6" style="text-align: center;">답변여부</div>
	                </div><!-- /.table-responsive -->
	            </div><!-- /.panel-body -->
	        </div><!-- /.panel -->
	    </div><!-- /.col-lg-4 -->
	</div><!-- /.row -->
</div>





<%@include file="../pageinclude/footer.jsp" %> 