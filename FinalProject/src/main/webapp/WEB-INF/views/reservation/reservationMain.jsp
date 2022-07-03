<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>

<head>
<meta charset='utf-8' />
<title>개발웍스  - 회의실/비품 예약</title>
<!-- 화면 해상도에 따라 글자 크기 대응(모바일 대응) -->
<meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no">
<!-- jquery CDN -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
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

        console.log(data); // log 로 데이터 찍어주기.
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
          navLinks: true,
          themeSystem: 'bootstrap',
          //minTime: '08:00:00',
          //maxTime: '22:00:00',
          selectable: true,
          select: function (obj) { // 캘린더에서 드래그로 이벤트를 생성
            $("#insertRezModal").modal("show");
            getRscList();
            console.log(obj);

            $("#startTime").val(moment(obj.start).format('YYYY-MM-DDTHH:mm:ss'));
            $("#endTime").val(moment(obj.end).format('YYYY-MM-DDTHH:mm:ss'));

          },
          editable: true,
          droppable: true, // this allows things to be dropped onto the calendar
          drop: function (arg) {
            // is the "remove after drop" checkbox checked?
            if (document.getElementById('drop-remove').checked) {
              // if so, remove the element from the "Draggable Events" list
              arg.draggedEl.parentNode.removeChild(arg.draggedEl);
            }
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
        console.log(json);
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
  .fc-toolbar-title {
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
    max-width: 1100px;
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
              <input type="datetime-local" class="mb-2 mr-sm-2" id="startTime" name="startTime">&emsp;&emsp;~&emsp;&emsp;
              <input type="datetime-local" class="mb-2 mr-sm-2" id="endTime" name="endTime"><br><br>

              <label for="rezTitle" class="mr-sm-2">예약 명</label>
              <input type="text" class="form-control mb-2 mr-sm-2" placeholder="예약 명을 입력하세요." id="rezTitle" name="rezTitle">
            </div>
            <!-- Modal footer -->
            <div class="modal-footer">
              <button type="submit" class="btn btn-primary">추가</button>
              <button type="button" class="btn btn-danger" data-dismiss="modal">취소</button>
            </div>
          </form>
        </div>
      </div>
    </div>
  </section>
</section>
</body>

</html>