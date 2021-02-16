<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<script src="https://code.jquery.com/jquery-3.5.1.js" integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc=" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css" integrity="sha384-9aIt2nRpC12Uk9gS9baDl411NQApFmC26EwAOH8WgZl5MYYxFfc+NcPb1dKGj7Sk" crossorigin="anonymous">

<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<html>

<script>
	//페이지 로드
	//수량*단가 합산 기능
	$(function() {
		var tr = $("#tblBody").children();
		var sum = 0;
		var multi = 0;
		$.each(tr, function(idx, item) {
			var qty = $(item).children().eq(2).text();
			var price = $(item).children().eq(3).text();
			
			multi = parseInt(qty) * parseInt(price);
			sum = sum + multi;
		});
		$('#total').val(numberWithCommas(sum));
	});
	
	function numberWithCommas(x) {
	    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	}
</script>
<div class="alert alert-primary" role="alert" style="text-align:center; font-size:2.5em" >
 판매주문 상세 내역
</div>
<body>
	<table class="table table-hover">
		<thead class="thead-dark">
			<tr>
				<th scope="col">#</th>
				<th scope="col">품목</th>
				<th scope="col">수량</th>
				<th scope="col">단가</th>
			</tr>
		</thead>
		<tbody id="tblBody">
			<c:forEach items="${details}" var="detail" varStatus="status">
			<tr>
				<td>${status.count}</td>
				<td>${detail.item_name}</td>
				<td>${detail.sorder_qty}</td>
				<td>${detail.item_price}</td>
				
			</tr>
			</c:forEach>
		</tbody>
	</table><br/>
	<div class="form-inline form-group" >
    	&nbsp;&nbsp;<label for="total" style="font-size: 20px; font-weight: normal;" >합계:</label> &nbsp;&nbsp;&nbsp;&nbsp;
    		
    			<input type="text" class="form-control" id="total" style="font-size: 13px; text-align:right"  readonly="readonly">
    			<label for="total" style="font-size: 20px; font-weight: normal;" >원</label>
    	
    </div>
</body>
</html>