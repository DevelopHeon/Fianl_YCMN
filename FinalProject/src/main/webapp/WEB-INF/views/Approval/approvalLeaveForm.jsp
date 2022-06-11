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
	<!-- 휴가신청서 작성 Form -->
		<section id="main-content">
			<section class="wrapper">
				<div class="container" id="main-container">
					<h3>휴가신청서</h3>
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
									<input type="hidden" class="form-control" id="appTitle" name="appTitle" value="휴가신청서_${ sessionScope.loginUser.empName }">
									<input type="hidden" class="form-control" id="appWriterNo" name="appWriterNo" value="${ sessionScope.loginUser.empNo }">
									<input type=hidden class="form-control" id="appKinds" name="appKinds" value="3">
								</div>
								<br>
							<hr>
							<span style="font-size:1.5rem;">휴가 종류 :</span>
							<select name="leaveCategory" class="form-control" style="margin-left:2.8%;">
								<option value="L">연차</option>
								<option value="AH">오전 반차</option>
								<option value="PH">오후 반차</option>
								<option value="FE">경조사</option>
							</select><br>
							<label for="leaveStart">기간 및 일시 :</label>
								<input class="form-control" style="margin-left:0.5%;" type="date" id="leaveStart" name="leaveStart" required>
							<label for="leaveFinish" style="margin-left:2%;">~</label>
								<input class="form-control" type="date" id="leaveFinish" name="leaveFinish" required>
							<label for="leaveTotalDate" style="margin-left:5%;">사용 연차일 : </label>
								<input class="form-control" type="text" id="leaveTotalDate" name="leaveTotalDate" placeholder="사용 연차 일수 작성" required>
							<br><br>
							<label for="leaveReason">휴가 사유 : </label>
								<textarea class="form-control" required name="leaveReson" id="leaveReson" rows="10" cols="50" style="resize:none;"></textarea>
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