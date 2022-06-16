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
					<h3>휴가신청서</h3>
					<hr>
					<div class="row">
						<!-- 전자결재 상세 조회 -->
						<div class="leavaDetail" style="line-height:2em;">
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
											${ approval.firstApprover }
										</td>
										<td id="lastApprover">
											${ approval.lastApprover }
										</td>
									</tr>
									<tr>
										<!-- <td></td> -->
										<td>
										<!-- 승인날짜가 없고, 상태가 R이면 반려 승인날짜가있고 -->
										<c:choose>
											<c:when test='${ empty approval.firstApprovalDate && approval.appStatus.equals("R")}'>반려</c:when>
											<c:when test="${ empty approval.firstApprovalDate }">승인대기</c:when>
											<c:when test="${ !empty approval.firstApprovalDate }">승인완료</c:when>
										</c:choose>
										</td>
										<td>
										<c:choose>
											<c:when test='${ empty approval.lastApprovalDate && approval.appStatus.equals("R")}'>반려</c:when>
											<c:when test="${ empty approval.lastApprovalDate }">승인대기</c:when>
											<c:when test="${ !empty approval.lastApprovalDate }">승인완료</c:when>
										</c:choose>
										</td>
									</tr>
									<tr>
										<!-- <td></td> -->
										<td id="firstApprovalDate">${ approval.firstApprovalDate }</td>
										<td id="lastApprovalDate">${ approval.lastApprovalDate }</td>
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
											${ approval.employee.empName }
										</span></span> 
									</td>
								</tr>
								<tr>
									<td style="width:100px;padding: 3px !important; height: 22px; vertical-align: middle; border: 1px solid black; text-align: center; font-weight: bold; background: #ddd;">
										부서명
									</td>
									<td style="width:200px;padding: 3px !important; height: 22px; vertical-align: middle; border: 1px solid black; text-align: left;">
										<span unselectable="on" contenteditable="false" class="comp_wrap" data-cid="1" data-dsl="{{label:draftDept}}"><span class="comp_item">
											부서명 들어오는곳
										</span></span> 
									</td>
								</tr>
								<tr>
									<td style="width:100px;padding: 3px !important; height: 22px; vertical-align: middle; border: 1px solid black; text-align: center; font-weight: bold; background: #ddd;">
										기안일
									</td>
									<td style="width:200px;padding: 3px !important; height: 22px; vertical-align: middle; border: 1px solid black; text-align: left;">
										<span unselectable="on" contenteditable="false" class="comp_wrap" data-cid="2" data-dsl="{{label:draftDate}}" data-wrapper="" style="" data-value="" data-autotype=""><span class="comp_item">
											기안일데이터 들어오는곳
										</span></span> 
									</td>
								</tr>
								<tr>
									<td style="width:100px;padding: 3px !important; height: 22px; vertical-align: middle; border: 1px solid black; text-align: center; font-weight: bold; background: #ddd;">
										문서번호
									</td>
									<td style="width:200px;padding: 3px !important; height: 22px; vertical-align: middle; border: 1px solid black; text-align: left;">
										<span unselectable="on" contenteditable="false" class="comp_wrap" data-cid="3" data-dsl="{{label:docNo}}" data-wrapper="" style="" data-value="" data-autotype=""><span class="comp_item">
										문서번호 들어온느곳</span></span> 
									</td>
								</tr>
							</tbody>
						</table>
							
							<br>
							<hr>
							<table class="__se_tbl" style="width: 800px; margin-top : 0px; border-collapse: collapse !important; color: black; background: white; border: 1px solid black; font-size: 12px; font-family: malgun gothic,dotum,arial,tahoma;">
							<tbody>
								<tr>	
									<td style="background: rgb(221, 221, 221); padding: 5px; border: 1px solid black; height: 25px; text-align: center; color: rgb(0, 0, 0); font-size: 14px; font-weight: bold; vertical-align: middle;">
										제목
									</td>
									<td style="background: rgb(255, 255, 255); padding: 5px; border: 1px solid black; height: 25px; text-align: left; color: rgb(0, 0, 0); font-size: 14px; font-weight: normal; vertical-align: middle;">
										<span id="vacationTypeArea" name="select" style="font-family: malgun gothic, dotum, arial, tahoma; font-size: 11pt; line-height: normal; margin-top: 0px; margin-bottom: 0px;">
											휴가종류 작성란
										</span> 
									</td>
								</tr>
								<tr>
									<td style="background: rgb(221, 221, 221); padding: 5px; border: 1px solid black; height: 25px; text-align: center; color: rgb(0, 0, 0); font-size: 14px; font-weight: bold; vertical-align: middle;">
										휴가&nbsp;종류
									</td>
									<td style="background: rgb(255, 255, 255); padding: 5px; border: 1px solid black; height: 25px; text-align: left; color: rgb(0, 0, 0); font-size: 14px; font-weight: normal; vertical-align: middle;">
										<span id="vacationTypeArea" name="select" style="font-family: malgun gothic, dotum, arial, tahoma; font-size: 11pt; line-height: normal; margin-top: 0px; margin-bottom: 0px;">
											휴가종류 작성란
										</span> 
									</td>
								</tr>
								<tr>
									<td style="background: rgb(221, 221, 221); padding: 5px; border: 1px solid black; height: 25px; text-align: center; color: rgb(0, 0, 0); font-size: 14px; font-weight: bold; vertical-align: middle;">
										기간&nbsp;및&nbsp;일시
									</td>
									<td style="padding: 3px; border: 1px solid black; width: 700px; height: 22px; text-align: left; color: rgb(0, 0, 0); font-size: 12px;  vertical-align: middle; background: rgb(255, 255, 255);">
										<span unselectable="on" contenteditable="false" class="comp_wrap" data-cid="4" data-dsl="{{calendar:startDate}}" data-wrapper="" style="" data-value="" data-autotype="">
											<input class="ipt_editor ipt_editor_date" value="시작일" type="text" readonly>&nbsp;~&nbsp; 
											<input class="ipt_editor ipt_editor_date" value="2022-06-18" type="text" readonly></span> 
									</td>
								</tr>
								<tr>
									<td style="background: rgb(221, 221, 221); padding: 5px; border: 1px solid black; height: 25px; text-align: center; color: rgb(0, 0, 0); font-size: 14px; font-weight: bold; vertical-align: middle;">
										반차&nbsp;여부
									</td>
									<td style="background: rgb(255, 255, 255); padding: 5px; border: 1px solid black; height: 25px; text-align: left; color: rgb(0, 0, 0); font-size: 14px; font-weight: normal; vertical-align: middle;">
										<span id="vacationHalfArea" style="font-family: malgun gothic, dotum, arial, tahoma; font-size: 11pt; line-height: normal; margin-top: 0px; margin-bottom: 0px;">
											만약 반차라면 o 아니면 x
										</span> 
									</td>
								</tr>
								<tr>
									<td style="background: rgb(221, 221, 221); padding: 5px; border: 1px solid black; height: 25px; text-align: center; color: rgb(0, 0, 0); font-size: 14px; font-weight: bold; vertical-align: middle;">
										연차&nbsp;일수
									</td>
									<td style="padding: 3px; border: 1px solid black; width: 700px; height: 22px; text-align: left; color: rgb(0, 0, 0); font-size: 12px;  vertical-align: middle; background: rgb(255, 255, 255);">
										<span id="restPointArea" style="font-family: malgun gothic, dotum, arial, tahoma; font-size: 9pt; line-height: normal; margin-top: 0px; margin-bottom: 0px;">
											연차일수 데이터작성
										</span>
									</td>
								</tr>
								<tr>
									<td style="background: rgb(221, 221, 221); padding: 5px; border: 1px solid black; height: 80px; text-align: center; color: rgb(0, 0, 0); font-size: 14px; font-weight: bold; vertical-align: middle;">
										<b style="color: rgb(255, 0, 0);">*</b>&nbsp;휴가&nbsp;사유 
									</td>
									<td style="padding: 3px; border: 1px solid black; width: 700px; height: 100px; text-align: left; color: rgb(0, 0, 0); font-size: 12px;  vertical-align: top; background: rgb(255, 255, 255);">
										<span unselectable="on" contenteditable="false" class="comp_wrap" data-cid="6" data-dsl="{{textarea:description}}" data-wrapper="" style="width: 100%;" data-value="" data-autotype="">
											<textarea class="txta_editor" rows="10" cols="110" style="resize:none;" readonly>사유작성란</textarea>
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
							<c:if test="${ empty approval.attachment.originName }">
								<b>첨부파일이 없습니다.</b>
							</c:if>
							<c:if test="${ !empty approval.attachment.originName }">
								<a download="${approval.attachment.originName}" href="/resources/appUpload_files/${approval.attachment.changeName}">${approval.attachment.originName}</a>
							</c:if>
						</div>
						<!-- <div class="btns" align="center" style="margin-top:5%;">
							<button type="submit" id="erAppBtn" class="btn btn-primary btn-lg">결재요청</button>
							<button type="button" id="close" class="btn btn-danger btn-lg">취소하기</button>
						</div> -->
					</div>
				</div>
			</section>
		</section>
</body>
</html>