<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%-- 검증 실패시에도 기존 값 유지되도록 form 태그 추가 --%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>지출결의서 수정</title>
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
	<!-- 지출결의서 작성 Form -->
		<section id="main-content">
			<section class="wrapper">
				<div class="container" id="main-container">
					<h3>지출결의서</h3>
					<hr>
					<div class="row">
						<!-- 전자결재 양식 시작 -->
						<form action="updateApprovalEr.do" method="post" 
						onsubmit="return approvalErValidate();" class="form-inline" 
						enctype="multipart/form-data">
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
									<input type=hidden class="form-control" id="appKinds" name="appKinds" value="2">
									<input type=hidden class="form-control" id="appKinds" name="appNo" value="${ appMap.approval.appNo }">
									<input type="hidden" class="form-control" id="appTitle" name="appTitle" value="지출결의서_${ sessionScope.loginUser.empName }">
								</div>
								<br>
							<hr>
							<div class="erInfo">
								<label for="bankName">은행명 : </label>
								<input type="text" class="form-control" id="bankName" name="apperAccount.bankName" value="${appMap.apperAccount.bankName }" style="margin-left:3.2%;" placeholder="은행명을 입력하세요." required />
								<label for="erAccountHolder" style="margin-left:20%;">예금주 : </label>
								<input type="text" class="form-control" id="erAccountHolder" name="apperAccount.erAccountHolder" value="${appMap.apperAccount.erAccountHolder}" placeholder="예금주명"  required />
								<br>
								<label for="accountNumber">계좌번호 : </label>
								<input type="text" value="${appMap.apperAccount.accountNumber}" style="width:25%;" class="form-control" id="accountNumber" name="apperAccount.accountNumber" placeholder="계좌번호를 입력하세요. ('-'미포함)"  required />
								<label for="erAmount" style="margin-left:7%;">총 지출금액 : </label>
								<input type="number" class="form-control" id="erAmount" name="apperAccount.erAmount" value="${appMap.apperAccount.erAmount}" placeholder="숫자만 입력"  required />
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
										<c:forEach items="${ list }" var="appEr" varStatus="status">
											<tr>
												<td><input type="text" class="form-control" list="listOptions" id="erClass" name="approvalErs[${status.index}].erClass" value="${appEr.erClass}" placeholder="과목입력"  required />
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
													<input class="form-control" type="date" id="erDate" name="approvalErs[${status.index}].erDate" value="${appEr.erDate}" required />
												</td>
												<td>
													<input class="form-control" type="text" id="erDetail" name="approvalErs[${status.index}].erDetail" value="${appEr.erDetail}" placeholder="내용"  required />
												</td>
												<td>
													<input class="form-control" type="text" id="erUse" name="approvalErs[${status.index}].erUse" value="${appEr.erUse}" placeholder="사용처"  required />
												</td>
												<td>
													<select class="form-control" id="erPayment" name="approvalErs[${status.index}].erPayment" required>
														<option value="BC">법인카드</option>
														<option value="M">현금</option>
														<option value="PC">개인카드</option>
													</select>
												</td>
												<td>
													<input type="hidden" value="${appEr.apperNo }" name="approvalErs[${status.index}].apperNo">
													<button type="button" id="rowRemoveBtn${status.index}" onclick="goDelete(this);" class="btn btn-danger">삭제</button>
												</td>
											</tr>
										</c:forEach>
										</tbody>
									</table>
									<button type="button" id="rowAddBtn" class="btn btn-primary">추가</button>
									<div class="addFile" style="margin-top:2%;">
										<b>* 증빙 서류 첨부</b><br><br>
										<input type="file" id="reUploadFile" name="reUploadFile" class="form-control" style="width:50%; height:3%;">
										<c:if test="${ !empty appMap.attachment.originName  }">
											<br><br><b> * 현재 첨부 파일 : ${ appMap.attachment.originName }</b><br>
										</c:if>
										<input type="hidden" name="attachment.changeName" value="${ appMap.attachment.changeName }">
										<input type="hidden" name="attachment.originName" value="${ appMap.attachment.originName }">
									</div>
								</div>
							</div>
						</div>
						<%-- <div class="errorCode" style="margin-left:5%;">
							<h3 style="color:red;"><form:errors path="firstApprover" /></h3>
							<h3 style="color:red;"><form:errors path="lastApprover" /></h3>
						</div> --%>
						<div class="btns" align="center" style="margin-top:5%;">
							<button type="submit" id="erAppBtn" class="btn btn-primary btn-lg">수정하기</button>
							<button type="button" class="btn btn-danger btn-lg" onclick="javascript:history.go(-1);">이전으로</button>
						</div>
						</form>
					</div>
				</div>
			</section>
		</section>
		<script>
		// 추가하기 버튼 클릭시 지출내용 작성 row 추가하기
		$("#rowAddBtn").click(function(){
			var trCnt = $('#erTable tr').length;
			var count = trCnt - 1;
			console.log(count);
			console.log(trCnt);
			var insertTr = "";
			if(trCnt < 6){
				insertTr += '<tr><td><input type="text" class="form-control" list="listOptions" name="approvalErs['+count+'].erClass" placeholder="과목입력" required="required" />'
					 + '<datalist id="listOptions">'
					 + '<option value="교육훈련비">'
					 + '<option value="도서인쇄비">'
					 + '<option value="접대비">'
					 + '<option value="사무용품비">'
					 + '<option value="복리후생비">'
					 + '<option value="통신비">'
					 + '<option value="여비교통비">'
					 + '</datalist></td>'
					 + '<td><input class="form-control" type="date" name="approvalErs['+count+'].erDate" required="required" /></td>'
					 + '<td><input class="form-control" type="text" name="approvalErs['+count+'].erDetail" placeholder="내용" required="required" /></td>'
					 + '<td><input class="form-control" type="text" name="approvalErs['+count+'].erUse" placeholder="사용처" required="required" /></td>'
					 + '<td><select class="form-control" name="approvalErs['+count+'].erPayment" required="required">'
					 + '<option value="M">현금</option>'
					 + '<option value="PC">개인카드</option>'
					 + '<option value="BC">법인카드</option></select></td>'
					 + '<td><button type="button" id="rowRemoveBtn" onclick="goDelete(this);" class="btn btn-danger">삭제</button></td></tr>';
					 
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
		}
			count--;
		</script>
		<script>
		// 페이지 로드 후 첫번째 지출증빙내역 삭제 버튼 비활성화
		$(function(){
			$("#rowRemoveBtn0").attr("disabled", true);
		});
		</script>
</body>
</html>