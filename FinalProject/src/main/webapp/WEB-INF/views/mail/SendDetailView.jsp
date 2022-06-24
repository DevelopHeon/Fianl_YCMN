<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Dashio - Bootstrap Admin Template</title>

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
</head>

<body>
	<jsp:include page="../main.jsp"/>

  <section id="container">
 
    <!-- **********************************************************************************************************************************************************
        MAIN CONTENT
        *********************************************************************************************************************************************************** -->
    <!--main content start-->
    <section id="main-content">
      <section class="wrapper">
        <!-- page start-->
        <div class="row mt">

          <div class="col-sm-10">
            <section class="panel">
              <header class="panel-heading wht-bg">
                <h4 class="gen-case">
                    	보낸 메일 확인
                  </h4>
              </header>
              <div class="panel-body ">
                <div class="mail-header row">
                  <div class="col-md-8">
                    <h4 class="pull-left">${ sMail.mail.mailTitle}</h4>
                  </div>
                 
                </div>
                <!-- 발신자 기준 조회 가능한 목록 : 수신, 참조, 비밀참조자  -->
                <div class="mail-sender">
                  <div class="row">
                  	<div class="col-md-8">
                      <span class="label label-primary">수신</span>
                      <span>${sMail.mail.mailTo}</span>
                    </div>
                    <div class="col-md-4">
                      <p class="date">${sMail.timestamp }</p>
                    </div>
                    
                  	<c:if test="${!empty sMail.mail.mailRef}">
                    <div class="col-md-8">
                      <span class="label label-success">참조</span>
                      <span>${sMail.mail.mailRef}</span>
                    </div>
                    </c:if>
					<c:if test="${!empty sMail.mail.mailSec}">
                    <div class="col-md-8">
                      <span class="label label-default">비밀참조</span>
                      <span>${sMail.mail.mailSec}</span>
                    </div>
                    </c:if>
                  </div>
                </div>
                <div class="view-mail">
                  <p>${sMail.mail.mailContent }</p>
                </div>
                <c:if test="${!empty sMail.mail.fileName }">
                <div class="attachment-mail">
                  <p>
                    <span><i class="fa fa-paperclip"></i> 1 attachment — </span>
                    <a href="resources/mailUpload_files/${sMail.mail.fileName}" download="${ sMail.mail.fileName }">${ sMail.mail.fileName }</a>
                  </p>
                  <ul>
                    <li>
                      <a class="atch-thumb" href="resources/mailUpload_files/${sMail.mail.fileName}" download="${ sMail.mail.fileName }">
                        <img src="resources/mailUpload_files/${sMail.mail.fileName}">
                        </a>
                      <a class="name">
                        ${sMail.mail.fileName}
                        </a>
                    </li>
                  </ul>
                </div>
                </c:if>
                <div class="compose-btn pull-left">
                  <button type="button" onclick="location.href='sendMail.do';" class="btn btn-sm "><i class="fa fa-arrow-right"></i> 목록으로</button>
                </div>
              </div>
            </section>
          </div>
        </div>
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
        <a href="mail_view.html#" class="go-top">
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

</body>
</html>