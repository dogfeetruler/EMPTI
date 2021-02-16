<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script src="https://code.jquery.com/jquery-3.5.1.js" integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc=" crossorigin="anonymous"></script>
<style>
	label{display:inline-block; width:100px;}
</style>
<script>
	function validCheck() {
		if(frm.item_no.value ==""){
			alert("품목코드를 입력해주세요.");
			frm.item_no.focus();
			return;
		}
		if(frm.item_name.value == ""){
			alert("품목명를 입력해주세요.");
			frm.item_name.focus();
			return;
		}
		if(frm.unit.value == ""){
			alert("단위를 입력해주세요.");
			frm.unit.focus();
			return;
		}
		if(frm.exp_date.value == ""){
			alert("유통기한을 입력해주세요.");
			frm.exp_date.focus();
			return;
		}
		if(frm.item_price.value == ""){
			alert("단가를 입력해주세요.");
			frm.item_price.focus();
			return;
		}
		frm.submit();
	}
	
	//콤마 포맷팅
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

</script>
<div align="center" >
	<h2 class="display-4 text-dark"  style=font-size:35px;>품목 등록</h2>
	<hr class="sidebar-divider d-none d-md-block" style="width: 15%;"> 
	<form action="setInsertItems" name="frm" class="from-group">
		<div class="col-sm-2" align="left" >
		<label>품목코드</label>	<input name="item_no" id="item_no" class="form-control"><br/>
		<label>품목명</label>		<input name="item_name" id="item_name" class="form-control"><br/>
		<label>유형</label>		<select name="category" id="category" class="form-control"><br/>
								  <option value="원자재" selected>원자재</option>
								  <option value="가공품">가공품</option>
								  <option value="장비">장비</option>
								  <option value="소비품">소비품</option>
								</select>
								<br/>
		<label>단위</label>		<input name="unit" id="unit" class="form-control"><br/>
		<label>유통기한(일)</label>	<input name="exp_date" id="exp_date" class="form-control"><br/>
		<label>단가</label>	<input name="item_price" id="item_price" class="form-control" onkeyup="inputNumberFormat(this)"><br/>
	<div align="center">
		<button class="btn btn-success" type="button" onclick="validCheck()">등록</button>
	</div><br/>
	</div>
	</form>
</div>

