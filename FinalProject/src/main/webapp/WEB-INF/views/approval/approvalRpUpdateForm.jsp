<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
	<jsp:include page="../main.jsp"/>
	<!-- 업무 보고서 작성 Form -->
		<section id="main-content">
			<section class="wrapper">
				<div class="container" id="main-container">
					<h3>업무보고서</h3>
					<hr>
					<div class="row">
						<!-- 전자결재 양식 시작 -->
						<form action="updateApprovalReport.do" method="post"
						 class="form-inline" enctype="multipart/form-data">
							<div class="form-group" style="line-height:2em;">
								<label for="depName">부서명 : </label>
									<input type="text" style="margin-left:3%;" class="form-control" id="depName" name="appMap.employee.depName" value="${ appMap.employee.depName }" readonly>
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
												<td id="firstApprover">
													${ appMap.approval.firstApprover }
													<input type='hidden' class='form-control' value="${appMap.approval.firstAppNo}" name='firstApprover'>
												</td>
												<td id="lastApprover">${ appMap.approval.lastApprover }
													<input type='hidden' class='form-control' value="${appMap.approval.lastAppNo}" name='lastApprover'>
												</td>
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
												<td><button class="btn-sm btn-primary" onclick="selectApprover(1, '${sessionScope.loginUser.empNo}')" type="button" data-toggle="modal" data-target="#firstModal">결재자 수정</button></td>
												<td><button class="btn-sm btn-primary" onclick="selectApprover(2, '${sessionScope.loginUser.empNo}')" type="button" data-toggle="modal" data-target="#firstModal">결재자 수정</button></td>
											</tr>
										</tbody>
									</table>
									<!-- 결재자 추가 클릭 시 뜨는 모달 공통으로 사용하므로 jsp 페이지로 따로 빼서 구현-->
									<div class="modal fade" id="firstModal" style="height:60%;">
										<jsp:include page="approverModal.jsp"/>
									</div>
								<label for="posName"> 직위/직책 :</label> 
									<input type="text" class="form-control" style="margin-left:1.3%;" id="posName" value="${ appMap.employee.posName }" readonly>
									<br>
								<label for="empName"> 기안자명 :</label>
									<input type="text" class="form-control"style="margin-left:1.8%;" id="empName" value="${ appMap.approval.appWriterNo }" readonly>
									<br>
								<label for="appCreateDate"> 기안일 :</label>
									<input type="text" class="form-control" style="margin-left:3%;" id="appCreateDate" value="${ appMap.approval.appCreateDate }" readonly>
								<br>
								<!-- 전자결재 데이터에 필요한 문서 제목, 작성자 사번, 결재양식 hidden 값으로 전달 -->
								<div class="hiddenInfo">
									<input type="hidden" class="form-control" id="appWriterNo" name="appWriterNo" value="${ sessionScope.loginUser.empNo }">
									<input type=hidden class="form-control" id="appKinds" name="appKinds" value="4">
									<input type=hidden class="form-control" id="appNo" name="appNo" value="${ appMap.approval.appNo }">
								</div>
								<br>
								<hr>
								<label for="appTitle">제목 : </label>
									<input type="text" class="form-control" id="appTitle" name="appTitle" value="${appMap.approval.appTitle}" style="margin-left:5%; width:35%" placeholder="업무보고서 제목" required />
								<br>
								<label for="reportContent">업무 내용 : </label>
								<textarea class="form-control" name="approvalReport.reportContent" id="reportContent" rows="8" cols="52" style="resize:none; margin-left:2.3%; margin-top:1%;" required><c:out value="${ appMap.approvalReport.reportContent }" /></textarea>
								<br>
								<label for="reportIssue">특이사항 : </label>
								<textarea class="form-control" name="approvalReport.reportIssue" id="reportIssue" rows="8" cols="52" style="resize:none; margin-left:2.5%; margin-top:2%;"><c:out value="${appMap.approvalReport.reportIssue}" /></textarea>
								<br><br>
								<b>* 보고서 서류 첨부 (첨부할 파일이 있는경우에만 추가)</b><br><br>
								<input type="file" id="reUploadFile" name="reUploadFile" class="form-control" style="width:50%; height:3%;">
								<c:if test="${ !empty appMap.attachment.originName  }">
									<br><br><b> * 현재 첨부 파일 : ${ appMap.attachment.originName }</b><br>
								</c:if>
									<input type="hidden" name="attachment.changeName" value="${ appMap.attachment.changeName }">
									<input type="hidden" name="attachment.originName" value="${ appMap.attachment.originName }">
							</div>
							<div class="btns" align="center" style="margin-top:5%;">
							<button type="submit" id="erAppBtn" class="btn btn-primary btn-lg">수정하기</button>
							<button type="button" class="btn btn-danger btn-lg" onclick="javascript:history.go(-1);">이전으로</button>
						</div>
						</form>
					</div>
				</div>
			</section>
		</section>
</body>
</html>