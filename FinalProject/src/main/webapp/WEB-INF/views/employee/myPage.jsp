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

  <!-- =======================================================
    Template Name: Dashio
    Template URL: https://templatemag.com/dashio-bootstrap-admin-template/
    Author: TemplateMag.com
    License: https://templatemag.com/license/
  ======================================================= -->
<style>

 #update {
	margin : 100px; 
 }
</style>
</head>

<body>
	<jsp:include page="../main.jsp"/>
	
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
              <div class="col-md-4 profile-text mt mb centered right-divider">
                <div class="profile-pic">
                <c:if test="${ sessionScope.loginUser.empPfe eq null}">
               		<p><img src="resources/img/user.png" class="img-circle"></p>
                </c:if>
                 <c:if test="${ sessionScope.loginUser.empPfe ne null}">
                	<p><img src="/resources/board_upfiles/${loginUser.empPfe}" class="img-circle"></p>
                </c:if>
                  <p>
                    <button class="btn btn-theme"><i class="fa fa-check"></i>변경하기</button>
                    <button class="btn btn-theme02">삭제하기</button>
                  </p>
                </div>
              </div>
              <!-- /col-md-4 -->
              <form action="updateEmp.do" method="post">
               <div class="col-md-4 profile-text">
               <label>내 정보</label>
               <table class="detail" align="center">
				<tr>
					<td width="100px">이름 : </td>
					<td colspan="5"><input type="text"  name="empName" value="${ loginUser.empName }"><br></td>
					<td width="100px">사번 : </td>
					<td><input type="text"  name="empNo" value="${ loginUser.empNo }" readonly><br></td>
					<td width="100px">아이디 : </td>
					<td><input type="text"  name="empId" value="${ loginUser.empId }" readonly><br></td>
				</tr>
				<tr>
					<td width="100px">소속 : </td>
					<td colspan="5"><input type="text"  name="departmentNo" value="${ loginUser.depNo }" readonly><br></td>
					<td width="100px">직급 : </td>
					<td><input type="text"  name="positionNo" value="${ loginUser.posNo }" readonly><br></td>
					<td width="100px">이메일 : </td>
					<td><input type="email"  name="empEmail" value="${ loginUser.empEmail }" style="width:180px"><br></td>
				</tr>
				<tr>
					<td width="100px">위치 : </td>
					<td colspan="5"><input type="text"  name="empLoc" value="${ loginUser.empLoc }"><br></td>
					<td width="100px">내선번호 : </td>
					<td><input type="text"  name="officeTel" value="${ loginUser.officeTel }"><br></td>
					<td width="100px">휴대번호 : </td>
					<td><input type="tel"  name="empPhone" value="${ loginUser.empPhone }"><br></td>
				</tr>		
			   </table>
               </div>
               <button id="update" type="submit" class="btn btn-primary">수정하기</button>
              </form>
              <!-- /col-md-4 -->
            </div> 
            <!-- /row -->
          </div>
          
          <!-- /col-lg-12 -->
          <div class="col-lg-12 mt">
            <div class="row content-panel">
              <div class="panel-heading">
                <ul class="nav nav-tabs nav-justified">
                  <li class="active">
                    <a data-toggle="tab" href="#overview">Overview</a>
                  </li>
                  <li>
                    <a data-toggle="tab" href="#contact" class="contact-map">Contact</a>
                  </li>
                  <li>
                    <a data-toggle="tab" href="#edit">Edit Profile</a>
                  </li>
                </ul>
              </div>
              <!-- /panel-heading -->
              <div class="panel-body">
                <div class="tab-content">
                  <div id="overview" class="tab-pane active">
                    <div class="row">
                      <div class="col-md-6">
                        <textarea rows="3" class="form-control" placeholder="Whats on your mind?"></textarea>
                        <div class="grey-style">
                          <div class="pull-left">
                            <button class="btn btn-sm btn-theme"><i class="fa fa-camera"></i></button>
                            <button class="btn btn-sm btn-theme"><i class="fa fa-map-marker"></i></button>
                          </div>
                          <div class="pull-right">
                            <button class="btn btn-sm btn-theme03">POST</button>
                          </div>
                        </div>
                        <div class="detailed mt">
                          <h4>Recent Activity</h4>
                          <div class="recent-activity">
                            <div class="activity-icon bg-theme"><i class="fa fa-check"></i></div>
                            <div class="activity-panel">
                              <h5>1 HOUR AGO</h5>
                              <p>Purchased: Dashio Admin Panel & Front-end theme.</p>
                            </div>
                            <div class="activity-icon bg-theme02"><i class="fa fa-trophy"></i></div>
                            <div class="activity-panel">
                              <h5>5 HOURS AGO</h5>
                              <p>Task Completed. Resolved issue with Disk Space.</p>
                            </div>
                            <div class="activity-icon bg-theme04"><i class="fa fa-rocket"></i></div>
                            <div class="activity-panel">
                              <h5>3 DAYS AGO</h5>
                              <p>Launched a new product: Flat Pack Heritage.</p>
                            </div>
                          </div>
                          <!-- /recent-activity -->
                        </div>
                        <!-- /detailed -->
                      </div>
                      <!-- /col-md-6 -->
                      <div class="col-md-6 detailed">
                        <h4>User Stats</h4>
                        <div class="row centered mt mb">
                          <div class="col-sm-4">
                            <h1><i class="fa fa-money"></i></h1>
                            <h3>$22,980</h3>
                            <h6>LIFETIME EARNINGS</h6>
                          </div>
                          <div class="col-sm-4">
                            <h1><i class="fa fa-trophy"></i></h1>
                            <h3>37</h3>
                            <h6>COMPLETED TASKS</h6>
                          </div>
                          <div class="col-sm-4">
                            <h1><i class="fa fa-shopping-cart"></i></h1>
                            <h3>1980</h3>
                            <h6>ITEMS SOLD</h6>
                          </div>
                        </div>
                        <!-- /row -->
                        <h4>My Friends</h4>
                        <div class="row centered mb">
                          <ul class="my-friends">
                            <li>
                              <div class="friends-pic"><img class="img-circle" width="35" height="35" src="img/friends/fr-01.jpg"></div>
                            </li>
                            <li>
                              <div class="friends-pic"><img class="img-circle" width="35" height="35" src="img/friends/fr-02.jpg"></div>
                            </li>
                            <li>
                              <div class="friends-pic"><img class="img-circle" width="35" height="35" src="img/friends/fr-03.jpg"></div>
                            </li>
                            <li>
                              <div class="friends-pic"><img class="img-circle" width="35" height="35" src="img/friends/fr-04.jpg"></div>
                            </li>
                            <li>
                              <div class="friends-pic"><img class="img-circle" width="35" height="35" src="img/friends/fr-05.jpg"></div>
                            </li>
                            <li>
                              <div class="friends-pic"><img class="img-circle" width="35" height="35" src="img/friends/fr-06.jpg"></div>
                            </li>
                            <li>
                              <div class="friends-pic"><img class="img-circle" width="35" height="35" src="img/friends/fr-07.jpg"></div>
                            </li>
                            <li>
                              <div class="friends-pic"><img class="img-circle" width="35" height="35" src="img/friends/fr-08.jpg"></div>
                            </li>
                            <li>
                              <div class="friends-pic"><img class="img-circle" width="35" height="35" src="img/friends/fr-09.jpg"></div>
                            </li>
                            <li>
                              <div class="friends-pic"><img class="img-circle" width="35" height="35" src="img/friends/fr-10.jpg"></div>
                            </li>
                            <li>
                              <div class="friends-pic"><img class="img-circle" width="35" height="35" src="img/friends/fr-11.jpg"></div>
                            </li>
                          </ul>
                          <div class="row mt">
                            <div class="col-md-4 col-md-offset-4">
                              <h6><a href="#">VIEW ALL</a></h6>
                            </div>
                          </div>
                        </div>
                        <!-- /row -->
                        <h4>Pending Tasks</h4>
                        <div class="row centered">
                          <div class="col-md-8 col-md-offset-2">
                            <h5>Dashboard Update (40%)</h5>
                            <div class="progress">
                              <div class="progress-bar progress-bar-info" role="progressbar" aria-valuenow="40" aria-valuemin="0" aria-valuemax="100" style="width: 40%">
                                <span class="sr-only">40% Complete (success)</span>
                              </div>
                            </div>
                            <h5>Unanswered Messages (80%)</h5>
                            <div class="progress">
                              <div class="progress-bar progress-bar-info" role="progressbar" aria-valuenow="40" aria-valuemin="0" aria-valuemax="100" style="width: 80%">
                                <span class="sr-only">80% Complete (success)</span>
                              </div>
                            </div>
                            <h5>Product Review (60%)</h5>
                            <div class="progress">
                              <div class="progress-bar progress-bar-info" role="progressbar" aria-valuenow="40" aria-valuemin="0" aria-valuemax="100" style="width: 60%">
                                <span class="sr-only">60% Complete (success)</span>
                              </div>
                            </div>
                            <h5>Friend Requests (90%)</h5>
                            <div class="progress">
                              <div class="progress-bar progress-bar-info" role="progressbar" aria-valuenow="40" aria-valuemin="0" aria-valuemax="100" style="width: 90%">
                                <span class="sr-only">90% Complete (success)</span>
                              </div>
                            </div>
                          </div>
                          <!-- /col-md-8 -->
                        </div>
                        <!-- /row -->
                      </div>
                      <!-- /col-md-6 -->
                    </div>
                    <!-- /OVERVIEW -->
                  </div>
                  <!-- /tab-pane -->
                  <div id="contact" class="tab-pane">
                    <div class="row">
                      <div class="col-md-6">
                        <div id="map"></div>
                      </div>
                      <!-- /col-md-6 -->
                      <div class="col-md-6 detailed">
                        <h4>Location</h4>
                        <div class="col-md-8 col-md-offset-2 mt">
                          <p>
                            Postal Address<br/> PO BOX 12988, Sutter Ave<br/> Brownsville, New York.
                          </p>
                          <br>
                          <p>
                            Headquarters<br/> 844 Sutter Ave,<br/> 9003, New York.
                          </p>
                        </div>
                        <h4>Contacts</h4>
                        <div class="col-md-8 col-md-offset-2 mt">
                          <p>
                            Phone: +33 4898-4303<br/> Cell: 48 4389-4393<br/>
                          </p>
                          <br>
                          <p>
                            Email: hello@dashiotheme.com<br/> Skype: UseDashio<br/> Website: http://Alvarez.is
                          </p>
                        </div>
                      </div>
                      <!-- /col-md-6 -->
                    </div>
                    <!-- /row -->
                  </div>
                  <!-- /tab-pane -->
                  <div id="edit" class="tab-pane">
                    <div class="row">
                      <div class="col-lg-8 col-lg-offset-2 detailed">
                        <h4 class="mb">Personal Information</h4>
                        <form role="form" class="form-horizontal">
                          <div class="form-group">
                            <label class="col-lg-2 control-label"> Avatar</label>
                            <div class="col-lg-6">
                              <input type="file" id="exampleInputFile" class="file-pos">
                            </div>
                          </div>
                          <div class="form-group">
                            <label class="col-lg-2 control-label">Company</label>
                            <div class="col-lg-6">
                              <input type="text" placeholder=" " id="c-name" class="form-control">
                            </div>
                          </div>
                          <div class="form-group">
                            <label class="col-lg-2 control-label">Lives In</label>
                            <div class="col-lg-6">
                              <input type="text" placeholder=" " id="lives-in" class="form-control">
                            </div>
                          </div>
                          <div class="form-group">
                            <label class="col-lg-2 control-label">Country</label>
                            <div class="col-lg-6">
                              <input type="text" placeholder=" " id="country" class="form-control">
                            </div>
                          </div>
                          <div class="form-group">
                            <label class="col-lg-2 control-label">Description</label>
                            <div class="col-lg-10">
                              <textarea rows="10" cols="30" class="form-control" id="" name=""></textarea>
                            </div>
                          </div>
                        </form>
                      </div>
                      <div class="col-lg-8 col-lg-offset-2 detailed mt">
                        <h4 class="mb">Contact Information</h4>
                        <form role="form" class="form-horizontal">
                          <div class="form-group">
                            <label class="col-lg-2 control-label">Address 1</label>
                            <div class="col-lg-6">
                              <input type="text" placeholder=" " id="addr1" class="form-control">
                            </div>
                          </div>
                          <div class="form-group">
                            <label class="col-lg-2 control-label">Address 2</label>
                            <div class="col-lg-6">
                              <input type="text" placeholder=" " id="addr2" class="form-control">
                            </div>
                          </div>
                          <div class="form-group">
                            <label class="col-lg-2 control-label">Phone</label>
                            <div class="col-lg-6">
                              <input type="text" placeholder=" " id="phone" class="form-control">
                            </div>
                          </div>
                          <div class="form-group">
                            <label class="col-lg-2 control-label">Cell</label>
                            <div class="col-lg-6">
                              <input type="text" placeholder=" " id="cell" class="form-control">
                            </div>
                          </div>
                          <div class="form-group">
                            <label class="col-lg-2 control-label">Email</label>
                            <div class="col-lg-6">
                              <input type="text" placeholder=" " id="email" class="form-control">
                            </div>
                          </div>
                          <div class="form-group">
                            <label class="col-lg-2 control-label">Skype</label>
                            <div class="col-lg-6">
                              <input type="text" placeholder=" " id="skype" class="form-control">
                            </div>
                          </div>
                          <div class="form-group">
                            <div class="col-lg-offset-2 col-lg-10">
                              <button class="btn btn-theme" type="submit">Save</button>
                              <button class="btn btn-theme04" type="button">Cancel</button>
                            </div>
                          </div>
                        </form>
                      </div>
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