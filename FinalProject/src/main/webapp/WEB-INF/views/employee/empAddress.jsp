<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
	.content-panel{
		margin-left: 50px;
	}
	#searchBtn{
		display: block;
	}
	.address{
		margin-left:30px;
	}
</style>
</head>

<body>
	<jsp:include page="../main.jsp"/>

    <!-- **********************************************************************************************************************************************************
        MAIN CONTENT
        *********************************************************************************************************************************************************** -->
    <!--main content start-->
    <section id="main-content">
      <section class="wrapper">
        <h3><i class="fa fa-angle-right"></i> 주소록</h3>
        <div class="row">
          <div class="col-md-10">
            <div class="">
				<form action="searchEmp.do" class="pull-left">
                      <div class="input-append">
                        <input type="text" name="search" class="form-control " placeholder="사원 이름 검색">
                        <button id="searchBtn" type="submit" class="btn btn-theme02">검색</button>
                      </div>
                      
                </form>
              <br><br><br><br><br>
              <h4><i class="fa fa-angle-right"></i>개발</h4>
              <hr>
              	<div class="table-inbox-wrap ">
                <table class="address table table-border table-hover">
                <thead>
                  <tr>
                  	<th style="display:none"></th>
                    <th>이름</th>
                    <th>아이디</th>
                    <th>직위</th>
                  </tr>
                </thead>
              <c:forEach items="${ list }" var="e">
              <c:if test="${e.depName eq '개발'}"> 
                <tbody>
                  <tr>
	                 <td style="display:none">${e.empNo }</td>
                     <td>${ e.empName }</td>
                     <td id="addressEmpId">${ e.empId}</td>
                     <td>${ e.posName}</td>
                  </tr>
                </tbody>
              </c:if>
              </c:forEach>
              </table>
              </div>
              <h4><i class="fa fa-angle-right"></i>총무</h4>
              <hr>
              	<div class="table-inbox-wrap ">
                <table class="address table table-border table-hover">
                <thead>
                  <tr>
                  	<th style="display:none"></th>
                    <th>이름</th>
                    <th>아이디</th>
                    <th>직위</th>
                  </tr>
                </thead>
              <c:forEach items="${ list }" var="e">
              <c:if test="${e.depName eq '총무'}"> 
                <tbody>
                  <tr>
	                 <td style="display:none">${e.empNo }</td>
                     <td>${ e.empName }</td>
                     <td id="addressEmpId">${ e.empId}</td>
                     <td>${ e.posName}</td>
                  </tr>
                </tbody>
              </c:if>
              </c:forEach>
              </table>
              </div>
              
              <h4><i class="fa fa-angle-right"></i>인사</h4>
              <hr>
              	<div class="table-inbox-wrap ">
                <table class="address table table-border table-hover">
                <thead>
                  <tr>
                  	<th style="display:none"></th>
                    <th>이름</th>
                    <th>아이디</th>
                    <th>직위</th>
                  </tr>
                </thead>
              <c:forEach items="${ list }" var="e">
              <c:if test="${e.depName eq '인사'}"> 
                <tbody>
                  <tr>
	                 <td style="display:none">${e.empNo }</td>
                     <td>${ e.empName }</td>
                     <td id="addressEmpId">${ e.empId}</td>
                     <td>${ e.posName}</td>
                  </tr>
                </tbody>
              </c:if>
              </c:forEach>
              </table>
              </div>

              <h4><i class="fa fa-angle-right"></i>연수중</h4>
              <hr>
              	<div class="table-inbox-wrap ">
                <table class="address table table-border table-hover">
                <thead>
                  <tr>
                  	<th style="display:none"></th>
                    <th>이름</th>
                    <th>아이디</th>
                    <th>직위</th>
                  </tr>
                </thead>
              <c:forEach items="${ list }" var="e">
              <c:if test="${e.depName eq '연수중'}"> 
                <tbody>
                  <tr>
	                 <td style="display:none">${e.empNo }</td>
                     <td>${ e.empName }</td>
                     <td id="addressEmpId">${ e.empId}</td>
                     <td>${ e.posName}</td>
                  </tr>
                </tbody>
              </c:if>
              </c:forEach>
              </table>
              </div>
          </div>
          </div>
        </div>
        <!-- row -->
        <div class="row mt">
        </div>        
        <!-- /row -->
      </section>
    </section>
    <!-- /MAIN CONTENT -->
    <!--main content end-->
    <script>
    	
    	$(function(){
    		$(".address>tbody>tr").click(function(){
    			var eno = $(this).children().eq(0).text();
    			console.log(eno); //http://localhost:8099/spring/
    			window.open("http://localhost:8099/spring/detailEmp.do?eno="+eno, "사원 정보", "width=550, height=300")
    		})
    	})
    
    </script>
    <!--footer start-->
    <footer class="site-footer">
      <div class="text-center">
        <p>
          &copy; Copyrights <strong>Dashio</strong>. All Rights Reserved
        </p>
        <div class="credits">
          <!--
            You are NOT allowed to delete the credit link to TemplateMag with free version.
            You can delete the credit link only if you bought the pro version.
            Buy the pro version with working PHP/AJAX contact form: https://templatemag.com/dashio-bootstrap-admin-template/
            Licensing information: https://templatemag.com/license/
          -->
          Created with Dashio template by <a href="https://templatemag.com/">TemplateMag</a>
        </div>
        <a href="basic_table.html#" class="go-top">
          <i class="fa fa-angle-up"></i>
          </a>
      </div>
    </footer>
    <!--footer end-->
  </section>
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