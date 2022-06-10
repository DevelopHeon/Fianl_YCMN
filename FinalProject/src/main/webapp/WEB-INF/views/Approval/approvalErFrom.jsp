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
									<input type="text" class="form-control" id="depName" name="depName" value="${ sessionScope.loginUser.depName }" readonly>
									<br>
									<table class="table table-bordered" style="width:300px; float:right; margin-right:5%; text-align:center;">
										<tbody>
											<tr style="background:lightgray; font-weight:bold;">
												<td rowspan="6" style="vertical-align:middle; width:30%;">결재</td>
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
								<label for="empName"> 기안자명 :</label>
									<input type="text" class="form-control" id="empName" name="empName" value="${ sessionScope.loginUser.empName }" readonly>
									<br>
								<label for="appCreateDate"> 기안일 :</label>
									<input type="text" class="form-control" id="appCreateDate" name="appCreateDate" readonly>
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
								<input type="text" class="form-control" id="bankName" name="bankName" placeholder="은행명을 입력하세요." required>
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
												<th style="width:10%;">* 증빙</th>
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
													<input type="file" id="uploadFile" name="uploadFile" multiple>
												</td>
												<td>
													<button type="button" id="rowRemoveBtn" class="btn btn-danger" disabled>삭제</button>
												</td>
											</tr>
										</tbody>
									</table>
									<button type="button" id="rowAddBtn" class="btn btn-primary">추가</button>
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
		// 추가하기 버튼 클릭시 지출내용 작성 row 추가하기
		var count = 0;
		$("#rowAddBtn").click(function(){
			var trCnt = $('#erTable tr').length;
			count++;
			console.log(count);
			var insertTr = "";
			if(trCnt < 6){
				insertTr += '<tr><td><input type="text" class="form-control" list="listOptions" id="approvalErs['+count+'].erClass" name="erClass" placeholder="과목입력">'
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
					 + '<td><input type="file" id="uploadFile" name="uploadFile" multiple></td>'
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
		// 증빙 항목 작성 row 삭제하기
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