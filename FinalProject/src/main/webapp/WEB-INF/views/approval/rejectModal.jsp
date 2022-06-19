<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h3 class="modal-title">반려 사유 작성</h3>
				<button type="button" class="close" data-dismiss="modal">&times;</button>
			</div>
			<div class="modal-body">
				<form action="" method="post" id="rejectForm" class="form-inline">
					<input type="hidden" name="rejecter" value="${ loginUser.empName }" />
					<input type="hidden" name="appNo" value="${ appMap.approval.appNo }"/>
					<input type="hidden" name="appKinds" value="${ appMap.approval.appKinds }"/>
					<input type="hidden" id="first" name="firstApprovalDate" value="${ appMap.approval.firstApprovalDate }"/>
					<input type="hidden" name="lastApprovalDate" value="${ appMap.approval.lastApprovalDate }"/>
					<h4><b>* 반려 사유를 작성해주세요.</b></h4>
					<textarea id="rejectReason" name="rejectReason" class="form-control" rows="10" cols="75" style="resize:none;" required></textarea>
				</form>
			</div>
			<div class="modal-footer" id="modalBtn">
				<button class="btn btn-info" onclick="insertRejecter()">작성</button>
				<button type="button" class="btn btn-danger" data-dismiss="modal">취소</button>
			</div>
		</div>
	</div>
</body>
<script>
	function insertRejecter(){
		var rejectForm = $("#rejectForm");
		var rejectReason = $("#rejectReason").val().length;
		var first = $("#first").val();
		console.log(first);
		if(rejectReason == 0){
			alert("반려 사유는 필수 입력 값입니다.")
			$("#rejectReason").focus();
		}else{
			if(confirm("반려 처리 하시겠습니까?")){
				rejectForm.attr("action", "insertRejecter.do");
				rejectForm.submit();
			}else{
				return false;
			}
		}
	}
</script>
</html>