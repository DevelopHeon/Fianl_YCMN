<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.uni.spring.employee.model.dto.Employee"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주소록_사원상세</title>

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
  <!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">


<style>
	#main-content{
		margin: 30px;
	}
	
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
          <div class="col-md-12">
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
               <table class="empDetail table table-inbox">
				<tr>
					<td id="empNo" style="display:none">${ detailEmp.empNo }</td>
					<td>${ detailEmp.empName }</td>
					<c:if test="${detailEmp.empOnOff eq 'O'}">
               			<td><span class="badge bg-success">온라인</span></td>
                	</c:if>
                	<c:if test="${detailEmp.empOnOff eq 'E'}">
               			<td><span class="badge bg-primary">자리비움</span></td>
                	</c:if>
                	<c:if test="${detailEmp.empOnOff eq 'F'}">
               			<td><span class="badge">오프라인</span></td>
                	</c:if>
				</tr>
				<tr>
					<td>${ detailEmp.jobPosition.posName }</td>
					<td>${ detailEmp.department.depName }</td>	
				</tr>
				<tr>
					<td>${ detailEmp.empPhone }</td>
				</tr>
				<c:if test="${!empty detailEmp.empLoc}">
				<tr>
					<td>${ detailEmp.empLoc }</td>
				</tr>
				</c:if>
			   </table>
			   <button type="button" class="btn btn-primary" onclick="writeMail();">메일쓰기</button>
              </div>
            </div> 
            <!-- /row -->
          </div>
		</div>
      </section>
      <br>
      <div id="reservation" style="width:200px; height:200px; background-color:#ddd;">
      	<p>회의 일정</p>
      	<c:if test="${!empty detailEmp.reservation.rezTitle}">
			<p>${ detailEmp.reservation.startTime } ~ ${ detailEmp.reservation.endTime } : ${ detailEmp.reservation.rezTitle }</p>
		</c:if>
      </div>
      
      <!-- /wrapper -->
    </section>
    <!-- /MAIN CONTENT -->
    <!--main content end-->
    <script src="https://code.jquery.com/jquery-3.4.1.js"></script>
    <script>
    	function writeMail(){
  
			var eno = $("#empNo").text();
			console.log(eno);
			window.location.href="writeMail.do?eno="+eno;
    		
    	}

    </script>
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