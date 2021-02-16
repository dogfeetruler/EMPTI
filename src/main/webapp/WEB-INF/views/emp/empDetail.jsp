<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css" integrity="sha384-9aIt2nRpC12Uk9gS9baDl411NQApFmC26EwAOH8WgZl5MYYxFfc+NcPb1dKGj7Sk" crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.5.1.js" integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc=" crossorigin="anonymous"></script>
<style>
	tr {text-align:center}
</style>
<div class="alert alert-primary" role="alert" style="text-align:center; font-size:2.5em" >
  사원 상세정보
</div>
<table class="table table-hover">
	<thead class="thead-dark">
			<tr style="text-align: center">
			<th>프로필</th> <td><img src="download?name=${getEmp.profile}" 
			style="width:200px" onerror="this.src='resources/images/profile.jpg'"/></td>
			</tr>
			<tr>
			<th>사원번호</th><td>${getEmp.emp_id}	</td>
			</tr> <tr>  
			<th>사원이름</th><td>${getEmp.name}</td>
			</tr> <tr>  
			<th>전화번호</th><td>${getEmp.phone}		</td>
			</tr> <tr>  
			<th>우편번호</th><td>${getEmp.zip_code}		</td>
			</tr> <tr>
			<th>주소</th><td>${getEmp.address}		</td>
			</tr> <tr>  
			<th>상세주소</th><td>${getEmp.address_detail}		</td>
			</tr> <tr>  
			<th>이메일</th><td>${getEmp.email}   	 	</td>
			</tr> <tr>  
			<th>입사일</th><td>${getEmp.hire_date}     	 	</td>
			</tr> <tr>  
			<th>급여</th><td>${getEmp.salary}   	 	</td>
			</tr> <tr>  
			<th>계약유형</th><td>${getEmp.position}   </td>
			</tr> <tr>  
			<th>상태</th><td>${getEmp.status}        </td>
			</tr> <tr>  
			<th>거래 은행</th><td>${getEmp.bank_name}   	 	</td>
			</tr> <tr>  
			<th>계좌번호</th><td>${getEmp.account_no}       </td>
			</tr> <tr>  
			<th>부서번호</th><td>${getEmp.dept_id}             </td>
			</tr><tr>  
			<th>매니저</th><td>${getEmp.mgr_id}             </td>
			</tr>
	</thead> 
	
</table>