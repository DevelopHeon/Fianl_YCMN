<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>

<head>
<title>근무 통계</title>
<script type="text/javascript" src="https://www.google.com/jsapi"></script>
<script>
  google.charts.load('current', { 'packages': ['corechart'] });
  google.charts.setOnLoadCallback(drawChart1);
  google.charts.setOnLoadCallback(drawChart2);
  google.charts.setOnLoadCallback(drawChart3);
  
  window.onload = resize;
  window.onresize = resize;
  // 차트 그리기 함수
  function drawChart1() {
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

      var chart = new google.visualization.PieChart(document.getElementById('getDeptList'));

      var options = {
        title: '부서 별 인원 수',
        height : 400,
        width: '100%'
      };

      chart.draw(data, options);

    }).fail(function (jq, text, err) {
      console.log(text + ' - ' + err);
    });
  }
  // 차트 그리기 함수
  function drawChart2() {
    $.ajax({
      url: "Chart2.do",
      dataType: "json",
    }).done(function (jsonData) {
      console.log(jsonData);
      var data = new google.visualization.DataTable();
      data.addColumn('string', '결재 구분');
      data.addColumn('number', '결재 이용량');

      jsonData.forEach(function (row) {
        data.addRow([
          row.name,
          row.value
        ]);
      });

      var chart = new google.visualization.SteppedAreaChart(document.getElementById('chartApprovalList'));

      var options = {
        title: '이번 달 결재 이용량',
        height : 400,
        width: '100%'
      };

      chart.draw(data, options);

    }).fail(function (jq, text, err) {
      console.log(text + ' - ' + err);
    });
  }
  function drawChart3() {
	    $.ajax({
	      url: "Chart3.do",
	      dataType: "json",
	    }).done(function (jsonData) {
	      console.log(jsonData);
	      var data = new google.visualization.DataTable();
	      data.addColumn('string', '직급 명');
	      data.addColumn('number', '급여 평균');

	      jsonData.forEach(function (row) {
	        data.addRow([
	          row.name,
	          row.value
	        ]);
	      });

	      var chart = new google.visualization.ColumnChart(document.getElementById('posSararyAVGList'));

	      var options = {
	        title: '직급 별 월 급여 평균',
	        height : 500,
	        width: '100%'
	      };

	      chart.draw(data, options);

	    }).fail(function (jq, text, err) {
	      console.log(text + ' - ' + err);
	    });
	  }
</script>
<style type="text/css">
	#WorksData{
	width:90%; 
	margin:3%;
	}
	th{
		width:30%;
		text-align:center;
		color:white;
		background-color:rgb(51, 102, 204);
	}
</style>
</head>

<body style="background:#eaeaea;">
<jsp:include page="../common/menubar.jsp" />
<section id="main-content">
  <section class="wrapper" style="margin:0">
    <h3><i class="fa fa-angle-right"></i> 인사 관리</h3>
    <div class="row mt">
      <div class="col-lg-6 col-md-12 col-sm-12">
        <div class="content-panel" style="min-height:800px">
          <h4><i class="fa fa-angle-right"></i> 회사 정보</h4>
          
          
          <section id="unseen" >
				<table id="WorksData" class="table table-bordered table-condensed">
				  <tr>
	              	<th>회사 이름</th>
	                <td>개발웍스</td>
	              </tr>
	              <tr>
	              	<th>회사 인원 수</th>
	                <td>${ empCount }</td>
	              </tr>
	              <tr>
	              	<th>출근 시간 통계</th>
	                <td>${ workingTime }</td>
	              </tr>
				</table>
			<div id="posSararyAVGList"></div>
          </section>
          
          
        </div>
        <!-- /content-panel -->
      </div>
      <!-- /col-lg-4 -->
      
      <div class="col-lg-6 col-md-12 col-sm-12">
        <div class="content-panel" style="min-height:800px">
          <h4><i class="fa fa-angle-right"></i> 근무 통계</h4>
          <section id="unseen">

            <div id="getDeptList"></div>
			<div id="chartApprovalList"></div>
			
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