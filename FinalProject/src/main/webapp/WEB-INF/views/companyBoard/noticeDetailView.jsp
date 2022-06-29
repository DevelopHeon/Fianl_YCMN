<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<jsp:include page="../common/menubar.jsp"/>
		<section id="main-content">
			<section class="wrapper">
				<div class="container" id="main-container">
					<h2 style="text-align:center;">공지사항</h2>
					<hr>
					<h3>${ notice.noticeTitle }</h3>
					<b>작성자 : ${ notice.noticeWriter }</b> |
					<b>${notice.createDate }</b>
					<c:if test="${ notice.noticeWriter eq loginUser.empName }">
	                	<button type="button" style="margin-left:70%;" class="btn btn-primary" onclick="noticeFormSubmit(1);">수정하기</button>
                		<button type="button" class="btn btn-danger" onclick="noticeFormSubmit(2);">삭제하기</button>
					</c:if>
					<form id="noticeForm" action="" method="post">
						<input type="hidden" name="noticeNo" value="${ notice.noticeNo }">
						<input type="hidden" name="fileName" value="${ notice.changeName }">
					</form>
					<br>
					<small>조회수 : <c:out value="${ notice.count }" /></small>
					<hr style="opacity:0.4;">
					<c:if test="${ !empty notice.originName }">
						<b>첨부파일 : <a href="${ pageContext.servletContext.contextPath }/resources/noticeUpload_files/${notice.changeName}" download="${ notice.originName }">${ notice.originName }</a></b>
						<hr style="opacity:0.4;">
					</c:if>
					<br><br>
					<div id="noticeContent">
						${ notice.noticeContent }					
					</div>
					<br>
					<hr>
					<br>
					<div align="center">
						<button type="button" class="btn btn-secondary btn-lg" onclick="location.href='listNotice.do';"><b>목록으로</b></button>
					</div>
				</div>
			</section>
		</section>
</body>
<script>
// 수정, 삭제 스크립트
	function noticeFormSubmit(num){
		var noticeForm = $("#noticeForm");
		
		if(num == 1){
			noticeForm.attr("action", "updateFormNotice.do");
		}else if(num ==2){
			if(confirm("정말 삭제하시겠습니까?")){
				noticeForm.attr("action", "deleteNotice.do");
			}else{
				return false;
			}
		}
		noticeForm.submit();
	} 
</script>
</html>