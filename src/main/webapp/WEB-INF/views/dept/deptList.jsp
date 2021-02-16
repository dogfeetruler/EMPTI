<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<script src="https://code.jquery.com/jquery-3.5.1.js" integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc=" crossorigin="anonymous"></script>

<script>
function deptDelete(dept_id) {
	if(confirm("삭제하시겠습니까?")){
		location.href="setDeleteDept?dept_id="+ dept_id;
	}
}
</script>

<div class="card shadow mb-4">
	<div class="card-header py-3">
		<h6 class="m-0 font-weight-bold text-primary">
		<a href="getDeptList">부서 목록</a> | 
		<a href="setInsertFormDept">부서 입력</a> |
	    <a href= "departments_list.do" onclick="window.open(this.href, 'width=800', 'height=1200', 'toolbars=no', 'scrollbars=yes'); return false">PDF</a> |
	
<!-- 		<a href="departments_list.do">PDF</a> | -->
		<a href="dept_excel.do">EXCEL</a>
		
		</h6>
	</div>
	<div class="card-body">
		<div class="table-responsive">
			<table class="table table-bordered" id="dataTable"  style="text-align: center;" width="100%" cellspacing="0">
				<thead>
					<tr style="text-align: center;">
						<th>부서번호</th>
						<th>부서명</th>
						<th>매니저</th>
						<th>수정</th>
						<th>삭제</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${deptList}" var="dept">
						<tr>
							<td>${dept.dept_id}</td>
							<td>${dept.dept_name}</td>
							<td>${dept.name}</td>
							<td><a href="setUpdateFormDept?dept_id=${dept.dept_id}"  class="btn btn-primary">수정</a></td>
							<td><a href="#" onclick="deptDelete(${dept.dept_id})" class="btn btn-danger">삭제</a></td>
						</tr>
						
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>
</div>