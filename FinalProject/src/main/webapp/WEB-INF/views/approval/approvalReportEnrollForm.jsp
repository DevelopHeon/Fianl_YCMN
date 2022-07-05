<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>업무보고서 작성</title>
<style>
	.form-group{
		margin-left:2%;
		width:100%;
		font-weight:300;
	}
	.form-control{
		margin-left:2%;
	}
	label{
		font-size:1.5rem;
		padding:20px 10px 10px 0px; /*위 오른쪽 아래 왼쪽*/
	}
	h4{ font-weight:bold;}
</style>
</head>
<body>
	<jsp:include page="../common/menubar.jsp"/>
	<!-- 업무 보고서 작성 Form -->
		<section id="main-content">
			<section class="wrapper">
				<div class="container" id="main-container">
					<h3>업무보고서</h3>
					<hr>
					<div class="row">
						<!-- 전자결재 양식 시작 -->
						<form:form action="insertReportApproval.do" method="post"
						 modelAttribute="approval" class="form-inline" enctype="multipart/form-data">
							<div class="form-group" style="line-height:2em;">
								<label for="depName">부서명 : </label>
									<input type="text" style="margin-left:3.7%;" class="form-control" id="depName" name="depName" value="${ sessionScope.loginUser.depName }" readonly>
									<br>
									<table id="approverTable" class="table table-bordered" style="width:300px; float:right; margin-right:5%; text-align:center;">
										<tbody>
											<tr style="background:lightgray; font-weight:bold;">
												<td rowspan="5" style="vertical-align:middle; width:30%;">결재</td>
												<td>최초승인자</td>
												<td>최종승인자</td>
											</tr>
											<tr>
												<!-- <td>결재</td> -->
												<td id="firstApprover"></td>
												<td id="lastApprover"></td>
											</tr>
											<tr>
												<!-- <td></td> -->
												<td></td>
												<td></td>
											</tr>
											<tr>
												<!-- <td></td> -->
												<td id="firstApprovalDate"></td>
												<td id="lastApprovalDate"></td>
											</tr>
											<tr>
												<!-- <td></td> --> <!-- onclick="selectApprover()" -->
												<td><button class="btn-sm btn-primary" onclick="selectApprover(1, '${sessionScope.loginUser.empNo}')" type="button" data-toggle="modal" data-target="#firstModal">결재자 추가</button></td>
												<td><button class="btn-sm btn-primary" onclick="selectApprover(2, '${sessionScope.loginUser.empNo}')" type="button" data-toggle="modal" data-target="#firstModal">결재자 추가</button></td>
											</tr>
										</tbody>
									</table>
									<!-- 결재자 추가 클릭 시 뜨는 모달 -->
									<div class="modal fade" id="firstModal" style="height:60%;">
										<jsp:include page="approverModal.jsp"/>
									</div>
								<label for="posName"> 직위/직책 :</label> 
									<input type="text" class="form-control" id="posName" name="posName" value="${ sessionScope.loginUser.posName }" readonly>
									<br>
								<label for="empName">기안자명 :</label>
									<input type="text" class="form-control" style="margin-left:2.5%;" id="empName" name="empName" value="${ sessionScope.loginUser.empName }" readonly>
									<br>
								<label for="appCreateDate">기안일 :</label>
									<input type="text" class="form-control" style="margin-left:3.8%;" id="appCreateDate" name="appCreateDate" readonly>
								<br>
								<!-- 전자결재 데이터에 필요한 문서 제목, 작성자 사번, 결재양식 hidden 값으로 전달 -->
								<div class="hiddenInfo">
									<input type="hidden" class="form-control" id="appWriterNo" name="appWriterNo" value="${ sessionScope.loginUser.empNo }">
									<input type=hidden class="form-control" id="appKinds" name="appKinds" value="4">
								</div>
								<hr style="width:100%;">
								<label for="appTitle">제목 : </label>
									<form:input type="text" class="form-control" path="appTitle" id="appTitle" name="appTitle" style="margin-left:5%; width:35%" placeholder="업무보고서 제목" required="required" />
								<form:errors style="color:red; margin-left:3%;" path="appTitle"></form:errors>
								<br>
								<label for="reportContent">업무 내용 : </label>
								<form:textarea class="form-control" path="approvalReport.reportContent" name="approvalReport.reportContent" id="reportContent" rows="8" cols="52" style="resize:none; margin-left:2.3%; margin-top:1%;" required="required"></form:textarea>
								<br>
								<label for="reportIssue">특이사항 : </label>
								<form:textarea class="form-control" path="approvalReport.reportIssue" name="approvalReport.reportIssue" id="reportIssue" rows="8" cols="52" style="resize:none; margin-left:2.5%; margin-top:2%;"></form:textarea>
								<br><br>
								<div class="errorCode" style="margin-left:5%;">
									<h3 style="color:red;"><form:errors path="firstApprover" /></h3>
									<h3 style="color:red;"><form:errors path="lastApprover" /></h3>
								</div>
								<b>* 보고서 서류 첨부 (첨부할 파일이 있는경우에만 추가)</b><br><br>
								<input type="file" id="uploadFile" name="uploadFile" class="form-control" style="width:50%; height:3%;">
							</div>
							<div class="btns" align="center" style="margin-top:5%;">
								<button type="submit" id="erAppBtn" class="btn btn-primary btn-lg">결재요청</button>
								<button type="button" id="close" class="btn btn-danger btn-lg">취소하기</button>
							</div>
						</form:form>
					</div>
				</div>
			</section>
		</section>
		<script>
			// close 클릭시 이전화면으로 이동
			$("#close").click(function(){
				$(location).attr("href", "main.do");
			})
		</script>
		<script>
		// 오늘 날짜 화면에 출력
		 document.getElementById('appCreateDate').value = new Date().toISOString().substring(0, 10);
		</script>
</body>
</html>