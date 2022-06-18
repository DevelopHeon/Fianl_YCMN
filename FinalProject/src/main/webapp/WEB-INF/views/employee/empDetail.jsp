<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.uni.spring.employee.model.dto.Employee"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주소록</title>

  <!-- Favicons -->
  <link href="img/favicon.png" rel="icon">
  <link href="img/apple-touch-icon.png" rel="apple-touch-icon">

  <!-- Bootstrap core CSS -->
  <link href="lib/bootstrap/css/bootstrap.min.css" rel="stylesheet">
  <!--external css-->
  <link href="lib/font-awesome/css/font-awesome.css" rel="stylesheet" />
  <!-- Custom styles for this template -->
  <link href="css/style.css" rel="stylesheet">
  <link href="css/style-responsive.css" rel="stylesheet">
<style>
 .img-circle {
 	width:80px;
 	float : left;
 	margin-right : 30px;
 }
</style>
</head>

<body>
	
    <!-- **********************************************************************************************************************************************************
        MAIN CONTENT
        *********************************************************************************************************************************************************** -->
    <!--main content start-->
    <section id="main-content">
      <section class="wrapper site-min-height">
        <div class="row mt">
          <div class="col-xs-12">
            <div class="row content-panel">
            <!-- /col-md-4 -->
            <!-- 프로필 사진 -->
                <c:if test="${ empty detailEmp.empPfe}">
               		<p><img src="resources/img/user.png" class="img-circle"></p>
                </c:if>
                 <c:if test="${ !empty detailEmp.empPfe }">
                	<p><img src="resources/empUpload_files/${detailEmp.empPfe}" id="empImg" class="img-circle"></p>
                </c:if>
             <!-- 프로필 사진 -->
              <!-- /col-md-4 -->
              <div class="profile-text mt mb centered right-divider">
               <table class="table table-inbox">
				<tr>
					<td>${ detailEmp.empName }</td>
					<td>${ detailEmp.empOnoff }</td>
				</tr>
				<tr>
					<td>${ detailEmp.posName }</td>
					<td>${ detailEmp.depName }</td>
					
				</tr>
				<tr>
					<td>${ detailEmp.empPhone }</td>
				</tr>
				<tr>
					<td>${ detailEmp.empLoc }</td>
				</tr>		
			   </table>
              <!-- /col-md-4 -->
              <table>
              	<tr>
					<td><button>메일쓰기</button></td>
					<td><button>메신저</button></td>
				</tr>
              </table>
              </div>
            </div> 
            <!-- /row -->
          </div>
		</div>
      </section>
      <div id="reservation">
      	<p>회의 일정</p>
      </div>
      
      <!-- /wrapper -->
    </section>
    <!-- /MAIN CONTENT -->
    <!--main content end-->
  <!-- js placed at the end of the document so the pages load faster -->
  <script src="lib/jquery/jquery.min.js"></script>
  <script src="lib/bootstrap/js/bootstrap.min.js"></script>
  <script class="include" type="text/javascript" src="lib/jquery.dcjqaccordion.2.7.js"></script>
  <script src="lib/jquery.scrollTo.min.js"></script>
  <script src="lib/jquery.nicescroll.js" type="text/javascript"></script>
  <!--common script for all pages-->
  <script src="lib/common-scripts.js"></script>
  <!--script for this page-->
 
</body>
</html>