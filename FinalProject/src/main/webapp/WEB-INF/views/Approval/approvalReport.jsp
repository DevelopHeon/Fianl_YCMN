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
						<form action="insertLeaveApproval.do" method="post" class="form-inline" enctype="multipart/form-data">
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
										<div class="modal-dialog modal-sm">
											<div class="modal-content">
												<div class="modal-header">
													<h3 class="modal-title">결재자 등록</h3>
													<button type="button" class="close" data-dismiss="modal">&times;</button>
												</div>
												<div class="modal-body">
													<div id="dept"></div>
													<h4>총무부서 &nbsp;<a data-toggle="collapse" data-target="#dept1"><i class="bi bi-arrow-down"></i></a></h4>
													<div id="dept1" class="collapse"></div>
													<h4>인사부서&nbsp;<a data-toggle="collapse" data-target="#dept2"><i class="bi bi-arrow-down"></i></a></h4>
													<div id="dept2" class="collapse"></div>
													<h4>개발부서&nbsp;<a data-toggle="collapse" data-target="#dept3"><i class="bi bi-arrow-down"></i></a></h4>
													<div id="dept3" class="collapse"></div>
												</div>
												<div class="modal-footer" id="modalBtn">
												</div>
											</div>
										</div>
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
			// 결재자 조회 ajax
			function selectApprover(num, empNo){
				var insertVal = "";
				$.ajax({
					url:"selectApprover.do",
					type:"get",
					data:{empNo:empNo},
					success:function(list){
						var value1 = "";
						var value2 = "";
						var value3 = "";
						var value4 = "";
						$.each(list, function(i, obj){
							if(obj.depName == '총무'){
								value1 += "<div class='apperList'><input type='radio' name='chk_approver' class='chk_approver' value="+ obj.empName +">&nbsp;&nbsp;"
								  +   obj.empName + "/"+ obj.posName
								  +   "<input type='hidden' class='form-control' value="+ obj.empNo +" name='empNo'></div>";
							}else if(obj.depName == '인사'){
								value2 += "<div class='apperList'><input type='radio' name='chk_approver' class='chk_approver' value="+ obj.empName +">&nbsp;&nbsp;"
								  +   obj.empName + "/"+ obj.posName
								  +   "<input type='hidden' class='form-control' value="+ obj.empNo +" name='empNo'></div>";
							}else if(obj.depName == '개발'){
								value3 += "<div class='apperList'><input type='radio' name='chk_approver' class='chk_approver' value="+ obj.empName +">&nbsp;&nbsp;"
								  +   obj.empName + "/"+ obj.posName
								  +   "<input type='hidden' class='form-control' value="+ obj.empNo +" name='empNo'></div>";
							}else{
								value4 += "<div class='apperList'><input type='radio' name='chk_approver' class='chk_approver' value="+ obj.empName +">&nbsp;&nbsp;"
								  +   obj.empName + "/"+ obj.posName
								  +   "<input type='hidden' class='form-control' value="+ obj.empNo +" name='empNo'></div>";
							}
						});
						
						// 1,2에 따라서 결재자 추가 버튼 생성
						if(num == 1){
							insertVal += '<button type="button" onclick="insertApprover(1)" id="addBtn" class="btn btn-primary">추가</button>'
									  +  '<button type="button" class="btn btn-danger" data-dismiss="modal">취소</button>'
						}else{
							insertVal += '<button type="button" onclick="insertApprover(2)" id="addBtn" class="btn btn-primary">추가</button>'
								  +  '<button type="button" class="btn btn-danger" data-dismiss="modal">취소</button>'
						}
						
						$("#dept1").html(value1);
						$("#dept2").html(value2);
						$("#dept3").html(value3);
						$("#dept").html(value4);
						$("#modalBtn").html(insertVal);
						
					},error:function(){
						console.log("결재자 조회용 ajax 통신 실패");
					}
				});
			}
		</script>
		<script>
		// 결재자 추가 스크립트
			function insertApprover(num){
				var approver = $("input[name=chk_approver]:checked").val();
				var approverNo = $("input[name=chk_approver]:checked").next().val();
				
				// radio 체크 여부에 따라 추가 버튼 활성화
				if($('input[name=chk_approver]:checked').length < 1){
					alert('결재자 선택후 버튼을 눌러주세요.')
					return false;
				}
				
				// 중복 결재자이면 추가되지 않도록 체크
				if($("input[name=firstApprover]").val() == approverNo || $("input[name=lastApprover]").val() == approverNo){
					console.log(approverNo);
					alert("이미 추가된 결재자입니다. 다른 사원을 선택하세요.");
					return false;
				}
				
				// 선택한 사원 테이블에 추가
				if(num == 1){
					// DB에 저장할때 사용할 사번도 추가해준다.
					approver += "<input type='hidden' class='form-control' value="+ approverNo +" name='firstApprover'>";			
					$("#firstApprover").html(approver);
				}else{
					approver += "<input type='hidden' class='form-control' value="+ approverNo +" name='lastApprover'>";
					$("#lastApprover").html(approver);
				}
				
				$(".close").click();
				
			}
		</script>
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