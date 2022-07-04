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

	.updown{
		display:none;
	}
	.on { visibility: visible; }
</style>
</head>

<body>
	<jsp:include page="../common/menubar.jsp"/>	

    <!-- **********************************************************************************************************************************************************
        MAIN CONTENT
        *********************************************************************************************************************************************************** -->
    <!--main content start-->
    <section id="main-content">
      <section class="wrapper">
        <h3><i class="fa fa-angle-right"></i> 주소록</h3>
        <div class="row">
          <div class="col-md-10">
			<form action="searchEmp.do" class="pull-left">
				<table>
					<tr>
						<td>
							<input type="text" name="search" class="form-control" placeholder="사원 이름 검색">
						</td>
						<td>
							<button id="searchBtn" type="submit" class="btn btn-outline-secondary btn-theme02">검색</button>  
						</td>
					</tr>
				</table>
             </form>
              <br><br><br>
              <h3 class="depName1"><i class="fa fa-angle-right"></i> 총무부서</h3>
              <hr>
              	<div class="updown table-inbox-wrap1">
                <table class="address table table-border table-hover centered">
                <thead>
                  <tr>
                  	<th>사번</th>
                    <th>이름</th>
                    <th>아이디</th>
                    <th>직위</th>
                  </tr>
                </thead>
              <c:forEach items="${ list }" var="e">
              <c:if test="${e.depName eq '총무부서'}"> 
                <tbody>
                  <tr>
	                 <td>${e.empNo }</td>
                     <td>${ e.empName }</td>
                     <td id="addressEmpId">${ e.empId}</td>
                     <td>${ e.posName}</td>
                  </tr>
                </tbody>
              </c:if>
              </c:forEach>
              </table>
              </div>
              
              <h3 class="depName2"><i class="fa fa-angle-right"></i> 인사부서</h3>
              <hr>
              	<div class="updown table-inbox-wrap2">
                <table class="address table table-border table-hover centered">
                <thead>
                  <tr>
                  	<th>사번</th>
                    <th>이름</th>
                    <th>아이디</th>
                    <th>직위</th>
                  </tr>
                </thead>
              <c:forEach items="${ list }" var="e">
              <c:if test="${e.depName eq '인사부서'}"> 
                <tbody>
                  <tr>
	                 <td>${e.empNo }</td>
                     <td>${ e.empName }</td>
                     <td id="addressEmpId">${ e.empId}</td>
                     <td>${ e.posName}</td>
                  </tr>
                </tbody>
              </c:if>
              </c:forEach>
              </table>
              </div>
              
              <h3 class="depName3"><i class="fa fa-angle-right"></i> 개발부서</h3>
              <hr>
              	<div class="updown table-inbox-wrap3">
                <table class="address table table-border table-hover centered">
                <thead>
                  <tr>
                  	<th>사번</th>
                    <th>이름</th>
                    <th>아이디</th>
                    <th>직위</th>
                  </tr>
                </thead>
              <c:forEach items="${ list }" var="e">
              <c:if test="${e.depName eq '개발부서'}"> 
                <tbody>
                  <tr>
	                 <td>${e.empNo }</td>
                     <td>${ e.empName }</td>
                     <td id="addressEmpId">${ e.empId}</td>
                     <td>${ e.posName}</td>
                  </tr>
                </tbody>
              </c:if>
              </c:forEach>
              </table>
              </div>

              <h3 class="depName4"><i class="fa fa-angle-right"></i> 영업부서</h3>
              <hr>
              	<div class="updown table-inbox-wrap4">
                <table class="address table table-border table-hover centered">
                <thead>
                  <tr>
                  	<th>사번</th>
                    <th>이름</th>
                    <th>아이디</th>
                    <th>직위</th>
                  </tr>
                </thead>
              <c:forEach items="${ list }" var="e">
              <c:if test="${e.depName eq '영업부서'}"> 
                <tbody>
                  <tr>
	                 <td>${e.empNo }</td>
                     <td>${ e.empName }</td>
                     <td id="addressEmpId">${ e.empId}</td>
                     <td>${ e.posName}</td>
                  </tr>
                </tbody>
              </c:if>
              </c:forEach>
              </table>
              </div>
              
               <h3 class="depName5"><i class="fa fa-angle-right"></i> 연구부서</h3>
              <hr>
              	<div class="updown table-inbox-wrap5">
                <table class="address table table-border table-hover centered">
                <thead>
                  <tr>
                  	<th>사번</th>
                    <th>이름</th>
                    <th>아이디</th>
                    <th>직위</th>
                  </tr>
                </thead>
              <c:forEach items="${ list }" var="e">
              <c:if test="${e.depName eq '연구부서'}"> 
                <tbody>
                  <tr>
	                 <td>${e.empNo }</td>
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
    		
    		
    		$(".depName1").on("click",function(){
    			var obj = $(".table-inbox-wrap1");

				if(obj.hasClass("on")){
					obj.removeClass("on").slideUp();
       			  }else{
       				obj.addClass("on").slideDown();
       			  }
    			});
    		$(".depName2").on("click",function(){
    			var obj = $(".table-inbox-wrap2");

				if(obj.hasClass("on")){
					obj.removeClass("on").slideUp();
       			  }else{
       				obj.addClass("on").slideDown();
       			  }
    			});
    		$(".depName3").on("click",function(){
    			var obj = $(".table-inbox-wrap3");

				if(obj.hasClass("on")){
					obj.removeClass("on").slideUp();
       			  }else{
       				obj.addClass("on").slideDown();
       			  }
    			});
    		$(".depName4").on("click",function(){
    			var obj = $(".table-inbox-wrap4");

				if(obj.hasClass("on")){
					obj.removeClass("on").slideUp();
       			  }else{
       				obj.addClass("on").slideDown();
       			  }
    			});
    		
    		$(".depName5").on("click",function(){
    			var obj = $(".table-inbox-wrap5");

				if(obj.hasClass("on")){
					obj.removeClass("on").slideUp();
       			  }else{
       				obj.addClass("on").slideDown();
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