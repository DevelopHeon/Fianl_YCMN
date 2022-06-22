<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.uni.spring.employee.model.dto.WorkingDay"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>

<%

	Date currentTime = new Date();
	SimpleDateFormat format = new SimpleDateFormat("MM/dd");
	
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>myPage</title>

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

 #update {
	margin : 100px; 
 }
</style>
</head>

<body onload="checkMonth()">
	<jsp:include page="../main.jsp"/>
<script>
function checkMonth() {
	var currentDate = new Date();
	
	var month = document.getElementsByClassName("month");
	
	var calendar = currentDate.getFullYear() + "년 " + (currentDate.getMonth()+1) +"월"
	//class month가 여러개일때
	for(var i = 0; i < month.length; i++){
		month[i].innerHTML = calendar;
	}
	
}

</script>
    <!-- **********************************************************************************************************************************************************
        MAIN CONTENT
        *********************************************************************************************************************************************************** -->
    <!--main content start-->
    <section id="main-content">
      <section class="wrapper site-min-height">
        <div class="row mt">
          <div class="col-lg-12">
            <div class="row content-panel">
            <!-- /col-md-4 -->
             <div><h2 class="month"></h2></div>
             <table>
             	<tr>
             	  <td width="300"><label class="month"></label> 누적 근무</td>
             	  <td width="300"><label class="month"></label> 잔여 근무</td>
             	  <td width="300"><label class="month"></label> 연장 근무</td>
             	</tr>
             	<tr>
             	  <td width="300"></td>
             	  <td width="300"></td>
             	  <td width="300"></td>
             	</tr>
             </table>
             
            </div> 
            <!-- /row -->
          </div>

          <!-- /col-lg-12 -->
          <div class="col-lg-12 mt content-panel">
            <div class="row">
              <div class="panel-heading">
              
                <ul class="nav nav-tabs nav-justified">           
                  <li class="active">
                    <a data-toggle="tab" href="#1week">1주차</a>
                  </li>
                  <li>
                    <a data-toggle="tab" href="#2week">2주차</a>
                  </li>
                  <li>
                    <a data-toggle="tab" href="#3week">3주차</a>
                  </li>
                  <li>
                    <a data-toggle="tab" href="#4week">4주차</a>
                  </li>
                  <li>
                    <a data-toggle="tab" href="#5week">5주차</a>
                  </li>
                </ul>
                
              </div>
              <!-- /panel-heading -->

             </div>
             <!-- /tab-content -->
           	
              <!-- /panel-body -->
              <div class="panel-body">
                <div class="tab-content">
                
                  <div id="1week" class="tab-pane">
                    <div class="row">
		             	<table class="table centered">
		             		<tr>
	             				<td width="80">날짜</td>
	             				<td width="150">출근시간</td>
	             				<td width="150">퇴근시간</td>
	           					<td width="150">근무상태</td>	
	             				<td width="150">총 근무시간</td>
		             		</tr>
			        <c:forEach items="${working}" var="w">
                	<c:if test= "${w.thisWeek eq 1}">
		             		<tr>
		             			<td>${w.today }</td>
		             			<td>${w.startTime }</td>
		             			<td>${w.finishTime }</td>
		             		<c:if test="${w.status eq 'L' }">
		             			<td>지각</td>
		             		</c:if>
		             		<c:if test="${w.status eq 'Y' }">
		             			<td>정상</td>
		             		</c:if>
		             		<c:if test="${w.status eq 'E' }">
		             			<td>조퇴</td>
		             		</c:if>
		             		<c:if test="${w.status eq 'N' }">
		             			<td>결근</td>
		             		</c:if>
		             			<td>${w.workHour }</td>
		             		</tr>
		            </c:if>
                  	</c:forEach>
			             </table>
                     </div>
                  	</div> 
                 
                  	<div id="2week" class="tab-pane">
                    <div class="row">
		             	<table class="table centered">
		             		<tr>
		             			<td width="80">날짜</td>
		             			<td width="150">출근시간</td>
		             			<td width="150">퇴근시간</td>
		             			<td width="150">근무상태</td>
		             			<td width="150">총 근무시간</td>
		             		</tr>
		            <c:forEach items="${working}" var="w">
                    <c:if test="${w.thisWeek eq 2}">
		             		<tr>
		             			<td>${w.today }</td>
		             			<td>${w.startTime }</td>
		             			<td>${w.finishTime }</td>
		             		<c:if test="${w.status eq 'L' }">
		             			<td>지각</td>
		             		</c:if>
		             		<c:if test="${w.status eq 'Y' }">
		             			<td>정상</td>
		             		</c:if>
		             		<c:if test="${w.status eq 'E' }">
		             			<td>조퇴</td>
		             		</c:if>
		             		<c:if test="${w.status eq 'N' }">
		             			<td>결근</td>
		             		</c:if>
		             			<td>${w.workHour }</td>
		             		</tr>
		             </c:if>
                  	</c:forEach> 
		             	</table>
                    </div>
                  	</div>


                  	<div id="3week" class="tab-pane">
                    <div class="row">
			             <table class="table centered">
		             		<tr>
		             			<td width="80">날짜</td>
		             			<td width="150">출근시간</td>
		             			<td width="150">퇴근시간</td>
		             			<td width="150">근무상태</td>
		             			<td width="150">총 근무시간</td>
		             		</tr>
		            <c:forEach items="${working}" var="w">
                    <c:if test="${w.thisWeek eq 3}">
		             		<tr>
		             			<td>${w.today }</td>
		             			<td>${w.startTime }</td>
		             			<td>${w.finishTime }</td>
			             		<c:if test="${w.status eq 'L' }">
		             			<td>지각</td>
		             		</c:if>
		             		<c:if test="${w.status eq 'Y' }">
		             			<td>정상</td>
		             		</c:if>
		             		<c:if test="${w.status eq 'E' }">
		             			<td>조퇴</td>
		             		</c:if>
		             		<c:if test="${w.status eq 'N' }">
		             			<td>결근</td>
		             		</c:if>
		             			<td>${w.workHour }</td>
		             		</tr>
		           	</c:if>
                  	</c:forEach>
		             	</table>
                    </div>
                  	</div>
                  	
                  	<div id="4week" class="tab-pane">
                    <div class="row">
			            <table class="table centered">
		             		<tr>
		             			<td width="80">날짜</td>
		             			<td width="150">출근시간</td>
		             			<td width="150">퇴근시간</td>
		             			<td width="150">근무상태</td>
		             			<td width="150">총 근무시간</td>
		             		</tr>
		            <c:forEach items="${working}" var="w">
                    <c:if test="${w.thisWeek eq 4}">
		             		<tr>
		             			<td>${w.today }</td>
		             			<td>${w.startTime }</td>
		             			<td>${w.finishTime }</td>
		             		<c:if test="${w.status eq 'L' }">
		             			<td>지각</td>
		             		</c:if>
		             		<c:if test="${w.status eq 'Y' }">
		             			<td>정상</td>
		             		</c:if>
		             		<c:if test="${w.status eq 'E' }">
		             			<td>조퇴</td>
		             		</c:if>
		             		<c:if test="${w.status eq 'N' }">
		             			<td>결근</td>
		             		</c:if>
		             			<td>${w.workHour }</td>
		             		</tr>
		             </c:if>
                  	 </c:forEach>		
		             	</table>
                    </div>
                  	</div>

                  	<div id="5week" class="tab-pane">
                    <div class="row">
			            <table class="table centered">
		             		<tr>
		             			<td width="80">날짜</td>
		             			<td width="150">출근시간</td>
		             			<td width="150">퇴근시간</td>
		             			<td width="150">근무상태</td>		             			
		             			<td width="150">총 근무시간</td>
		             		</tr>
		            <c:forEach items="${working}" var="w">
                    <c:if test="${w.thisWeek eq 5}">
		             		<tr>
		             			<td>${w.today }</td>
		             			<td>${w.startTime }</td>
		             			<td>${w.finishTime }</td>
		             		<c:if test="${w.status eq 'L' }">
		             			<td>지각</td>
		             		</c:if>
		             		<c:if test="${w.status eq 'Y' }">
		             			<td>정상</td>
		             		</c:if>
		             		<c:if test="${w.status eq 'E' }">
		             			<td>조퇴</td>
		             		</c:if>
		             		<c:if test="${w.status eq 'N' }">
		             			<td>결근</td>
		             		</c:if>
		             			<td>${w.workHour }</td>
		             		</tr>
		            </c:if>
		            <!-- <c:if test="${w.thisWeek ne null}">
		             		<tr>
		             			<td colspan="4">근태 기록이 없습니다.</td>
		             		</tr>
		            </c:if> -->
                  	</c:forEach>

		             	</table>
                    </div>
                  	</div>
            </div>
            <!-- /col-lg-12 -->
          </div>
          <!-- /row -->
          </div>
        </div>
        <!-- /container -->
      </section>
      <!-- /wrapper -->
    </section>
    <!-- /MAIN CONTENT -->
    <!--main content end-->
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
        <a href="profile.html#" class="go-top">
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
  <!-- MAP SCRIPT - ALL CONFIGURATION IS PLACED HERE - VIEW OUR DOCUMENTATION FOR FURTHER INFORMATION -->
  <script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?key=AIzaSyASm3CwaK9qtcZEWYa-iQwHaGi3gcosAJc&sensor=false"></script>
</body>
</html>