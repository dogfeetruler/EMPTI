<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<script src="https://code.jquery.com/jquery-3.5.1.js"
	integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc="
	crossorigin="anonymous"></script>
<script>
$(function(){
		disposalList();
		disposalInsert();
		disposalUpdate();  
		disposalSelect();
		disposalDelete();
		disposalList();
		init();
		fnc_btnfindItem();
		$('#searchForm').on('click','#btnSearch',function() {
			disposalList();
		});
	});
	
	
//커ㅁ머 포맽팅
function inputNumberFormat(obj) {
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
	
	
	//초기화
	function init() {
		//초기화 버튼 클릭
		$('#btnInit').on('click',function(){
			$('#disposalForm').each(function(){
				this.reset();
			});
			$("#item_name").empty();
		});
	}//init
	
	// 등록 요청
	function disposalInsert(){
		//등록 버튼 클릭
		$('#disposalForm').on('click', '#btnInsert', function(){
			console.log($("#disposalForm").serialize());
			$.ajax({ 
			    url: "disposals",  
			    type: 'POST',  
			    dataType: 'json', 
			    data : $("#disposalForm").serialize(),			    
			    success: function(response) {
			    	console.log(response.kkk)
			    	if(response.result == true) {
			    		disposalList();
			    		$('#disposalForm').each(function(){
							this.reset();
						});
			    		$('#storages_no').empty();
			    		
			    	}
			    },
			    error:function(xhr, status, message) { 
			        alert(""+ status+" 정보를 입력해주세요 "+message);
			    } 
			 });  
		});//등록 버튼 클릭
	}
	
	// 수정 요청
	function disposalUpdate() {
		//수정 버튼 클릭
		$('#disposalForm').on('click', '#btnUpdate', function(){
			var disposalNo = $('#disposalDiv').find('#disposal_no').val();
			var disposalDate = $('[name="disposal_date"]').val();
			var disposalQty = $('[name="disposal_qty"]').val();
			var price = $('[name="price"]').val();
			var category = $('[name="category"]').val();
			var itemNo = $('[name="item_no"]').val();
			var strgNo = $('[name="strg_no"]').val();
			$.ajax({ 
			    url: "disposals", 
			    type: 'PUT', 
			    dataType: 'json', 
			    data : JSON.stringify({disposal_no : disposalNo, disposal_date : disposalDate, disposal_qty : disposalQty,
			    						price : price, category : category, item_no : itemNo, strg_no: strgNo}),
			    contentType:'application/json;charset=utf-8',
			    success: function(data) { 
			    	console.log(data);
			    	disposalList();
		    		$('#disposalForm').each(function(){
						this.reset();
					});
		    		$('#storages_no').empty();
			    },
			    error:function(xhr, status, message) { 
			        alert(" status: "+status+" 에러:"+message);
			    }
			});
		});//수정 버튼 클릭
	}
	
	
	// 조회 요청
	function disposalSelect() {
		//조회 버튼 클릭
		$('body').on('click','#btnSelect',function(){
			var disposalNo = $(this).closest('tr').find('#hidden_disposal_no').val();
			console.log(disposalNo)
			//특정 사용자 조회
			$.ajax({
				url:'disposals/' + disposalNo, 
				type:'GET',
				contentType:'application/json;charset=utf-8',
				dataType:'json',
				error:function(xhr,status,msg){
					alert("상태값 :" + status + " Http에러메시지 :"+msg);
				},
				success:disposalSelectResult
			});
		}); //조회 버튼 클릭
	}
	function disposalDelete(){
		$('body').on('click', '#btnDelete', function() {
			var disposalNo = $(this).closest('tr').find('#hidden_disposal_no').val();
			console.log(disposalNo);
			var result = confirm("폐기/불량 내역을 삭제하시겠습니까?");
			if(result){
			$.ajax({
				url:'disposals/'+ disposalNo,  
	               type:'DELETE',
	               contentType:'application/json;charset=utf-8',
	               cache: false,
	               dataType:'json',
	               error:function(xhr,status,msg){
	                  console.log("상태값 :" + status + " Http에러메시지 :"+msg);
	               }, success:function(xhr) {
	                  console.log(xhr.result);
	                  disposalList();
					}
				});
			}
		});
	}
	
	// 조회 응답
	function disposalSelectResult(disposals) {
		$('[name="disposal_no"]').val(disposals.disposal_no);
		$('[name="disposal_qty"]').val(disposals.disposal_qty);
		$('[name="price"]').val(numberWithCommas(disposals.price));
		$('[name="disposal_date"]').val(disposals.disposal_date);
		$('[name="category"]').val(disposals.category);
		$('[name="strg_no"]').val(disposals.strg_no);
		$('[name="item_no"]').val(disposals.item_no);
		$('[name="item_name"]').text(disposals.item_name);
		
	}
	
	
	//  리스트 요청
	function disposalList() {
		var category = this.value;
		$.ajax({
			url:'disposals',
			data: $("#searchForm").serialize(),
			type:'GET',			
			dataType:'json',
			error:function(xhr,status,msg){
				alert("상태값 :" + status + " 에러 메세지:"+msg);
			},
			success:disposalListResult
			});
		}
	
	//가격 포맽팅
	function numberWithCommas(x) {
	    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	}
	
	// 폐기불량 리스트 뿌려줌
	function disposalListResult(data) {
		$("tbody").empty();
		$.each(data,function(idx,item){
			$('<tr>')
			.append($('<td>').html(item.disposal_no))
			.append($('<td>').html(item.disposal_qty))
			.append($('<td align="right">').html(numberWithCommas(item.price)))
			.append($('<td>').html(item.disposal_date))
			.append($('<td>').html(item.category))
			.append($('<td>').html(item.strg_no))
			.append($('<td>').html(item.item_no))
			.append($('<td>').html('<button id=\'btnSelect\' class=\'btn btn-info\'>조회</button>'))
			.append($('<td>').html('<button id=\'btnDelete\' class=\'btn btn-danger\'>삭제</button>'))
			.append($('<input type=\'hidden\' id=\'hidden_disposal_no\'>').val(item.disposal_no))
			.appendTo('tbody');
		});//each
	}//userListResult
	
	function fnc_btnfindItem(){
		//품목 검색 기능
		$('#btnFindItem').on('click', function() {
			var wo = window.open('findItems','item', 'width=800, height=800, left=400, top=100');
			return wo;
		});
	};
	
	var storages_select_value = function(select_obj) {
		if($("#storages_no").text() == ""){
		$("#storages_no").append(select_obj.value);
		}
		else {
		$("#storages_no").empty();
		$("#storages_no").append(select_obj.value);
		}	
	}
	


</script>

<div class="row">
	<!-- 목록 시작 -->
	<div class="col-lg-7 col-md-12">
		<h2 style="text-align:center">폐기/불량 목록</h2>
		<hr class="sidebar-divider d-none d-md-block">
		<a href= "disposal_list.do" onclick="window.open(this.href, 'width=800', 'height=1200', 'toolbars=no', 'scrollbars=yes'); return false">PDF</a> |
		<a href="disposal_excel.do">EXCEL</a>
			<form id="searchForm">
		 		<input type="radio"  name="radioCategory" value="" checked><span> 전체조회</span>
			 	<input type="radio"  name="radioCategory" value="폐기"><span> 폐기</span>
			 	<input type="radio"  name="radioCategory" value="불량"><span> 불량</span><br>
			 	<input type="date" name="startDate" value="start" data-date-format='yyyy-MM-dd'>  ~  <input type="date" name="endDate" value="end" data-date-format='yyyy-MM-dd'>
			 	<input type="button" class="btn btn-secondary" value="검색" id="btnSearch" /> 
			 	<input type="reset"  class="btn btn-warning" value="초기화" /> 
		 	</form><br/>
		<table class="table text-center">
			<thead>
				<tr>
					<th class="text-center">폐기/불량 번호</th>
					<th class="text-center">폐기/불량 수량</th>
					<th class="text-center">처리비용(원)</th>
					<th class="text-center">날짜</th>
					<th class="text-center">구분</th>
					<th class="text-center">창고번호</th>
					<th class="text-center">품목코드</th>
					<th class="text-center">조회</th>
					<th class="text-center">삭제</th>
				</tr>
			</thead>
			<tbody></tbody>
		</table>
	</div> 
	<!-- 목록 끝-->
	 
	<!-- 등록수정 폼 시작 -->
	<div class="col-lg-5 col-md-12">
		<div id="disposalDiv" class="ml-5">
			<h2 style="text-align:center">폐기/불량 입력</h2>
			<hr class="sidebar-divider d-none d-md-block">
			<form id="disposalForm">
				<label>폐기/불량 번호</label>	<input class="form-control" name="disposal_no" id="disposal_no" readonly><br/>
				<label>날짜</label>			<input class="form-control" name="disposal_date" type="datetime-local"><br/>
				<label>구분</label>			<select class="form-control" name="category">
														<option value="폐기">폐기</option>
														<option value="불량">불량</option>
											</select><br/>
				<label>품목코드</label>		<button type="button" value="품목선택" id="btnFindItem"><img src="resources/images/Glass.png" width="30px" height="30px"></button>
											<input class="form-control" name="item_no" id="item_no" > <span id="item_name" name="item_name"></span><br/><br/>
				<label>폐기/불량 수량</label>		<input class="form-control" name="disposal_qty"  ><br/>
				<label>처리비용</label>			<input class="form-control" name="price" onkeyup="inputNumberFormat(this)" ><br/>
				
				
				
				<label>창고</label>			<select class="form-control" name="strg_no" class="selectBox" onchange="storages_select_value(this);">
												<option value="" selected> ==선택하세요== </option>
													<c:forEach items="${storages}" var="storages">
														<option value="${storages.strg_no}">${storages.strg_category}</option>
													</c:forEach>
											</select><span id="storages_no"></span><br/>
				
				
				<div class="btn-group">
					<input type="button" class="btn btn-success" value="등록" id="btnInsert" /> 
					<input type="button" class="btn btn-primary" value="수정" id="btnUpdate" /> 
					<input type="button" class="btn btn-warning" value="초기화" id="btnInit" />
				</div>
			</form>
		</div>
	</div>
	<!-- 등록수정 폼 끝-->
</div>
