<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<script src="https://code.jquery.com/jquery-3.5.1.js" integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc=" crossorigin="anonymous"></script>
<script>
//수정폼으로 이동
function upForm(itemNo) {
	location.href = "setUpdateFormItems?item_no=" + itemNo
}

function itemsDelete(itemNo) {
	if(confirm("삭제하시겠습니까?")){
		location.href="setDeleteItems?item_no=" + itemNo;
	}
}


</script>


<div class="card shadow mb-4">
	<div class="card-header py-3">
		<h6 class="m-0 font-weight-bold text-primary">
		<a href="getItemsList">품목 목록</a> | 
		<a href="setInsertFormItems">품목 입력</a> |
		<a href= "items_list.do" onclick="window.open(this.href, 'width=800', 'height=1200', 'toolbars=no', 'scrollbars=yes'); return false">PDF</a> |
		
	<!-- 	<a href="items_list.do">PDF</a> | -->
		<a href="items_excel.do">EXCEL</a>
		</h6>
	</div>

	<div class="card-body">
		<div class="table-responsive">
			<table class="table table-bordered" id="dataTable" style="text-align: center;" width="100%"	cellspacing="0">
				<thead>
					<tr>
						<th>품목코드</th>
						<th>품목명</th>
						<th>품목유형</th>
						<th>단위</th>
						<th>유통기한</th>
						<th>가공품 원가</th>
						<th>수정</th>
						<th>삭제</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${itemsList}" var="items">
						<tr>
							<td>${items.item_no}</td>
							<td>${items.item_name}</td>
							<td>${items.category}</td>
							<td style="text-align: right;">${items.unit}</td>
							<td>${items.exp_date}일</td>
							<td style="text-align: right;">
								<fmt:parseNumber value="${items.item_price}" var="fmt"/>
								<fmt:formatNumber type="number" maxFractionDigits="3" value="${fmt}"/>&nbsp;원
							</td>
							<td><a href="#" onclick="upForm('${items.item_no}')" class="btn btn-primary">수정</a></td>
							<td><button type="button" onclick="itemsDelete('${items.item_no}')" class="btn btn-danger">삭제</button></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>
</div>