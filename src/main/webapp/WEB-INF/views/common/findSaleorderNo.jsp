<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css" integrity="sha384-9aIt2nRpC12Uk9gS9baDl411NQApFmC26EwAOH8WgZl5MYYxFfc+NcPb1dKGj7Sk" crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.5.1.js" integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc=" crossorigin="anonymous"></script>
<script>
	$(function(){
		$('.clickNo').on('click', function(){
			opener.document.getElementById("sorder_no").value = $(this).find('.td1').text();
			var amt = $(this).find('.sp1').text();
 			opener.document.getElementById("total_amount").value = amt;
 			opener.document.getElementById("condition").value = "완납";
			window.close();
		});
	});

</script>
<div class="alert alert-primary" role="alert" style="text-align:center; font-size:2.5em" >
  판매주문 리스트
</div>

<table class="table table-hover">
	 <thead class="thead-dark">
		<tr style="text-align:center">
			<th>주문번호</th><th>주문날짜</th><th>판매원금</th><th>잔금</th><th>거래처명</th>
		</tr>
	</thead>
		<c:forEach items="${findSaleorderNo}" var="orders">
			<tr  class="clickNo" style="text-align:center">
			<c:if test="${orders.balance >0 }">
			<c:if test="${orders.sale_sum > 0 and orders.del_status ne '반품'}">
				<td class="td1">${orders.sorder_no}</td>
				<td class="td2">${orders.sorder_date}</td>
				<td class="td3">
					<fmt:parseNumber value="${orders.sale_sum}" var="fmt"/>
					<fmt:formatNumber type="number" maxFractionDigits="3" value="${fmt}"/>원
				</td>
				<td class="td4">
					<fmt:parseNumber value="${orders.balance}" var="fmt"/>
					<span class="sp1"><fmt:formatNumber type="number" maxFractionDigits="3" value="${fmt}"/></span>원
				</td>
				<td class="td5">${orders.company_name}</td>
			</c:if>
			</c:if>
			</tr>
		</c:forEach>
</table>