<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>보낸메일</title>

</head>

<body>
   <jsp:include page="../common/menubar.jsp"/>   

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
                    <a href="resources/mailUpload_files/${sMail.mail.changeName}" download="${ sMail.mail.changeName }">${ sMail.mail.fileName }</a>
                  </p>
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
  </section>

</body>
</html>