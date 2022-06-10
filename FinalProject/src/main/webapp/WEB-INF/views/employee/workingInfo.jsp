<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

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
	
	var month = document.getElementById("month");
	
	var calendar = currentDate.getFullYear() + "년 " + (currentDate.getMonth()+1) +"월"
	month.innerHTML = calendar;
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
             <div><h2 id="month"></h2></div>
             <c:forEach items="${working}" var="w">
				<div>
					<input type="text" id="start">${w.startTime }
				</div>
				<div>
					<input type="text" id="finish">
				</div>
			</c:forEach>

            </div> 
            <!-- /row -->
          </div>

          <!-- /col-lg-12 -->
          <div class="col-lg-12 mt">
            <div class="row content-panel">
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
              <div class="panel-body">
                <div class="tab-content">
                  <div id="1week" class="tab-pane active">
                    <div class="row">
                      <div class="col-md-6">
                          <div><p>1</p></div>

                      </div>
                      <!-- /col-md-6 -->

                    </div>
                    <!-- /OVERVIEW -->
                  </div>
                  <!-- /tab-pane -->
                  <div id="2week" class="tab-pane">
                    <div class="row">
                       	<div><p>2</p></div>
                    </div>
                    <!-- /row -->
                  </div>
                  <!-- /tab-pane -->
                  <div id="3week" class="tab-pane">
                    <div class="row">
 						<div><p>3</p></div>
                      <!-- /col-lg-8 -->
                    </div>
                    <!-- /row -->
                  </div>
                  <!-- /tab-pane -->
                  <div id="4week" class="tab-pane">
                    <div class="row">
 						<div><p>4</p></div>
                      <!-- /col-lg-8 -->
                    </div>
                    <!-- /row -->
                  </div>
                  <!-- /tab-pane -->
                  <div id="5week" class="tab-pane">
                    <div class="row">
 						<div><p>5</p></div>
                      <!-- /col-lg-8 -->
                    </div>
                    <!-- /row -->
                  </div>
                  <!-- /tab-pane -->
                </div>
                <!-- /tab-content -->
              </div>
              <!-- /panel-body -->
            </div>
            <!-- /col-lg-12 -->
          </div>
          <!-- /row -->
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
  <script>
    $('.contact-map').click(function() {

      //google map in tab click initialize
      function initialize() {
        var myLatlng = new google.maps.LatLng(40.6700, -73.9400);
        var mapOptions = {
          zoom: 11,
          scrollwheel: false,
          center: myLatlng,
          mapTypeId: google.maps.MapTypeId.ROADMAP
        }
        var map = new google.maps.Map(document.getElementById('map'), mapOptions);
        var marker = new google.maps.Marker({
          position: myLatlng,
          map: map,
          title: 'Dashio Admin Theme!'
        });
      }
      google.maps.event.addDomListener(window, 'click', initialize);
    });
  </script>

</body>
</html>