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
	<jsp:include page="../main.jsp"/>
	<section id="main-content">
			<section class="wrapper">
				<div class="container" id="main-container">
					<h3 style="margin-top:8%;">결재 수신함</h3>
					<hr>
					<c:if test="${ empty list }">
						<h4>조회된 결재문서가 없습니다.</h4>
					</c:if>
					<input type="hidden" id="userNo" value="${ loginUser.empNo }">
					<table id="myAppList" class="table table-hover" style="text-align:center;">
						<thead style="background:lightgray;">
							<tr>
								<th>번호</th>
								<th style="width:40%;">제목</th>
								<th>결재 양식</th>
								<th>기안일</th>
								<th>기안자</th>
								<th>반려자</th>
								<th>결재 상태</th>
							</tr>
						</thead>
					<tbody id="listTable">
						<c:forEach items="${ list }" var="app">
							<tr>
								<td><input type="hidden" class="number" value="${ app.appNo }" />${ app.rownum }</td>
								<td>${ app.appTitle }</td>
								<c:choose>
									<c:when test="${ app.appKinds eq 3 }">
										<td>휴가신청서</td>
									</c:when>
									<c:when test="${ app.appKinds eq 2 }">
										<td>지출결의서</td>
									</c:when>
									<c:otherwise>
										<td>업무 보고서</td>
									</c:otherwise>
								</c:choose>
								<td>${ app.appCreateDate }</td>
								<td>${ app.appWriterNo }</td>
								<td>${ app.rejecter }</td>
								<td>
								<c:choose>
									<c:when test="${ app.appStatus eq 'W' }">
										결재 대기
									</c:when>
									<c:when test="${ app.appStatus eq 'I' }">
										결재 중
									</c:when>
									<c:when test="${ app.appStatus eq 'C' }">
										결재 완료
									</c:when>
									<c:otherwise>
										반려
									</c:otherwise>
								</c:choose>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				<br>
				<br clear="both">
				<div id="paginArea" style="margin-left:40%;">
					<ul class="pagination justify-content-center">
						<c:choose>
							<c:when test="${ pi.currentPage ne 1 }">
								<li class="page-item"><a class="page-link" href="listInbox.do?currentPage=${ pi.currentPage-1 }&userNo=${ loginUser.empNo }">Previous</a></li>
							</c:when>
							<c:otherwise>
								<li class="page-item disabled"><a class="page-link" href="#">Previous</a></li>
							</c:otherwise>
						</c:choose>
						
						<c:forEach begin="${ pi.startPage }" end="${ pi.endPage }" var="p">
							<c:choose>
								<c:when test="${ pi.currentPage ne p }">
									<li class="page-item"><a class="page-link" href="listInbox.do?currentPage=${ p }&userNo=${ loginUser.empNo }">${ p }</a></li>
								</c:when>
								<c:otherwise>
									<li class="page-item disabled"><a class="page-link" href="">${ p }</a></li>
								</c:otherwise>
							</c:choose>
						</c:forEach>
						
						<c:choose>
							<c:when test='${ pi.currentPage ne pi.maxPage}'>
								<li class="page-item"><a class="page-link" href="listInbox.do?currentPage=${ pi.currentPage+1 }&userNo=${ loginUser.empNo }">Next</a></li>
							</c:when>
							<c:otherwise>
								<li class="page-item disabled"><a class="page-link" href="#">Next</a></li>
							</c:otherwise>
						</c:choose>
					</ul>
				</div>
				</div>
			</section>
		</section>
</body>
<!-- 클릭시 상세조회 화면이동 -->
<script>
	$(function(){
		$("#myAppList tbody tr").click(function(){
			<%-- 현재 선택한 tr의 결재 양식 값 담기 양식마다 상세조회 페이지가 다르기때문에 --%>
			var appKinds = $(this).children().eq(2).text();
			<%-- hidden으로 숨겨놓은 클릭한 문서의 고유 번호 --%>			
			var thisRow = $(this).closest('tr');
			var appNo = thisRow.find('td:eq(0)').find('input').val();
			console.log(appNo);
			
			console.log(appNo);
			if(appKinds == '지출결의서'){
				appKinds = 2;
			}else if(appKinds == '휴가신청서'){
				appKinds = 3;
			}else{
				appKinds = 4;
			}
			console.log(appKinds);
			location.href = "detailApproval.do?appNo="+appNo+"&appKinds="+appKinds;
		});
	});
</script>
</html>