<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div align="center">
	<h1>매입장부 등록</h1>
	<form action="setInsertBuyledger">
		<label>장부번호</label><input name="ldgr_no"> <br>
		<label>날짜</label>	<input name="ldgr_date" type="datetime-lacal"> <br>
		<label>금액</label>	<input name="total_amount"> <br>
		<label>상태</label>	<select name="condition">
							<option value="" selected disabled hidden> ==선택하세요== </option>
							<option value="완납">완납</option>
							<option value="분납">분납</option>
							<option value="미수금">미수금</option>	
							</select> <br>
		<label>주문 번호</label>	<input name="order_no"> <br>
		<label>비고</label>	<input name="note"> <br>
	<button type="submit">입력</button>
	</form>
</div>