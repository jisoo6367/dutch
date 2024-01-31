<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<c:set var="contextPath" value="${pageContext.request.contextPath }"/>

<%@include file="../pageinclude/header.jsp" %>

<h2>관리자 페이지</h2>


<head>
<style>
    .canvas-container {
        display: flex;
        flex-wrap: wrap;
        justify-content: space-around;
    }

    .canvas-item {
    	margin-top: 100px;
        margin-bottom: 100px;
        margin-right: 10px;
        
    }
</style>
</head>
<body>
    <div class="canvas-container">
        <div class="canvas-item">
            <canvas id="genderChart" width="450" height="300"></canvas>
        </div>
        <div class="canvas-item">
            <canvas id="ageChart" width="450" height="300"></canvas>
        </div>
        <div class="canvas-item">
            <canvas id="reportChart" width="450" height="300"></canvas>
        </div>
        <div class="canvas-item">
            <canvas id="monthlyRegisterChart" width="450" height="300"></canvas>
        </div>
    </div>
<script src="https://cdn.jsdelivr.net/npm/chart.js@2.8.0"></script>



<script>
//Chart.defaults.global.maintainAspectRatio = false;
const xname = ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'];

var ctx = document.getElementById('ageChart').getContext('2d');
var ageChart = new Chart(ctx, {
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
    options: {
    	scales: {
    		y: {
    			beginAtZero: true
    		}
    	}
    }
});
</script>



<script>
var ctx = document.getElementById('genderChart').getContext('2d');
var genderChart = new Chart(ctx, {
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


<script>
var ctx = document.getElementById('monthlyRegisterChart').getContext('2d');

var registerChart = new Chart(ctx, {
	type: 'line',
	data:{
		labels: xname,
		datasets:[
			{
			 label:'월별 가입자 수',
			 data:[ ${registerList[0].register_cnt},
				 	${registerList[1].register_cnt},
				 	${registerList[2].register_cnt},
				 	${registerList[3].register_cnt},
				 	${registerList[4].register_cnt},
				 	${registerList[5].register_cnt},
				 	${registerList[6].register_cnt},
				 	${registerList[7].register_cnt},
				 	${registerList[8].register_cnt},
				 	${registerList[9].register_cnt},
				 	${registerList[10].register_cnt},
				 	${registerList[11].register_cnt}] ,
			 pointRadius: 4,
			 pointHoverRadius: 8,
			 spanGaps: true,
			}
		]
	}
});

</script>



<%-- 커뮤니티 &더치페이방 신고수 / 클릭시 이동--%>
<script>
var ctx = document.getElementById('reportChart').getContext('2d');

var reportChart = new Chart(ctx, {
	
	type: 'bar',
	data: {
	    labels: ['dutchpay', 'community'],
	    datasets: [{
	        label: '신고 수',
	        backgroundColor: ['rgba(39,79,76,.5)', 'rgba(40,161,130,.5)'],
	        borderColor: ['rgb(39,79,76)','rgb(40,161,130)'],
	        borderWidth: 1,
	        data: [ ${reportDTO.p_cnt}, ${reportDTO.t_cnt} ]

	    }]
	},
    options: {
        scales: {
            yAxes: [{
                ticks: {
                    beginAtZero: true
                }
            }]
        },
        onClick: function(event, elements) {
            if (elements.length > 0) {
                // 클릭한 막대의 데이터 인덱스
                var dataIndex = elements[0]._index;

                // 클릭한 데이터에 따라 페이지 이동
                if (dataIndex === 0) {
                    window.location.href = '${contextPath}/pay/reportedList';
                } else if (dataIndex === 1) {
                    window.location.href = '${contextPath}/community/reportedList';
                }
            }
        }
    }

    	
    
});


</script>








</body>


<%@include file="../pageinclude/footer.jsp" %> 