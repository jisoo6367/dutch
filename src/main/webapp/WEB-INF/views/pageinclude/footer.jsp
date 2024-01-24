<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<c:set var="contextPath" value="${pageContext.request.contextPath }"/>


</div> <!-- body-container -->
<!-- footer body -->

<footer class="footer" style="height: 100px; position: relative; transform: translateY(-100%);">
	<hr>
	<div class="container">
		<div class="row">
			<div class="col-sm-2 text-center" id="footerImg">
				<img src="resources/img/footerImg.png" alt="footer이미지">
				<p style="margin-top: 5px; font-size: 18px;">dutch_pay</p>
			</div>
			<div class="col-sm-2" id="footerTeammate">
				<p style="color: #aea8a8;">강사: 신상현</p>
				<p style="color: #aea8a8;">팀장: 송치원</p>
				<p style="color: #aea8a8;">팀원: 홍지수</p>
				<p style="color: #aea8a8;">팀원: 이승원</p>
				<p style="color: #aea8a8;">팀원: 김혜진</p>
			</div>
			<div class="col-sm-2" id="footerNav1">
				<p style="">더치페이</p>
				<a href="${contextPath }/pay/list">
					<p style="color: #aea8a8; font-size: 10px;">더치페이 목록</p>
				</a>
				<a href="${contextPath }/pay/register">
					<p style="color: #aea8a8; font-size: 10px;">더치페이 생성</p>
				</a>
			</div>
			<div class="col-sm-2" id="footerNav1">
				<p style="">커뮤니티</p>
				<p style="color: #aea8a8; font-size: 10px;">커뮤니티 목록</p>
				<p style="color: #aea8a8; font-size: 10px;">커뮤니티 생성</p>
			</div>
			<div class="col-sm-2" id="footerNav2">
				<p style="">공지사항</p>
				<p style="color: #aea8a8; font-size: 10px;">공지사항 목록</p>
				<br>
				<p style="">1:1 문의</p>
				<p style="color: #aea8a8; font-size: 10px;">1:1문의 목록</p>
			</div>
			<div class="col-sm-2" id="footerRegDate">
				<p style="">발표일: 2024/02/02</p>
			</div>
		</div>   
	</div>
</footer>

</body>


</html>