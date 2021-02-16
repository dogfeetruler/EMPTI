<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<script src="https://code.jquery.com/jquery-3.5.1.js" integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc=" crossorigin="anonymous"></script>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<style>
	label{display:inline-block; width:120px;}
</style>
<script>
//페이지 로드
$(function(){
	$('#subBtn').on('click', function() {
		if(cpFrm.company_name.value == ""){
			alert("회사명을 입력해주세요.");
			cpFrm.company_name.focus();
			return;
		}
		if(cpFrm.phone.value == ""){
			alert("대표 전화번호를 입력해주세요.");
			cpFrm.phone.focus();
			return;
		}
		if(cpFrm.ceo_name.value ==""){
			alert("대표 이름을 입력해주세요.");
			cpFrm.ceo_name.focus();
			return;
		}
		if(cpFrm.addr1.value == ""){
			alert("우편번호를 선택해주세요.");
			cpFrm.addr1.focus();
			return;
		}
		if(cpFrm.addr3.value == ""){
			alert("상세주소를 입력해주세요.");
			cpFrm.addr3.focus();
			return;
		}
		if(cpFrm.dealer_phone.value == ""){
			alert("담당자 전화번호를 입력해주세요.");
			cpFrm.dealer_phone.focus();
			return;
		}
		if(cpFrm.dealer_name.value == ""){
			alert("담당자 이름을 입력해주세요.");
			cpFrm.dealer_name.focus();
			return;
		}
		if(cpFrm.bank_name.value == ""){
			alert("거래은행을 선택해주세요.");
			cpFrm.bank_name.focus();
			return;
		}
		if(cpFrm.account_no.value == ""){
			alert("은행계좌를 입력해주세요.");
			cpFrm.account_no.focus();
			return;
		}
		
		var result = confirm("거래처 등록을 하시겠습니까?");
		if (result) {
			cpFrm.submit();
			window.open = "getCompanyList";
		} else {
			return false;
		}
	});
	
	$('#btnFindBank').on('click', function() {
		var wo = window.open('findBank','item', 'width=800, hight=800');
		return wo;
	});
});

//주소 검색
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
</script>
<div class="col-sm-12 my-auto">
	<h2 class="display-4 text-dark"  style=font-size:30px;>거래처등록</h2>
	<hr class="sidebar-divider d-none d-md-block" width="43%" align="left"> 
		<form id="cpFrm" action="setInsertCompany" class="from-group">
		<label>회사코드</label>	 <input class="form-control" name="company_no" style="width: 250px; display: inline;" value="${maxCom.company_no}" readonly> <br/>
		<label>회사명</label> 	<input class="form-control"name="company_name" id="company_name" style="width: 250px; display: inline;" required="required"> <br/>
		<label>대표 전화번호</label> <input class="form-control" name="phone" id="phone" style="width: 250px; display: inline;"> <br/>
		<label>대표 이름</label> 	<input class="form-control" name="ceo_name" id="ceo_name" style="width: 250px; display: inline;"> <br/>
		<label>주소</label>			<input class="form-control" name="zip_code" id="addr1" readonly="readonly" style="width: 10%; display: inline;" placeholder="우편번호">
		<label></label>			<button class="btn btn-default" type="button"  onclick="execPostCode();"><i class="fa fa-search"></i> 우편번호 찾기</button><br/>                             
		<label></label>			<input class="form-control" name="address" id="addr2" readonly="readonly" style="top: 5px; width: 35%; display: inline;" placeholder="도로명 주소"><br/>
		<label></label>			<input class="form-control" name="address_detail" id="addr3" style="width: 35%; display: inline;" placeholder="상세주소">
							<br/>
		<label>담당자 이름</label>	<input class="form-control" name="dealer_name" id="dealer_name" style="width: 250px; display: inline;"> <br/>
		<label>담당자 전화번호</label>	<input class="form-control" name="dealer_phone" id="dealer_phone" style="width: 250px; display: inline;"> <br/>

		<label>거래은행</label>	<input name="bank_name" id="bank_name" type="text" class="form-control" style="width: 250px; display: inline;">
								<button type="button" value="은행선택" id="btnFindBank" style="background-color: rgba(0,0,0,0); border:0px;"><img src="resources/images/Glass.png" width="30px" height="30px"></button>
								<br/>
		<label>은행계좌</label>	<input name="account_no" id="account_no" class="form-control" style="width: 250px; display: inline;"> <br/>
		<label>비고</label> <input class="form-control" name="note" style="width: 250px; display: inline;"> <br/>
	<button class="btn btn-success" id="subBtn" type="button">등록</button>
	</form>
</div>