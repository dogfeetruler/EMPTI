<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css" integrity="sha384-9aIt2nRpC12Uk9gS9baDl411NQApFmC26EwAOH8WgZl5MYYxFfc+NcPb1dKGj7Sk" crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.5.1.js" integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc=" crossorigin="anonymous"></script>
<style>
	tr {text-align:center}
</style>
<div class="alert alert-primary" role="alert" style="text-align:center; font-size:2.5em" >
  거래처 상세정보
</div>
<table class="table table-hover">
	<thead class="thead-dark">
		<tr>
			<th>회사코드</th><td>${company.company_no}		</td>
			</tr> <tr>  
			<th>회사 명</th><td>${company.company_name}		</td>
			</tr> <tr>  
			<th>담당자 명</th><td>${company.dealer_name} 		</td>
			</tr> <tr>  
			<th>담당자 연락처</th><td>${company.dealer_phone}		</td>
			</tr> <tr>  
			<th>대표 명</th><td>${company.ceo_name}    	 	</td>
			</tr> <tr>  
			<th>회사연락처</th><td>${company.phone}       	 	</td>
			</tr> <tr>  
			<th>회사 주소</th><td>${company.address}    	 	</td>
			</tr> <tr>  
			<th>상세주소</th><td>${company.address_detail}   </td>
			</tr> <tr>  
			<th>우편번호</th><td>${company.zip_code}         </td>
			</tr> <tr>  
			<th>거래 은행</th><td>${company.bank_name}   	 	</td>
			</tr> <tr>  
			<th>계좌번호</th><td>${company.account_no}       </td>
			</tr> <tr>  
			<th>비고</th><td>${company.note}             </td>
		</tr>
	</thead> 
	
</table>