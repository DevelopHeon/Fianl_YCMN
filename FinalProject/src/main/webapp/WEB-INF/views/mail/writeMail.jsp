<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%-- 검증 실패시에도 기존 값 유지되도록 form 태그 추가 --%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메일작성</title>

  <!-- Bootstrap core CSS -->
  <link href="lib/bootstrap/css/bootstrap.min.css" rel="stylesheet">


<!-- SmartEditor2 라이브러리  --> 
<script type="text/javascript" src="resources/smartEditor2/js/HuskyEZCreator.js" charset="utf-8"></script>
<script type="text/javascript" src="//code.jquery.com/jquery-1.11.0.min.js"></script>

</head>
<body>
	<jsp:include page="../common/menubar.jsp"/>
	
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
                
                  <form:form action="insertMail.do" id="insertMail" modelAttribute="mail" role="form-horizontal" method="post" enctype="multipart/form-data">
                    <div class="form-group">
                      <label for="subject" class="">제목:</label>
                      <a style="color:red"><form:errors path="mailTitle"></form:errors></a>
                      <form:input type="text" name="mailTitle" tabindex="1" id="subject" class="form-control" required="required" path="mailTitle"/>
                      
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
							<textarea name="mailContent" id="ir1"
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
                  </form:form>
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
		    elPlaceHolder: "ir1",  //textarea ID 입력
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
		
		if($("#subject").val() == ""){
			alert("제목을 입력해주세요");
			return;
		}

		
		oEditors.getById["ir1"].exec("UPDATE_CONTENTS_FIELD", []);
		
		
		var contentVal = $("#ir1").val();
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

</body>
</html>