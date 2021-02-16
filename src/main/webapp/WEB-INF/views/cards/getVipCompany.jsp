<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<script src="https://code.jquery.com/jquery-3.5.1.js" integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc=" crossorigin="anonymous"></script>
<script>
	//페이지 로드
	$(function() {
		$.ajax({
			url : 'getVipCompany',
			type : 'GET',
			dataType : 'json',
			async: false,
			success : function(result) {
				var company = result.company_name + " / " + result.count + "건";
				$('.vip').text(company);
				
			}
		});
	});
</script>
<div class="card border-left-primary shadow h-100 py-2">
  <div class="card-body">
    <div class="row no-gutters align-items-center">
      <div class="col mr-2">
        <div class="text-s font-weight-bold text-primary text-uppercase mb-1">주문량 가장 많은 거래처</div>
        <div class="h5 mb-0 font-weight-bold text-gray-800 vip"></div>
      </div>
      <div class="col-auto">
        <i class="fas fa-calendar fa-2x text-gray-300"></i>
      </div>
    </div>
  </div>
</div>