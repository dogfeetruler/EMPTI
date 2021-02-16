<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<script src="https://code.jquery.com/jquery-3.5.1.js" integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc=" crossorigin="anonymous"></script>

<script>
function storagesDelete(strgNo){
	if(confirm("삭제하시겠습니까?")){
		location.href="setDeleteStorages?strg_no=" + strgNo;
	}
}

//수정폼으로 이동
function upFrom(strgNo) {
	location.href = "setUpdateFormStorages?strg_no=" + strgNo
}



</script>

<div class="card shadow mb-4">
	<div class="card-header py-3">
		<h6 class="m-0 font-weight-bold text-primary">
		<a href="getStoragesListMap">창고 목록</a> | 
		<a href="setInsertFormStorages">창고 등록</a> |
		<a href= "storages.do" onclick="window.open(this.href, 'width=800', 'height=1200', 'toolbars=no', 'scrollbars=yes'); return false">PDF</a> |
		
	<!-- 	<a href="storages.do">PDF</a> | -->
		<a href="storages_excel.do">EXCEL</a>
		
		</h6>
	</div>
	<div class="card-body">
		<div class="table-responsive">
			<table class="table table-bordered" id="dataTable" style="text-align: center;" width="100%"	cellspacing="0">
				<thead>
					<tr>
						<th>창고번호</th>
						<th>창고유형</th>
						<th>담당사원</th>
						<th>수정</th>
						<th>삭제</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${storagesList}" var="storages">
						<tr>
							<td>${storages.strg_no}</td>
							<td>${storages.strg_category}</td>
							<td>${storages.name}</td>
							<td><button type="button" onclick="upFrom(${storages.strg_no})" class="btn btn-primary">수정</button></td>
							<td><button type="button" onclick="storagesDelete(${storages.strg_no})" class="btn btn-danger">삭제</button></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>
</div>