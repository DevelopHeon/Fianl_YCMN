<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<jsp:useBean id="date" class="java.util.Date" />
<fmt:formatDate var="nowTime" value="${date}" pattern="YYYY-MM-dd'T'HH:mm:ss" />
<!DOCTYPE html>
<html>

<head>
<meta charset='utf-8' />
<title>회의실/비품 예약</title>
<!-- 화면 해상도에 따라 글자 크기 대응(모바일 대응) -->
<meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no">
<!-- jquery CDN -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<!-- fullcalendar bootstrap -->
<link href='https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css' rel='stylesheet'>
<link href='https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css' rel='stylesheet'>
<!-- fullcalendar CDN -->
<link href='https://cdn.jsdelivr.net/combine/npm/fullcalendar@5.11.0/main.min.css,npm/fullcalendar@5.11.0/main.min.css' rel='stylesheet' />
<script src='https://cdn.jsdelivr.net/combine/npm/fullcalendar@5.11.0/main.min.js,npm/fullcalendar@5.11.0'></script>
<!-- fullcalendar 언어 CDN -->
<script src='https://cdn.jsdelivr.net/npm/fullcalendar@5.11.0/locales-all.min.js'></script>
<!-- moment.js -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.3/moment.min.js"></script>
<script>
document.addEventListener('DOMContentLoaded', function () {
    $(function () {
      var request = $.ajax({
        url: "reserveList.do", // 변경하기
        method: "GET",
        dataType: "json"
      });

      request.done(function (data) {

        //console.log(data); // log 로 데이터 찍어주기.
        var now = new Date();
        var calendarEl = document.getElementById('calendar');
        var calendar = new FullCalendar.Calendar(calendarEl, {

          initialDate: now, // 오늘 날짜 기준
          initialView: 'timeGridDay', // 첫 화면은 일 기준
          locale: 'ko',
          headerToolbar: {
            left: 'prev,next today',
            center: 'title',
            right: 'dayGridMonth,timeGridWeek,timeGridDay,listWeek'
          },
          themeSystem: 'bootstrap5',
          selectable: true,
          slotMinTime: "07:00", // 최소 시간
          slotMaxTime: "22:00", // 최대 시간
          allDaySlot: false,
          select: function (obj) { // 캘린더에서 드래그로 이벤트를 생성
            if ("${ listCount }" == 0){
              alert('예약할 자원이 없습니다. \n 관리자가 예약할 자원을 추가한 후 이용해 주세요.');
            }else if ("${ listCount }" != 0 && obj.start < now){
              alert('현재 날짜보다 이전으로 예약할 수 없습니다.');
            }else if ("${ listCount }" != 0 && obj.start > now){
              $("#insertRezModal").modal("show");
              getRscList(); // 예약할 자원 목록
              //console.log(obj);

              $("#startTime").val(moment(obj.start).format('YYYY-MM-DDTHH:mm:ss'));
              $("#endTime").val(moment(obj.end).format('YYYY-MM-DDTHH:mm:ss'));
              return true;
            }
          },
          eventClick: function (info) {
            //console.log(info);
            $("#selectRezModal").modal("show");

            $("#rezWriter2").val(info.event._def.extendedProps.empName);
            $("#rscName2").val(info.event._def.extendedProps.rscName);
            $("#startTime2").val(moment(info.event.start).format('YYYY-MM-DDTHH:mm:ss'));
            $("#endTime2").val(moment(info.event.end).format('YYYY-MM-DDTHH:mm:ss'));
            $("#rezTitle2").val(info.event.title);

            info.el.style.borderColor = 'black';
          },
          events: data
        });

      calendar.render();
      });

      request.fail(function (jqXHR, textStatus) {
        alert("Request failed: " + textStatus);
      });
    });

    });

  //모달에 자원 목록 출력
  function getRscList() {
    $.ajax({
      url: "rscList.do",
      type: "get",
      dataType: "JSON",
      success: function (json) {
        //console.log(json);
        var html = "";

        $.each(json, function (index, rsc) {
          html += "<option value='" + rsc.rscNo + "'>" + rsc.rscName + "</option>";
        })

        $("select[name='rscNo']").html(html);
      },
      error: function (request, status, error) {
        alert("code: " + request.status + "\n" + "message: " + request.responseText + "\n" + "error: " + error);
      }
    });
  }
</script>
<style>
  td,
  .fc-toolbar-title,
  .fc-list-day-cushion {
    color: black;
  }

  body {
    margin: 0;
    padding: 0;
    font-family: Arial, Helvetica Neue, Helvetica, sans-serif;
    font-size: 14px;
  }

  #top {
    background: #eee;
    border-bottom: 1px solid #ddd;
    padding: 0 10px;
    line-height: 40px;
    font-size: 12px;
  }

  #calendar {
    max-width: 1300px;
    max-height: 1000px;
    margin: 40px auto;
    padding: 0 10px;
  }
</style>
</head>

<body>
<jsp:include page="../common/menubar.jsp" />

<section id="main-content">
  <section class="wrapper" style="margin:0">
    <h3><i class="fa fa-angle-right"></i> 회의실/비품 예약</h3>
    <div class="row mt">
      <div class="col-lg-12">
        <div class="content-panel">
          <script>
            document.addEventListener('DOMContentLoaded', function () {
              var calendarEl = document.getElementById('calendar');
              var calendar = new FullCalendar.Calendar(calendarEl, {
                initialView: 'dayGridMonth'
              });
              calendar.render();
            });
          </script>

          <div id='calendar'></div>
        </div>
      </div>
    </div>
  </section>
</section>
<!-- 일정 추가 모달 -->
<div class="modal fade" id="insertRezModal">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title">예약 추가</h4>
        <button type="button" class="close" data-dismiss="modal">&times;</button>
      </div>

      <form action="insertReserve.do" method="post">
        <!-- Modal Body -->
        <div class="modal-body">
          <label for="rezWriter" class="mr-sm-2">예약자 명</label>
          <input type="hidden" class="form-control mb-2 mr-sm-2" id="rezWriter" name="rezWriter" value="${loginUser.empNo}" readonly><br>
          <input type="text" class="form-control mb-2 mr-sm-2" id="empName" name="empName" value="${loginUser.empName}" readonly><br>

          <label for="rscNo" class="mr-sm-2">예약 자원</label>
          <select name="rscNo" id="rscNo" class="form-control">
          </select><br>

          <label for="rezTime" class="mr-sm-2">예약 시간</label><br>
          <input type="datetime-local" class="mb-2 mr-sm-2" id="startTime" min="${ nowTime }" name="startTime">&emsp;&emsp;~&emsp;&emsp;
          <input type="datetime-local" class="mb-2 mr-sm-2" id="endTime" min="${ nowTime }" name="endTime"><br><br>

          <label for="rezTitle" class="mr-sm-2">예약 명</label>
          <input type="text" class="form-control mb-2 mr-sm-2" id="rezTitle" name="rezTitle" placeholder="예약 명을 입력하세요." pattern=".{1,30}" required title="예약 명은 필수 입력값입니다. 30자 이내로 작성해주세요.">
        </div>
        <!-- Modal footer -->
        <div class="modal-footer">
          <button type="submit" id="rezAddBtn" class="btn btn-primary">추가</button>
          <button type="button" class="btn btn-danger" data-dismiss="modal">취소</button>
        </div>
      </form>
    </div>
  </div>
</div>
<script type="text/javascript">
  $('#rezAddBtn').click(function () {
    var startTime = $('#startTime').val();
    var endTime = $('#endTime').val();

    if (startTime > endTime) {
      alert('예약 종료 시간이 예약 시작 시간보다 앞설 수 없습니다.');
      return false;
    }
    return true;
  });
</script>
<div class="modal fade" id="selectRezModal">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title">예약 상세 조회</h4>
        <button type="button" class="close" data-dismiss="modal">&times;</button>
      </div>
      <!-- Modal Body -->
      <div class="modal-body">
        <label for="rezWriter" class="mr-sm-2">예약자 명</label>
        <input type="text" class="form-control mb-2 mr-sm-2" id="rezWriter2" name="empName" readonly><br>

        <label for="rscNo" class="mr-sm-2">예약 자원</label>
        <input type="text" class="form-control mb-2 mr-sm-2" id="rscName2" name="rscNo" value="${rscNo}" readonly><br>

        <label for="rezTime" class="mr-sm-2">예약 시간</label><br>

        <input type="datetime-local" class="mb-2 mr-sm-2" id="startTime2" name="startTime" readonly>&emsp;&emsp;~&emsp;&emsp;
        <input type="datetime-local" class="mb-2 mr-sm-2" id="endTime2" name="endTime" readonly><br><br>

        <label for="rezTitle" class="mr-sm-2">예약 명</label>
        <input type="text" class="form-control mb-2 mr-sm-2" id="rezTitle2" name="rezTitle" readonly>
      </div>
      <!-- Modal footer -->
      <div class="modal-footer">
        <button type="button" class="btn btn-primary" data-dismiss="modal">확인</button>
      </div>
    </div>
  </div>
</div>

</body>
</html>