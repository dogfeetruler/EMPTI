<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<script src="https://code.jquery.com/jquery-3.5.1.js" integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc=" crossorigin="anonymous"></script>
<script>
$(function() {
	$('#Btn').on('click', function() {
		$('.checkbox:checked').each(function(idx, item) {
			$(this).closest('tr').clone().appendTo(opener.document.getElementById('tblBody'));
		});
			
	});

    $(".chkAll").click(function(){
        var chk = $(this).is(":checked");//.attr('checked');
        if(chk) $(".select_subject input").prop('checked', true);
        else  $(".select_subject input").prop('checked', false);
    });

});
</script>

<div> 구매주문 내역</div>
<table>
	<thead>
		<tr>
			<th>#</th>
			<th>주문날짜</th>
			<th>거래처명</th>
			<th>품목명</th>
			<th>수량</th>
			<th>창고</th>
			<th><input type="checkbox" class="chkAll"/></th>
			<th style="display:none;">주문번호</th>
			<th style="display:none;">주문상세번호</th>
			<th style="display:none;">품목코드</th>
			<th style="display:none;">거래처번호</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${findStcBo}" var="fsb" varStatus="status">
				<tr class="findStockBN">
					<td>${status.count}</td>
					<td>${fsb.border_date}</td>
					<td>${fsb.company_name}</td>
					<td>${fsb.item_name}</td>
					<td>${fsb.border_qty}</td>
					<td><select name="strg_category" class="form-control" style="width: 260px; display: inline;">
                           <option value="">===선택하세요===</option>
                           <c:forEach items="${storages}" var="strg">
                              <option value="${strg.strg_no}">${strg.strg_category}</option>
                           </c:forEach>
                        </select><br/>
                    </td>
					<td><input type="checkbox" class="checkbox" value="${fsb.border_no}"/></td>
					<td style="display:none;">${fsb.border_no}</td>
					<td style="display:none;">${fsb.borderdetail_no}</td>
					<td style="display:none;">${fsb.item_no}</td>
					<td style="display:none;">${fsb.company_no}</td>
				</tr>
		</c:forEach>
	</tbody>
</table>
<button type="button" class="btn btn-success btn-lg" id="Btn">확인</button>