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
					<h3>지출 결의서</h3>
					<hr>
					<div class="row">
						<!-- 전자결재 상세 조회 -->
						<div class="leavaDetail" style="line-height:2em;">
						<!-- 현재 로그인한 회원이고 결재가 진행중이지 않을경우에만 버튼 출력 -->
						<c:if test='${ appMap.employee.empNo == loginUser.empNo and appMap.approval.appStatus.equals("W") }'>
							<div class="btnClass">
								<button class="btn btn-info" onclick="postFormSubmit(1)" style="margin-left:78%; margin-bottom:2%;">수정하기</button>&nbsp;
								<button class="btn btn-danger" onclick="postFormSubmit(2)" style="margin-bottom:2%;">삭제하기</button>
							</div>	
						</c:if>
							<table id="approverTable" class="table table-bordered" style="width:300px; margin-right:5%; float:right; text-align:center;">
								<tbody>
									<tr style="background:lightgray; font-weight:bold;">
										<td rowspan="5" style="vertical-align:middle; width:30%;">결재</td>
										<td>최초승인자</td>
										<td>최종승인자</td>
									</tr>
									<tr>
										<!-- <td>결재</td> -->
										<td id="firstApprover">
											<c:out value="${ appMap.approval.firstApprover }" />
										</td>
										<td id="lastApprover">
											<c:out value="${ appMap.approval.lastApprover }" />
										</td>
									</tr>
									<tr>
										<!-- <td></td> -->
										<td>
										<!-- 승인날짜가 없고, 상태가 R이면 반려 승인날짜가있고 -->
										<c:choose>
											<c:when test='${ empty appMap.approval.firstApprovalDate && appMap.approval.appStatus.equals("R")}'>반려</c:when>
											<c:when test="${ empty appMap.approval.firstApprovalDate }">승인대기</c:when>
											<c:when test="${ !empty appMap.approval.firstApprovalDate }">승인완료</c:when>
										</c:choose>
										</td>
										<td>
										<c:choose>
											<c:when test='${ empty appMap.approval.lastApprovalDate && appMap.approval.appStatus.equals("R")}'>반려</c:when>
											<c:when test="${ empty appMap.approval.lastApprovalDate }">승인대기</c:when>
											<c:when test="${ !empty appMap.approval.lastApprovalDate }">승인완료</c:when>
										</c:choose>
										</td>
									</tr>
									<tr>
										<!-- <td></td> -->
										<td id="firstApprovalDate"><c:out value="${ appMap.approval.firstApprovalDate }" /></td>
										<td id="lastApprovalDate"><c:out value="${ appMap.approval.lastApprovalDate }" /></td>
									</tr>
							</tbody>
						</table>
						<table class="__se_tbl" style="background: white; margin: 0px; border: 1px solid black; border-image: none; color: black; font-family: malgun gothic,dotum,arial,tahoma; font-size: 12px; border-collapse: collapse !important;"><!-- User --> 
							<tbody>
								<tr>
									<td style="width: 100px; height: 22px; vertical-align: middle; border: 1px solid black; text-align: center; font-weight: bold; background: rgb(221, 221, 221); padding: 3px !important;">
										기안자
									</td>
									<td style="width: 200px; height: 22px; vertical-align: middle; border: 1px solid black; text-align: left; padding: 3px !important;">
										<span unselectable="on" contenteditable="false" class="comp_wrap" data-cid="0" data-dsl="{{label:draftUser}}" data-value="" data-autotype=""><span class="comp_item">
											<c:out value="${ appMap.approval.appWriterNo }" />
										</span></span> 
									</td>
								</tr>
								<tr>
									<td style="width:100px;padding: 3px !important; height: 22px; vertical-align: middle; border: 1px solid black; text-align: center; font-weight: bold; background: #ddd;">
										부서명
									</td>
									<td style="width:200px;padding: 3px !important; height: 22px; vertical-align: middle; border: 1px solid black; text-align: left;">
										<span unselectable="on" contenteditable="false" class="comp_wrap" data-cid="1" data-dsl="{{label:draftDept}}"><span class="comp_item">
											<c:out value="${ appMap.employee.depName }" />
										</span></span> 
									</td>
								</tr>
								<tr>
									<td style="width:100px;padding: 3px !important; height: 22px; vertical-align: middle; border: 1px solid black; text-align: center; font-weight: bold; background: #ddd;">
										직위/직책
									</td>
									<td style="width:200px;padding: 3px !important; height: 22px; vertical-align: middle; border: 1px solid black; text-align: left;">
										<span unselectable="on" contenteditable="false" class="comp_wrap" data-cid="1" data-dsl="{{label:draftDept}}"><span class="comp_item">
											<c:out value="${ appMap.employee.posName }" />
										</span></span> 
									</td>
								</tr>
								<tr>
									<td style="width:100px;padding: 3px !important; height: 22px; vertical-align: middle; border: 1px solid black; text-align: center; font-weight: bold; background: #ddd;">
										기안일
									</td>
									<td style="width:200px;padding: 3px !important; height: 22px; vertical-align: middle; border: 1px solid black; text-align: left;">
										<span unselectable="on" contenteditable="false" class="comp_wrap" data-cid="2" data-dsl="{{label:draftDate}}" data-wrapper="" style="" data-value="" data-autotype=""><span class="comp_item">
											<c:out value="${ appMap.approval.appCreateDate }" />
										</span></span> 
									</td>
								</tr>
								<tr>
									<td style="width:100px;padding: 3px !important; height: 22px; vertical-align: middle; border: 1px solid black; text-align: center; font-weight: bold; background: #ddd;">
										문서번호
									</td>
									<td style="width:200px;padding: 3px !important; height: 22px; vertical-align: middle; border: 1px solid black; text-align: left;">
										<span unselectable="on" contenteditable="false" class="comp_wrap" data-cid="3" data-dsl="{{label:docNo}}" data-wrapper="" style="" data-value="" data-autotype=""><span class="comp_item">
											<c:out value="${ appMap.approval.appNo }" />
										</span></span> 
									</td>
								</tr>
							</tbody>
						</table>
							<br>
							<hr>
							<br>
							<table class="__se_tbl" style="width: 800px; margin-top : 0px; border-collapse: collapse !important; color: black; background: white; border: 1px solid black; font-size: 12px; font-family: malgun gothic,dotum,arial,tahoma;">
							<tbody>
								<tr>	
									<td style="background: rgb(221, 221, 221); padding: 5px; border: 1px solid black; height: 25px; width: 100px; text-align: center; color: rgb(0, 0, 0); font-size: 14px; font-weight: bold; vertical-align: middle;">
										제목
									</td>
									<td colspan="3" style="background: rgb(255, 255, 255); padding: 5px; border: 1px solid black; height: 25px; text-align: left; color: rgb(0, 0, 0); font-size: 14px; font-weight: normal; vertical-align: middle;">
										<span id="vacationTypeArea" name="select" style="font-family: malgun gothic, dotum, arial, tahoma; font-size: 11pt; line-height: normal; margin-top: 0px; margin-bottom: 0px;">
											<c:out value="${ appMap.approval.appTitle }" />
										</span> 
									</td>
									<!-- <td></td>
									<td></td> -->
								</tr>
								<tr>	
									<td style="background: rgb(221, 221, 221); padding: 5px; border: 1px solid black; height: 25px; text-align: center; color: rgb(0, 0, 0); font-size: 14px; font-weight: bold; vertical-align: middle;">
										은행명
									</td>
									<td style="background: rgb(255, 255, 255); padding: 5px; border: 1px solid black; height: 25px; text-align: left; color: rgb(0, 0, 0); font-size: 14px; font-weight: normal; vertical-align: middle;">
										<span id="vacationTypeArea" name="select" style="font-family: malgun gothic, dotum, arial, tahoma; font-size: 11pt; line-height: normal; margin-top: 0px; margin-bottom: 0px;">
											<c:out value="${ appMap.apperAccount.bankName }" />
										</span> 
									</td>
									<td style="background: rgb(221, 221, 221); padding: 5px; width:100px; border: 1px solid black; height: 25px; text-align: center; color: rgb(0, 0, 0); font-size: 14px; font-weight: bold; vertical-align: middle;">
										예금주
									</td>
									<td style="background: rgb(255, 255, 255); padding: 5px; border: 1px solid black; height: 25px; text-align: left; color: rgb(0, 0, 0); font-size: 14px; font-weight: normal; vertical-align: middle;">
										<span id="vacationTypeArea" name="select" style="font-family: malgun gothic, dotum, arial, tahoma; font-size: 11pt; line-height: normal; margin-top: 0px; margin-bottom: 0px;">
											<c:out value="${ appMap.apperAccount.erAccountHolder }" />
										</span> 
									</td>
								</tr>
								<tr>	
									<td style="background: rgb(221, 221, 221); padding: 5px; border: 1px solid black; height: 25px; text-align: center; color: rgb(0, 0, 0); font-size: 14px; font-weight: bold; vertical-align: middle;">
										계좌번호
									</td>
									<td style="background: rgb(255, 255, 255); padding: 5px; border: 1px solid black; height: 25px; text-align: left; color: rgb(0, 0, 0); font-size: 14px; font-weight: normal; vertical-align: middle;">
										<span id="vacationTypeArea" name="select" style="font-family: malgun gothic, dotum, arial, tahoma; font-size: 11pt; line-height: normal; margin-top: 0px; margin-bottom: 0px;">
											<c:out value="${ appMap.apperAccount.accountNumber }" />
										</span> 
									</td>
									<td style="background: rgb(221, 221, 221); padding: 5px; border: 1px solid black; height: 25px; text-align: center; color: rgb(0, 0, 0); font-size: 14px; font-weight: bold; vertical-align: middle;">
										총 지출금액
									</td>
									<td style="background: rgb(255, 255, 255); padding: 5px; border: 1px solid black; height: 25px; text-align: left; color: rgb(0, 0, 0); font-size: 14px; font-weight: normal; vertical-align: middle;">
										<span id="vacationTypeArea" name="select" style="font-family: malgun gothic, dotum, arial, tahoma; font-size: 11pt; line-height: normal; margin-top: 0px; margin-bottom: 0px;">
											<c:out value="${ appMap.apperAccount.erAmount }원" />
										</span> 
									</td>
								</tr>
							</tbody>
						</table>
						</div>
						<!-- 전자결재 데이터에 필요한 문서 제목, 작성자 사번, 결재양식 hidden 값으로 전달 -->
							<div class="hiddenInfo">
								<input type="hidden" class="form-control" id="appTitle" name="appTitle" value="휴가신청서_${ sessionScope.loginUser.empName }">
								<input type="hidden" class="form-control" id="appWriterNo" name="appWriterNo" value="${ sessionScope.loginUser.empNo }">
								<input type=hidden class="form-control" id="appKinds" name="appKinds" value="3">
							</div>
							<div class="addFile" style="margin-top:2%;">
								<b style="font-size:14px;">* 첨부파일</b><br><br>
								<c:if test="${ empty appMap.attachment.originName }">
									<b>첨부파일이 없습니다.</b>
								</c:if>
								<c:if test="${ !empty appMap.attachment.originName }">
									<a download="${appMap.attachment.originName}" href="${ pageContext.servletContext.contextPath }/resources/appUpload_files/${appMap.attachment.changeName}">${appMap.attachment.originName}</a>
								</c:if>
							</div>
						<form id="postForm" action="" method="post">
							<input type="hidden" name="appNo" value="appMap.approval.appNo">
							<input type="hidden" name="appKinds" value="appMap.approval.appKinds">
						</form>
						<div class="tableDiv" style="margin-top:3%;">
							<table class="table table-striped" id="erTable" style="height:15px;">
								<thead>
									<tr>
										<th>* 계정과목</th>
										<th>* 지출일자</th>
										<th>* 지출내용</th>
										<th>* 사용처</th>
										<th>* 결제수단</th>
									</tr>
								</thead>
								<tbody style="text-align:center; height:15px;">
									<c:forEach items="${ list }" var="appEr">
										<tr>
											<td><c:out value="${ appEr.erClass }"/></td>
											<td><c:out value="${ appEr.erDate }"/></td>
											<td><c:out value="${ appEr.erDetail }"/></td>
											<td><c:out value="${ appEr.erUse }"/></td>
											<td>
												<c:choose>
													<c:when test='${ appEr.erPayment.equalsIgnoreCase("PC") }'>개인카드</c:when>
													<c:when test='${ appEr.erPayment.equalsIgnoreCase("BC") }'>법인카드</c:when>
													<c:when test='${ appEr.erPayment.equalsIgnoreCase("M") }'>현금</c:when>
												</c:choose>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						<!-- 최초 승인일 컬럼이 비어있고, 최초승인자와 로그인유저의 이름이 같거나, 최초승인일 안비어있고 최종승인자컬럼과 이름이 같고 최종 승인일이 비어있을경우 출력 -->
						<c:if test="${ appMap.approval.firstApprover.equals(loginUser.empName) and empty appMap.approval.firstApprovalDate
						 or (appMap.approval.lastApprover.equals(loginUser.empName) and empty appMap.approval.lastApprovalDate and !empty appMap.approval.firstApprovalDate) }">
							<div class="btns" align="center" style="margin-top:5%;">
								<button class="btn btn-info btn-lg" onclick="postFormSubmit(3)">결재 승인</button>
								<button class="btn btn-danger btn-lg" style="margin-left:1%;" onclick="postFormSubmit(4)">반려</button>
							</div>
						</c:if>
						<script>
						// 수정 화면 이동 스크립트
					/* 		function postFormSubmit(num){
							var postForm = $("#postForm");
							
							if(num == 1){
								postForm.attr("action", "updateFormBoard.do");
							}else{
								postForm.attr("action", "deleteBoard.do");
							}
								postForm.submit();
							} */
						</script>
					</div>
				</div>
			</div>
		</section>
	</section>
</body>
</html>