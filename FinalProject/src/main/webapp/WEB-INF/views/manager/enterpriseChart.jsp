<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<title>근무 통계</title>
<script type="text/javascript" src="https://www.google.com/jsapi"></script>
<script>
  google.charts.load('current', { 'packages': ['corechart'] });
  google.charts.setOnLoadCallback(drawChart);
  // 차트 그리기 함수
  function drawChart() {
    $.ajax({
      url: "Chart1.do",
      dataType: "json",
    }).done(function (jsonData) {
      console.log(jsonData);
      var data = new google.visualization.DataTable();
      data.addColumn('string', '부서');
      data.addColumn('number', '부서 인원 수');

      jsonData.forEach(function (row) {
        data.addRow([
          row.name,
          row.value
        ]);
      });

      var chart = new google.visualization.PieChart(document.getElementById('piechart'));

      var options = {
        title: '부서 별 인원 수'
      };

      chart.draw(data, options);

    }).fail(function (jq, text, err) {
      console.log(text + ' - ' + err);
    });
  }
</script>
</head>

<body>
<jsp:include page="../common/menubar.jsp" />
<section id="main-content">
  <section class="wrapper"  style="margin:0">
    <h3><i class="fa fa-angle-right"></i> 인사 관리</h3>
    <div class="row mt">
      <div class="col-lg-12">
        <div class="content-panel">
          <h4><i class="fa fa-angle-right"></i> 근무 통계</h4>
          <section id="unseen">
          
			<div id="piechart" style="width: 900px; height: 500px;"></div>
			<div id="chartDiv"></div>
			
          </section>
        </div>
        <!-- /content-panel -->
      </div>
      <!-- /col-lg-4 -->
    </div>
    <!-- /row mt -->
  </section>
  <!-- /wrapper -->
</section>
<!-- /MAIN CONTENT -->
</body>
</html>