<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script src="https://code.jquery.com/jquery-3.5.1.js" integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc=" crossorigin="anonymous"></script>
<script>
	//페이지 로드
	$(function() {
		$.ajax({
			url : 'getProfits',
			type : 'GET',
			dataType : 'json',
			async: false,
			success : function(result) {
				$('.profits').text(numberWithCommas(result));
			}
		});
	});
	
	function numberWithCommas(x) {
	    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	}
</script>
<div class="card border-left-success shadow h-100 py-2">
  <div class="card-body">
    <div class="row no-gutters align-items-center">
      <div class="col mr-2">
        <div class="text-s font-weight-bold text-success text-uppercase mb-1">이번 달 영업이익</div>
        <div class="h5 mb-0 font-weight-bold text-gray-800 profits"></div>
      </div>
      <div class="col-auto">
        <i class="fas fa-dollar-sign fa-2x text-gray-300"></i>
      </div>
    </div>
  </div>
</div>