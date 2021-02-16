<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<script src="https://code.jquery.com/jquery-3.5.1.js" integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc=" crossorigin="anonymous"></script>
<script type="text/javascript">
	var buyDel = [];
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
			obj['border_no'] = $(item).children().eq(7).children().val();
			var staTus = $(item).children().eq(2).children().val();
			if (staTus == null || staTus == "") {
				staTus = $(item).children().eq(2).children().text();
				obj['status'] = staTus;
			} else {
				obj['status'] = staTus;
			}
			buyDel.push(obj);
		});
	});
	
$(function() {
	delUpdate.addEventListener("click",function() {
		var result = confirm("배송상태를 수정하시겠습니까?\n수령완료 시 수정이 불가능합니다.");
		var delStatus = $('[name=status] option:selected');
		if (result) {
			$.ajax ({
				url: "setUpdateBuyDel",
				type: "POST",
				data: JSON.stringify(buyDel),
				contentType : "application/json",
				success: function() {
				location.href = "getBuyordersListMap";
				},  error: function() {
				alert("수정을 실패하였습니다.");
				}
			
			});
		window.event.stopPropagation();
		}
	});
});
</script>

<div class="card shadow mb-4">
	<div class="card-header py-3">
		<h6 class="m-0 font-weight-bold text-primary">
			<a href="getBuyordersListMap">구매주문 목록</a> | 
			<a href="setInsertFormBuyorders">구매주문 입력</a> |
			<!-- <a href="buyorders_list.do">PDF</a> | -->
			<a href= "buyorders_list.do" onclick="window.open(this.href, 'width=800', 'height=1200', 'toolbars=no', 'scrollbars=yes'); return false">PDF</a> |
			<a href="buyOrdersexcel.do">EXCEL</a> 
		</h6>
	</div>
	<div class="card-body">
		<div class="table-responsive">
			<a href="getBuyordersListMap" class="btn btn-outline-primary">주문내역</a> | 
			<a href="getReturnBuyordersList" class="btn btn-outline-primary">반품내역</a> <br><br>
			<table class="table table-bordered" id="dataTable" style="width: 100%; cellspacing=0;">
				<thead id="tblHead">
					<tr style="text-align: center;">
						<th>주문일자</th>
						<th>구매합계</th>
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
					<c:forEach items="${buyordersMap}" var="buy">
						<c:if test="${buy.buy_sum >= 0}">
						<tr>
							<td>
							 <a href="javascript:void(0);" onclick="orderDetails(${buy.border_no});">${buy.border_date}</a>
							</td>
							
							<td align="right" <c:if test="${buy.status == '반품'}">style="color:red"</c:if>>
							<fmt:parseNumber value="${buy.buy_sum}" var="fmt"/>
							<fmt:formatNumber type="number" maxFractionDigits="3" value="${fmt}"/>&nbsp;원
							</td>
							
							
							<td class="returnStatus">
							<c:if test="${buy.status != '반품'}" >
							<select id="status" name="status" onchange="buyChk(${buy.border_no}, this)" <c:if test="${buy.status == '수령완료'}">disabled="disabled"</c:if>>
								<option value="수령중" <c:if test="${fn:contains(buy.status,'수령중')}">selected="selected"</c:if>>수령중</option>
								<option value="수령완료" <c:if test="${fn:contains(buy.status,'수령완료')}">selected="selected"</c:if>>수령완료</option>
							</select>
							</c:if>
							<c:if test="${buy.status == '반품'}">
									<span class="spanReturn" style="color:red">반품</span>
								</c:if>
							</td>
							
							<td>${buy.name}</td>
							<td>${buy.company_name}</td>
							
							<td class="returnTd" style="text-align: center;" >
							<a id="returnBtn" class="btn btn-outline-dark" href="#" onclick="reBorder(${buy.border_no});" <c:if test="${buy.status == '반품'}">style="display:none"</c:if>>반품</a>
							</td>
							<td class="deleteTd" style="text-align: center;">
							<a id="deleteBtn" class="btn btn-outline-danger" href="#" onclick="delBorder(${buy.border_no});" <c:if test="${buy.status == '반품'}">style="display:none"</c:if>>삭제</a>
							</td>
							
							<!--다중 업데이트의 조건을 받기위한 히든 데이터 -->
							<td style="display: none;">
							<input type="hidden" name="border_no" id="border_no" value="${buy.border_no}">  
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
function buyChk(borderNo, borderDel) {
	var orId = borderNo;
	var orSta = $(borderDel).val();
	for (var i=0; i<buyDel.length; i++) {
		if(buyDel[i].border_no == orId) {
			buyDel[i].status = orSta; 
		}
	}
	console.log(buyDel);
}
//주문일자를 누르면 상세정보를 새창으로 띄워주는 소스
function orderDetails(border_no) {
	window.open('getBuyorderdetailList?border_no=' + border_no,
				'buyorderdetails',
				'width=800, height=300, left=150, top=250, location=no, status=no, scrollbars=yes');
	return false;
}
//판매 주문 삭제(상세정보 포함)
function delBorder(borderNo) {
	var result = confirm("정말로 삭제하시겠습니까?");
	if (result) {
		alert("삭제하였습니다.");
		window.location.href = "setDeleteBuyorders?border_no="+borderNo;
	} else {
		return false;
	}
}
function reBorder(borderNo) {
	var result = confirm("반품하시겠습니까?");
	if (result) {		
		window.location.href = "setInsertBuyordersRetrun?return_no="+borderNo;
	} else {
		return false;
	}

}
</script>
</body>