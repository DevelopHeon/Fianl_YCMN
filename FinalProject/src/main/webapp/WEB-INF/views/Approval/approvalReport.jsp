<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
	label, b{
		font-size:1.5rem;
		padding:20px 10px 10px 0px; /*위 오른쪽 아래 왼쪽*/
	}
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
						<form action="insertLeaveApproval.do" method="post" class="form-inline" enctype="multipart/form-data">
							<div class="form-group" style="line-height:2em;">
								<label for="depName">부서명 : </label>
									<input type="text" style="margin-left:3.7%;" class="form-control" id="depName" name="depName" value="${ sessionScope.loginUser.depName }" readonly>
									<br>
									<table class="table table-bordered" style="width:300px; float:right; margin-right:5%; text-align:center;">
										<tbody>
											<tr style="background:lightgray; font-weight:bold;">
												<td rowspan="5" style="vertical-align:middle; width:30%;">결재</td>
												<td>최초승인자</td>
												<td>최종승인자</td>
											</tr>
											<tr>
												<!-- <td>결재</td> -->
												<td></td>
												<td></td>
											</tr>
											<tr>
												<!-- <td></td> -->
												<td></td>
												<td></td>
											</tr>
											<tr>
												<!-- <td></td> -->
												<td></td>
												<td></td>
											</tr>
											<tr>
												<!-- <td></td> -->
												<td><button class="btn-sm btn-primary" type="button">결재자 추가</button></td>
												<td><button class="btn-sm btn-primary" type="button">결재자 추가</button></td>
											</tr>
										</tbody>
									</table>
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
									<input type=hidden class="form-control" id="appKinds" name="appKinds" value="3">
								</div>
								<hr>
								<label for="appTitle">제목 : </label>
									<input type="text" class="form-control" id="appTitle" name="appTitle" style="margin-left:5%; width:35%" placeholder="업무보고서 제목">
								<br>
								<label for="reportContent">업무 내용 : </label>
								<textarea class="form-control" required name="reportContent" id="reportContent" rows="8" cols="52" style="resize:none; margin-left:2.3%; margin-top:1%;"></textarea>
								<br>
								<label for="reportIssue">특이사항 : </label>
								<textarea class="form-control" required name="reportIssue" id="reportIssue" rows="8" cols="52" style="resize:none; margin-left:2.5%; margin-top:2%;"></textarea>
								<br><br><b>* 보고서 서류 첨부 (첨부할 파일이 있는경우에만 추가)</b><br>
								<input type="file" id="uploadFile" name="uploadFile" class="form-control" style="width:50%; height:3%;">
						</div>
						<div class="btns" align="center" style="margin-top:5%;">
							<button type="submit" id="erAppBtn" class="btn btn-primary btn-lg">결재요청</button>
							<button type="button" id="close" class="btn btn-danger btn-lg">취소하기</button>
						</div>
						</form>
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