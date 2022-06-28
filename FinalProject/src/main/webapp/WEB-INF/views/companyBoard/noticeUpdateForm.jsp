<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<!DOCTYPE html>
<html>
<head>
<style>
/* 첨부파일 상자 이미지로 대체 */
.file_input_textbox {height:29px; width:50%; margin-left:8.4%; margin-top:10px;}
.file_input_div {position:relative; width:80px; height:36px; overflow:hidden;}
.file_input_hidden {font-size:29px; position:absolute; right:0px; 
	top:0px; opacity:0; filter: alpha(opacity=0); 
	-ms-filter: alpha(opacity=0); cursor:pointer;}
</style>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- SmartEditor2 라이브러리  --> 
<script type="text/javascript" src="resources/smartEditor2/js/HuskyEZCreator.js" charset="utf-8"></script>
<script type="text/javascript" src="//code.jquery.com/jquery-1.11.0.min.js"></script>
</head>
<body>
	<jsp:include page="../common/menubar.jsp"/>
	<section id="main-content">
		<section class="wrapper">
			<div class="row mt">
				<div class="col-sm-11">
					<h2>공지사항 수정하기</h2>
					<form id="updateNotice" method="post" action="updateNotice.do" enctype="multipart/form-data">
						<br><br>
						<div id="titleDiv" class="form-group form-inline">
							<label for="title" class="col-sm-1" style="font-size:2rem">제목</label>
							<input type="text" id="title" class="form-control col-sm-10" name="noticeTitle" style="width:80%;" value="${ notice.noticeTitle }" required>
							<div class="file_input_div col-sm-1">
								<button type="button" class="file_input_img_btn btn btn-info">파일첨부</button>
								<input type="file" name="reUploadFile" class="file_input_hidden"
								onchange="javascript: document.getElementById('fileName').value = this.value">
								<input type="hidden" name="changeName" value="${ notice.changeName }">
								<input type="hidden" name="originName" value="${ notice.originName }">
							</div>
						</div>
						<input type="text" id="fileName" class="file_input_textbox" placeholder="첨부파일명" value="${ notice.originName }" readonly>
						<div id="contentDiv" class="form-group" style="margin-top:3%;">
							<textarea id="content" name="noticeContent" style="width:100%; height:500px;">${ notice.noticeContent }</textarea>
						</div>
						<div id="inputHidden">
							<input type="hidden" name="noticeWriter" value="${ loginUser.empNo }">
							<input type="hidden" name="noticeNo" value="${ notice.noticeNo }" >
						</div>
						<div align="center">
		                    <button id="update" class="btn btn-primary btn-lg">수정하기</button>&nbsp;&nbsp;&nbsp;
		                    <button type="button" onclick="javascript:history.go(-1);" class="btn btn-danger btn-lg">취소하기</button>
		                </div>
					</form>
				</div>
			</div>
		</section>
	</section>
</body>
<script id="smartEditor" type="text/javascript"> 
		var oEditors = [];
		nhn.husky.EZCreator.createInIFrame({
		    oAppRef: oEditors,
		    elPlaceHolder: "content",  //textarea ID 입력
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
		
	$("#update").click(function() {
		oEditors.getById["content"].exec("UPDATE_CONTENTS_FIELD", []);
		
		if($("#title").val() == ""){
			alert("제목을 입력해주세요");
			$("#title").focus();
			return false;
		}
		
		var contents = $.trim(oEditors[0].getContents());
		console.log(contents);
		if(contents === "" || contents === "<p>&nbsp;</p>"){
			alert("글 내용을 입력해주세요");
			$("#content").focus();
			return false;
		}
		
		
		$("#updateNotice.do").submit();
	});
</script>
</html>