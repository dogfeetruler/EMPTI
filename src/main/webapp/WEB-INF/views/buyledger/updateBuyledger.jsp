<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div align="center">
	<h1>매출장부 수정</h1>
	<form action="setUpdateBuyledger">
		<label>날짜</label>	<input name="ldgr_date" value="${buyledger.ldgr_date}"> <br>
		<label>금액</label>	<input name="total_amount" value="${buyledger.total_amount}"> <br>
		<label>상태</label>	<select name="condition">
							<option value="완납">완납</option>
							<option value="분납">분납</option>
							<option value="미수금">미수금</option>	
							</select> <br>
		<label>주문 건</label>	<input name="order_no" value="${buyledger.order_no}"> <br>
		<label>비고</label>	<input name="note" value="${buyledger.note}"> <br>
		<input type="hidden" name="ldgr_no" value="${buyledger.ldgr_no}"> <br>
	<button type="submit">입력</button>
	</form>
</div>