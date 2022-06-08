<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta name="description" content="">
  <meta name="author" content="Dashboard">
  <meta name="keyword" content="Dashboard, Bootstrap, Admin, Template, Theme, Responsive, Fluid, Retina">
  <title>Dashio - Bootstrap Admin Template</title>


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

  <!-- =======================================================
    Template Name: Dashio
    Template URL: https://templatemag.com/dashio-bootstrap-admin-template/
    Author: TemplateMag.com
    License: https://templatemag.com/license/
  ======================================================= -->
</head>

<body>
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
      <a href="views/index.html" class="logo"><b>DASH<span>IO</span></b></a>
      <!--logo end-->
      <div class="nav notify-row" id="top_menu">
        <!--  notification start -->
        <ul class="nav top-menu">
          <!-- inbox dropdown start-->
          <li id="header_inbox_bar" class="dropdown">
            <a data-toggle="dropdown" class="dropdown-toggle" href="views/index.html#">
              <i class="fa fa-envelope-o"></i>
              <span class="badge bg-theme">5</span>
              </a>
            <ul class="dropdown-menu extended inbox">
              <div class="notify-arrow notify-arrow-green"></div>
              <li>
                <p class="green">You have 5 new messages</p>
              </li>
              <li>
                <a href="views/index.html#">
                  <span class="photo"><img alt="avatar" src="resources/img/ui-zac.jpg"></span>
                  <span class="subject">
                  <span class="from">Zac Snider</span>
                  <span class="time">Just now</span>
                  </span>
                  <span class="message">
                  Hi mate, how is everything?
                  </span>
                  </a>
              </li>
              <li>
                <a href="views/index.html#">
                  <span class="photo"><img alt="avatar" src="resources/img/ui-divya.jpg"></span>
                  <span class="subject">
                  <span class="from">Divya Manian</span>
                  <span class="time">40 mins.</span>
                  </span>
                  <span class="message">
                  Hi, I need your help with this.
                  </span>
                  </a>
              </li>
              <li>
                <a href="views/index.html#">
                  <span class="photo"><img alt="avatar" src="resources/img/ui-danro.jpg"></span>
                  <span class="subject">
                  <span class="from">Dan Rogers</span>
                  <span class="time">2 hrs.</span>
                  </span>
                  <span class="message">
                  Love your new Dashboard.
                  </span>
                  </a>
              </li>
              <li>
                <a href="views/index.html#">
                  <span class="photo"><img alt="avatar" src="resources/img/ui-sherman.jpg"></span>
                  <span class="subject">
                  <span class="from">Dj Sherman</span>
                  <span class="time">4 hrs.</span>
                  </span>
                  <span class="message">
                  Please, answer asap.
                  </span>
                  </a>
              </li>
              <li>
                <a href="views/index.html#">See all messages</a>
              </li>
            </ul>
          </li>
          <!-- inbox dropdown end -->
          <!-- notification dropdown start-->
          <li id="header_notification_bar" class="dropdown">
            <a data-toggle="dropdown" class="dropdown-toggle" href="views/index.html#">
              <i class="fa fa-bell-o"></i>
              <span class="badge bg-warning">7</span>
              </a>
            <ul class="dropdown-menu extended notification">
              <div class="notify-arrow notify-arrow-yellow"></div>
              <li>
                <p class="yellow">You have 7 new notifications</p>
              </li>
              <li>
                <a href="views/index.html#">
                  <span class="label label-danger"><i class="fa fa-bolt"></i></span>
                  Server Overloaded.
                  <span class="small italic">4 mins.</span>
                  </a>
              </li>
              <li>
                <a href="views/index.html#">
                  <span class="label label-warning"><i class="fa fa-bell"></i></span>
                  Memory #2 Not Responding.
                  <span class="small italic">30 mins.</span>
                  </a>
              </li>
              <li>
                <a href="views/index.html#">
                  <span class="label label-danger"><i class="fa fa-bolt"></i></span>
                  Disk Space Reached 85%.
                  <span class="small italic">2 hrs.</span>
                  </a>
              </li>
              <li>
                <a href="views/index.html#">
                  <span class="label label-success"><i class="fa fa-plus"></i></span>
                  New User Registered.
                  <span class="small italic">3 hrs.</span>
                  </a>
              </li>
              <li>
                <a href="views/index.html#">See all notifications</a>
              </li>
            </ul>
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
          <p class="centered"><a href="views/profile.html"><img src="resources/img/ui-sam.jpg" class="img-circle" width="80"></a></p>
          <h5 class="centered">Sam Soffes</h5>
          <li class="mt">
            <a class="active" href="home.jsp">
              <i class="fa fa-dashboard"></i>
              <span>Dashboard</span>
              </a>
          </li>
          <li class="sub-menu">
            <a href="resources/javascript:;">
              <i class="fa fa-desktop"></i>
              <span>UI Elements</span>
              </a>
            <ul class="sub">
              <li><a href="generalForm.do">제너럴</a></li>
              <li><a href="../buttons.html">Buttons</a></li>
              <li><a href="views/panels.html">Panels</a></li>
              <li><a href="views/font_awesome.html">Font Awesome</a></li>
            </ul>
          </li>
          <li class="sub-menu">
            <a href="views/javascript:;">
              <i class="fa fa-cogs"></i>
              <span>Components</span>
              </a>
            <ul class="sub">
              <li><a href="views/grids.html">Grids</a></li>
              <li><a href="views/calendar.html">Calendar</a></li>
              <li><a href="views/gallery.html">Gallery</a></li>
              <li><a href="views/todo_list.html">Todo List</a></li>
              <li><a href="views/dropzone.html">Dropzone File Upload</a></li>
              <li><a href="views/inline_editor.html">Inline Editor</a></li>
              <li><a href="views/file_upload.html">Multiple File Upload</a></li>
            </ul>
          </li>
          <li class="sub-menu">
            <a href="views/javascript:;">
              <i class="fa fa-book"></i>
              <span>Extra Pages</span>
              </a>
            <ul class="sub">
              <li><a href="views/blank.html">Blank Page</a></li>
              <li><a href="views/login.html">Login</a></li>
              <li><a href="views/lock_screen.html">Lock Screen</a></li>
              <li><a href="views/profile.html">Profile</a></li>
              <li><a href="views/invoice.html">Invoice</a></li>
              <li><a href="views/pricing_table.html">Pricing Table</a></li>
              <li><a href="views/faq.html">FAQ</a></li>
              <li><a href="views/404.html">404 Error</a></li>
              <li><a href="views/500.html">500 Error</a></li>
            </ul>
          </li>
          <li class="sub-menu">
            <a href="views/javascript:;">
              <i class="fa fa-tasks"></i>
              <span>Forms</span>
              </a>
            <ul class="sub">
              <li><a href="views/form_component.html">Form Components</a></li>
              <li><a href="views/advanced_form_components.html">Advanced Components</a></li>
              <li><a href="views/form_validation.html">Form Validation</a></li>
              <li><a href="views/contactform.html">Contact Form</a></li>
            </ul>
          </li>
          <li class="sub-menu">
            <a href="views/javascript:;">
              <i class="fa fa-th"></i>
              <span>Data Tables</span>
              </a>
            <ul class="sub">
              <li><a href="views/basic_table.html">Basic Table</a></li>
              <li><a href="views/responsive_table.html">Responsive Table</a></li>
              <li><a href="views/advanced_table.html">Advanced Table</a></li>
            </ul>
          </li>
          <li>
            <a href="views/inbox.html">
              <i class="fa fa-envelope"></i>
              <span>Mail </span>
              <span class="label label-theme pull-right mail-info">2</span>
              </a>
          </li>
          <li class="sub-menu">
            <a href="views/javascript:;">
              <i class=" fa fa-bar-chart-o"></i>
              <span>Charts</span>
              </a>
            <ul class="sub">
              <li><a href="views/morris.html">Morris</a></li>
              <li><a href="views/chartjs.html">Chartjs</a></li>
              <li><a href="views/flot_chart.html">Flot Charts</a></li>
              <li><a href="views/xchart.html">xChart</a></li>
            </ul>
          </li>
          <li class="sub-menu">
            <a href="views/javascript:;">
              <i class="fa fa-comments-o"></i>
              <span>Chat Room</span>
              </a>
            <ul class="sub">
              <li><a href="views/lobby.html">Lobby</a></li>
              <li><a href="views/chat_room.html"> Chat Room</a></li>
            </ul>
          </li>
          <li>
            <a href="views/google_maps.html">
              <i class="fa fa-map-marker"></i>
              <span>Google Maps </span>
              </a>
          </li>
          <li class="sub-menu">
            <a href="views/javascript:;">
              <i class="fa fa-book"></i>
              <span>인사관리</span>
              </a>
            <ul class="sub">
              <li><a href="#">근무통계</a></li>
              <li><a href="#">직위/직무관리</a></li>
              <li><a href="#">조직도</a></li>
              <li><a href="#">임직원 관리</a></li>
            </ul>
          </li>
          <li class="sub-menu">
            <a href="views/javascript:;">
              <i class="fa fa-book"></i>
              <span>결재</span>
              </a>
            <ul class="sub">
              <li><a href="views/blank.html">Blank Page</a></li>
              <li><a href="views/login.html">Login</a></li>
              <li><a href="views/lock_screen.html">Lock Screen</a></li>
              <li><a href="views/profile.html">Profile</a></li>
              <li><a href="views/invoice.html">Invoice</a></li>
              <li><a href="views/pricing_table.html">Pricing Table</a></li>
              <li><a href="views/faq.html">FAQ</a></li>
              <li><a href="views/404.html">404 Error</a></li>
              <li><a href="views/500.html">500 Error</a></li>
            </ul>
          </li>
          <li class="sub-menu">
            <a href="views/javascript:;">
              <i class="fa fa-book"></i>
              <span>메일</span>
              </a>
            <ul class="sub">
              <li><a href="views/blank.html">메일 작성</a></li>
              <li><a href="views/login.html">받은 메일함</a></li>
              <li><a href="views/lock_screen.html">보낸 메일함</a></li>
              <li><a href="views/profile.html">휴지통</a></li>
            </ul>
          </li>
          <li class="sub-menu">
            <a href="views/javascript:;">
              <i class="fa fa-book"></i>
              <span>일정</span>
              </a>
            <ul class="sub">
              <li><a href="views/blank.html">Blank Page</a></li>
              <li><a href="views/login.html">Login</a></li>
              <li><a href="views/lock_screen.html">Lock Screen</a></li>
              <li><a href="views/profile.html">Profile</a></li>
              <li><a href="views/invoice.html">Invoice</a></li>
              <li><a href="views/pricing_table.html">Pricing Table</a></li>
              <li><a href="views/faq.html">FAQ</a></li>
              <li><a href="views/404.html">404 Error</a></li>
              <li><a href="views/500.html">500 Error</a></li>
            </ul>
          </li>
          <li class="sub-menu">
            <a href="views/javascript:;">
              <i class="fa fa-book"></i>
              <span>게시판</span>
              </a>
            <ul class="sub">
              <li><a href="#">공지사항</a></li>
              <li><a href="#">익명게시판</a></li>
            </ul>
          </li>
          <li class="sub-menu">
            <a href="views/javascript:;">
              <i class="fa fa-book"></i>
              <span>예약</span>
              </a>
            <ul class="sub">
              <li><a href="#">내 예약 현황</a></li>
              <li><a href="#">회의실/비품 예약</a></li>
              <li><a href="#">회의실/비품 관리</a></li>
            </ul>
          </li>
          <li class="sub-menu">
            <a href="views/javascript:;">
              <i class="fa fa-book"></i>
              <span>인사/근태</span>
              </a>
            <ul class="sub">
              <li><a href="#">인사 정보</a></li>
              <li><a href="#">근태 정보</a></li>
              <li><a href="#">연차 현황</a></li>
              <li><a href="#">주소록</a></li>
            </ul>
          </li>
        </ul>
        <!-- sidebar menu end-->
      </div>
    </aside>
    <!--sidebar end-->
  </section>
  <!-- 가운데 내용 start -->
  <section id="main-content">
  <section class="wrapper">
  </section>
  	<div class="row">
  		내용작성 잘되는지 확인
  	</div>
  </section>
  
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
    $(document).ready(function() {
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
    });
  </script>
  <script type="application/javascript">
    $(document).ready(function() {
      $("#date-popover").popover({
        html: true,
        trigger: "manual"
      });
      $("#date-popover").hide();
      $("#date-popover").click(function(e) {
        $(this).hide();
      });

      $("#my-calendar").zabuto_calendar({
        action: function() {
          return myDateFunction(this.id, false);
        },
        action_nav: function() {
          return myNavFunction(this.id);
        },
        ajax: {
          url: "show_data.php?action=1",
          modal: true
        },
        legend: [{
            type: "text",
            label: "Special event",
            badge: "00"
          },
          {
            type: "block",
            label: "Regular event",
          }
        ]
      });
    });

    function myNavFunction(id) {
      $("#date-popover").hide();
      var nav = $("#" + id).data("navigation");
      var to = $("#" + id).data("to");
      console.log('nav ' + nav + ' to: ' + to.month + '/' + to.year);
    }
  </script>
</body>

</html>
