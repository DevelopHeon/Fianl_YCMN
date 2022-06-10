<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import = "com.uni.spring.schedule.model.dto.Schedule" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>일정</title>

  <!-- Favicons -->
  <link href="img/favicon.png" rel="icon">
  <link href="img/apple-touch-icon.png" rel="apple-touch-icon">
  <!-- Bootstrap core CSS -->
  <link href="lib/bootstrap/css/bootstrap.min.css" rel="stylesheet">
  <!--external css-->
  <link href="lib/font-awesome/css/font-awesome.css" rel="stylesheet" />
  <link href="lib/bootstrap-wysihtml5/bootstrap-wysihtml5.css" rel="stylesheet" />
  <!-- Custom styles for this template -->
  <link href="css/style.css" rel="stylesheet">
  <link href="css/style-responsive.css" rel="stylesheet">
	
	<script>

      document.addEventListener('DOMContentLoaded', function() {
        var calendarEl = document.getElementById('calendar');
        var calendar = new FullCalendar.Calendar(calendarEl, {
          initialView: 'dayGridMonth',// 초기 로드 될때 보이는 캘린더 화면(기본 설정: 달)
          expandRows: true, // 화면에 맞게 높이 재설정       
          slotMinTime: '08:00', // Day 캘린더에서 시작 시간        
          slotMaxTime: '20:00', // Day 캘린더에서 종료 시간        
          // 해더에 표시할 툴바       
          headerToolbar: {          
        	  left: 'prev,next today',          
        	  center: 'title',          
        	  right: 'dayGridMonth,timeGridWeek,timeGridDay,listWeek'
          },
          locale: 'ko',
          navLinks: true, // 날짜를 선택하면 Day 캘린더나 Week 캘린더로 링크        
          editable: true, // 수정 가능?        
          selectable: true, // 달력 일자 드래그 설정가능       
          nowIndicator: true, // 현재 시간 마크        
          dayMaxEvents: true, // 이벤트가 오버되면 높이 제한 (+ 몇 개식으로 표현)
          eventAdd: function(obj) { // 이벤트가 추가되면 발생하는 이벤트         
        	console.log(obj); 
          },       
          eventChange: function(obj) { // 이벤트가 수정되면 발생하는 이벤트         
        	  console.log(obj);       
          },        
          eventRemove: function(obj){ // 이벤트가 삭제되면 발생하는 이벤트         
        	  console.log(obj);      
          },        
          select: function(arg) { // 캘린더에서 드래그로 이벤트를 생성할 수 있다.         
        	  var title = prompt('입력할 일정:');         
          if (title) { //title 값이 있을때, 화면에 calendar.addEvent() json형식으로 일정 추가          
        	  calendar.addEvent({              
        		  title: title,             
        		  start: arg.start,          
        		  end: arg.end,           
        		  allDay: arg.allDay      
        		  })        
        		  }        
          calendar.unselect()   
          },
          eventClick: function(arg){ //있는 일정 클릭시
        	  console.log("***등록된 일정 클릭 ***");
        	  console.log(arg.event);
        	  
        	  if(confirm('Are you sure you want to delete this event?')){
        		  arg.event.remove()
        	  }
          },
          editable: true,
          dayMaxEvents: true,
          events: [ 
    	    <%List<Schedule> scheduleList = (List<Schedule>) request.getAttribute("scheduleList");%>
            <%if (scheduleList != null) {%>
            <%for (Schedule vo : scheduleList) {%>
	            {
	            	title : '<%=vo.getScheduleTitle()%>',
	                start : '<%=vo.getScheduleStart()%>',
	                end   : '<%=vo.getScheduleEnd()%>'
	             },
				<%}
			}%>
				]
        	  //========================ajax 데이터 불러올 부분 ====================//
        	  
        });
        calendar.render();
      });

    </script>
    <style>
  body {
    margin: 40px 10px;
    padding: 0;
    font-family: Arial, Helvetica Neue, Helvetica, sans-serif;
    font-size: 11px;
    height:100%;
  }
  
 
  #calendar {
    max-width: 1400px;
    min-height: 500px;
    margin: 0 auto;
  }
  /*연월*/
  .fc-toolbar-title{
  	color:#000;
  }
  
  /*요일*/
  .fc-col-header-cell-cushion {
	color: #000;
  }
  .fc-col-header-cell-cushion:hover {
	text-decoration: none;
	color:#000;
  }
  /*일자*/
  .fc-daygrid-day-number{
	color: #100;
	font-size:1em;
  }
  
  /*종일제목*/
  .fc-event-title.fc-sticky{
    
  }
  /*more버튼*/ 
  .fc-daygrid-more-link.fc-more-link{
	color: #000;
  }
  /*일정시간*/
  .fc-daygrid-event > .fc-event-time{
	color:#000;
  }
  /*시간제목*/
  .fc-daygrid-dot-event > .fc-event-title{
    color:#000 !important;
  }
  /*가로 줄 - 월달력 종일 or 복수일자*/
  .fc-h-event{
	
  }
  /*세로 줄 - 주달력, 일달력*/
  .fc-v-event{
	
  }
  /*title 옆에 점*/
  .fc-daygrid-event-dot{
	
  }
  /*month/week/day*/
  .fc-button-active{
	border-color: #6D8B74 		!important;
	background-color: #6D8B74 	!important;
	color: #000 				!important;
	font-weight: bold 			!important;
  }
  /*노란버튼*/
  .btn-warning{
  	font-weight: bold;
  }
  /*모달 푸터*/
  .modal-footer{
  	display:inline-block;
  }
  /*일별 시간 */
  .fc-timegrid-slot-label-cushion{
  	color:#000;	
  }
  /* 일정 등록버튼*/
  .add-button{
  	background:#2C3E50;
  	color: white;
  	font-size:20px;
  	height: 60px;
  	border-radius: 5px;
  	width: 250px;
  }
  .row{
  	display:flex;
  	flex-direction: row;
  }
  .main-side{
  	margin-left:10px;
  }
</style>
</head>
<body>
	<jsp:include page="../main.jsp"/>
	
    <!-- **********************************************************************************************************************************************************
        MAIN CONTENT
        *********************************************************************************************************************************************************** -->
    <!--main content start-->
    <!--  -->
    <section id="main-content">
      <section class="wrapper">
        <!-- page start-->
        <div class="row mt">
          <div class="main-side">
          		<button class="add-button" type="button" onclick="click_add()">
          		일정 추가
          		</button>	
          </div>
          <div class="col-sm-11">
              <div id='calendar-container'>
                 <div id='calendar'></div>
              </div>
          </div>
        </div>
      </section>
      <!-- /wrapper -->
    </section>
    <!-- /MAIN CONTENT -->
    <!--main content end-->

    
   <script>
   
   	
   
   
   </script>
  <!-- js placed at the end of the document so the pages load faster -->
  <script src="lib/jquery/jquery.min.js"></script>
  <script src="lib/bootstrap/js/bootstrap.min.js"></script>
  <script class="include" type="text/javascript" src="lib/jquery.dcjqaccordion.2.7.js"></script>
  <script src="lib/jquery.scrollTo.min.js"></script>
  <script src="lib/jquery.nicescroll.js" type="text/javascript"></script>
  <!-- fullcalendar CDN -->  
  <link href='https://cdn.jsdelivr.net/npm/fullcalendar@5.11.0/main.min.css' rel='stylesheet' />  
  <script src='https://cdn.jsdelivr.net/npm/fullcalendar@5.11.0/main.min.js'></script>  
  <!-- fullcalendar 언어 CDN -->  
  <script src='https://cdn.jsdelivr.net/npm/fullcalendar@5.11.0/locales-all.min.js'></script>

  <!--common script for all pages-->
  <script src="lib/common-scripts.js"></script>
  <!--script for this page-->
  <script type="text/javascript" src="lib/bootstrap-wysihtml5/wysihtml5-0.3.0.js"></script>
  <script type="text/javascript" src="lib/bootstrap-wysihtml5/bootstrap-wysihtml5.js"></script>

  <script type="text/javascript">
    //wysihtml5 start

    $('.wysihtml5').wysihtml5();

    //wysihtml5 end
  </script>
</body>
</html>