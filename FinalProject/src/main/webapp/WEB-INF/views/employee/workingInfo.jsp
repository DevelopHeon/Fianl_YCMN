<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.uni.spring.employee.model.dto.WorkingDay, java.util.ArrayList"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%
	Date currentTime = new Date();
	SimpleDateFormat format = new SimpleDateFormat("M");
	String thisMonth = String.valueOf(currentTime.getMonth()+1);
	String prevM = String.valueOf(currentTime.getMonth());
	ArrayList<WorkingDay> workInfo = (ArrayList)session.getAttribute("workInfo");

%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>myPage</title>

	<!-- Favicons -->
	<link href="resources/img/favicon.png" rel="icon">
	<link href="resources/img/apple-touch-icon.png" rel="apple-touch-icon">
	<!-- CSS -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
	<!-- 테마 -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
	<!-- 자바스크립트 -->
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<style>

 #update {
	margin : 100px; 
 }
</style>
</head>

<body onload="checkMonth();">
	<jsp:include page="../common/menubar.jsp"/>	
<script>
function checkMonth() {
	var currentDate = new Date();
	
	var month = document.getElementsByClassName("month");
	
	var calendar = currentDate.getFullYear() + "년 " + (currentDate.getMonth()+1) +"월"
	//class month가 여러개일때
	for(var i = 0; i < month.length; i++){
		month[i].innerHTML = calendar;
	}

	//이번달 필요 근무 시간
    var start = new Date(2022, 5, 1); // 2022-6-1
    var end = new Date(2022, 5, 30); // 2022-6-30

    var count = 0;

	var thisMonthWork = document.getElementById("thisMonthWork").innerHTML;
	//var a = thisMonthWork.split('시');
	//console.log(a);
	var mw = thisMonthWork.substring(0, thisMonthWork.indexOf('시'))

	while(true) {  
	    var tempDate = start;
	    if(tempDate.getTime() > end.getTime()) { //종료날짜를 넘어가면  break
	        console.log("count : " + count);
	    	var baseWorking = count * 8 //6월 최소 근무량 (주 40시간 기준)
	
	        break;
	    } else {
	        var tmp = tempDate.getDay();
	        if(tmp == 0 || tmp == 6) {
	            // 주말
	            console.log("주말");
	        } else {
	            // 평일
	            console.log("평일");
	            count++;//평일엔 카운트를 더함  
	        }
	        tempDate.setDate(start.getDate() + 1); 
	    }
	}
	
	$("#baseWork").html(baseWorking + " 시간");
	
	var p = (mw / baseWorking) * 100;//이달 근무 퍼센트
	console.log(p.toFixed(2)); //소수점 둘째자리까지
	$("#bar").html(p.toFixed(2)+"%");
	
	//근무 상태에 보일 퍼센트 바(bar)
	$(document).ready(function(){
		
		document.getElementById("bar").style.width = p.toFixed(2) + "%";
	})
	
	//잔여 근무시간
	
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
             <div>
             <!-- <a id="prev"><i class="fa fa-chevron-left centered" style="font-size:25px"></i></a> -->
             <h2 id="thisM" class="centered"><%=format.format(currentTime) %>월</h2>
             <!-- <a id="next"><i class="fa fa-chevron-right centered" style="font-size:25px"></i></a>  -->
             
             </div>
              <table class="table centered">
             	<tr>
             	  <td width="300"><label class="month"></label> 누적 근무 시간</td>
             	  <td width="300"><label class="month"></label> 필요 근무 시간</td>
             	  <td width="300"><label class="month"></label> 근무 상태</td>
             	</tr>
             	<tr>
             	  <td id="thisMonthWork" width="300">${weekTotal }</td>
             	  <td id="baseWork" width="300"></td>
             	  <td width="300">
             	  	<div class="progress progress-striped active">
                		<div id="bar" class="progress-bar" role="progressbar" aria-valuenow="90" aria-valuemin="0" aria-valuemax="100">
                		</div>
              		</div>
              	  </td>
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
		             			<td style="display:none">${w.thisWeek }</td>
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
    <script>
    	$(function(){
    		var thisM = document.getElementById("thisM").innerHTML;
    		var currentDate = new Date();   		
    		var prevM = (currentDate.getMonth()) +"월"
    		var nextM = currentDate.getMonth()+2 + "월"
    		
    		$("#prev").click(function(){
    			console.log(thisM);
    			$("#thisM").html(prevM);
    		})
    		
    		$("#next").click(function(){
    			console.log(thisM);
    			$("#thisM").html(nextM);
    		})
    		
    	})
    	
    </script>
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