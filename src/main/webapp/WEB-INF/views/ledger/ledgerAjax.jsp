<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<script src="https://code.jquery.com/jquery-3.5.1.js"
	integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc=" crossorigin="anonymous"></script>

<script>

$(function(){
		ledgerList();
		ledgerInsert();
		ledgerUpdate();  
		ledgerSelect();
		init();
		fnc_findOrderNo();
		fnc_selectOrderNo();
		$('#searchForm').on('click','#btnSearch',function() {
		ledgerList()			 
		});
	});
	
	//커ㅁ머 포맽팅
	function ledgerVO(obj) {
		if(obj !=null)
		obj.value = comma(uncomma(obj.value));
	}
	function comma(str) {
		str = String(str);
		return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
	}
	function uncomma(str) {
		str = String(str);
		return str.replace(/[^\d]+/g, '');
	}	
	
	//주문번호 조회
	function fnc_findOrderNo()	{
		$('#ledgerDiv').on('click', '#btnFindOrderNo', function() {
			var status = $('#status option:selected').val();
			
			if(status == '매입'){
				var bwo = window.open('findBuyorderNo','item', 'width=800, height=1000, left=800');
				//var wo = window.open('findBuyorderNo/status','item', 'width=800, height=800');
				return bwo;
			} else {     
				var swo = window.open('findSaleorderNo','item', 'width=800, height=1000, left=800');
				return swo;
			}
		});		
	};
	
	//초기화
	function init() {
		//초기화 버튼 클릭
		$('#btnInit').on('click',function(){
			$('#ledgerForm').each(function(){
				this.reset();
			});
		});
	}//init
	
	// 등록 요청
	function ledgerInsert(){
		//등록 버튼 클릭
		$('#ledgerForm').on('click', '#btnInsert', function(){
			if(ledgerForm.ldgr_date.value == ""){
				alert("날짜를 선택해주세요.");
				ledgerForm.ldgr_date.focus();
				return;
			}
			if(ledgerForm.total_amount.value == ""){
				alert("금액을 입력해주세요.");
				ledgerForm.total_amount.focus();
				var amt = ledgerForm.total_amount.value;
				amt.replace(/\,/g,"");
				return ;
			}
			if(ledgerForm.status.value ==""){
				alert("구분을 선택해주세요.");
				frm.status.focus();
				return;
			}
			if(ledgerForm.condition.value == ""){
				alert("상태를 선택해주세요.");
				frm.condition.focus();
				return;
			}

			$.ajax({ 
			    url: "ledgers",  
			    type: 'POST',  
			    dataType: 'json', 
			    data : $("#ledgerForm").serialize(),			    
			    success: function(response) {
			    	if(response.result == true) {
			    	alert("등록되었습니다.");
			    		ledgerList();
						$('#ledgerForm').each(function(){
							this.reset();
						});
			    	}
			    }, 
			    error:function(xhr, status, message) { 
			        alert(""+ status+" 정보를 입력해주세요 "+message);
			    } 
			 });  
		});//등록 버튼 클릭
	}
	
	// 수정 요청
	function ledgerUpdate() {
		//수정 버튼 클릭
		$('#ledgerForm').on('click', '#btnUpdate', function(){
			var ledgerNo = $('#ledgerDiv').find('#ldgr_no').val();
			var ldgrDate = $('[name="ldgr_date"]').val();
			var totalAmount = $('[name="total_amount"]').val();
			var amt = totalAmount.replace(/\,/g,"");
			var sts = $('[id="status"]').val();
			var borderNo = $('[id="border_no"]').val();
			var sorderNo = $('[id="sorder_no"]').val();
			var con = $('[name="condition"]').val();
			var note = $('[name="note"]').val();
			$.ajax({ 
			    url: "ledgers", 
			    type: 'PUT', 
			    dataType: 'json', 
			    data : JSON.stringify({ldgr_no:ledgerNo, ldgr_date: ldgrDate, total_amount:amt, status: sts, 
		    							border_no: borderNo, sorder_no : sorderNo, condition: con, note: note}),
			    contentType:'application/json;charset=utf-8',
			    success: function(data) { 
			    	alert("수정되었습니다.");
			    	console.log(data);
			    	ledgerList();
					$('#ledgerForm').each(function(){
						this.reset();
					});
			    },
			    error:function(xhr, status, message) { 
			        alert(" status: "+status+" 에러:"+message);
			    }
			});
		});//수정 버튼 클릭
	}
	
	
	// 단건조회 요청
	function ledgerSelect() {
		//조회 버튼 클릭
		$('body').on('click','#btnSelect',function(){
			var ldgrNo = $(this).closest('tr').find('#hidden_ldgr_no').val();
			//특정 사용자 조회
			$.ajax({
				url:'ledgers/' + ldgrNo, 
				type:'GET',
				contentType:'application/json;charset=utf-8',
				dataType:'json',
				error:function(xhr,status,msg){
					alert("상태값 :" + status + " Http에러메시지 :"+msg);
				},
				success:ledgerSelectResult
			});
		}); //조회 버튼 클릭
	}
	
	// 등록폼 조회 응답
	function ledgerSelectResult(ledgers) {
		$('input:text[name="ldgr_no"]').val(ledgers.ldgr_no);
		$('[name="ldgr_date"]').val(ledgers.ldgr_date);
		$('input:text[name="total_amount"]').val(numberWithCommas(ledgers.total_amount));
		$('select[id="status"]').val(ledgers.status).attr("selected", "selected");
		if(ledgers.status == "매입") {
			$('#order_no').empty();
			$('#order_no')
			.append($('<label>').text("구매주문번호"))
			.append("&nbsp;&nbsp;")
			.append($('<button type="button" id=\'btnFindOrderNo\'>')
			.append('<img src="resources/images/Glass.png" width="30px" height="30px">'))
			.append($('<input id=\'border_no\' class=\'form-control\'><br>').val(ledgers.border_no)); 
		} else if (ledgers.status == "매출"){
 			$('#order_no').empty();
			$('#order_no')
			.append($('<label>').text("판매주문번호"))
			.append("&nbsp;&nbsp;")
			.append($('<button type="button" id=\'btnFindOrderNo\'>')
			.append('<img src="resources/images/Glass.png" width="30px" height="30px">'))
			.append($('<input id=\'sorder_no\' class=\'form-control\'><br>').val(ledgers.sorder_no)); 
		} else {
			$('#order_no').empty();
		}
		$('select[name="condition"]').val(ledgers.condition).attr("selected", "selected");
		$('input:text[name="note"]').val(ledgers.note);
		
	}
	

	// 전체조회요청
	function ledgerList() { 	
		console.log($("#searchForm").serialize());
		$.ajax({
			url:'ledgers',
			data: $("#searchForm").serialize(),
			type:'GET',			
			dataType:'json',
			error:function(xhr,status,msg){
				alert("상태값 :" + status + " 에러 메세지:"+msg);
			},
			success:ledgerListResult
		});
	};
	
	//금액 포맽팅
	function numberWithCommas(x) {
	    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	}
	
	// 조회 응답 . 리스트 뿌려줌.
	function ledgerListResult(data) {
		$("tbody").empty();
		$.each(data,function(idx,item){
			var amount = numberWithCommas(item.total_amount) +"&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp";
			$('<tr>')
			.append($('<td>').html(item.ldgr_no))
			.append($('<td>').html(item.ldgr_date))
			.append($('<td>').html(item.status))
			.append($('<td>').html(item.border_no))
			.append($('<td>').html(item.sorder_no))
			.append($('<td align="right">').html(amount))
			.append($('<td>').html(item.condition))
			.append($('<td>').html(item.note))
			.append($('<td>').html('<button id=\'btnSelect\' class=\'btn btn-info\'>조회</button>'))
			.append($('<input type=\'hidden\' id=\'hidden_ldgr_no\'>').val(item.ldgr_no))
			.appendTo('tbody');
		});//each
	};//ledgerListResult
	
	
	// 구분에 따른 구매/판매 주문번호 조회
	function fnc_selectOrderNo(){
		$('#ledgerForm').on('change', '#status', function() {
			var status = $('#status option:selected').val();
			if(status == "매입") {
				$('#order_no').empty();
				$('#order_no')
				.append($('<label>').text("구매주문번호"))
				.append("&nbsp;&nbsp;")
				.append($('<button type="button" id=\'btnFindOrderNo\'>')
				.append('<img src="resources/images/Glass.png" width="30px" height="30px">'))
				.append($('<input id=\'border_no\' name=\'border_no\' class=\'form-control\'>'))
				.append($('<input id=\'sorder_no\' name=\'sorder_no\' hidden><br>'))
			} else if (status == "매출"){
				$('#order_no').empty();
				$('#order_no')
				.append($('<label>').text("판매주문번호"))
				.append("&nbsp;&nbsp;")
				.append($('<button type="button" id=\'btnFindOrderNo\'>')
				.append('<img src="resources/images/Glass.png" width="30px" height="30px">'))
				.append($('<input id=\'sorder_no\' name=\'sorder_no\' class=\'form-control\'>'))
				.append($('<input id=\'border_no\' name=\'border_no\' hidden><br>'))

			} else {
				$('#order_no').empty();
			}
		});
	};

	

</script>

<div class="row">
	<!-- 목록 시작 -->
	<div class="col-lg-9 col-md-12">
		<h2 style="text-align:center">장부 목록</h2>
		<hr class="sidebar-divider d-none d-md-block">
		<a href= "ledger_list.do" onclick="window.open(this.href, 'width=800', 'height=1200', 'toolbars=no', 'scrollbars=yes'); return false">PDF</a> |
		<a href="LdgrExcel.do">EXCEL</a>
			<form id="searchForm">
				 <input type="radio"  name="radioStatus" value="" checked><span> 전체조회</span>
				 <input type="radio"  name="radioStatus" value="매입"><span> 매입</span>
				 <input type="radio"  name="radioStatus" value="매출" ><span> 매출</span><br>
				 <input type="date" name="startDate" value="start" data-date-format='yyyy-MM-dd'>  ~  <input type="date" name="endDate" value="end" data-date-format='yyyy-MM-dd'>
				 <input type="button" class="btn btn-secondary" value="검색" id="btnSearch" /> 
				 <input type="reset"  class="btn btn-warning" value="초기화" /> 
		 	</form><br/>
		<table class="table text-center">
			<thead>
				<tr>
					<th class="text-center">장부번호</th>
					<th class="text-center">날짜</th>
					<th class="text-center">구분</th>
					<th class="text-center">구매주문번호</th>
					<th class="text-center">판매주문번호</th>
					<th class="text-center">금액(원)</th>
					<th class="text-center">상태</th>
					<th class="text-center">비고</th>
					<th class="text-center">조회</th>
				</tr>
			</thead>
			<tbody></tbody>
		</table>
	</div> 
	<!-- 목록 끝-->
	 
	<!-- 등록수정 폼 시작 -->
	<div class="col-lg-3 col-md-12 ">
		<div id="ledgerDiv" class="ml-5">
			<h2 style="text-align:center">장부 등록</h2>
			<hr class="sidebar-divider d-none d-md-block">
			<form id="ledgerForm">  
				<label>장부번호</label>	<input class="form-control" name="ldgr_no" id="ldgr_no" readonly><br> 
				<label>날짜</label> 		<input class="form-control" name="ldgr_date" id="ldgr_date" type="datetime-local"> <br> 
				<label>구분</label> 		<select class="form-control" name="status" id="status">
											<option value="" selected>== 매출/매입 선택 ==</option>
											<option value="매입">매입</option>
											<option value="매출">매출</option>
										</select><br>
				
				<div id="order_no"></div>
				<label>금액(원)</label> 		<input class="form-control" name="total_amount" id="total_amount" onkeyup="inputNumberFormat(this)"> <br>  
				<label>상태</label> 		<select class="form-control" name="condition" id="condition">
											<option value="" selected>==선택하세요==</option>
											<option value="완납">완납</option>
											<option value="미수">미수</option>
											<option value="미납">미납</option>
									   	</select> <br> 
				<label>비고</label> 		<input name="note" class="form-control" > <br>
								 		
										
				<div class="btn-group" >
					<input type="button" class="btn btn-success" value="등록" id="btnInsert" /> 
					<input type="button" class="btn btn-primary" value="수정" id="btnUpdate" /> 
					<input type="button" class="btn btn-warning" value="초기화" id="btnInit" />
				</div>
			</form>
		</div>
	</div>
	<!-- 등록수정 폼 끝-->
	
</div>

	
