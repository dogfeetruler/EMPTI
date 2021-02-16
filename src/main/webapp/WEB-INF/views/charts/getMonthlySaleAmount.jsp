<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script> 
  <!-- 월별 총 매출액 및 건수 차트 -->
    <script type="text/javascript">
    google.charts.load('current', {'packages':['corechart']});
    google.charts.setOnLoadCallback(drawVisualization);

    function drawVisualization() {
      // Some raw data (not necessarily accurate)
      var data = google.visualization.arrayToDataTable([]);
	      data.addColumn('string', '월별');
	      data.addColumn('number', '총 매출액');
	      data.addColumn('number', '총 건수');
	  var chartdata = [];
	  $.ajax({  
		  url: "getMonthlySaleAmount", 
		  async : false, 			// 비동기여부. false = 동기식
		  success : function(result){
			  for(i=0; i<result.length; i++){
				  chartdata.push([
					  			result[i].ldgr_date,
					  			parseInt(result[i].total_amount)/100000, 
					  			parseInt(result[i].count)]); //push : data담음
			  }
		  }
	  });
	  data.addRows(chartdata);
	  
      var options = {
        title : '월별 매출액 및 건수',
        vAxis: {title: '매출액(십만원)'},
        hAxis: {title: '날짜'},
        seriesType: 'bars',
        series: {1: {type: 'line'}}        };

      var chart = new google.visualization.ComboChart(document.getElementById('myComboChart'));
      chart.draw(data, options);
    }
    </script>
    <!-- Combo Chart -->
	<div class="card shadow lg-4">
		<div class="card-header py-3">
			<h6 class="m-0 font-weight-bold text-primary">매출액 통계</h6>
		</div>
		<div class="card-body">
			<div class="chart-bar">
				<div id="myComboChart" class="col-lg-12" style="width: 100%; height: 100%;"></div>
			</div>
		</div>
	</div>