<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<script src="https://code.jquery.com/jquery-3.5.1.js" integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc=" crossorigin="anonymous"></script>
<script>
$(function(){
		stocksList();
		stocksSelect();
		stocksInsert(); 
		stocksUpdate(); 
		init();
		fnc_btnfindItem();
		findOrderNo();
		
		//검색버튼
		$('#searchForm').on('click','#btnSearch',function() {
			stocksList();
		});
	});
		<%-- //품목코드 검색
		function fnc_btnfindItem(){
		$('#btnFindItem').on('click', function() {
			var wo = window.open('findItems','item', 'width=500, height=700, left=950, top=50');
			return wo;
		}); 
	}; --%>
	//주문번호 조회 기능
	function findOrderNo()	{
		$('#stocksform').on('click', '#btnFindOrderNo', function() {
			var bwo = window.open('findBuyorderNo','item', 'width=800, height=1000, left=800');
			return bwo;
		});		
	};
	
	// 창고번호를 선택했을때 옆에 창고이름이 나오는 '그 자리'를 찾아가는 함수
	var storages_select_value = function(select_obj) {
	if($("#storages_name").text() == ""){	/* id값이 storage_name인 자리의 text가 공백이면 */
		$("#storages_name").append(select_obj.value);	<%-- 그 곳을 찾아가서 select_obj.value값, value="${storages.strg_category}"를 그 자리에 넣음. --%>
		} else {
			$("#storages_name").empty();			/* 그 자리가 공백이 아니면, 일단 비운다. */
			$("#storages_name").append(select_obj.value); /* 그리고 다시 채워넣는다. ㅇㅋ */
		}
	
	}	
	
	//초기화
	function init() {
		//초기화 버튼 클릭
		$('#btnInit').on('click',function(){
			$('#stocksform').each(function(){
				this.reset();
			});
			$("#item_name").empty();	/* 품목명도 초기화 */
		});
	}//init
	
	// 등록 요청
	function stocksInsert(){
		//등록 버튼 클릭
		$('#btnInsert').on('click',function(){
			if(stocksform.item_no.value ==""){
				alert("품목코드를 입력해주세요.");
				stocksform.item_no.focus();
				return;
			}
			if(stocksform.stock_qty.value ==""){
				alert("수량을 입력해주세요.");
				stocksform.stock_qty.focus();
				return;
			}
			if(stocksform.stock_price.value ==""){
				alert("거래가를 입력해주세요.");
				stocksform.stock_price.focus();
				return;
			}
			if(stocksform.stock_date.value ==""){
				alert("거래일자를 입력해주세요.");
				stocksform.stock_date.focus();
				return;
			}
			if(stocksform.strg_no.value ==""){
				alert("창고를 입력해주세요.");
				stocksform.strg_no.focus();
				return;
			}
			$.ajax({ 
			    url: "adminStocks",  
			    type: 'POST',  
			    dataType: 'json', 
			    data : $("#stocksform").serialize(),			    
			    success: function(response) {
			    	console.log(response.kkk)
			    	if(response.result == true) {
			    		stocksList();
			    	}
			    }, 
			    error:function(xhr, status, message) { 
			        alert(""+ status+" 정보를 입력해주세요 "+message);
			    } 
			 });  
		});//등록 버튼 클릭
	}
	
	// 조회 요청
	function stocksSelect() {
		//조회 버튼 클릭
		$('body').on('click','#btnSelect',function(){
		$("#storages_name").empty();
			var stocksNo = $(this).closest('tr').find('#hidden_stock_no').val();
			//특정 사용자 조회
			$.ajax({
				url:'adminStocks/' + stocksNo,
				type:'GET',
				contentType:'application/json;charset=utf-8',
				dataType:'json',
				error:function(xhr,status,msg){
					alert("상태값 :" + status + " Http에러메시지 :"+msg);
				},
				success:stocksSelectResult
			});
		}); //조회 버튼 클릭
	}
	
	// 조회 응답
	function stocksSelectResult(stocks) {
		$('input:text[name="stock_no"]').val(stocks.stock_no);
		$('input:text[name="item_no"]').val(stocks.item_no);
		$('span[name="item_name"]').text(stocks.item_name);
		$('select[name="stock_category"]').val(stocks.stock_category).attr("selected", "selected");
		$('input:text[name="stock_qty"]').val(stocks.stock_qty);
		$('input:text[name="stock_price"]').val(stocks.stock_price);
		$('[name="stock_date"]').val(stocks.stock_date);
		$('select[name="strg_no"]').val(stocks.strg_no).attr("selected", "selected","selected","selected");
		$('input:text[name="detail_no"]').val(stocks.detail_no);
		$('input:text[name="note"]').val(stocks.note);
	}
	
	//수정 요청
	function stocksUpdate() {
		//수정 버튼 클릭
		$('#stocksform').on('click', '#btnUpdate', function(){
			var stocksNo = $('#stocksform').find('#stock_no').val();
			var itemNo = $('[name="item_no"]').val();
			var stockCategory = $('[name="stock_category"]').val();
			var stockQty = $('[name="stock_qty"]').val();
			var stockPrice = $('[name="stock_price"]').val();	
			var stockDate = $('[name="stock_date"]').val();
			var strgNo = $('[name="strg_no"]').val();
			var detailNo = $('[name="detail_no"]').val();
			var note = $('[name="note"]').val();
			$.ajax({ 
			    url: "adminStocks", 
			    type: 'PUT', 
			    dataType: 'json', 
			    data : JSON.stringify({stock_no:stocksNo, item_no: itemNo, stock_category:stockCategory, stock_qty: stockQty,
			    						stock_price: stockPrice, stock_date: stockDate, strg_no: strgNo, detail_no: detailNo,  note: note}),
			    contentType:'application/json;charset=utf-8',
			    success: function(data) { 
			    	console.log(data);
			       stocksList();
			    },
			    error:function(xhr, status, message) { 
			        alert(" status: "+status+" 에러:"+message);
			    }
			});
		});//수정 버튼 클릭
	}
	
	//목록 조회 요청
	function stocksList() {
		console.log($("#searchForm").serialize());
		$.ajax({
			url:'adminStocks',
			data: $("#searchForm").serialize(),
			type:'GET',			
			dataType:'json',
			error:function(xhr,status,msg){
				alert("상태값 :" + status + " 에러 메세지:"+msg);
			},
			success:stocksListResult
		});
	}// 리스트 조회
	
	// 입출고 내역 목록 뿌려줌
	function stocksListResult(data) {
		$("tbody").empty();
		$.each(data,function(idx,item){
			$('<tr>')
			.append($('<td>').html('<input type=\'checkbox\' class=\'chkStock\'>'))
			.append($('<td>').html(item.stock_no))
			.append($('<td>').html(item.item_no))
			.append($('<td>').html(item.stock_category))
			.append($('<td>').html(item.stock_qty))
			.append($('<td>').html(numberWithCommas(item.stock_price)))
			.append($('<td>').html(item.stock_date))
			.append($('<td>').html(item.strg_no))
			.append($('<td>').html(item.detail_no))
			.append($('<td>').html(item.note))
			.append($('<td>').html('<button id=\'btnSelect\' class=\'btn btn-info\'>조회</button>'))
			.append($('<input type=\'hidden\' id=\'hidden_stock_no\'>').val(item.stock_no))
			.appendTo('tbody');
		});//each
	}//userListResult
</script>
	<!-- 목록 시작 -->
<div class="row">
	<div class="col-lg-9 col-md-12">
			<h2 style="text-align:center">입출고 목록</h2>
			<hr class="sidebar-divider d-none d-md-block">
				<form id="searchForm">
					<label>거래유형</label>	<select name="selectCategory">
											  <option value="" selected>전체</option>
											  <option value="입고" >입고</option>
											  <option value="출고" >출고</option>
											</select><br/>
					 <input type="date" name="startDate" value="start" data-date-format='yyyy-MM-dd'>  ~  
					 <input type="date" name="endDate" value="end" data-date-format='yyyy-MM-dd'>
					 <input type="button" class="btn btn-secondary" value="검색" id="btnSearch" /> 
					 <input type="reset"  class="btn btn-warning" value="초기화" /> 
		 		</form><br/>
			<table class="table text-center">
				<thead>
				<tr>
					<th class="text-center"><input type="checkbox" class="chkAll"></th>				
					<th class="text-center">입출고번호</th>
					<th class="text-center">입출고날짜</th>
					<th class="text-center">주문번호</th>
					<th class="text-center">품목코드</th>
					<th class="text-center">유형</th>
					<th class="text-center">수량</th>
					<th class="text-center">창고</th>
					<th class="text-center">상태</th>
					<th class="text-center">조회</th>
				</tr>
				</thead>
				<tbody ></tbody>
			</table>
		</div>
	<!-- 목록 끝-->

	<!-- 등록폼 시작 -->
	<div class="col-lg-3 col-md-12 ">
		<div id="storckDiv" class="ml-5">
			<h2 style="text-align:center">입출고 입력</h2>
			<hr class="sidebar-divider d-none d-md-block">
			<form id="stocksform" class="form form-group">
									<input class="form-control" name="stock_no" id="stock_no" type="hidden"><br/>
			<label>구매주문번호</label>	<button type="button" id="btnFindOrderNo" style="background-color: rgba(0,0,0,0); border:0px;"><img src="resources/images/Glass.png" width="30px" height="30px"></button>
									<input class="form-control" name="border_no" id="border_no"><br/>
				
			<label>판매주문번호</label>	<input class="form-control" name="sorder_no" id="sorder_no"><br/>
			<!-- <label>품목코드</label>	<button type="button" value="품목선택" id="btnFindItem" style="background-color: rgba(0,0,0,0); border:0px;"><img src="resources/images/Glass.png" width="30px" height="30px"></button>
									<input class="form-control" name="item_no" id="item_no" type="text"> <span name="item_name" id="item_name" ></span>
									<br/><br/> -->
			<label>유형</label>	<select class="form-control" name="stock_category">
									  <option value="입고" >입고</option>
									  <option value="출고" >출고</option>
									</select><br/>
			<label>수량</label>		<input class="form-control" name="stock_qty" id="stock_qty"><br/>
			<label>거래일자</label>	<input class="form-control" name="stock_date" id="stock_date" type="datetime-local"><br/>
			
			<label>창고</label>		<select class="form-control" name="strg_no" class="selectBox" id="strg_no" onchange="storages_select_value(this);">
										<option value="" selected="selected"> ==선택하세요== </option>
											<c:forEach items="${storages}" var="storages">
												<option value="${storages.strg_no}">${storages.strg_category}</option>
											</c:forEach>
										</select>
									<span id="storages_name"></span><br/>	<!-- 창고번호 선택했을때 옆에 창고이름이 나올 자리. -->
									
			<label>상태</label>	<select class="form-control" name="stock_status">
									  <option value="재고" selected="selected">재고</option>
									  <option value="소진">소진</option>
									  <option value="폐기">폐기</option>
									</select><br/>
			<div class="btn-group" >      
				<input type="button"  class="btn btn-success" value="등록"  id="btnInsert"/> 
				<input type="button"  class="btn btn-primary" value="수정"  id="btnUpdate"/>
				<input type="button"  class="btn btn-warning" value="초기화" id="btnInit"/>		
			</div>
			</form>
		</div>
	</div>	
	<!-- 등록폼 끝-->
</div>	
