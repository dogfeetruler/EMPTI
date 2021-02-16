<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
    
    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
    <script type="text/javascript">
      google.charts.load("current", {packages:["corechart"]});
      google.charts.setOnLoadCallback(drawChart);
      function drawChart() {
    	// Create the data table.
          var data = new google.visualization.DataTable();
          data.addColumn('string', '품목명');
          data.addColumn('number', '판매량');
		  var chartdata = [];
          $.ajax({  
			  url: "getHigherSaleItems", 
			  async : false, 			// 비동기여부. false = 동기식
			  success : function(result){
				  for(i=0; i<result.length; i++){
					  chartdata.push([result[i].item_name, parseInt(result[i].count)]); //push : data담음
				  }
			  }
		  });
          data.addRows(chartdata);
        
         var options = {
          title: '판매량이 높은 품목 Best 5',
          pieHole: 0.4,
        };

        var chart = new google.visualization.PieChart(document.getElementById('donutchart'));
        chart.draw(data, options);
      }
    </script>
    <div class="card shadow lg-4">
		<div class="card-header py-3">
			<h6 class="m-0 font-weight-bold text-primary">판매량 높은 품목</h6>
		</div>
		<div class="card-body">
			<div class="chart-bar">
				<div id="donutchart" class="col-lg-12" style="width: 100%; height: 100%;"></div>
			</div>
		</div>
	</div>
