<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>결재문서 상세조회</title>
</head>
<body>
	<jsp:include page="../common/menubar.jsp"/>
	<section id="main-content">
			<section class="wrapper">
				<div class="container" id="main-container">
					<h3>휴가 기안서</h3>
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
										<td id="firstApprover"><c:out value="${ appMap.approval.firstApprover }" /></td>
										<td id="lastApprover"><c:out value="${ appMap.approval.lastApprover }" /></td>
									</tr>
									<tr>
										<!-- <td></td> -->
										<td>
										<!-- 최종 승인날짜가 없고, 상태가 R이면 반려 승인날짜가있고 -->
										<c:choose>
											<c:when test='${ !empty appMap.approval.firstApprovalDate && appMap.approval.appStatus.equals("R")}'>반려</c:when>
											<c:when test="${ empty appMap.approval.firstApprovalDate }">승인대기</c:when>
											<c:when test="${ !empty appMap.approval.firstApprovalDate }">승인완료</c:when>
										</c:choose>
										</td>
										<td>
										<c:choose>
											<c:when test='${ !empty appMap.approval.lastApprovalDate && appMap.approval.appStatus.equals("R")}'>반려</c:when>
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
							<c:if test="${ !empty appMap.approval.rejecter }">
								<table class="__se_tbl" style="width: 600px; margin-top : 0px; border-collapse: collapse !important; color: black; background: white; border: 1px solid black; font-size: 12px; font-family: malgun gothic,dotum,arial,tahoma;">
								<tbody>
									<tr>	
										<td style="background: rgb(221, 221, 221); width:200px; padding: 5px; border: 1px solid black; height: 25px; width: 100px; text-align: center; color: rgb(0, 0, 0); font-size: 14px; font-weight: bold; vertical-align: middle;">
											반려자
										</td>
										<td colspan="3" style="background: rgb(255, 255, 255); padding: 5px; border: 1px solid black; height: 25px; text-align: left; color: rgb(0, 0, 0); font-size: 14px; font-weight: normal; vertical-align: middle;">
											<span id="vacationTypeArea" name="select" style="font-family: malgun gothic, dotum, arial, tahoma; font-size: 11pt; line-height: normal; margin-top: 0px; margin-bottom: 0px;">
												<c:out value="${ appMap.approval.rejecter }" />
											</span> 
										</td>
									</tr>
									<tr>	
										<td style="background: rgb(221, 221, 221); padding: 5px; border: 1px solid black; height: 25px; width: 100px; text-align: center; color: rgb(0, 0, 0); font-size: 14px; font-weight: bold; vertical-align: middle;">
											반려 사유
										</td>
										<td colspan="3" style="background: rgb(255, 255, 255); padding: 5px; border: 1px solid black; height: 25px; text-align: left; color: rgb(0, 0, 0); font-size: 14px; font-weight: normal; vertical-align: middle;">
											<span id="vacationTypeArea" name="select" style="font-family: malgun gothic, dotum, arial, tahoma; font-size: 11pt; line-height: normal; margin-top: 0px; margin-bottom: 0px;">
												<textarea name="rejectReason" rows="10" cols="70" style="resize:none;" readonly><c:out value="${appMap.approval.rejectReason}"/></textarea>
											</span> 
										</td>
									</tr>
									</tbody>
								</table>
							</c:if>
							<br>
							<table class="__se_tbl" style="width: 800px; margin-top : 0px; border-collapse: collapse !important; color: black; background: white; border: 1px solid black; font-size: 12px; font-family: malgun gothic,dotum,arial,tahoma;">
							<tbody>
								<tr>	
									<td style="background: rgb(221, 221, 221); padding: 5px; border: 1px solid black; height: 25px; text-align: center; color: rgb(0, 0, 0); font-size: 14px; font-weight: bold; vertical-align: middle;">
										제목
									</td>
									<td style="background: rgb(255, 255, 255); padding: 5px; border: 1px solid black; height: 25px; text-align: left; color: rgb(0, 0, 0); font-size: 14px; font-weight: normal; vertical-align: middle;">
										<span id="vacationTypeArea" name="select" style="font-family: malgun gothic, dotum, arial, tahoma; font-size: 11pt; line-height: normal; margin-top: 0px; margin-bottom: 0px;">
											<c:out value="${ appMap.approval.appTitle }" />
										</span> 
									</td>
								</tr>
								<tr>
									<td style="background: rgb(221, 221, 221); padding: 5px; border: 1px solid black; height: 25px; text-align: center; color: rgb(0, 0, 0); font-size: 14px; font-weight: bold; vertical-align: middle;">
										휴가&nbsp;종류
									</td>
									<td style="background: rgb(255, 255, 255); padding: 5px; border: 1px solid black; height: 25px; text-align: left; color: rgb(0, 0, 0); font-size: 14px; font-weight: normal; vertical-align: middle;">
										<span id="vacationTypeArea" name="select" style="font-family: malgun gothic, dotum, arial, tahoma; font-size: 11pt; line-height: normal; margin-top: 0px; margin-bottom: 0px;">
										<c:choose>
											<c:when test='${ appMap.approvalLeave.leaveCategory.equals("AH")}'>오전 반차</c:when>
											<c:when test='${ appMap.approvalLeave.leaveCategory.equals("PH")}'>오후 반차</c:when>
											<c:when test='${ appMap.approvalLeave.leaveCategory.equals("L")}'>연차</c:when>
											<c:otherwise>경조사</c:otherwise>
										</c:choose>
										</span> 
									</td>
								</tr>
								<tr>
									<td style="background: rgb(221, 221, 221); padding: 5px; border: 1px solid black; height: 25px; text-align: center; color: rgb(0, 0, 0); font-size: 14px; font-weight: bold; vertical-align: middle;">
										기간&nbsp;및&nbsp;일시
									</td>
									<td style="padding: 3px; border: 1px solid black; width: 700px; height: 22px; text-align: left; color: rgb(0, 0, 0); font-size: 12px;  vertical-align: middle; background: rgb(255, 255, 255);">
										<span unselectable="on" contenteditable="false" class="comp_wrap" data-cid="4" data-dsl="{{calendar:startDate}}" data-wrapper="" style="" data-value="" data-autotype="">
											&nbsp;<input class="ipt_editor ipt_editor_date" value="<c:out value="${ appMap.approvalLeave.leaveStart }" />" type="text" readonly>&nbsp;~&nbsp; 
											&nbsp;<input class="ipt_editor ipt_editor_date" value="<c:out value="${ appMap.approvalLeave.leaveFinish }" />" type="text" readonly></span> 
									</td>
								</tr>
								<tr>
									<td style="background: rgb(221, 221, 221); padding: 5px; border: 1px solid black; height: 25px; text-align: center; color: rgb(0, 0, 0); font-size: 14px; font-weight: bold; vertical-align: middle;">
										반차&nbsp;여부
									</td>
									<td style="background: rgb(255, 255, 255); padding: 5px; border: 1px solid black; height: 25px; text-align: left; color: rgb(0, 0, 0); font-size: 14px; font-weight: normal; vertical-align: middle;">
										<span id="vacationHalfArea" style="font-family: malgun gothic, dotum, arial, tahoma; font-size: 11pt; line-height: normal; margin-top: 0px; margin-bottom: 0px;">
										<c:choose>
											<c:when test='${ appMap.approvalLeave.leaveCategory.equals("AH") or appMap.approvalLeave.leaveCategory.equals("PH")}'>O</c:when>
											<c:otherwise>X</c:otherwise>
										</c:choose>
										</span> 
									</td>
								</tr>
								<tr>
									<td style="background: rgb(221, 221, 221); padding: 5px; border: 1px solid black; height: 25px; text-align: center; color: rgb(0, 0, 0); font-size: 14px; font-weight: bold; vertical-align: middle;">
										연차&nbsp;일수
									</td>
									<td style="padding: 3px; border: 1px solid black; width: 700px; height: 22px; text-align: left; color: rgb(0, 0, 0); font-size: 12px;  vertical-align: middle; background: rgb(255, 255, 255);">
										<span id="restPointArea" style="font-family: malgun gothic, dotum, arial, tahoma; font-size: 9pt; line-height: normal; margin-top: 0px; margin-bottom: 0px;">
											&nbsp;<c:out value="${ appMap.approvalLeave.leaveTotalDate } 일" />
										</span>
									</td>
								</tr>
								<tr>
									<td style="background: rgb(221, 221, 221); padding: 5px; border: 1px solid black; height: 80px; text-align: center; color: rgb(0, 0, 0); font-size: 14px; font-weight: bold; vertical-align: middle;">
										<b style="color: rgb(255, 0, 0);">*</b>&nbsp;휴가&nbsp;사유 
									</td>
									<td style="padding: 3px; border: 1px solid black; width: 700px; height: 100px; text-align: left; color: rgb(0, 0, 0); font-size: 12px;  vertical-align: top; background: rgb(255, 255, 255);">
										<span unselectable="on" contenteditable="false" class="comp_wrap" data-cid="6" data-dsl="{{textarea:description}}" data-wrapper="" style="width: 100%;" data-value="" data-autotype="">
											<textarea class="txta_editor" rows="10" cols="110" style="resize:none;" readonly><c:out value="${ appMap.approvalLeave.leaveReason }" /></textarea>
										</span> 
									</td>
								</tr>
							</tbody>
						</table>
						</div>
						<!-- 결재 승인시 필요한 값들 hidden으로 값 전송 -->
						<form id="postForm" action="" method="post">
							<input type="hidden" name="appNo" value="${appMap.approval.appNo}">
							<input type="hidden" name="appKinds" value="${appMap.approval.appKinds}">
							<input type="hidden" name="firstApprover" value="${appMap.approval.firstApprover}">
							<input type="hidden" name="lastApprover" value="${ appMap.approval.lastApprover }">
							<input id="approverConfirm" name="approverConfirm" type="hidden" value="${ loginUser.empName }">
							<input type=hidden name="fileName" value="${appMap.attachment.changeName}" >
						</form>
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
						<!-- 최초 승인일 컬럼이 비어있고, 최초승인자와 로그인유저의 이름이 같거나, 최초승인일 안비어있고 최종승인자컬럼과 이름이 같고 최종 승인일이 비어있을경우 출력 -->
						<c:if test="${ appMap.approval.firstApprover.equals(loginUser.empName) and empty appMap.approval.firstApprovalDate
						 or (appMap.approval.lastApprover.equals(loginUser.empName) and empty appMap.approval.lastApprovalDate and !empty appMap.approval.firstApprovalDate) }">
							<div class="btns" align="center" style="margin-top:5%;">
								<button class="btn btn-info btn-lg" onclick="postFormSubmit(3)">결재 승인</button>
								<button class="btn btn-danger btn-lg" style="margin-left:1%;" type="button" data-toggle="modal" data-target="#reject">반려</button>
							</div>
						</c:if>
						<!-- 반려 버튼 클릭시 출력되는 모달 -->
						<div class="modal fade" id="reject" style="height:60%;">
							<jsp:include page="rejectModal.jsp"/>
						</div>
						<br><br>
						<%-- 의견 작성란 jsp --%>
						<jsp:include page="opinionTable.jsp"/>	
						<script>
						// 수정 화면 , 결재승인 스크립트
					 		function postFormSubmit(num){
							var postForm = $("#postForm");
							
							var firstApprover = $("#firstApprover").text();
							var lastApprover = $("#lastApprover").text();
							console.log(firstApprover, lastApprover);
							
							if(num == 1){
								postForm.attr("action", "updateFormApproval.do");
							}else if(num ==2){
								if(confirm("정말 삭제하시겠습니까?")){
									postForm.attr("action", "deleteApproval.do?userNo=${loginUser.empNo}");
								}else{
									return false;
								}
							}else if(num == 3){
								if(confirm("결재 승인 처리를 하시겠습니까?")){
									postForm.attr("action", "approve.do");
								}else{
									return false;
								}
							}
								postForm.submit();
							} 
						</script>
					</div>
				</div>
			</section>
		</section>
</body>
</html>