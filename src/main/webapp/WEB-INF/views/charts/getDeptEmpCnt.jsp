<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<!-- 부서별 사원 수 차트 시작 -->
    <script type="text/javascript">
    
      google.charts.load('current', {'packages':['corechart']});
      google.charts.setOnLoadCallback(drawChart);

      function drawChart() {
         
    	  // Create the data table.
          var data = new google.visualization.DataTable();
          data.addColumn('string', '부서명');
          data.addColumn('number', '사원수');
		  var chartdata = [];
          $.ajax({  
			  url: "getDeptEmpCnt", 
			  async : false, 			// 비동기여부. false = 동기식
			  success : function(result){
				  for(i=0; i<result.length; i++){
					  chartdata.push([result[i].dept_name, parseInt(result[i].cnt)]); //push : data담음
				  }
			  }
		  });
          data.addRows(chartdata);
          
          // Set chart options
          var options = {title:'부서별 인원 수',
                         is3D : true,
                         hAxis: { format:'0,000', gridlines: {count:10} } ,
                         colors: ['#e0440e', '#e6693e', '#ec8f6e', '#f3b49f', '#f6c7b6']
          				};


        var chart = new google.visualization.ColumnChart(document.getElementById('myBarChart'));
        chart.draw(data, options);
        
      }
    </script>
    <!--  <div id="columnchart_material" style="width: 400px; height: 320px;"></div> -->
    <!-- Bar Chart -->
    
	<div class="card shadow lg-4">
		<div class="card-header py-3" >
			<h6 class="m-0 font-weight-bold text-primary">사원 현황</h6>
		</div>
		<div class="card-body">
			<div class="chart-bar">
				<div id="myBarChart" class="col-lg-12" style="width: 100%; height: 100%;"></div>
			</div>
		</div>
	</div>
	
<!-- 부서별 사원 수 차트 끝 -->