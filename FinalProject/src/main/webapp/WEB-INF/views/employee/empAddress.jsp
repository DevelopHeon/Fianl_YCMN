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
        <h3><i class="fa fa-angle-right"></i> Basic Table Examples</h3>
        <div class="row">
          <div class="col-md-11">
            <div class="content-panel">
              <h4><i class="fa fa-angle-right"></i>즐겨찾기</h4>
              <hr>
              	<div class="table-inbox-wrap ">
              	<c:forEach items="${ empLiked }" var="eL">
                <table class="table table-inbox table-hover">
                <thead>
                  <tr>
                  	<th></th>
                    <th>이름</th>
                    <th>아이디</th>
                    <th>직위</th>
                  </tr>
                </thead>
                <tbody>
                  <tr>
                  <td class="inbox-small-cells"><i class="fa fa-star inbox-started"></i></td>
                     <td>${ eL.empName }</td>
                     <td>${ eL.empId}</td>
                     <td>${ eL.posName}</td>
                     <td></td>
                  </tr>
                </tbody>
              </table>
              </c:forEach>
              <c:forEach items="${ list }" var="e">
              <h4><i class="fa fa-angle-right"></i>  ${ e.depName}</h4>
              <hr>
              	<div class="table-inbox-wrap ">
                <table id="address" class="table table-inbox table-hover">
                <thead>
                  <tr>
                  	<th></th>
                    <th>이름</th>
                    <th>아이디</th>
                    <th>직위</th>
                  </tr>
                </thead>
                <tbody>
                  <tr>
                  <!-- <td class="inbox-small-cells"><i class="fa fa-star inbox-started"></i></td>  -->
                  <td class="inbox-small-cells"><i class="fa fa-star"></i></td>
                     <td>${ e.empName }</td>
                     <td id="addressEmpId">${ e.empId}</td>
                     <td>${ e.posName}</td>
                     <td></td>
                  </tr>
                </tbody>
              </table>
              </div>
              </c:forEach>
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
    		var addressEmpId = document.getElementById("addressEmpId").innerHTML;
    
   			$("#address>tbody>tr>td:first-child>.fa").click(function(){
   				if($(this).hasClass("fa-star inbox-started")){
   					$(this).removeClass("inbox-started");
   					
   				}else{
   					$(this).addClass("inbox-started");
   					console.log(addressEmpId); //user01
   					
   					$.ajax({
   					  url:"likedAddress.do",
   					  type:"get",
   					  data:{addressEmpId:addressEmpId},
   					  success:function(result){
   						  console.log(result),
   						  console.log("성공"),
   						  console.log(empLiked)
   					  },
   					  error:function(){
   						  console.log("실패")
   					  }
   				  })
   				}
       		});

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