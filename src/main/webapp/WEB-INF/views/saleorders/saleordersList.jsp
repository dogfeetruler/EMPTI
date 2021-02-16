<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<script src="https://code.jquery.com/jquery-3.5.1.js" integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc=" crossorigin="anonymous"></script>
<head>
<script type="text/javascript">
	var selDel = [];
	//페이지 로드
	$(function(){
		//데이터 테이블 주문일자 역 정렬
		$('#dataTable').DataTable({
			  order: [[0, 'desc']],
			  ordering: true,
			  serverSide: false
		});
		//옵션 태그의 값을 입력받아서 전체 수정
		var tr = $('#tblBody').children();
		
		$.each(tr, function(idx , item) {
			var obj = {};
			obj['sorder_no'] = $(item).children().eq(7).children().val();
			var staTus = $(item).children().eq(2).children().val(); 
			if (staTus == null || staTus == "") {
				staTus = $(item).children().eq(2).children().text();
				obj['del_status'] = staTus;
			} else {
				obj['del_status'] = staTus;
			}
			selDel.push(obj);
		});
	});
		
$(function() {
	delUpdate.addEventListener("click",function() {
	var result = confirm("배송상태를 수정하시겠습니까?\n배송완료 시 수정이 불가능합니다.");
		if (result) {
			$.ajax ({
				url: "setUpdateSaleDel",
				type: "POST",
				data: JSON.stringify(selDel),
				contentType : "application/json",
				success: function() {
				location.href = "getSaleordersListMap";					
			},  error: function() {
				alert("수정을 실패하였습니다.");
			}
			});
	window.event.stopPropagation();
		} 
	});
});

</script>

</head>
<body>
<div class="card shadow mb-4">
	<div class="card-header py-3">
		<h6 class="m-0 font-weight-bold text-primary">
			<a href="getSaleordersListMap">판매주문 목록</a> | 
			<a href="setInsertFormSaleorders">판매주문 입력</a> |
			<a href= "saleorders_list.do" onclick="window.open(this.href, 'width=800', 'height=1200', 'toolbars=no', 'scrollbars=yes'); return false">PDF</a> |
			<!-- <a href="saleorders_list.do">PDF</a> | -->
			<a href="sorderexcel.do">EXCEL</a>
		</h6>
	</div>
	<div class="card-body">
		<div class="table-responsive">
			<a href="getSaleordersListMap" class="btn btn-outline-primary">주문내역</a> | 
			<a href="getReturnSaleordersList" class="btn btn-outline-primary">반품내역</a> <br><br>
			<table class="table table-bordered" id="dataTable" style="width: 100%; cellspacing=0;">
				<thead id="tblHead">
					<tr style="text-align: center;">
						<th>주문일자</th>
						<th>판매합계</th>
						<th style="width: 200px;">배송상태&nbsp;
						<button class="btn btn-success btn-sm" type="button" id="delUpdate" style="">수정</button>
						</th>
						<th>담당사원</th>
						<th>거래처</th>
						<th style="width: 80px;">반품</th>
						<th style="width: 80px;">삭제</th>
						<th style="display: none;"></th>
					</tr>
				</thead>
				<tbody id="tblBody">
					<c:forEach items="${saleordersMap}" var="sale">
						<c:if test="${sale.sale_sum >= 0}">
							<tr>
								<td>
								 <a href="javascript:void(0);" onclick="orderDetails(${sale.sorder_no});">${sale.sorder_date}</a>
								</td>
								
								<td align="right" <c:if test="${sale.del_status == '반품'}">style="color:red"</c:if>>
								<fmt:parseNumber value="${sale.sale_sum}" var="fmt"/>
								<fmt:formatNumber type="number" maxFractionDigits="3" value="${fmt}"/>&nbsp;원
								</td>
								
								<td class="returnStatus">
								<c:if test="${sale.del_status != '반품'}" >
								<select id="del_status" class="del_status" name="del_status" onchange="selChk(${sale.sorder_no}, this)"  <c:if test="${sale.del_status == '배송완료'}">disabled="disabled"</c:if>>
									<option value="배송준비중" <c:if test="${fn:contains(sale.del_status,'배송준비중')}">selected="selected"</c:if>>배송준비중</option>
									<option value="배송중" <c:if test="${fn:contains(sale.del_status,'배송중')}">selected="selected"</c:if>>배송중</option>
									<option value="배송완료" <c:if test="${fn:contains(sale.del_status,'배송완료')}">selected="selected"  </c:if>>배송완료</option>
								</select>
								</c:if>
								<c:if test="${sale.del_status == '반품'}">
									<span class="spanReturn" style="color:red">반품</span>
								</c:if>
								</td>
								
								<td>${sale.name}</td>
								<td>${sale.company_name}</td>
								
								<td class="returnTd" style="text-align: center;">
								<a id="returnBtn" class="btn btn-outline-dark" href="#" onclick="reSorder(${sale.sorder_no});" <c:if test="${sale.del_status == '반품'}">style="display:none"</c:if>>반품</a>
								</td>
								<td class="deleteTd" style="text-align: center;">
								<a id="deleteBtn" class="btn btn-outline-danger" href="#" onclick="delSorder(${sale.sorder_no});" <c:if test="${sale.del_status == '반품'}">style="display:none"</c:if>>삭제</a>
								</td>
								
								<!--다중 업데이트의 조건을 받기위한 히든 데이터 -->
								<td style="display: none;">
								<input type="hidden" name="sorder_no" id="sorder_no" value="${sale.sorder_no}">  
								</td>
							</tr>
						</c:if>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>
</div>
<script>
//Select 박스의 옵션 값을 바꿀때 마다 값을 onchange하는 기능
function selChk(sorderNo, sorderDel) {
	var orId = sorderNo;
	var orSta = $(sorderDel).val();
	for (var i=0; i<selDel.length; i++) {
		if(selDel[i].sorder_no == orId) {
			selDel[i].del_status = orSta; 
		}
	}
	console.log(selDel);
}
//주문일자를 누르면 상세정보를 새창으로 띄워주는 소스
function orderDetails(sorder_no) {
	window.open('getSaleorderdetailList?sorder_no=' + sorder_no,
				'saleorderdetails',
				'width=800, height=300, left=150, top=250, location=no, status=no, scrollbars=yes');
	return false;
}
//판매 주문 삭제(상세정보 포함)
function delSorder(sorderNo) {
	var result = confirm("정말로 삭제하시겠습니까?");
	if (result) {
		alert("삭제하였습니다.");
		window.location.href = "setDeleteSaleorders?sorder_no="+sorderNo;
	} else {
		return false;
	}
}
function reSorder(sorder_no) {
	var result = confirm("반품하시겠습니까?");
	if (result) {
		alert("반품하였습니다.");
		window.location.href = "setInsertSaleordersRetrun?return_no="+sorder_no;
	} else {
		return false;
	}
}
</script>
</body>