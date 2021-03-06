<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.uni.spring.employee.model.dto.WorkingDay"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%
   WorkingDay w = new WorkingDay();
   
   Date currentTime = new Date();
   SimpleDateFormat format = new SimpleDateFormat("yyyy년 MM월 dd일 a hh:mm:ss");
   
%>
<!DOCTYPE html>
<html>
<head>
  <!-- Favicons -->
  <link rel="icon" type="image/png" href="resources/img/favicon.ico">
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta name="description" content="">
  <meta name="author" content="Dashboard">
  <meta name="keyword" content="Dashboard, Bootstrap, Admin, Template, Theme, Responsive, Fluid, Retina">
  <title>Dashio - Bootstrap Admin Template</title>

  <!-- 부트스트랩 아이콘 CDN -->
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css">
  <!-- Favicons -->
  <link href="resources/img/favicon.png" rel="icon">
  <link href="resources/img/apple-touch-icon.png" rel="apple-touch-icon">

  <!-- Bootstrap core CSS -->
  <link href="resources/lib/bootstrap/css/bootstrap.min.css" rel="stylesheet">
  <!--external css-->
  <link href="resources/lib/font-awesome/css/font-awesome.css" rel="stylesheet" />
  <link rel="stylesheet" type="text/css" href="resources/css/zabuto_calendar.css">
  <link rel="stylesheet" type="text/css" href="resources/lib/gritter/css/jquery.gritter.css" />
  <!-- Custom styles for this template -->
  <link href="resources/css/style.css" rel="stylesheet">
  <link href="resources/css/style-responsive.css" rel="stylesheet">
  <script src="resources/lib/chart-master/Chart.js"></script>

  <style>
   #main-content{
      color:black;
   }
   body{ }
   #approverTable>tbody>tr>td{
      height:35px;
   }
   .workCheck{
      margin-left:60px;
   }
   
   body{
      background:white;
      position:relative;
   }
    .innerOuter{
       position:absolute;
       margin: 80px 0 0 150px;
       background-color : black;
       color : #eee;
    }
    .off{
        display : none;
    }
</style>
</head>

<body>
   <c:if test = "${ !empty msg }">
      <script>
         alert("${msg}");
      </script>
      <c:remove var="msg" scope="session"/>
   </c:if>
  <section id="container">
    <!-- **********************************************************************************************************************************************************
        TOP BAR CONTENT & NOTIFICATIONS
        *********************************************************************************************************************************************************** -->
    <!--header start-->
    <header class="header black-bg">
      <div class="sidebar-toggle-box">
        <div class="fa fa-bars tooltips" data-placement="right" data-original-title="Toggle Navigation"></div>
      </div>
      <!--logo start-->
      <a href="main.do" class="logo"><b>개발웍스</b></a>
      <!--logo end-->
      <div class="nav notify-row" id="top_menu">
        <!--  notification start -->
        <ul class="nav top-menu">
          <!-- inbox dropdown start-->
          <li id="header_inbox_bar" class="dropdown">
            <a data-toggle="dropdown" class="dropdown-toggle" onclick="mailList();">
              <i class="fa fa-envelope-o"></i>
              <span class="badge bg-theme">${unread }</span>
              </a>
            <ul class="dropdown-menu extended inbox">
              <div class="notify-arrow notify-arrow-green"></div>
              <li>
                <p class="green">You have ${unread } new messages</p>
              </li>
              <li>
                 <table id="mainMailList">

                  </table>
              </li>
              <li>
                <a href="receiveMail.do">See all messages</a>
              </li>
            </ul>
            <script>
            function mailList(){
               $.ajax({
                  url:"mainMailList.do",
                  success:function(list){
                     var result ="";
                     if(list.length < 0){
                        result += "<tr><td>새로운 메일이 없습니다.</td></tr>"
                     }else{
                        $.each(list, function(i, obj) {
                           if(obj.employee.empPfe == null){
                              result += "<tr>"
                                 +      "<td>"
                                 +      "<a href='detailReceiveMail.do?mno="+obj.receiveNo+"'>"
                                 +      "<span class='photo'><img class='img-circle' src='resources/img/user.png' width='20px'></span>"
                         }else{
                            result += "<tr>"
                                 +      "<td>"
                                 +      "<a href='detailReceiveMail.do?mno="+obj.receiveNo+"'>"
                                 +      "<span class='photo'><img class='img-circle' src='resources/empUpload_files/"+obj.employee.empPfe+"' width='25px'></span><br><br>"
                         }
                           result += "<span class='subject'>"
                                   + "<span class='from' style='width:30px'>"+ obj.employee.empName +"</span>"
                                 + "<span class='time'>"+ obj.timestamp + "</span>"
                                 + "</span>"
                                      + "<span class='message'>"+ obj.mail.mailTitle +"</span>"
                                      +   "</a>"
                                      +  "</td>"
                                      + "</tr>"
                        })
                     }
                     $("#mainMailList").html(result);
                  }
               })
            } 
               
            </script>
          </li>
          <!-- notification dropdown end -->
        </ul>
        <!--  notification end -->
      </div>
      <div class="top-menu">
        <ul class="nav pull-right top-menu">
          <li><a class="logout" href="logout.do">Logout</a></li>
        </ul>
      </div>
    </header>
    <!--header end-->
    <!-- **********************************************************************************************************************************************************
        MAIN SIDEBAR MENU
        *********************************************************************************************************************************************************** -->
    <!--sidebar start-->
    <aside>
      <div id="sidebar" class="nav-collapse ">
        <!-- sidebar menu start-->
        <ul class="sidebar-menu" id="nav-accordion">
             <c:if test="${ empInfo.empPfe eq null}">
                  <p class="empImg centered"><img src="resources/img/user.png" class="img-circle" width="80"></p>
            </c:if>
            <c:if test="${ !empty empInfo.empPfe }">
                <p class="empImg centered"><img src="resources/empUpload_files/${empInfo.empPfe}" class="img-circle" width="80"></p>
            </c:if>
            
          <h5 class="centered">${ sessionScope.loginUser.empName }</h5>
          <button type="button" class="workCheck btn btn-primary" data-toggle="modal" data-target="#workcheck" onclick="checkTime(); todayCheck();" >출퇴근 확인</button>

		  <!-- admin일 경우 관리 메뉴 보임 -->
		  <c:if test="${ sessionScope.loginUser.empId eq 'admin' }">
          <li class="sub-menu">
            <a href="views/javascript:;">
              <i class="fa fa-book"></i>
              <span>인사관리</span>
              </a>
            <ul class="sub">
              <li><a href="enterpriseChart.do">근무통계</a></li>
              <li><a href="jobManage.do">직위/직무관리</a></li>
              <li><a href="listEmp.do">임직원 관리</a></li>
            </ul>
          </li>
          </c:if>
          <li class="sub-menu">
            <a href="views/javascript:;">
              <i class="fa fa-folder-open"></i>
              <span>인사/근태</span>
              </a>
            <ul class="sub">
              <li><a href="myPage.do">내 인사정보</a></li>
              <li><a href="workingInfo.do">내 근태 현황</a></li>
              <li><a href="timeOff.do">내 연차 내역</a></li>
              <li><a href="organizationChart.do">조직도</a></li>
              <li><a href="empAddress.do">주소록</a></li>
            </ul>
          </li>
          <li class="sub-menu">
            <a href="views/javascript:;">
              <i class="bi bi-pencil-square"></i>
              <span>결재</span>
              </a>
            <ul class="sub">
              <li><a href="approvalList.do">결재 신청</a></li>
              <li><a href="listOutbox.do?userNo=${ sessionScope.loginUser.empNo }">결재 상신함</a></li>
              <li><a href="listInbox.do?userNo=${ sessionScope.loginUser.empNo }">결재 수신함</a></li>
              <li><a href="listReturn.do?userNo=${ sessionScope.loginUser.empNo }">결재 반려함</a></li>
            </ul>
          </li>
          <li class="sub-menu">
            <a href="views/javascript:;">
              <i class="fa fa-envelope"></i>
              <span>메일</span>&nbsp;&nbsp;&nbsp;&nbsp;
                 <c:if test="${unread ne 0 }" >
                 <span class="badge bg-success">${unread}</span>
                 </c:if>
              </a>
            <ul class="sub">
              <li><a href="writeMail.do">메일 작성</a></li>
              <li><a href="receiveMail.do">받은 메일함</a></li>
              <li><a href="sendMail.do">보낸 메일함</a></li>
              <li><a href="deleteMail.do">휴지통</a></li>
            </ul>
          </li>
          <li class="sub-menu">
            <a href="views/javascript:;">
              <i class="bi bi-card-list"></i>
              <span>게시판</span>
              </a>
            <ul class="sub">
              <li><a href="listNotice.do">공지사항</a></li>
              <li><a href="anoBoardList.do">익명게시판</a></li>
            </ul>
          </li>
          <li class="sub-menu">
            <a href="views/javascript:;">
              <i class="bi bi-calendar-event"></i>
              <span>예약</span>
              </a>
            <ul class="sub">
              <li><a href="myRezList.do">내 예약 현황</a></li>
              <li><a href="reservMain.do">회의실/비품 예약</a></li>
              <c:if test="${ sessionScope.loginUser.empId eq 'admin' }"><!-- admin일 경우 자원 관리 메뉴 보임 -->
              <li><a href="resourceManage.do">회의실/비품 관리</a></li>
              </c:if>
            </ul>
          </li>
        </ul>
        <!-- sidebar menu end-->
      </div>
    </aside>
    <!--sidebar end-->
  </section>
   <div class="content">
      <br>
      <br>
      <div class="innerOuter off">
            <div id="empOnOff">
              <label for="empOnOff">상태 </label><br>
              	<div>
              		<input type="radio" name="empOnOff" value="O" onclick="changeOnOff(1);" <c:if test ="${loginUser.empOnOff eq 'O'}">checked</c:if>><p class="badge bg-success">온라인</p>
			  	</div>
			  	<div>
             		<input type="radio" name="empOnOff" value="E" onclick="changeOnOff(2);" <c:if test ="${loginUser.empOnOff eq 'E'}">checked</c:if>><p class="badge bg-primary">자리비움</p>&nbsp;
			  	</div>
			  	<div>	
              		<input type="radio" name="empOnOff" value="F" onclick="changeOnOff(3);" <c:if test ="${loginUser.empOnOff eq 'F'}">checked</c:if>><p class="badge">오프라인</p>&nbsp;
           	  	</div>
           </div>
      </div>
      <br>
      <br>
   </div>
   
  <div class="modal fade" id="workcheck" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">

    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">근태 확인</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      
      <div class="modal-body centered">
           <!-- <p>현재 날짜와 시간은 <%= format.format(currentTime) %></p> -->
           <h4 id="today" name="today" value="today" class="card-title mb-3 font-weight-bold"></h4>
           <p id="clock" name="clock" value="clock" style="font-size:40px"></p>
      </div>
      <div class="d-flex" style="font-size: 16px; ">
      <p class="col-6" style="padding:0px;">출근시간</p>   
      <p class="col-6 text-right" name="start" id="start"></p>

     </div>
     <div class="d-flex" style="font-size: 16px">
      <p class="col-6" style="padding:0px;">퇴근시간</p>
      <p class="col-6 text-right" name="finish" id="finish"></p>
     </div>
      <div class="modal-footer">
            <button type="submit" name="status" value="s" id="startBtn" class="btn btn-primary">출근</button>
            <button type="submit" name="status" value="f" id="finishBtn" class="btn btn-primary" disabled>퇴근</button>
           <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
      </div>
    </div>

  </div>
</div>

  <!-- js placed at the end of the document so the pages load faster -->
  <script src="resources/lib/jquery/jquery.min.js"></script>

  <script src="resources/lib/bootstrap/js/bootstrap.min.js"></script>
  <script class="include" type="text/javascript" src="resources/lib/jquery.dcjqaccordion.2.7.js"></script>
  <script src="resources/lib/jquery.scrollTo.min.js"></script>
  <script src="resources/lib/jquery.nicescroll.js" type="text/javascript"></script>
  <script src="resources/lib/jquery.sparkline.js"></script>
  <!--common script for all pages-->
  <script src="resources/lib/common-scripts.js"></script>
  <script type="text/javascript" src="resources/lib/gritter/js/jquery.gritter.js"></script>
  <script type="text/javascript" src="resources/lib/gritter-conf.js"></script>
  <!--script for this page-->
  <script src="resources/lib/sparkline-chart.js"></script>
  <script src="resources/lib/zabuto_calendar.js"></script>
  <script type="text/javascript">
  <!-- 밑에 아저씨 얼굴 나오는 부분 -->
/*     $(document).ready(function() {
      var unique_id = $.gritter.add({
        // (string | mandatory) the heading of the notification
        title: 'Welcome to Dashio!',
        // (string | mandatory) the text inside the notification
        text: 'Hover me to enable the Close Button. You can hide the left sidebar clicking on the button next to the logo.',
        // (string | optional) the image to display on the left
        image: 'resources/img/ui-sam.jpg',
        // (bool | optional) if you want it to fade out on its own or just sit there
        sticky: false,
        // (int | optional) the time you want it to be alive for before fading out
        time: 8000,
        // (string | optional) the class name you want to apply to that specific message
        class_name: 'my-sticky-class'
      });

      return false;
    }); */
  </script>
  <script type="application/javascript">

  /*******상태 표시*******/
  $(function(){

     $(".empImg").click(function(){ //프로필을 클릭하면
        if($(".innerOuter").hasClass("off")){ //상태 라디오버튼이 조회됨
           $(".innerOuter").removeClass("off");
        }else{
           $(".innerOuter").addClass("off");
        }
     })
  })
  //상태 변경할때마다 값 받기
   function changeOnOff(num){
     if(num == 1){
        $('input:radio[name="empOnOff"]:input[value="O"]').prop("checked", true);
     }else if(num == 2){
        $('input:radio[name="empOnOff"]:input[value="E"]').prop("checked", true);           
     }else{
        $('input:radio[name="empOnOff"]:input[value="F"]').prop("checked", true);
     }
     
     var empOnOff = $("input:radio[name='empOnOff']:checked").val();
     console.log(empOnOff);
     
        $.ajax({
           type:"get",
         url:"empOnOff.do",
         data:{empOnOff:empOnOff},
         success:function(result){
            console.log(result);
         },
         error:function(e){
         }
        })
     }
  
  /*******출퇴근*******/
  //서버시간 출력
  var date;
     
  function checkTime() {
      //현재시간
      var currentDate = new Date();

      var clock = document.getElementById("clock");
      var today = document.getElementById("today");

      //요일
      //getDay() : 요일 0~6 일~토요일
      var week = new Array('일', '월', '화', '수', '목', '금', '토');
      var todayWeek = week[currentDate.getDay()];
      //월
      //퇴근시간 체크시 oracle date는 1~9월 앞에 0이 붙음,,이것 때문에 쿼리문에서 에러 오지게남 *퇴근체크
      //모두 String으로 바꾸고 1~9월일 경우 앞에 0을 붙여줌
      function getMonth(){
         var month = currentDate.getMonth()+1;
         return month < 10 ? '0' + month : '' + month;
      }
      //일
      function getDate(){
    	  var day = currentDate.getDate();
          return day < 10 ? '0' + day : '' + day;
      }
      //oooo년oo월oo일(요일)
      var calendar = currentDate.getFullYear()+"년 " + getMonth() + "월 " + getDate() + "일" + " ("+ todayWeek + ")"
      
      var hours = add(currentDate.getHours(), 2);
      var minutes = add(currentDate.getMinutes(), 2);
      var seconds = add(currentDate.getSeconds(), 2);

      clock.innerHTML = hours + ":" + minutes + ":" + seconds;
      today.innerHTML = calendar;
      
      //1초마다 리셋
      date = setTimeout("checkTime()", 1000);

      //시,분,초 자리 수 없거나 한자리일때 0붙이기
      //add(currentDate.gethours(), 2) -> 일의자리가 되거나 없을때(00) 앞에 0을 붙여주도록 return값 재정의
      function add(time, digit) {
          var zero ="";
          time = time.toString(); //숫자를 문자형으로 바꿔주기
          if(time.length < digit) {
              for(i = 0; i < digit - time.length; i++){
                  zero += '0';
              }
          }
          return zero + time;
      }

  }
  
  //모달창 새로고침시 출근시간 값이 보이지 않음, 금일 출,퇴근이 체킹되었는지 확인하는 함수
  function todayCheck() {
       $.ajax({
           url:"startCheck.do",
           type:"get",
           async: false,
           data:{empNo:${loginUser.empNo}},
           success:function(result){
              if(result != "0"){
                 start.innerHTML = "금일 출근이 체크되었습니다.";
                 $("#startBtn").attr('disabled', true);
                 $("#finishBtn").attr('disabled', false);
              }
           },
           error:function(){
              console.log("실패")
           }
        });
       
       $.ajax({
           url:"finishCheck.do",
           type:"get",
           async: false,
           data:{empNo:${loginUser.empNo}},
           success:function(result){
              if(result != "0"){
                 finish.innerHTML = "금일 퇴근이 체크되었습니다.";
                 $("#finishBtn").attr('disabled', true);
              }
           },
           error:function(){
           }
        })
   }

  //출,퇴근 시간 체킹
  var start = document.getElementById("start");
  var finish = document.getElementById("finish");
  var now = document.getElementById("clock");
  var cal = document.getElementById("today");
  //출근
   $(function(){

     $("#startBtn").click(function(){
        //출근 시간 체크!
         clearInterval(date);
        //체크한 시간 출근시간 p태그에 반영!
         start.innerHTML = now.innerHTML;
           console.log(now);
        //서버시간 재가동!
         checkTime();
        
        $("#startBtn").attr('disabled', true)
        alert("출근 완료");
        $("#finishBtn").attr('disabled', false)
        
        var startTime = now.innerHTML;
        localStorage.setItem("startTime", startTime)
        $.ajax({
           url:"workingCheck.do",
           type:"get",
           async: false,
           data:{startTime:startTime,
                 empNo:${loginUser.empNo}
           },
           success:function(result){
           },
           error:function(){
           }
        })

     })
     
     
  })
  
//퇴근
  $(function(){

     $("#finishBtn").click(function(){
        console.log(startTime);
        
        var reCheck = confirm("퇴근 하시겠습니까?");
        
        if(reCheck){
        //퇴근 시간 체크!
         clearInterval(date);
        //체크한 시간 출근시간 p태그에 반영!
         finish.innerHTML = now.innerHTML;
           console.log(now);
        //서버시간 재가동!
         checkTime(); 
         alert("퇴근 완료");
         $("#finishBtn").attr('disabled', true);
        }
        
        var finishTime = now.innerHTML;
        console.log(finishTime);
        var today = cal.innerHTML;
        console.log(today);
        var startTime = start.innerHTML;
        
        console.log(startTime);
        $.ajax({
           url:"leaveCheck.do",
           type:"get",
           async: false,
           data:{finishTime:finishTime,
                 startTime:startTime,
                 today:today,
                 empNo:${loginUser.empNo}
           },
           success:function(result){
           },
           error:function(){
           }
        })
       
     })
     
     
 }) 
  
  </script>
</body>

</html>