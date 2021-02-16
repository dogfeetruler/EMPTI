<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<script src="https://code.jquery.com/jquery-3.5.1.js" integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc=" crossorigin="anonymous"></script>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<style>
	label{display:inline-block; width:120px;}
</style>
<script>
//부서 검색
var dept_select_value = function(select_obj) {
	if($("#dept_name").text() == ""){
	$("#dept_name").append(select_obj.value);
	}
	else {
	$("#dept_name").empty();
	$("#dept_name").append(select_obj.value);
	}	
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

$(function(){
	$('#btnFindBank').on('click', function() {
		var wo = window.open('findBank','item', 'width=800, hight=800');
		return wo;
	});
});


function check() {
	if(frm.name.value == ""){
		alert("이름을 입력해주세요.");
		frm.name.focus();
		return;
	}
	if(frm.pwd.value == ""){
		alert("패스워드를 입력해주세요.");
		frm.pwd.focus();
		return;
	}
	if(frm.pwd2.value ==""){
		alert("패스워드를 입력해주세요.");
		frm.pwd2.focus();
		return;
	}
	if(frm.phone.value == ""){
		alert("전화번호를 입력해주세요.");
		frm.phone.focus();
		return;
	}
	if(frm.addr1.value == ""){
		alert("우편번호를 입력해주세요.");
		frm.addr1.focus();
		return;
	}
	if(frm.addr2.value == ""){
		alert("주소를 입력해주세요.");
		frm.addr2.focus();
		return;
	}
	if(frm.addr3.value == ""){
		alert("상세주소를 입력해주세요.");
		frm.addr3.focus();
		return;
	}
	if(frm.email.value ==""){
		alert("이메일을 입력해주세요.");
		frm.email.focus();
		return;
	}
	if(frm.hire_date.value == ""){
		alert("입사일을 선택해주세요.");
		frm.hire_date.focus();
		return;
	}
	if(frm.salary.value == ""){
		alert("급여를 선택해주세요.");
		frm.salary.focus();
		return;
	}
	if(frm.position.value ==""){
		alert("계약유형을 선택해주세요.");
		frm.position.focus();
		return;
	}
	if(frm.status.value == ""){
		alert("상태를 입력해주세요.");
		frm.status.focus();
		return;
	}
	if(frm.bank_name.value == ""){
		alert("거래은행을 선택해주세요.");
		frm.bank_name.focus();
		return;
	}	
	if(frm.account_no.value ==""){
		alert("은행계좌를 입력해주세요.");
		frm.account_no.focus();
		return;
	}
	if(frm.dept_id.value == ""){
		alert("부서를 입력해주세요.");
		frm.dept_id.focus();
		return;
	}
	if(frm.uploadFile.value == ""){
		alert("이미지를 선택해주세요.");
		frm.uploadFile.focus();
		return;
	}
		frm.submit();
}
</script>    
    
<div class="col-sm-12 my-auto">
	<h2 class="display-4 text-dark"  style=font-size:30px;>사원등록</h2>
	<hr class="sidebar-divider d-none d-md-block" width="43%" align="left"> 
	<form action="setInsertEmp" id="frm" method="post" enctype="multipart/form-data" class="from-group">
		<label>사원아이디</label>	<input name="emp_id" id="emp_id" value="${empId.emp_id}" class="form-control" style="width: 250px; display: inline;"> <br/>
		<label>이름</label>		<input name="name" id="name"class="form-control" style="width: 250px; display: inline;"> <br/>
		<label>패스워드</label>	<input type="password" id="pwd"  class="form-control pw" name="pwd" style="width: 250px; display: inline;"> <br/>
		<label>패스워드 확인</label>	<input type="password" id="pwd2" class="form-control pw" name="pwd2"style="width: 250px; display: inline;"> <br/>
		<div id="pw"></div>
		<label>전화번호</label>	<input name="phone" id="phone" class="form-control" style="width: 250px; display: inline;"> <br/>
		<label>주소</label>			<input class="form-control" name="zip_code" id="addr1" readonly="readonly" style="width: 10%; display: inline;" placeholder="우편번호">
		<label></label>			<button class="btn btn-default" type="button"  onclick="execPostCode();"><i class="fa fa-search"></i> 우편번호 찾기</button><br/>                             
		<label></label>			<input class="form-control" name="address" id="addr2" readonly="readonly" style="top: 5px; width: 35%; display: inline;" placeholder="도로명 주소"><br/>
		<label></label>			<input class="form-control" name="address_detail" id="addr3" style="width: 35%; display: inline;" placeholder="상세주소">
								 <br/>
		<label>이메일</label>		<input name="email" type="email" class="form-control" style="width: 250px; display: inline;"> <br/>
		<label>입사일</label>		<input name="hire_date" id="hire_date"type="date" class="form-control" style="width: 250px; display: inline;"> <br/>
		<label>급여</label>		<input name="salary" id="salary"  class="form-control" style="width: 250px; display: inline;" value="" onkeyup="inputNumberFormat(this)"> <br/>
		<label>계약유형</label>	<select name="position" id="position" class="form-control" style="width: 250px; display: inline;"> 
									<option value="" selected> ======선택하세요====== </option>
									<option>정직원</option>
									<option>계약직</option>
									<option>일용직</option>
								</select><br/>
		<label>상태</label>		<select name="status" id="status" class="form-control" style="width: 250px; display: inline;">
									<option value="" selected> ======선택하세요====== </option>
									<option>재직</option>
									<option>휴가</option>
									<option>퇴직</option>
								</select> <br/>
		<label>거래은행</label>	<input name="bank_name" id="bank_name" type="text" class="form-control" style="width: 250px; display: inline;">
								<button type="button" value="은행선택" id="btnFindBank" style="background-color: rgba(0,0,0,0); border:0px;"><img src="resources/images/Glass.png" width="30px" height="30px"></button>
								<br/>
		<label>은행계좌</label>	<input name="account_no" id="account_no" class="form-control" style="width: 250px; display: inline;"> <br/>
		<label>부서이름</label>	<select name="dept_id" id="dept_id" onchange="dept_select_value(this);" class="form-control" style="width: 250px; display: inline;"> 
									<c:forEach items="${dept}" var="dept">
										<option value="${dept.dept_id}">${dept.dept_name}</option>
									</c:forEach>
								</select>
								<span id="dept_name"></span>
								<br/>
		<label>이미지</label>     <input type="file" name="uploadFile" id="uploadFile" class="form-control" style="width: 250px; display: inline;"><br>
	<button class="btn btn-success" type="button" onclick="check()" >등록</button>
	</form>
</div>