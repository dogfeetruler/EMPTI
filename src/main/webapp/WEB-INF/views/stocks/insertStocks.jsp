<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<script src="https://code.jquery.com/jquery-3.5.1.js" integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc=" crossorigin="anonymous"></script>
<style>
	label{display:inline-block; width:100px;}
</style>
<script>
	var option="";
	$(function() {
		strgList();
		findStrgList();
		insertStocks();
		findStockBorderList();	
		checkAll();
	});

		function insertStocks() {
		$('#insertBtn').on('click', function(){
			var stockDate = $('[name=stock_date]').val();
			var borderNo;
			var td = [];
				$('.checkbox:checked').each(function(idx, item) {					
					var obj = {};
					borderNo = $(this).closest('tr').children().eq(7).text();
					obj['stock_date'] = stockDate;
					obj['stock_qty'] = $(this).closest('tr').children().eq(4).text();
					obj['border_no'] = borderNo;
					obj['item_no'] = $(this).closest('tr').children().eq(9).text();		
					obj['strg_no'] = $(this).closest('tr').find('.strgNo').val();
					obj['real_qty'] = $(this).closest('tr').children().eq(4).text();
					console.log(borderNo)
					td.push(obj);
					});
		//구매주문의 데이터는 vo객체에, 구매상세주문의 데이터는 List에 담아서 
					var result = confirm("입고하시겠습니까?");
						if (result) {
							$.ajax ({
								url: "setInsertStockBorders/" + borderNo,
								type: "POST",
								data: JSON.stringify(td),
								contentType : "application/json",
								success: function() {
								alert("성공적으로 입고하였습니다.");
								window.location.href="getStocksList"
								}, error: function() {
								alert("입고를 실패하였습니다.");
								}
							});
						}else {
							return false;
						} 			  
				});
		}
		function checkAll() {		
	    $(".chkAll").click(function(){
	        var chk = $(this).is(":checked");//.attr('checked');
	        if(chk) $(".checkbox ").prop('checked', true);
	        else  $(".checkbox ").prop('checked', false);
	    });
		}
	
	/* 창고 조회 */
	function strgList() {
		$.ajax({
			url: 'strgList',
			type: 'GET',
			dataType: 'json',
			success: findStrgList	
		});
	}
	
	/* 창고리스트 select 넣기 */
	function findStrgList(data){
		$.each(data, function(idx,item){
			option += '<option value="' + item.strg_no +'">' +item.strg_category+ '</option>'
		});
		
	}
	
	/* 구매주문 리스트 */
	function findStockBorderList() {
	      $.ajax({
	          url:'findStockBorderNo',
	          type:'GET',         
	          dataType:'json',
	          error:function(xhr,status,msg){
	             alert("상태값 :" + status + " 에러 메세지:"+msg);
	          },
	          success:findListResult
	       });	
	}
	

	function findListResult(data) {
		$("tbody").empty();
		$.each(data,function(idx,item){
			 $('<tr>')
	   		 .append($('<td>').html(idx+1))
	         .append($('<td>').html(item.border_date))
	         .append($('<td>').html(item.company_name))      
	         .append($('<td>').html(item.item_name))
	         .append($('<td>').html(item.border_qty))
	         .append($('<td>').append($('<select class="strgNo">').html(option)))
	         .append($('<td>').html('<input type="checkBox" class="checkbox" value="'+ item.border_no + '"/>'))
	         .append($('<td>').html(item.border_no).css("display", "none"))
	         .append($('<td>').html(item.borderdetail_no).css("display", "none"))
    	     .append($('<td>').html(item.item_no).css("display", "none"))
    	     .append($('<td>').html(item.company_no).css("display", "none"))
	         .appendTo('tbody');	
		});
	}
	

</script>
<div class="col-sm-12 my-auto">
	<h2 class="display-4 text-dark" style=font-size:35px;>입고 입력</h2>
	<hr class="sidebar-divider d-none d-md-block" width="40%" align="left"> 
	<form action="" id="stockFrm">
		<label>입고 번호</label>	<input value="" type="text" name="stock_no" class="form-control" style="width: 130px; display: inline;" readonly="readonly"><br/>
		<label>입고 일자</label>	<input value="${serverTime}" type="datetime-local" name="stock_date" class="form-control" style="width: 260px; display: inline;"><br/>

		<label>유형</label>		<input value="입고" name="stock_category" class="form-control" style="width: 80px; display: inline;" readonly="readonly"><br/>
		<label>주문 조회</label>	
								
		<table border="1" id="orderTable" class="table table-bordered" style="width: 70%;">
			<thead>
				<tr>
					<th>#</th>
					<th>주문날짜</th>
					<th>거래처명</th>
					<th>품목명</th>
					<th>수량</th>
					<th>창고</th>
					<th><input type="checkbox" class="chkAll"/></th>
					<th style="display:none;">주문번호</th>
					<th style="display:none;">주문상세번호</th>
					<th style="display:none;">품목코드</th>
					<th style="display:none;">거래처번호</th>
				</tr>
			</thead>
			<tbody id="tblBody">
			</tbody>
		</table>						
		<button type="button" id="insertBtn" class="btn btn-success">입력</button>
	</form>
</div>