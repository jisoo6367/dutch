<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<c:set var="contextPath" value="${pageContext.request.contextPath }"/>

<%@include file="../pageinclude/header.jsp" %>


	<h2>관리자페이지이빈다</h2>
	
<script src="https://cdn.jsdelivr.net/npm/chart.js@2.8.0"></script>

<canvas id="ageChart"></canvas>
<script>
//Chart.defaults.global.maintainAspectRatio = false;

var ctx = document.getElementById('ageChart').getContext('2d');
var chart = new Chart(ctx, {
    //차트설정
    type: 'bar',

    //차트데이터
    data: {
        labels: ['10대', '20대', '30대', '40대', '50대', '60대', '70대', '80대'],
        datasets: [{
            label: '가입자 연령별 분포도',
            backgroundColor: ["rgba(242,166,54,.5)", "rgba(39,79,76,.5)",
								"rgba(40,161,130,.5)", "rgba(206,29,22,.5)",
								"rgba(242,166,54,.5)", "rgba(39,79,76,.5)",
								"rgba(40,161,130,.5)", "rgba(206,29,22,.5)"],
            borderColor: ["rgb(242,166,54)", "rgb(39,79,76)",
							"rgb(40,161,130)", "rgb(206,29,22)",
							"rgb(242,166,54)", "rgb(39,79,76)",
							"rgb(40,161,130)", "rgb(206,29,22)"],
			hoverBackgroundColor: ["rgb(242,166,54)", "rgb(39,79,76)",
									"rgb(40,161,130)", "rgb(206,29,22)",
									"rgb(242,166,54)", "rgb(39,79,76)",
									"rgb(40,161,130)", "rgb(206,29,22)"],
			borderWidth: 1,
            data: [${teenager}, ${twenties}, ${thirties}, ${forties},
            		${fifties}, ${sixties}, ${seventies}, ${eighties}]
        }]
    },
    options: {}
});
</script>


<canvas id="genderChart"></canvas>
<script>
var ctx = document.getElementById('genderChart').getContext('2d');
var chart = new Chart(ctx, {
    //차트설정
    type: 'doughnut',

    //차트데이터
    data: {
        labels: ['여성', '남성'],
        datasets: [{
            label: '가입자 성별 분포도',
            backgroundColor: ['rgb(204, 102, 102)', 'rgb(102, 153, 153)'],
            //borderColor: 'rgb(255, 99, 132)',
            data: [${female}, ${male}]
        }]
    },
    options: {
    	//maintainAspectRatio : false
    }
});
</script>


<canvas id="monthlyMemberChart"></canvas>
<script>

var ctx = document.getElementById('monthlyMemberChart').getContext('2d');

var sexLineChart = new Chart(ctx, {
	type: 'line',
	data:{
		labels:['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'],
		datasets:[
			{
			 label:'2019',
			 data:[${jan},5,7,3,14,26,12,16,18,10,10,8] ,
			 pointRadius: 4,
			 pointHoverRadius: 8,
			 spanGaps: true,
			}
		]
	}
});

</script>
<br>




	










<%@include file="../pageinclude/footer.jsp" %> 