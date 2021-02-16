<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css" integrity="sha384-9aIt2nRpC12Uk9gS9baDl411NQApFmC26EwAOH8WgZl5MYYxFfc+NcPb1dKGj7Sk" crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.5.1.js" integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc=" crossorigin="anonymous"></script>
<script>
	$(function(){
		$('.clickBank').on('click', function(){
			opener.document.getElementById("bank_name").value = $(this).find('.td2').text();
			window.close();
		});
	});

</script>
<div class="alert alert-primary" role="alert" style="text-align:center; font-size:2.5em">
거래 은행
</div>

	<table class="table table-hover">
		<thead class="thead-dark" style="text-align:center">
			<tr>
				<th>은행코드</th><th>은행명</th>
			</tr>
		</thead>
		<c:forEach items="${findBank}" var="bank">
			<tr class="clickBank" style="text-align: center;">
				<td class="td1">${bank.bank_code}</td>
				<td class="td2">${bank.bank_name}</td>
			</tr>
		</c:forEach>
	</table>