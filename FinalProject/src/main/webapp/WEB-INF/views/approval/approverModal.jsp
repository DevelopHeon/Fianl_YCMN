<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
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
</body>
</html>