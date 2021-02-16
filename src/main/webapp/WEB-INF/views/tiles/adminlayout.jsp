<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="">
  <meta name="author" content="">
	
  <title>EMPTI</title>

  <!-- 폰트 CSS 적용-->
  <link href="resources/admin/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
  <link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">

  <!-- 스타일 CSS 적용-->
  <link href="resources/admin/css/sb-admin-2.min.css" rel="stylesheet">
  
  <!-- 데이타테이블 CSS 적용 -->
  <link href="resources/admin/vendor/datatables/dataTables.bootstrap4.min.css" rel="stylesheet">
	
  
</head>

<body id="page-top">

  <!-- Page Wrapper -->
  <div id="wrapper">

    <!-- Sidebar -->
    <ul class="navbar-nav bg-gradient-info sidebar sidebar-dark accordion" id="accordionSidebar">

      <!-- Sidebar - Brand -->
      <a class="sidebar-brand d-flex align-items-center justify-content-center" href="main">
        <div class="sidebar-brand-icon rotate-n-15">
          <i class="fas fa-laugh-wink"></i>
        </div>
        <div class="sidebar-brand-text mx-3">EMPTI <sup>★</sup></div>
      </a>

      <!-- Divider -->
      <hr class="sidebar-divider my-0">

      <!-- Nav Item - Dashboard -->
      <li class="nav-item active">
        <a class="nav-link" href="main">
          <i class="fas fa-fw fa-tachometer-alt"></i>
          <span>MAIN</span></a>
      </li>

      <!-- Divider -->
      <hr class="sidebar-divider">

      <!-- Heading -->
      <div class="sidebar-heading">
		목록
      </div>
	  
	  <sec:authorize access="hasAnyRole('ROLE_HR','ROLE_ADMIN')">
      <!-- Nav Item - Pages Collapse Menu -->
      <li class="nav-item">
        <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseEmp" aria-expanded="true" aria-controls="collapseEmp">
          <i class="fas fa-fw fa-cog"></i>
          <span>인사</span>
        </a>
        <div id="collapseEmp" class="collapse" aria-labelledby="headingTwo" data-parent="#accordionSidebar">
          <div class="bg-white py-2 collapse-inner rounded">
            <h6 class="collapse-header">인사</h6>
            
            <a class="collapse-item" href="getDeptList">부서관리</a>
            <a class="collapse-item" href="getEmpList">사원관리</a>
            
          </div>
        </div>
      </li>
      </sec:authorize>
      
     <sec:authorize access="hasAnyRole('ROLE_STOCKS','ROLE_ADMIN')">
	 <li class="nav-item">
        <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseStock" aria-expanded="true" aria-controls="collapseStock">
          <i class="fas fa-fw fa-cog"></i>
          <span>재고</span>
        </a>
        <div id="collapseStock" class="collapse" aria-labelledby="headingTwo" data-parent="#accordionSidebar">
          <div class="bg-white py-2 collapse-inner rounded">
            <h6 class="collapse-header">재고</h6>
            <a class="collapse-item" href="getCompanyList">거래처관리</a>
            <a class="collapse-item" href="getItemsList">품목관리</a>
            <a class="collapse-item" href="getStoragesListMap">창고관리</a>
            <a class="collapse-item" href="getStocksList">입/출고관리</a>
            <a class="collapse-item" href="setDisposalForm">폐기/불량</a>
          </div>
        </div>
	 </li>
	 </sec:authorize>
	 
	 <sec:authorize access="hasAnyRole('ROLE_DEALS','ROLE_ADMIN')">
	 <li class="nav-item">
        <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseTrade" aria-expanded="true" aria-controls="collapseTrade">
          <i class="fas fa-fw fa-cog"></i>
          <span>거래</span>
        </a>
        <div id="collapseTrade" class="collapse" aria-labelledby="headingTwo" data-parent="#accordionSidebar">
          <div class="bg-white py-2 collapse-inner rounded">
            <h6 class="collapse-header">거래</h6>
            <a class="collapse-item" href="getBuyordersListMap">구매관리</a>
            <a class="collapse-item" href="getSaleordersListMap">판매관리</a>
          </div>
        </div>
	 </li>
	 </sec:authorize>
	 
	 <sec:authorize access="hasAnyRole('ROLE_LEDGERS','ROLE_ADMIN')">
	 <li class="nav-item">
        <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseMoney" aria-expanded="true" aria-controls="collapseMoney">
          <i class="fas fa-fw fa-cog"></i>
          <span>장부</span>
        </a>
        <div id="collapseMoney" class="collapse" aria-labelledby="headingTwo" data-parent="#accordionSidebar">
          <div class="bg-white py-2 collapse-inner rounded">
            <h6 class="collapse-header">장부</h6>
            
            <a class="collapse-item" href="setLedgerForm">매입/매출 관리</a>
            
          </div>
        </div>
	 </li>
	 </sec:authorize>
      <!-- Divider -->
      <hr class="sidebar-divider d-none d-md-block">

      <!-- Sidebar Toggler (Sidebar) -->
      <div class="text-center d-none d-md-inline">
        <button class="rounded-circle border-0" id="sidebarToggle"></button>
      </div>

    </ul>
    <!-- End of Sidebar -->

    <!-- Content Wrapper -->
    <div id="content-wrapper" class="d-flex flex-column">

      <!-- Main Content -->
      <div id="content">

        <!-- Topbar -->
        <nav class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow">

          <!-- Sidebar Toggle (Topbar) -->
          <button id="sidebarToggleTop" class="btn btn-link d-md-none rounded-circle mr-3">
            <i class="fa fa-bars"></i>
          </button>

          <!-- Topbar Search -->
<!--           <form class="d-none d-sm-inline-block form-inline mr-auto ml-md-3 my-2 my-md-0 mw-100 navbar-search">
            <div class="input-group">
              <input type="text" class="form-control bg-light border-0 small" placeholder="Search for..." aria-label="Search" aria-describedby="basic-addon2">
              <div class="input-group-append">
                <button class="btn btn-primary" type="button">
                  <i class="fas fa-search fa-sm"></i>
                </button>
              </div>
            </div>
          </form> -->

          <!-- Topbar Navbar -->
          <ul class="navbar-nav ml-auto">

            <!-- Nav Item - Search Dropdown (Visible Only XS) -->
            <li class="nav-item dropdown no-arrow d-sm-none">
              <a class="nav-link dropdown-toggle" href="#" id="searchDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                <i class="fas fa-search fa-fw"></i>
              </a>
              <!-- Dropdown - Messages -->
              <div class="dropdown-menu dropdown-menu-right p-3 shadow animated--grow-in" aria-labelledby="searchDropdown">
                <form class="form-inline mr-auto w-100 navbar-search">
                  <div class="input-group">
                    <input type="text" class="form-control bg-light border-0 small" placeholder="Search for..." aria-label="Search" aria-describedby="basic-addon2">
                    <div class="input-group-append">
                      <button class="btn btn-primary" type="button">
                        <i class="fas fa-search fa-sm"></i>
                      </button>
                    </div>
                  </div>
                </form>
              </div>
            </li>

            

			
			<%-- <c:if test="${login != null}">
			<li class="nav-item dropdown no-arrow">
			<a class="nav-link dropdown-toggle" href="logout" style="color:black">로그아웃</a></li>
			</c:if> --%>

            <!-- Nav Item - User Information -->
            <li class="nav-item dropdown no-arrow">
              <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                <span class="mr-2 d-none d-lg-inline text-gray-600 small">${login.name}님&nbsp;</span>
                <!-- 프로필 사진 -->
                <c:if test="${not empty login.profile}">
                <img class="img-profile rounded-circle" src="download?name=${login.profile}">
              	</c:if>
              	<c:if test="${empty login.profile}">
                <img class="img-profile rounded-circle" src="resources/images/profile.jpg">
              	</c:if>
              </a>
              <!-- Dropdown - User Information -->
              <div class="dropdown-menu dropdown-menu-right shadow animated--grow-in" aria-labelledby="userDropdown">
                <a href="mySetUpdateFormEmp?emp_id=${login.emp_id}">
                  <i class="fas fa-user fa-sm fa-fw mr-2 text-gray-400"></i>
                  Profile
                </a>
                <div class="dropdown-divider"></div>
                <a href="logout" >
                  <i class="fas fa-user fa-sm fa-fw mr-2 text-gray-400"></i>
                  Logout
                </a>
              </div>
            </li>

          </ul>

        </nav>
        <!-- End of Topbar -->

        <!-- Begin Page Content -->
        <div class="container-fluid">

          <!-- Page Heading -->
          <div class="d-sm-flex align-items-center justify-content-between mb-4">
            <h1 class="h3 mb-0 text-gray-800"></h1>
          </div>


		<!-- 컨텐츠 영역 -->
		<tiles:insertAttribute name="content" />
        </div>
        <!-- /.container-fluid -->
      </div>
      <!-- End of Main Content -->
	
      
      <!-- Footer -->
      <footer class="sticky-footer bg-white">
        <div class="container my-auto">
          <div class="copyright text-center my-auto">
            <span>Copyright &copy; Your Website 2020</span>
          </div>
        </div>
      </footer>
      <!-- End of Footer -->

    </div>
    <!-- End of Content Wrapper -->

  </div>
  <!-- End of Page Wrapper -->

  <!-- Scroll to Top Button-->
  <a class="scroll-to-top rounded" href="#page-top">
    <i class="fas fa-angle-up"></i>
  </a>

  <!-- Logout Modal-->
  <div class="modal fade" id="logoutModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="exampleModalLabel">Ready to Leave?</h5>
          <button class="close" type="button" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">Ã</span>
          </button>
        </div>
        <div class="modal-body">Select "Logout" below if you are ready to end your current session.</div>
        <div class="modal-footer">
          <button class="btn btn-secondary" type="button" data-dismiss="modal">Cancel</button>
          <a class="btn btn-primary" href="login.html">Logout</a>
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

  <!-- Page level plugins -->
  <script src="resources/admin/vendor/datatables/jquery.dataTables.min.js"></script>
  <script src="resources/admin/vendor/datatables/dataTables.bootstrap4.min.js"></script>

  <!-- Page level custom scripts -->
  <script src="resources/admin/js/demo/datatables-demo.js"></script>
  
  <!--    Page level plugins 
  <script src="resources/admin/vendor/chart.js/Chart.min.js"></script>

  Page level custom scripts
  <script src="resources/admin/js/demo/chart-area-demo.js"></script>
  <script src="resources/admin/js/demo/chart-pie-demo.js"></script> -->
</body>
</html>