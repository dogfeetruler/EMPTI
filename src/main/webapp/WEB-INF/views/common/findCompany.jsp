<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css" integrity="sha384-9aIt2nRpC12Uk9gS9baDl411NQApFmC26EwAOH8WgZl5MYYxFfc+NcPb1dKGj7Sk" crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.5.1.js" integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc=" crossorigin="anonymous"></script>
<script>
    $(function(){
		$('.findCompany').on('click', function(){
			opener.document.getElementById("company_no").value = $(this).find('.td1').text();
			opener.document.getElementById("company_name").innerHTML = $(this).find('.td2').html();
			window.close();
		});
	});
</script>
<div class="alert alert-primary" role="alert" style="text-align:center; font-size:2.5em" >
  거래처 리스트
</div>
	<table class="table table-hover">
		 <thead class="thead-dark" style="text-align:center">
			<tr>
				<th>거래처코드</th><th>거래처명</th>
			</tr>
		</thead>
		<c:forEach items="${findCompanyList}" var="findCompany">
				<tr style="text-align:center" class="findCompany">
					<td class="td1">${findCompany.company_no}</td>
					<td class="td2">${findCompany.company_name}</td>
				</tr>
		</c:forEach>
	</table>
