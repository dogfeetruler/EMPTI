<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<script src="https://code.jquery.com/jquery-3.5.1.js" integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc=" crossorigin="anonymous"></script>
<style>
	label{display:inline-block; width:100px;}
</style>
<script type="text/javaScript">
	var sum = 0;
	var multi = 0;
	$(function(){
		//거래처 검색 기능
		$('#btnFindCompany').on('click',function(){
			var winObj = window.open('findCompany','companies', 'width=500, height=700, left=400, top=100');
			return winObj;
		});
		//품목 검색 기능
		$('#btnFindItem').on('click', function() {
			var wo = window.open('findItems','item', 'width=800, height=800');
			return wo;
		});
		//판매상세 테이블 초기화 버튼
		$("#resetBtn").on("click", function() {
			var tr = $("#tblBody").children();
			tr.remove();
		});
		
	});
	//담당 사원 사번 표시 기능
	var emp_select_value = function(select_obj) {
		if($("#emp_name").text() == ""){
			$("#emp_name").append(select_obj.value);
		}
		else {
			$("#emp_name").empty();
			$("#emp_name").append(select_obj.value);
		}	
	}
	//판매상세 테이블 추가 버튼
	function addOrder()  {
		if ($('[name=item_no]').val() == '') {
			alert("품목을 선택해주십시오.");
		} else if($('[name=sorder_qty]').val() == ''){
			alert("수량을 입력해주십시오.");
		} else {
			var od_no1 = $('[name=item_no]').val();
			var od_no2 = $('[name=item_name]').text();
			var od_no3 = $('[name=sorder_qty]').val();
			var od_no4 = $('[name=item_price]').val();
			console.log(od_no1, od_no2, od_no3, od_no4);
			var td1 = $('<td />').text(od_no1);
			var td2 = $('<td />').text(od_no2);
			var td3 = $('<td />').text(od_no3);
			var td4 = $('<td />').text(od_no4);
			var tr = $('<tr />').append(td1, td2, td3, td4);
				$('#buyTable').append(tr);
				$('[name=item_no]').val('');
				$('[name=item_name]').val('');
				$('[name=sorder_qty]').val('');
				$('[name=item_price]').val('');
			
			//추가한 상세주문 데이터의 '수량'*'단가'를 합산하여 sale_sum에 출력
			$.each($('#tblBody tr'), function(idx, item) {
				var qty = $(item).children().eq(2).text();
				var price = $(item).children().eq(3).text();
				multi = parseInt(qty) * parseInt(price);
				sum = sum + multi;
			});
			$('[name=sale_sum]').val(sum);
			$('[name=item_name]').text(" ");
		}
		
	}
	//시퀀스 조회 후 판매주문 Insert 실행
	function seq_sorderInsert() {
		if(saleOrd.company_no.value == ""){
			alert("거래처코드를 입력해주세요.");
			saleOrd.company_no.focus();
			return;
		} 
		$.ajax ({
			url: "getSaleSeq",
			contentType : "application/json",
			success: function(saleSeq) {
				ajaxInsert(saleSeq);
			}, error: function() {
				alert("시퀀스 실패.");
			}
		});
	}
	//판매주문 입력 기능
	function ajaxInsert(saleSeq) {
		
		//판매주문의 데이터
		var om_no1 = $('[name=sorder_date]').val();
		var om_no2 = $('[name=company_no]').val();
		var om_no3 = $('[name=emp_id]').val();
		var om_no4 = $('[name=sale_sum]').val();
		var om_no5 = $('[name=del_status]').val();
		console.log(om_no1, om_no2, om_no3, om_no4, om_no5);
		var mObj = {'sorder_date':om_no1,
				    'company_no':om_no2,
				    'emp_id':om_no3,
				    'sale_sum':om_no4,
				    'del_status':om_no5,
				    'sorder_no': saleSeq}
		
		//판매상세주문의 데이터
		var tr = $('#tblBody').children();
		var td = [];
		$.each(tr, function(idx , item) {
			var obj = {};
			obj['sorder_no'] = saleSeq;
			obj['item_no'] = $(item).children().eq(0).text(); 
			obj['sorder_qty'] = $(item).children().eq(2).text();
			td.push(obj);
		});
		//판매주문의 데이터는 vo객체에, 판매상세주문의 데이터는 List에 담아서 Insert
		var datas = {vo: mObj, list:td}
		var result = confirm("주문하시겠습니까?");
		if (result) {
				$.ajax ({
					url: "setInsertSaleorders",
					type: "POST",
					data: JSON.stringify(datas),
					contentType : "application/json",
					success: function() {
					alert("성공적으로 주문하였습니다.");
					window.location.href = "getSaleordersListMap";
				}, error: function() {
					alert("주문을 실패하였습니다.");
				}
			});
		} else {
			return false;
		}
	}
	

	
	
	
</script>

<div class="col-sm-12 my-auto">
	<h2 class="display-4 text-dark"  style=font-size:35px;>판매 주문 입력</h2>
	<hr class="sidebar-divider d-none d-md-block" width="40%" align="left"> 
	<form action="setInsertSaleorders" id="saleOrd">
		<label>주문일자 </label>	<input value="${serverTime}" type="datetime-local" name="sorder_date" id="sorder_date" class="form-control" style="width: 300px; display: inline;"><br/>
		<label>거래처코드</label>	<input name="company_no" id="company_no" class="form-control" style="width: 250px; display: inline;"> <span id="company_name"></span>
			   						<button type="button" value="거래처선택" id="btnFindCompany" style="background-color: rgba(0,0,0,0); border:0px;"><img src="resources/images/Glass.png" width="30px" height="30px"></button><br/>
<!-- 		<label>배송상태</label>	<select name="del_status" class="form-control" style="width: 250px; display: inline;">
								 	  <option value="배송준비중" selected>배송준비중</option>
									  <option value="배송중">배송중</option>
									  <option value="배송완료" >배송완료</option>
								</select><br/> -->
		<label>담당자</label>	<%-- <select name="emp_id" class="form-control" style="width: 250px; display: inline;" onchange="emp_select_value(this);">
								<option value="" selected>==사원 선택==</option>
								<c:forEach items="${emps}" var="emp"> 
								<option value="${emp.emp_id}">${emp.name}</option>
								</c:forEach>
								</select>
								<span id="emp_name"></span> --%>
								<input name="name" value="${login.name}" class="form-control" style="width: 250px; display: inline;" readonly><br>
		<label>담당자 사번</label>	<input name="emp_id" value="${login.emp_id}" class="form-control" style="width: 250px; display: inline;" readonly> 
									<br/>
		<label>품목</label>		<input name="item_no" id="item_no" class="form-control" style="width: 100px; display: inline;"><span name="item_name" id="item_name" ></span>
									<button type="button" value="품목선택" id="btnFindItem" style="background-color: rgba(0,0,0,0); border:0px;"><img src="resources/images/Glass.png" width="30px" height="30px"></button><br/>
		<label>수량</label> 		<input name="sorder_qty" id="sorder_qty" type="number" class="form-control" style="width: 250px; display: inline;"> <br>
		
		<label>단가</label>		<input name="item_price" id="item_price" type="number" class="form-control" style="width: 250px; display: inline;"><br>
		<label>판매합계</label> 	<input name="sale_sum" class="form-control" style="width: 250px; display: inline;"><br/><br/>
		
	<div>
		<button type="button" onclick="addOrder()" class="btn btn-primary">추가</button>
		<button type="button" id="resetBtn" class="btn btn-warning">초기화</button>
	</div><br/>
	
	<!-- 판매상세주문 테이블 -->
	<table border="1" id="buyTable" class="table table-bordered" style="width: 40%;">
		<thead>
			<tr align="center">
				<th>품목코드</th><th>품목명</th><th>수량</th><th>단가</th>
			</tr>
		</thead>
		<tbody id="tblBody">
			
		</tbody>
	</table>
	
	<button type="button" onclick="seq_sorderInsert()" class="btn btn-success">주문입력</button>
	</form>
</div>