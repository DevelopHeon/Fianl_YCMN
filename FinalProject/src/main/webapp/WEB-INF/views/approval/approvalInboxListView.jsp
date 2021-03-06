<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>결재 수신함</title>
<style>
.card{
	display:flex;
	justify-content:center;
	align-items: center;
}
.card-body {
	margin-right:22%;
}
p{
	font-size:2.8rem;
	color:#16c97e;
}
</style>
</head>
<body>
	<jsp:include page="../common/menubar.jsp"/>
	<section id="main-content">
			<section class="wrapper">
				<div class="container" id="main-container">
				<h3>결재현황</h3>
				<div class="row" style="white-space:nowrap;">
					<div class="col-sm-3" style="margin-left:12.5%;">
						<div class="card">
							<div class="card-body col-sm-3">
								<h1>&nbsp;${ appCnt.APP_W } 건</h1>
								<a href="selectInboxList.do?appStatus=W&userNo=${ loginUser.empNo }"><p>결재대기</p></a>
							</div>
						</div>
					</div>
					<div class="col-sm-3">
						<div class="card">
							<div class="card-body col-sm-3">
								<h1>${ appCnt.APP_I } 건</h1>
								<a href="selectInboxList.do?appStatus=I&userNo=${ loginUser.empNo }"><p>결재중</p></a>
							</div>
						</div>
					</div>
					<div class="col-sm-3">
						<div class="card">
							<div class="card-body col-sm-3">
								<h1>&nbsp;${ appCnt.APP_C } 건</h1>
								<a href="selectInboxList.do?appStatus=C&userNo=${ loginUser.empNo }"><p>결재완료</p></a>
							</div>
						</div>
					</div>
				</div>
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
								<th style="width:25%;">제목</th>
								<th>결재 양식</th>
								<th>기안일</th>
								<th>기안자</th>
								<th>1차 승인일</th>
								<th>2차 승인일</th>
								<th>결재 상태</th>
								<th style="width:5%;">차례</th>
							</tr>
						</thead>
					<tbody id="listTable">
						<c:forEach items="${ list }" var="app">
							<tr>
								<td><input type="hidden" class="number" value="${ app.appNo }" />${ app.rownum }</td>
								<td>${ app.appTitle }&nbsp;<c:if test="${app.opicnt != 0}">[<span style="color:#2c86dc;"><c:out value="${app.opicnt }"/></span>]</c:if></td>
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
								<td>
								<c:if test="${ empty app.firstApprovalDate }">
									미승인
								</c:if>
								<c:if test="${ !empty app.firstApprovalDate }">
									${ app.firstApprovalDate }
								</c:if>
								</td>
								<td>
								<c:if test="${ empty app.lastApprovalDate }">
									미승인
								</c:if>
								<c:if test="${ !empty app.lastApprovalDate }">
									${ app.lastApprovalDate }
								</c:if>
								</td>
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
								<%-- 승인차례일 경우 알려주기 위한 td --%>
								<td>
									<c:choose>
										<c:when test='${ empty app.firstApprovalDate and app.firstApprover == loginUser.empNo }'>
											<i class="bi bi-star-fill" style="color:#ffd400;"></i>
										</c:when>
										<c:when test='${ empty app.lastApprovalDate and !empty app.firstApprovalDate and app.lastApprover == loginUser.empNo }'>
											<i class="bi bi-star-fill" style="color:#ffd400;"></i>
										</c:when>
										<c:otherwise>
											
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
<!-- selectbox 값에따라 화면에 보이는 list 변경 -->
<script>
	function changeKinds(){
		var appStatus = $("#appStatusBox").val();
		var appWriterNo = $("#userNo").val();
		console.log(appStatus + "," + appWriterNo);
		location.href = "selectBoxList.do?appStatus=" + appStatus + "&appWriterNo=" + appWriterNo; 
	}
</script>
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