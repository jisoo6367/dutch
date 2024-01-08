<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>   
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<c:set var="contextPath" value="${pageContext.request.contextPath }"/>

<%@include file="../pageinclude/header.jsp" %>

<div id="page-wrapper"> 
    <div class="row">
        <div class="col-lg-12">
            <h3 class="page-header">DuctPay 글등록</h3>
        </div>
        <!-- /.col-lg-12 -->
    </div>
    <!-- /.row -->
    <div class="row">
        <div class="col-lg-12">
            <div class="panel panel-default">
            
                <div class="panel-heading"><h4>더치페이 등록</h4></div>
                <!-- /.panel-heading -->
                             
                <div class="panel-body">

<form role="form" action="${contextPath }/pages/dutchregister" 
      method="post" name="frmBoard" id="frmBoard">
	<div class="form-group">
	    <label>방제목</label>
	    <input class="form-control" name="ptitle" id="ptitle" placeholder="제목을 입력하세요.">
	</div>
	<div class="form-group">
		<label>카테고리</label>
	    <input class="form-control" name="category" id="category" placeholder="카데고리를 검색하세요.">
	</div>
	<div class="form-group">
		<label>회원고유번호</label>
	    <input class="form-control" name="mno" id="mno" placeholder="회원고유번호를 검색하세요.">
	</div>
	<div class="form-group">
		<label>방내용</label>
	    <input class="form-control" name="pcontent" id="pcontent" placeholder="내용을 입력하세요.">
	</div>
	
	<button type="button" class="btn btn-primary" id="btnUserAdd">참여자 추가 버튼</button>

	<div class="btnAdd">
	<%-- <label>회원 닉네임</label>
	<input name="nickname" id="nickname"/> value="${member.nickname }"
	    		   <button type="button" class="btn btn-primary btnUserConfirmed">등록</button>
	    		   <button type="button" class="btn btn-warning btnUserDelete">삭제</button> --%>
	    		   
	    <input type="hidden" name="pno" id="pno"/>
	</div>
	
    <div class="form-group">
 		<label>전체금액</label>
	    <input class="form-control" name="ptotalPayment" id="ptotalPayment" placeholder="전체금액을 입력하세요.">
	</div>
	<div class="form-group">
 		<label>개인부담금액</label>
	    <input class="form-control" name="ppersonal" id="ppersonal" placeholder="개인부담금액을 입력하세요.">
	</div>  

	<button type="button" class="btn btn-primary" id="btnUserConfirmed">확정</button>
	<button type="button" class="btn btn-primary" id="btnRegister">게시물 등록</button>
	<button type="button" class="btn btn-warning"
			onclick="location.href='${contextPath}/pages/dutchlist';">취소</button>

    <input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }"/>
</form>

	</div>
	</div>
	</div>
	</div>


</div>
        <!-- /#page-wrapper -->

<form id="frmSendValue">

</form>

        
<script>

var frmBoard = $("#frmBoard") ;
var pnoCnt = 0;
<%-- 더치페이 게시물에 입력값 유무 확인 함수 --%>
function checkBoardValues(){
	
	var ptitle = document.getElementById("ptitle").value ;
	var category = document.getElementById("category").value ;
	var mno = document.getElementById("mno").value ;
//	var pcontent = document.getElementById("pcontent").value ;
	var ptotalPayment = document.getElementById("ptotalPayment").value ;
	var ppersonal = document.getElementById("ppersonal").value ;
	
	if (ptitle.length == 0 || category.length == 0 || mno.length == 0 || ptotalPayment.length == 0 || ppersonal.length == 0) {
		
		return false;
	} else {
		return true ;
	}
	
}

/* $(document).ready (function () {                
    $('#btnUserAdd').click (function () {                                        
        $('#btnUserAdd').append (                        
            '<input type="text" name="txt"> <input type="button" class="btnRemove" value="Remove"><br>'                    
        ); // end append                            
        $('.btnRemove').on('click', function () { 
            $(this).prev().remove (); // remove the textbox
            $(this).next ().remove (); // remove the <br>
            $(this).remove (); // remove the button
        });
    }); // end click                                            
}); // end ready  */
var userList = [];
<%-- User input 여러개 등록--%>
$("#btnUserAdd").on("click", function(){
	
	$(".btnAdd").append("<div><br><label>회원 닉네임 </label><input name='nickname'/> <button type='button' class='btn btn-primary btnUserConfirmed'>등록</button> <button type='button' class='btn btn-warning btnUserDelete'>삭제</button> <br><div>");

	$(".btnUserDelete").on("click", function(){
 		$(this).prev().prev().prev().prev().remove();
		$(this).prev().prev().prev().remove();
		$(this).prev().prev().remove();
		$(this).prev().remove(); 
		$(this).next().remove();
		$(this).remove();	
	});
	
	$(".btnUserConfirmed").on("click", function(){
		userList.push($(this).siblings("input").val());
		console.log(userList);
	});
	
	console.log(userList);
	
});




<%-- User input 삭제 --%>
$(".btnUserDelete").on("click", function(){
	alert("삭제되었습니다.");
	
});

<%-- 더치페이 게시글 내용 등록버튼 값 --%>
$("#btnRegister").on("click", function(){
	
	if(!checkBoardValues()){
		alert("모든 항목을 전부 입력해주셔야 합니다.");
		return ; 
	}
	
	
	$("#pno").val(pnoCnt);
	frmBoard.submit();
	
	pnoCnt += 1;
	/* $.ajax({
		type:"post",
		url:"${contextPath}/pages/dutchregister",
		data: {userList: userList},
		dataType: "json" ,
		contentType: "application/json",
		success: function(result){
			console.log("sended");
		}
	}); */
	
});





</script>



<%@include file="../pageinclude/footer.jsp" %> 