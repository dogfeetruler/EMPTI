<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<script src="https://code.jquery.com/jquery-3.5.1.js" integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc=" crossorigin="anonymous"></script>
<head>
<script>
//페이지 로드
$(function(){
	//데이터 테이블 주문일자 역 정렬
	$('#dataTable').DataTable({
		  order: [[0, 'desc']],
		  ordering: true,
		  serverSide: false
	});
});

function orderDetails(return_no) {
	window.open('getBuyorderdetailList?border_no=' + return_no,
				'buyorderdetails',
				'width=800, height=300, left=150, top=250, location=no, status=no, scrollbars=yes');
	return false;
}
</script>
</head>
<body>
<div class="card shadow mb-4">
	<div class="card-header py-3">
				<h6 class="m-0 font-weight-bold text-primary">
			<a href="getBuyordersListMap">구매주문 목록</a> | 
			<a href="setInsertFormBuyorders">구매주문 입력</a> |
			<a href= "buyorders_list.do" onclick="window.open(this.href, 'width=800', 'height=1200', 'toolbars=no', 'scrollbars=yes'); return false">PDF</a> |
			<a href="buyOrdersexcel.do">EXCEL</a> 
		</h6>
	</div>
	<div class="card-body">
		<div class="table-responsive">
			<a href="getBuyordersListMap" class="btn btn-outline-primary">주문내역</a> | 
			<a href="getReturnBuyordersList" class="btn btn-outline-primary">반품내역</a> <br><br>
			<table class="table table-bordered" id="dataTable" style="width: 100%; cellspacing=0;">
				<thead id="tblhead">
					<tr>
						<th>주문일자</th>
						<th>반품일자</th>
						<th>반품합계</th>
						<th>주문담당</th>
						<th>거래처</th>
						<th style="display: none;"></th>
						<th style="display: none;"></th>
					</tr>
				</thead>
				<tbody id="tblBody">
					<c:forEach items="${returnBorders}" var="rb">
					<tr>
						<td><a href="javascript:void(0);" onclick="orderDetails(${rb.return_no});">${rb.border_date}</a></td>
						
						<td>${rb.return_date}</td>
						
						<td align="right">
						<fmt:parseNumber value="${rb.buy_sum}" var="fmt"/>
						<fmt:formatNumber type="number" maxFractionDigits="3" value="${fmt}"/>
						</td>
						
						<td>${rb.name}</td>
						
						<td>${rb.company_name}</td>
						
						<td style="display: none;">${rb.border_no}</td>
						<td style="display: none;">${rb.return_no}</td>
					</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>
</div>
</body>