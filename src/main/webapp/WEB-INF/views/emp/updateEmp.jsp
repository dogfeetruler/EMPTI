<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<script src="https://code.jquery.com/jquery-3.5.1.js" integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc=" crossorigin="anonymous"></script>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<style>
	label{display:inline-block; width:120px;}
</style>
<script>
//부서 이름
var dept_select_value = function(select_obj) {
	if($("#dept_name").text() == ""){
	$("#dept_name").append(select_obj.value);
	}
	else {
	$("#dept_name").empty();
	$("#dept_name").append(select_obj.value);
	}	
}


	//콤머 포맽팅
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

//비밀번호 유효성 검사
$(function (){
	$('.pw').focusout(function() {
		var pwd1 = $("#pwd").val();
		var pwd2 = $("#pwd2").val();
		if (pwd1 != '' && pwd2 == '') {

		} else if (pwd1 != "" || pwd2 != "") {
			if (pwd1 == pwd2) {
				$('#pw').empty()
				$('#pw')
				.append($('<span>')).text(" 비밀번호가 일치합니다.")
			} else {
				$('#pw').empty()
				$('#pw')
				.append($('<span>')).text("비밀번호가 일치하지 않습니다.")
				
			}
		}
	});
});

//우편번호
function execPostCode() {
    new daum.Postcode({
        oncomplete: function(data) {
           // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

           // 도로명 주소의 노출 규칙에 따라 주소를 조합한다.
           // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
           var fullRoadAddr = data.roadAddress; // 도로명 주소 변수
           var extraRoadAddr = ''; // 도로명 조합형 주소 변수

           // 법정동명이 있을 경우 추가한다. (법정리는 제외)
           // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
           if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
               extraRoadAddr += data.bname;
           }
           // 건물명이 있고, 공동주택일 경우 추가한다.
           if(data.buildingName !== '' && data.apartment === 'Y'){
              extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
           }
           // 도로명, 지번 조합형 주소가 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
           if(extraRoadAddr !== ''){
               extraRoadAddr = ' (' + extraRoadAddr + ')';
           }
           // 도로명, 지번 주소의 유무에 따라 해당 조합형 주소를 추가한다.
           if(fullRoadAddr !== ''){
               fullRoadAddr += extraRoadAddr;
           }

           // 우편번호와 주소 정보를 해당 필드에 넣는다.
           console.log(data.zonecode);
           console.log(fullRoadAddr);
           
           $("#addr1").val(data.zonecode);
           $("#addr2").val(fullRoadAddr);
           
           /* document.getElementById('signUpUserPostNo').value = data.zonecode; //5자리 새우편번호 사용
           document.getElementById('signUpUserCompanyAddress').value = fullRoadAddr;
           document.getElementById('signUpUserCompanyAddressDetail').value = data.jibunAddress; */
       }
    }).open();
}

//은행 찾기
$(function(){
	$('#btnFindBank').on('click', function() {
		var wo = window.open('findBank','item', 'width=800, hight=800');
		return wo;
	});
});

function btnUpdate(empId, loginId) {
	if(empId == loginId) {
		$('#setUpdateEmp').attr('action', 'mySetUpdateEmp').submit();
	} else {
		$('#setUpdateEmp').attr('action', 'setUpdateEmp').submit();
	}
}


</script>  
<div class="col-sm-12 my-auto">
	<h2 class="display-4 text-dark"  style=font-size:30px;>사원수정</h2>
	<hr class="sidebar-divider d-none d-md-block" width="43%" align="left"> 
	<form id="setUpdateEmp" method="post" enctype="multipart/form-data" class="form form-group">
		<label>사원아이디 </label>	 <input name="emp_id" value="${empUp.emp_id}" class="form-control" style="width: 250px; display: inline;" readonly="readonly"> <br/>
		<label>이름 </label>		 <input name="name" value="${empUp.name}" class="form-control" style="width: 250px; display: inline;"> <br/>
		<label>패스워드 </label>	 <input type="password" name="pwd" id="pwd" class="form-control pw" value="${empUp.pwd}" style="width: 250px; display: inline;">  <br/>
		<label>패스워드 확인 </label> <input type="password" name="pwd2" id="pwd2" class="form-control pw" value="${empUp.pwd2}" style="width: 250px; display: inline;"> <br/>
		<div id="pw"></div>
		<label>전화번호 </label>	 <input name="phone" value="${empUp.phone}" class="form-control" style="width: 250px; display: inline;"> <br/>
		<label>주소 </label>		 <input class="form-control" name="zip_code" id="addr1" readonly="readonly" style="width: 15%; display: inline;" placeholder="우편번호" value="${empUp.zip_code}">
		<label></label>			 <button class="btn btn-default" type="button"  onclick="execPostCode();"><i class="fa fa-search"></i> 우편번호 찾기</button><br/>                             
		<label></label>			 <input class="form-control" name="address" id="addr2" readonly="readonly" style="top: 5px; width: 35%; display: inline;" placeholder="도로명 주소" value="${empUp.address}"><br/>
		<label></label>			 <input class="form-control" name="address_detail" id="addr3" style="width: 35%; display: inline;" placeholder="상세주소" value="${empUp.address_detail}">
								 <br/>
		<label>이메일 </label>		 <input name="email" value="${empUp.email}" class="form-control" style="width: 250px; display: inline;"> <br/>
		<label>입사일 </label>		 <input name="hire_date" value="${empUp.hire_date}" type="date" class="form-control" style="width: 250px; display: inline;"> <br/>
		<label>급여</label>		<input name="salary" id="salary"  class="form-control" style="width: 250px; display: inline;" value="${empUp.salary} " onkeyup="inputNumberFormat(this)"> <br/>
		<label>계약유형</label>	<select name="position" id="position" class="form-control" style="width: 250px; display: inline;"> 
									<option value="일용직" <c:if test="${fn:contains(empUp.position,'일용직')}">selected="selected"</c:if>>일용직</option>
									<option value="계약직" <c:if test="${fn:contains(empUp.position,'계약직')}">selected="selected"</c:if>>계약직</option>
									<option value="정직원" <c:if test="${fn:contains(empUp.position,'정직원')}">selected="selected"</c:if>>정직원</option>
									<option value="과장" <c:if test="${fn:contains(empUp.position,'과장')}">selected="selected"</c:if>>과장</option>
									<option value="부사장" <c:if test="${fn:contains(empUp.position,'부사장')}">selected="selected"</c:if>>부사장</option>
									<option value="사장" <c:if test="${fn:contains(empUp.position,'사장')}">selected="selected"</c:if>>사장</option>
								</select><br/>
		<label>상태</label>		<select name="status" id="status" class="form-control" style="width: 250px; display: inline;">
									<option value="재직" <c:if test="${fn:contains(empUp.status,'재직')}">selected="selected"</c:if>>재직</option>
									<option value="휴가" <c:if test="${fn:contains(empUp.status,'휴가')}">selected="selected"</c:if>>휴가</option>
									<option value="퇴사" <c:if test="${fn:contains(empUp.status,'퇴사')}">selected="selected"</c:if>>퇴사</option>
								</select> <br/>
		<label>거래은행 </label>	 <input name="bank_name" value="${empUp.bank_name}" class="form-control" style="width: 250px; display: inline;"> <br/>
		<label>은행계좌</label>	 <input name="account_no" value="${empUp.account_no}" class="form-control" style="width: 250px; display: inline;"> <br/>
		<label>부서명 </label>	 <select name="dept_id" onchange="dept_select_value(this);" class="form-control" style="width: 250px; display: inline;"> 
									<option value="">대표</option>
									<option >--------------</option>
									<c:forEach items="${deptList}" var="dept">
										<option value="${dept.dept_id}" <c:if test="${dept.dept_id == empUp.dept_id }">selected</c:if> >${dept.dept_name}</option>
									</c:forEach>
								</select>
								<span id="dept_name"></span>
								<br/>
		<label>이미지 </label>    <input type="file" name="uploadFile" / class="form-control" style="width: 250px; display: inline;">${empUp.profile}<br>
								<input type="hidden" name="uploadFile" value="${empUp.profile}"><br>
		<button type="button" onclick="btnUpdate(${empUp.emp_id},${login.emp_id})" class="btn btn-primary">수정</button>
	</form>
</div>
