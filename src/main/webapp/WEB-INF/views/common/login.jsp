<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<script src="https://code.jquery.com/jquery-3.5.1.js" integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc=" crossorigin="anonymous"></script>
<script>
function check(){
	/* 	$.ajax({
		url:"login",
		type: "post",
		data: $('#frm').serialize(),
		dataType: "json",
		success:function(data){
			if(data.result==true){
				location.href="main";
			} else {
				alert(data.errorMsg);
			}
		}
	}); */
};
</script>
<head>

  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="">
  <meta name="author" content="">

  <title>EMPTI</title>

  <!-- Custom fonts for this template-->
  <link href="resources/admin/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
  <link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">

  <!-- Custom styles for this template-->
  <link href="resources/admin/css/sb-admin-2.min.css" rel="stylesheet">

</head>

<body class="bg-gradient-secondary">
  <div class="container">

    <!-- Outer Row -->
    <div class="row justify-content-center">
      <div class="col-xl-10 col-lg-12 col-md-9">
        <div class="card o-hidden border-0 shadow-lg my-5">
          <div class="card-body p-0">
            <!-- Nested Row within Card Body -->
            <div class="row">
              <div class="col-lg-6 d-none d-lg-block">
              	<img src="resources/images/로그인01.jpg" 
              	style="width: 100%" style= "height: 100%">
              </div>
              <div class="col-lg-6">
                <div class="p-5">
                  <div class="text-center">
                    <h1 class="h4 text-gray-900 mb-4">친환경 유기농 전문기업</h1>
                  </div>
                  <form class="user" id="frm" action="login" method="post">
                    <div class="form-group">
                      <input type="text" class="form-control form-control-user" name="emp_id" aria-describedby="emailHelp" placeholder="EmployeeId">
                    </div>
                    <div class="form-group">
                      <input type="password" class="form-control form-control-user" name="pwd" placeholder="Password">
                    </div>
                    <div class="form-group">
                      <div class="custom-control custom-checkbox small">
                        <input type="checkbox" class="custom-control-input" id="customCheck">
                        <label class="custom-control-label" for="customCheck">아이디 저장</label>
                      </div>
                    </div>
                    <button type="submit" class="btn btn-success btn-user btn-block">로그인</button>
                    <hr>
                  </form>
                  ${param.error}

				<c:if test="${not empty SPRING_SECURITY_LAST_EXCEPTION}">
					  로그인 에러입니다.<br>
					  예외 타입：${SPRING_SECURITY_LAST_EXCEPTION.getClass().name}<br>
					  메시지：${SPRING_SECURITY_LAST_EXCEPTION.message}<br>
					<c:remove var="SPRING_SECURITY_LAST_EXCEPTION" scope="session" />
				</c:if>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>

  <!-- Bootstrap core JavaScript-->
  <script src="resources/admin/vendor/jquery/jquery.min.js"></script>
  <script src="resources/admin/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

  <!-- Core plugin JavaScript-->
  <script src="resources/admin/vendor/jquery-easing/jquery.easing.min.js"></script>

  <!-- Custom scripts for all pages-->
  <script src="resources/admin/js/sb-admin-2.min.js"></script>

</body>
</html>