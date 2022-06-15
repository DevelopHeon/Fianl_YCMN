<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import = "com.uni.spring.schedule.model.dto.Schedule" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>일정</title>
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.css" integrity="sha512-3pIirOrwegjM6erE5gPSwkUzO+3cTjpnV9lexlNZqvupR64iZBnOOTiiLPb9M36zpMScbmUNIcHUqKD47M719g==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js" integrity="sha512-VEd+nq25CkR676O+pLBnDW09R7VQX9Mdiij052gVCp5yVH3jGtH70Ho/UUv4mJDsEdTvqRCFZg0NKGiojGnUCw==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
	<script>
	// toastr 설정
	toastr.options = {
		"closeButton" : true,
		"debug" : false,
		"newestOnTop" : true,
		"progressBar" : true,
		"positionClass" : "toast-top-right",
		"preventDuplicates" : false,
		"onclick" : null,
		"showDuration" : "300",
		"hideDuration" : "1000",
		"timeOut" : "1000",
		"extendedTimeOut" : "1000",
		"showEasing" : "swing",
		"hideEasing" : "linear",
		"showMethod" : "fadeIn",
		"hideMethod" : "fadeOut"
	}
	// Sweet Alert 설정
	var alert = function(msg, type) {
		swal({
			title : '',
			text : msg,
			type : type,
			timer : 1500,
			customClass : 'sweet-size',
			showConfirmButton : false
		});
	}
	var confirm = function(msg, title, resvNum) {
		swal({
			title : title,
			text : msg,
			type : "warning",
			showCancelButton : true,
			confirmButtonClass : "btn-danger",
			confirmButtonText : "예",
			cancelButtonText : "아니오",
			closeOnConfirm : false,
			closeOnCancel : true
		}, function(isConfirm) {
			if (isConfirm) {
				location.href = "LogoutProc.do";
			}
		});
	}
	var cancelConfirm = function(msg, title, param) {
		swal(
				{
					title : title,
					text : msg,
					html : true,
					type : "warning",
					showCancelButton : true,
					confirmButtonClass : "btn-danger",
					confirmButtonText : "예",
					cancelButtonText : "아니오",
					closeOnConfirm : false,
					closeOnCancel : true
				}, function(isConfirm) {
					if (isConfirm) {
						deleteEvent(param);
					}
				});
	}
	function Alert(msg) {
		alert(msg, 'success');
	}
	function Confirm(msg) {
		confirm('', msg);
	}
	function CancelConfirm(msg, param) {
		cancelConfirm('', msg, param);
	}

		
		//페이지 로딩과 동시에 함수 호출
		$(function(){
			getEventsList();
		});
		
		// 일정 데이터 가져오기
		function getEventsList() {
			$.ajax({
				type : "post",
				url : "GetScheduleList.do",
				success : function(data) {
					
					var list = data;
					console.log(list);
					var events = list.map(function(item) {
						return {
							id : item.scheduleNo,
							title : item.scheduleTitle,
							start : item.scheduleStart,
							end : item.scheduleEnd
						}
					});
					getCalendar(events);
				},
				error : function(data) {
					alert("시스템 에러 발생!");
				}
			});
		}
		
		// fullcalendar 불러오기
		function getCalendar(events) {
			var calendarEl = document.getElementById('calendar');
			var calendar = new FullCalendar.Calendar(calendarEl, {
				initialView : 'dayGridMonth',// 초기 로드 될때 보이는 캘린더 화면(기본 설정: 달)
				// 해더에 표시할 툴바       
				headerToolbar : {
					left : 'prev,next today',
					center : 'title',
					right : 'dayGridMonth,timeGridWeek,timeGridDay'
				},
				locale : 'ko', //사용 언어
				dayMaxEvents : true, // 이벤트가 오버되면 높이 제한 (+ 몇 개식으로 표현)
				height : 930,
				editable : true,// 수정 가능?   
				dayMaxEventRows : true,
				eventDidMount: function(info) {
		            tippy(info.el, {
		                content:  info.event.extendedProps.description,//이벤트 디스크립션을 툴팁으로 가져온다 
		            });
		        },
				events : events,
				eventTimeFormat : { // '14:30:00' 형태로 만들기
					hour : '2-digit',
					minute : '2-digit',
					hour12 : false
				},
				eventClick : function(info) {
					CancelConfirm("일정을 삭제하시겠습니까?", info);
				}
			});
			calendar.render();
		}
		// 종료일 input 최소값(시작일) 속성 변경
		function setEndMin() {
			var startdate = $("#scStart").val();
			$("#scEnd").attr("min", startdate);
		}
		// 일정 등록하기
		function whatTime(empId) {
			// 시작일 + 시간 형태 설정
			var startTime = $("#scStart").val();
			if ($(".timer").val() != "" && $(".timer").val() != null) {
				startTime = $("#scStart").val() + "T" + $(".timer").val()
						+ ":00";
			}
			var schInfo = {
				sc_title : $("#scTitle").val(),
				sc_start : startTime,
				sc_end : $("#scEnd").val(),
				emp_id : empId
			}
			if (startTime == "" || startTime == null) {
				toastr.warning("시작일을 입력해주세요");
				$("#scStart").focus();
				return false;
			} else if ($("#scTitle").val() == "" || $("#scTitle").val() == null) {
				toastr.warning("일정내용을 입력해주세요");
				$("#scTitle").focus();
				return false;
			} else {
				$.ajax({
					type : "post",
					url : "InsertSchedule.do",
					data : JSON.stringify(schInfo),
					contentType : "application/json; charset=utf-8",
					dataType : "json",
					success : function(data) {
						if (data.result > 0) {
							window.location.reload();
						} else {
							toastr.warning("일정을 추가할 수 없습니다");
						}
					},
					error : function(data) {
						alert("시스템 에러 발생!");
					}
				});
			}
		}
		
		// 일정 삭제하기
		function deleteEvent(info) {
			info.event.remove(); // 캘린더상에서 이벤트 삭제하기
			
			var schInfo = {sc_id : info.event.id}
			
			$.ajax({
				type : "post",
				url : "DeleteSchedule.do",
				data : JSON.stringify(schInfo),
				contentType : "application/json; charset=utf-8",
				dataType : "json",
				success : function(data) {
					if (data.result > 0) {
						window.location.reload();
					} else {
						toastr.warning("일정을 삭제할 수 없습니다");
					}
				},
				error : function(data) {
					alert("시스템 에러 발생!");
				}
			});
		}

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
  	padding : 20px 0;
  	text-align: center;
  }
  
  .form-control {
	margin-bottom: 10px;
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
          	<div class="col-12 scheduleForm">
          		<input type="text" name="scheduletitle" id="sctitle" class = "form-control form-control-sm text-center mb-1" placeholder = "일정제목">
      			<input type="datetime-local" name="scheduleStart" id="scstart" class= "form-control form-control-sm text-center mb-1" placeholder="시작일" autocomplete="off">
      			<input type="datetime-local" name="scheduleEnd" id="scend" class= "form-control form-control-sm text-center mb-1" placeholder="종료일" autocomplete="off">
         		
          		
          		
          		<div class=add-button>
          			<a onclick="whatTime('${empInfo.emp }')">일정 추가</a>
          		</div>	
          	</div>
          		
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
  
  <!-- fullcalendar CDN -->  
  <link href='https://cdn.jsdelivr.net/npm/fullcalendar@5.11.0/main.min.css' rel='stylesheet' />  
  <script src='https://cdn.jsdelivr.net/npm/fullcalendar@5.11.0/main.min.js'></script>  
  <!-- fullcalendar 언어 CDN -->  
  <script src='https://cdn.jsdelivr.net/npm/fullcalendar@5.11.0/locales-all.min.js'></script>

  
</body>
</html>