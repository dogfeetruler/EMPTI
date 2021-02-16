<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<script src="https://code.jquery.com/jquery-3.5.1.js" integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc=" crossorigin="anonymous"></script>
 <style>
	label{display:inline-block; width:100px;}
</style>
<script>
// 콤머 포맽팅
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


  

<div align="center">
	<h2 class="display-4 text-dark"  style=font-size:30px>품목 수정</h2>
	<hr class="sidebar-divider d-none d-md-block" style="width: 15%;"> 
		<form action="setUpdateItems" class="form form-group">
			<div class="col-sm-2" align="left">
				<label>품목코드</label>	<input  class="form-control" name="item_no" value="${updateList.item_no}" readonly="readonly"><br/>
				<label>품목명</label>		<input  class="form-control" name="item_name" value="${updateList.item_name}"><br/>
				<label>품목유형</label>	<input  class="form-control" name="category" value="${updateList.category}"><br/>
				<label>단위</label>		<input  class="form-control" name="unit" value="${updateList.unit}" ><br/>
				<label>유통기한</label>	<input  class="form-control" name="exp_date" value="${updateList.exp_date}"><br/>
				<label>단가</label>	<input  class="form-control" name="item_price" value="${updateList.item_price}" onkeyup="inputNumberFormat(this)"> <br/>
		
				<div align="center">
					<button class="btn btn-primary" type="submit">수정</button>
				</div>
			</div>
		</form>
</div>

	