<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>받은메일</title>

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
                    	받은 메일 확인
                  </h4>
              </header>
              <form id="receiveDetail" action="" method="post">
              <div class="panel-body ">
                <div class="mail-header row">
                  <div class="col-md-8">
                  <input type="text" name="receiveNo" value="${ rMail.receiveNo}" style="display:none">
                  	<span class="pull-left label label-warning">보낸 사람</span>
                  	<span class="empNo pull-left" style="display:none">&nbsp;&nbsp;${ rMail.empNo}</span>
                  	<span class="pull-left">
                  		<c:if test="${ rMail.employee.empPfe eq null}">
               				<img src="resources/img/user.png" class="img-circle" width="40">
           				</c:if>
           				<c:if test="${ !empty rMail.employee.empPfe }">
               				<img src="resources/empUpload_files/${rMail.employee.empPfe}" class="img-circle" width="40">
            			</c:if>
                 		&nbsp;&nbsp;${ rMail.employee.empName}</span>
                 		<br><br><br>
                    <h2 class="pull-left">${ rMail.mail.mailTitle}</h2>
                  </div>
                  <div class="col-md-4">
                    <div class="compose-btn pull-right">
                      <a class="btn btn-sm btn-theme" onclick="receiveDetailMail(1);"><i class="fa fa-reply"></i> Reply</a>
                      <button class="btn btn-sm tooltips" onclick="receiveDetailMail(2);" data-original-title="Trash" data-toggle="tooltip" data-placement="top" title=""><i class="fa fa-trash-o"></i></button>
                    </div>
                  </div>
                </div>
                <!-- 수신자 기준 가능한 조회목록: 발신자, 수신자(본인), 참조자  -->
                <div class="mail-sender">
                  <div class="row">
                  	<div class="col-md-8">
                  	  <span class="label label-primary">수신</span>
                      <span>&nbsp;&nbsp;${ rMail.mail.mailTo}</span>
                    </div>                    
                    <div class="col-md-4">
                      <p class="date">${rMail.timestamp }</p>
                    </div>
                  	<c:if test="${!empty rMail.mail.mailRef}">
                    <div class="col-md-8">
                      <span class="label label-success">참조</span>
                      <span>&nbsp;&nbsp;${ rMail.mail.mailRef}</span>
                    </div>
                    </c:if>

                  </div>
                </div>
                
                <div class="view-mail">
                  <p>${rMail.mail.mailContent }</p>
                </div>
                <c:if test="${!empty rMail.mail.fileName }">
                <div class="attachment-mail">
                  <p>
                    <span><i class="fa fa-paperclip"></i> 1 attachment — </span>
                    <a href="resources/mailUpload_files/${rMail.mail.changeName}" download="${ rMail.mail.changeName }">${ rMail.mail.fileName }</a>
                  </p>
                  <ul>
                    <li>
                      <a class="atch-thumb" href="resources/mailUpload_files/${rMail.mail.fileName}" download="${ rMail.mail.fileName }">
                        </a>
                    </li>
                  </ul>
                </div>
                </c:if>
                <div class="compose-btn pull-left">
                  <button type="button" class="btn btn-sm btn-theme" onclick="receiveDetailMail(1);"><i class="fa fa-reply"></i> Reply</button>
                  <button type="button" onclick="location.href='receiveMail.do';" class="btn btn-sm "><i class="fa fa-arrow-right"></i> 목록으로</button>
                  <button type="button" class="btn btn-sm tooltips" onclick="receiveDetailMail(2);"><i class="fa fa-trash-o"></i></button>
                </div>
              </div>
              </form>
            </section>
          </div>
        </div>
      </section>
      <!-- /wrapper -->
    </section>
    <!-- /MAIN CONTENT -->
    <!--main content end-->
    <script>
    function receiveDetailMail(num){
    	var receiveForm = $("#receiveDetail");
    	
    	if(num == 1){
    		receiveForm.attr("action","writeReplyForm.do");
    	}else{
    		if(confirm("메일을 삭제 하시겠습니까?")){
    			alert("삭제 되었습니다");
    		}else{
    			return false;
    		}
    		receiveForm.attr("action","deleteRMail.do");
    	}
    	receiveForm.submit();
    	
    }
	function trashMail(){
		
		if(confirm("메일을 삭제 하시겠습니까?")){
			alert("삭제 되었습니다");
			$("#trashMail").submit();
		}
	}
	
    </script>
  </section>

</body>
</html>