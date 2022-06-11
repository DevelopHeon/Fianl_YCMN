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
	h4{ font-weight:bold;}
</style>
</head>
<body>
	<jsp:include page="../main.jsp"/>
	<!-- 지출결의서 작성 Form -->
		<section id="main-content">
			<section class="wrapper">
				<div class="container" id="main-container">
					<h3>지출결의서</h3>
					<hr>
					<div class="row">
						<!-- 전자결재 양식 시작 -->
						<form action="insertErApproval.do" method="post" class="form-inline" enctype="multipart/form-data">
							<div class="form-group" style="line-height:2em;">
								<label for="depName">부서명 : </label>
									<input type="text" style="margin-left:3%;" class="form-control" id="depName" name="depName" value="${ sessionScope.loginUser.depName }" readonly>
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
												<!-- <td></td> --> <!-- onclick="selectApprover()" -->
												<td><button class="btn-sm btn-primary" onclick="selectApprover()" type="button" data-toggle="modal" data-target="#firstModal">결재자 추가</button></td>
												<td><button class="btn-sm btn-primary" type="button">결재자 추가</button></td>
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
												<div class="modal-footer">
													<button type="button" class="btn btn-primary">추가</button>
													<button type="button" class="btn btn-danger" data-dismiss="modal">취소</button>
												</div>
											</div>
										</div>
									</div>
								<label for="posName"> 직위/직책 :</label> 
									<input type="text" class="form-control" style="margin-left:1.3%;" id="posName" name="posName" value="${ sessionScope.loginUser.posName }" readonly>
									<br>
								<label for="empName"> 기안자명 :</label>
									<input type="text" class="form-control"style="margin-left:1.8%;" id="empName" name="empName" value="${ sessionScope.loginUser.empName }" readonly>
									<br>
								<label for="appCreateDate"> 기안일 :</label>
									<input type="text" class="form-control" style="margin-left:3%;" id="appCreateDate" name="appCreateDate" readonly>
								<br>
								<!-- 전자결재 데이터에 필요한 문서 제목, 작성자 사번, 결재양식 hidden 값으로 전달 -->
								<div class="hiddenInfo">
									<input type="hidden" class="form-control" id="appTitle" name="appTitle" value="지출결의서_${ sessionScope.loginUser.empName }">
									<input type="hidden" class="form-control" id="appWriterNo" name="appWriterNo" value="${ sessionScope.loginUser.empNo }">
									<input type=hidden class="form-control" id="appKinds" name="appKinds" value="2">
								</div>
								<br>
							<hr>
							<div class="erInfo">
								<label for="bankName">은행명 : </label>
								<input type="text" class="form-control" id="bankName" name="bankName" style="margin-left:3.2%;" placeholder="은행명을 입력하세요." required>
								<label for="erAccountHolder" style="margin-left:20%;">예금주 : </label>
								<input type="text" class="form-control" id="erAccountHolder" name="erAccountHolder" placeholder="예금주명" required>
								<br>
								<label for="accountNumber">계좌번호 : </label>
								<input type="text" style="width:25%;" class="form-control" id="accountNumber" name="accountNumber" placeholder="계좌번호를 입력하세요. ('-'미포함)" required>
								<label for="erAmount" style="margin-left:7%;">총 지출금액 : </label>
								<input type="number" class="form-control" id="erAmount" name="erAmount" placeholder="숫자만 입력" required>
								<br>
								<b>* 경비지출 확인을 위해 증빙란에 지출에 관련된 서류를 첨부해주세요.</b>
								<div class="tableDiv" style="margin-top:3%;">
									<table class="table" id="erTable">
										<thead>
											<tr>
												<th>* 계정과목</th>
												<th>* 지출일자</th>
												<th>* 지출내용</th>
												<th>* 사용처</th>
												<th>* 결제수단</th>
												<th>* 삭제</th>
											</tr>
										</thead>
										<tbody>
											<tr>
												<td><input type="text" class="form-control" list="listOptions" id="erClass" name="approvalErs[0].erClass" placeholder="과목입력" required>
													<datalist id="listOptions">
														<option value="교육훈련비">
														<option value="도서인쇄비">
														<option value="접대비">
														<option value="사무용품비">
														<option value="복리후생비">
														<option value="통신비">
														<option value="여비교통비">
													</datalist>
												</td>
												<td>
													<input class="form-control" type="date" id="erDate" name="approvalErs[0].erDate" required>
												</td>
												<td>
													<input class="form-control" type="text" id="erDetail" name="approvalErs[0].erDetail" placeholder="내용" required>
												</td>
												<td>
													<input class="form-control" type="text" id="erUse" name="approvalErs[0].erUse" placeholder="사용처" required>
												</td>
												<td>
													<select class="form-control" name="approvalErs[0].erPayment" required>
														<option value="M">현금</option>
														<option value="PC">개인카드</option>
														<option value="BC">법인카드</option>
													</select>
												</td>
												<td>
													<button type="button" id="rowRemoveBtn" class="btn btn-danger" disabled>삭제</button>
												</td>
											</tr>
										</tbody>
									</table>
									<button type="button" id="rowAddBtn" class="btn btn-primary">추가</button>
									<div class="addFile" style="margin-top:2%;">
										<b>* 증빙서류 첨부</b><br>
										<input type="file" id="uploadFile" name="uploadFile" class="form-control" style="width:50%; height:3%;" required>
									</div>
								</div>
							</div>
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
			function selectApprover(){
				$.ajax({
					url:"selectApprover.do",
					type:"get",
					success:function(list){
						var value1 = "";
						var value2 = "";
						var value3 = "";
						var value4 = "";
						$.each(list, function(i, obj){
							
							if(obj.depName == '총무'){
								value1 += "<p><input type='radio' name='chk_approver' value="+ obj.empName +">&nbsp;&nbsp;"
								  +   obj.empName + "/"+ obj.posName +"</p>"
								  +   "<input type='hidden' class='form-control' value="+ obj.empNo +" name='empNo'>";
							}else if(obj.depName == '인사'){
								value2 += "<p><input type='radio' name='chk_approver' value="+ obj.empName +">&nbsp;&nbsp;"
								  +   obj.empName + "/"+ obj.posName +"</p>"
								  +   "<input type='hidden' class='form-control' value="+ obj.empNo +" name='empNo'>";
							}else if(obj.depName == '개발'){
								value3 += "<p><input type='radio' name='chk_approver' value="+ obj.empName +">&nbsp;&nbsp;"
								  +   obj.empName + "/"+ obj.posName +"</p>"
								  +   "<input type='hidden' class='form-control' value="+ obj.empNo +" name='empNo'>";
							}else{
								value4 += "<p><input type='radio' name='chk_approver' value="+ obj.empName +">&nbsp;&nbsp;"
								  +   obj.empName + "/"+ obj.posName +"</p>"
								  +   "<input type='hidden' class='form-control' value="+ obj.empNo +" name='empNo'>";
							}
								   
						});
						$("#dept1").html(value1);
						$("#dept2").html(value2);
						$("#dept3").html(value3);
						$("#dept").html(value4);
					},error:function(){
						console.log("결재자 조회용 ajax 통신 실패")
					}
				});
			}
		</script>
		<script>
		// 추가하기 버튼 클릭시 지출내용 작성 row 추가하기
		var count = 0;
		$("#rowAddBtn").click(function(){
			var trCnt = $('#erTable tr').length;
			count++;
			console.log(count);
			var insertTr = "";
			if(trCnt < 6){
				insertTr += '<tr><td><input type="text" class="form-control" list="listOptions" id="erClass" name="approvalErs['+count+'].erClass" placeholder="과목입력">'
					 + '<datalist id="listOptions">'
					 + '<option value="교육훈련비">'
					 + '<option value="도서인쇄비">'
					 + '<option value="접대비">'
					 + '<option value="사무용품비">'
					 + '<option value="복리후생비">'
					 + '<option value="통신비">'
					 + '<option value="여비교통비">'
					 + '</datalist></td>'
					 + '<td><input class="form-control" type="date" id="erDate" name="approvalErs['+count+'].erDate"></td>'
					 + '<td><input class="form-control" type="text" id="erDetail" name="approvalErs['+count+'].erDetail" placeholder="내용"></td>'
					 + '<td><input class="form-control" type="text" id="erUse" name="approvalErs['+count+'].erUse" placeholder="사용처"></td>'
					 + '<td><select class="form-control" name="approvalErs['+count+'].erPayment">'
					 + '<option value="M">현금</option>'
					 + '<option value="PC">개인카드</option>'
					 + '<option value="BC">법인카드</option></select></td>'
					 + '<td><button type="button" id="rowRemoveBtn" onclick="goDelete(this);" class="btn btn-danger">삭제</button></td></tr>'
					 
					 console.log(insertTr);
				$("#erTable>tbody:last").append(insertTr);
			}else{
				alert("최대 5개까지만 추가가 가능합니다.");
				return false;
			}
		});
		</script>
		<script>
		// 지출항목 작성 row 삭제하기
		function goDelete(obj){
			$(obj).closest('tr').remove();
			count--;
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