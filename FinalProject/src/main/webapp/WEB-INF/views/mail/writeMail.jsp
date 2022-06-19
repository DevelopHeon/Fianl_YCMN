<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>mail</title>

  <!-- Favicons -->
  <link href="img/favicon.png" rel="icon">
  <link href="img/apple-touch-icon.png" rel="apple-touch-icon">
  <!-- Bootstrap core CSS -->
  <link href="lib/bootstrap/css/bootstrap.min.css" rel="stylesheet">
  <!--external css-->
  <link href="lib/font-awesome/css/font-awesome.css" rel="stylesheet" />
  <link href="lib/bootstrap-wysihtml5/bootstrap-wysihtml5.css" rel="stylesheet" />
  <!-- Custom styles for this template -->
  <link href="css/style.css" rel="stylesheet">
  <link href="css/style-responsive.css" rel="stylesheet">

</head>
<body>
	<jsp:include page="../main.jsp"/>
	
    <!-- **********************************************************************************************************************************************************
        MAIN CONTENT
        *********************************************************************************************************************************************************** -->
    <!--main content start-->
    <section id="main-content">
      <section class="wrapper">
        <!-- page start-->
        <div class="row mt">
          <div class="col-sm-11">
            <section class="panel">
              <header class="panel-heading wht-bg">
                <h4 class="gen-case">
                    	작성하기
                    <form action="#" class="pull-right mail-src-position">
                      <div class="input-append">
                        <input type="text" class="form-control " placeholder="Search Mail">
                      </div>
                    </form>
                  </h4>
              </header>
              <div class="panel-body">

                <div class="compose-mail">
                
                  <form action="insertMail.do" id="insertMail" role="form-horizontal" method="post" enctype="multipart/form-data">
                    <div class="form-group">
                      <label for="subject" class="">제목:</label>
                      <input type="text" name="mailTitle" tabindex="1" id="subject" class="form-control" required>
                    </div>
                    <div class="form-group" style="display:none">
                      <label for="writer" class="">발신인</label>
                      <input type="text" value="${ loginUser.empNo }" name="empNo" tabindex="1" id="empNo" class="form-control">
                    </div>
                    <div class="form-group">
                      <label for="to" class="">수신:</label>
                      <span id="mailTo"></span>
                      <a class="btn-primary" onclick="selectApprover(1, '${loginUser.empNo}')"  data-toggle="modal" data-target="#addressModal" style="font-size:30px">+</a>

                      <div class="compose-options">
                        <a onclick="$(this).hide(); $('#mailRef').parent().removeClass('hidden'); $('#mailRef').focus();" href="javascript:;">Cc</a>
                        <a onclick="$(this).hide(); $('#mailSec').parent().removeClass('hidden'); $('#mailSec').focus();" href="javascript:;">Bcc</a>
                      </div>
                    </div>
                    <div class="form-group hidden">
                      <label for="cc" class="">참조:</label>
                      <span id="mailRef"></span>
                      <a class="btn-primary" onclick="selectApprover(2, '${loginUser.empNo}')"  data-toggle="modal" data-target="#addressModal" style="font-size:30px">+</a>
                    </div>
                    <div class="form-group hidden">
                      <label for="bcc" class="">비밀참조:</label>
                      <span id="mailSec"></span>
                      <a class="btn-primary" onclick="selectApprover(3, '${loginUser.empNo}')"  data-toggle="modal" data-target="#addressModal" style="font-size:30px">+</a>
                    </div>

                    <div class="compose-editor">
                      <textarea class="wysihtml5 form-control" name="mailContent" rows="9">



${loginUser.empName} / ${loginUser.posName} / ${loginUser.depName}
${loginUser.empPhone}
                      </textarea>
                     </div>
                     <div class="form-group">
                      <label for="file" class="">첨부파일:</label>
                      <input type="file" class="file" name="upfile" >
                    </div>
                    <div class="compose-btn">
                      <button class="btn btn-theme btn-sm"><i class="fa fa-check"></i> 보내기</button>
                      <button type="button" class="goMain btn btn-sm" onclick="goMain();"><i class="fa fa-times"></i> 취소하기</button>
                    </div>
                  </form>
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
    <!-- 수신 모달 -->
    <div class="modal fade" id="addressModal">
		<jsp:include page="addressListModal.jsp"/>
	</div>
    <script>
	function goMain(){

		var goMain = confirm("메인으로 돌아가시겠습니까? (메일은 저장되지 않습니다)");
		
		if(goMain){
			location.href='main.do';
		}

		
		
	}
    	
    </script>
  <!-- js placed at the end of the document so the pages load faster -->
  <script src="lib/jquery/jquery.min.js"></script>
  <script src="lib/bootstrap/js/bootstrap.min.js"></script>
  <script class="include" type="text/javascript" src="lib/jquery.dcjqaccordion.2.7.js"></script>
  <script src="lib/jquery.scrollTo.min.js"></script>
  <script src="lib/jquery.nicescroll.js" type="text/javascript"></script>
  <!--common script for all pages-->
  <script src="lib/common-scripts.js"></script>
  <!--script for this page-->
  <script type="text/javascript" src="lib/bootstrap-wysihtml5/wysihtml5-0.3.0.js"></script>
  <script type="text/javascript" src="lib/bootstrap-wysihtml5/bootstrap-wysihtml5.js"></script>

  <script type="text/javascript">
    //wysihtml5 start

    $('.wysihtml5').wysihtml5();

    //wysihtml5 end
  </script>
</body>
</html>