<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>익명게시판 글 수정</title>
</head>
<!-- SmartEditor2 라이브러리  --> 
<script type="text/javascript" src="resources/smartEditor2/js/HuskyEZCreator.js" charset="utf-8"></script>
<script type="text/javascript" src="//code.jquery.com/jquery-1.11.0.min.js"></script>
<body>
	<jsp:include page="../common/menubar.jsp"/>
	<section id="main-content">
		<section class="wrapper">
			<div class="row mt">
				<div class="col-sm-11">
					<h2>게시글 수정하기</h2>
					<form id="updateAnoBoard" method="post" action="updateAnoBoard.do">
						<br><br>
						<div id="titleDiv" class="form-group form-inline">
							<label for="title" class="col-sm-1" style="font-size:2rem">제목</label>
							<input type="text" id="title" class="form-control col-sm-10" name="anoTitle" style="width:80%;" value="${ anoBoard.anoTitle }" required>
						</div>
						<br>
						<div id="contentDiv" class="form-group" style="margin-top:3%;">
							<textarea id="content" name="anoContent" style="width:100%; height:500px;"><c:out value="${ anoBoard.anoContent }" /></textarea>
						</div>
						<input type="hidden" id="anoNo" name="anoNo" value="${ anoBoard.anoNo }" >
						<input type="hidden" id="anoNo" name="userId" value="${ loginUser.empId }" >
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
		
		
		$("#updateAnoBoard").submit();
	});
</script>
</html>