<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주소록_사원검색</title>
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
          <div class="col-md-11">
            <div class="content-panel">
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
              <br>
              <br>
              <br>
			  <div class="table-inbox-wrap ">
                <table class="address table table-hover">
                <thead>
                  <tr>
                    <th>이름</th>
                    <th>아이디</th>
                    <th>직위</th>
                    <th>부서</th>
                  </tr>
                </thead>
              <c:if test="${ !empty searchEmp}"> 
              <c:forEach items="${ searchEmp }" var="e">
                <tbody>
                  <tr>
                  	 <td style="display:none">${ e.empNo }</td>
                     <td>${ e.empName }</td>
                     <td id="addressEmpId">${ e.empId}</td>
                     <td>${ e.posName}</td>
                     <td>${ e.depName}</td>
                  </tr>
                </tbody>
              </c:forEach>
              </c:if>
              	</table>
              </div>
              <hr>
              <button type="button" onclick="history.back();" class="btn btn-theme02" >뒤로가기</button>
          </div>
          </div>
        </div>
        <!-- row -->
        <div class="row mt">
        </div>        
        <!-- /row -->
      </section>
    </section>
    <script>
	$(function(){
		$(".address>tbody>tr").click(function(){
			var eno = $(this).children().eq(0).text();
			console.log(eno); //http://localhost:8099/spring/
			window.open("http://localhost:8099/spring/detailEmp.do?eno="+eno, "사원 정보", "width=700, height=300")
		})
	})
    </script>
    <!-- /MAIN CONTENT -->
    <!--main content end-->
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