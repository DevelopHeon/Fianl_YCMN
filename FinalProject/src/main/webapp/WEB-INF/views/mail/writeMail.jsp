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
                <div class="compose-btn pull-right">
                  <button class="btn btn-theme btn-sm"><i class="fa fa-check"></i> Send</button>
                  <button class="btn btn-sm"><i class="fa fa-times"></i> Discard</button>
                  <button class="btn btn-sm">Draft</button>
                </div>
                <div class="compose-mail">
                
                  <form action="insertMail.do" id="insertMail" role="form-horizontal" method="post" enctype="multipart/form-data">
                    <div class="form-group">
                      <label for="subject" class="">제목:</label>
                      <input type="text" name="mailTitle" tabindex="1" id="subject" class="form-control">
                    </div>
                    <div class="form-group" style="display:none">
                      <label for="writer" class="">발신인</label>
                      <input type="text" value="${ loginUser.empNo }" name="empNo" tabindex="1" id="empNo" class="form-control">
                    </div>
                    <div class="form-group">
                      <label for="to" class="">수신:</label>
                      <input type="text" tabindex="1" name="mailTo" class="form-control">
                      <a class="btn-primary" data-toggle="modal" data-target="#exampleModal" style="font-size:30px">+</a>

                      <div class="compose-options">
                        <a onclick="$(this).hide(); $('#cc').parent().removeClass('hidden'); $('#cc').focus();" href="javascript:;">Cc</a>
                        <a onclick="$(this).hide(); $('#bcc').parent().removeClass('hidden'); $('#bcc').focus();" href="javascript:;">Bcc</a>
                      </div>
                    </div>
                    <div class="form-group hidden">
                      <label for="cc" class="">참조:</label>
                      <input type="text" tabindex="2" name="mailRef" id="cc" class="form-control">
                      <a class="btn-primary" data-toggle="modal" data-target="#exampleModa2" style="font-size:30px">+</a>
                    </div>
                    <div class="form-group hidden">
                      <label for="bcc" class="">비밀참조:</label>
                      <input type="text" tabindex="2" name="mailSec" id="bcc" class="form-control">
                      <a class="btn-primary" data-toggle="modal" data-target="#exampleModa3" style="font-size:30px">+</a>
                    </div>

                    <div class="compose-editor">
                      <textarea class="wysihtml5 form-control" name="mailContent" rows="9">
                      
                      
                      


              
${loginUser.empName} / ${loginUser.posName} / ${loginUser.depName}
${loginUser.empPhone}
                      </textarea>
                     </div>
                     <div class="form-group">
                      <label for="upfile" class="">첨부파일:</label>
                      <input type="file" class="upfile" name="fileName" >
                    </div>
                    <div class="compose-btn">
                      <button class="btn btn-theme btn-sm"><i class="fa fa-check"></i> Send</button>
                      <button class="btn btn-sm"><i class="fa fa-times"></i> Discard</button>
                      <button class="btn btn-sm">Draft</button>
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
  <div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  	<div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">수신</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
         <form action="#">
            <div class="input-append">
              <input type="text" class="form-control " placeholder="Search">
            </div>
         </form>
         <div>
         <input type="text" name="searchTo">
         </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary">Save changes</button>
      </div>
    </div>
  </div>
</div>
    
   <script>
   
   	$(function(){
   		
   		const $toMail = $("#enrollMail input[name=toMail]");
   		
   		$toMail.keyup(function(){
   			
   			if($toMail.val().length >= 1){
   				
   			}
   		})
   	})
   
   
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