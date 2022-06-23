<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  
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

<!-- SmartEditor2 라이브러리  --> 
<script type="text/javascript" src="resources/smartEditor2/js/service/HuskyEZCreator.js" charset="utf-8"></script>
<script type="text/javascript" src="//code.jquery.com/jquery-1.11.0.min.js"></script>

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
                      
                      <!-- 주소록에서 특정사원 메일쓰기를 클릭할때 -->
                      <c:if test="${!empty emp.empName}">
                      <input type="text" id="mailTo" name="mailTo" value="${emp.empNo }" style="display:none"></input>
                      <span>${emp.empName}</span>
                      </c:if>

                      <c:if test="${empty emp.empName}">
                      <span id="mailTo"></span>
                      </c:if>
                      <a class="btn" onclick="selectApprover(1, '${loginUser.empNo}')"  data-toggle="modal" data-target="#addressModal" style="font-size:20px"><i class="fa fa-plus-circle"></i></a>

                      <div class="compose-options">
                        <a onclick="$(this).hide(); $('#mailRef').parent().removeClass('hidden'); $('#mailRef').focus();" href="javascript:;"><i class="fa fa-plus"></i> 참조 </a>&nbsp;&nbsp;
                        <a onclick="$(this).hide(); $('#mailSec').parent().removeClass('hidden'); $('#mailSec').focus();" href="javascript:;"><i class="fa fa-plus"></i> 비밀참조</a>
                      </div>
                    </div>
                    <div class="form-group hidden">
                      <label for="cc" class="">참조:</label>
                      <span id="mailRef"></span>
                      <a class="btn" onclick="selectApprover(2, '${loginUser.empNo}')"  data-toggle="modal" data-target="#addressModal" style="font-size:20px"><i class="fa fa-plus-circle"></i></a>
                    </div>
                    <div class="form-group hidden">
                      <label for="bcc" class="">비밀참조:</label>
                      <span id="mailSec"></span>
                      <a class="btn" onclick="selectApprover(3, '${loginUser.empNo}')"  data-toggle="modal" data-target="#addressModal" style="font-size:20px"><i class="fa fa-plus-circle"></i></a>
                    </div>
                    
                      <!-- <div class="compose-editor">
                      <textarea class="wysihtml5 form-control" name="mailContent" rows="9">


${loginUser.empName} / ${loginUser.posName} / ${loginUser.depName}
${loginUser.empPhone}
                      </textarea>
                     </div> -->

							<textarea name="mailContent" id="se"
								style="width: 100%; height: 412px;">
								
								
${loginUser.empName} / ${loginUser.posName} / ${loginUser.depName}
${loginUser.empPhone}</textarea>


                     
                     <div class="form-group">
                      <label for="file" class="">첨부파일:</label>
                      <input type="file" class="file" name="upfile" >
                    </div>
                    <div class="compose-btn">
                      <button id="save" class="btn btn-theme btn-sm"><i class="fa fa-check"></i> 보내기</button>
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
    
<script id="smartEditor" type="text/javascript"> 
		var oEditors = [];
		nhn.husky.EZCreator.createInIFrame({
		    oAppRef: oEditors,
		    elPlaceHolder: "se",  //textarea ID 입력
		    sSkinURI: "resources/smartEditor2/SmartEditor2Skin.html", //martEditor2Skin.html 경로 입력
					fCreator : "createSEditor2",
					htParams : {
						// 툴바 사용 여부 (true:사용/ false:사용하지 않음) 
						bUseToolbar : true,
						// 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음) 
						bUseVerticalResizer : true,
						// 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음) 
						bUseModeChanger : true
					}
				});
		
	$("#save").click(function() {
		oEditors.getById["se"].exec("UPDATE_CONTENTS_FIELD", []);
		
		if($("#subject").val() == ""){
			alert("제목을 입력해주세요");
			return;
		}
		if($("#mailTo").val() == null){
			alert("수신자를 입력해주세요");
			return false;
		}
		
		var contentVal = $("#se").val();
		console.log(contentVal);
		contentVal = contentVal.replace(/<p>/gi,"");
		contentVal = contentVal.replace(/<\/p>/gi,"<br>");
		contentVal = contentVal.replace(/<p><br><\/p>/gi,"<br>");
		contentVal = contentVal.replace(/<\/p><p>/gi, "<br>");
		if(contentVal == "" || contentVal == "<p>&nbsp;</p>"){
			alert("글 내용을 입력해주세요");
			return;
		}
		
		
		$("#insertMail").submit();
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