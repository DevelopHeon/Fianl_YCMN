<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    
<!DOCTYPE html>
<html>
<head>
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">

<!-- jQuery library -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<!-- Latest compiled JavaScript -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<c:if test = "${ !empty msg }">
		<script>
			alert("${msg}");
		</script>
		<c:remove var="msg" scope="session"/>
	</c:if>
	<div id="login-page">
		<div class="container" style="margin-top:15%;">
		<h1 style="text-align:center; margin-bottom:3%;">개발웍스</h3>
			<div class="col-md-4" style="float:left;">
				<img style="width:100%; float:left;" alt="회사사진" src="resources/img/common/로그인사진.jpg">
			</div>
			<%-- 아이디와 비밀번호가 모두 입력 되었을 경우에만 데이터 전송 --%>
			<form class="form-login" method="post" id="loginForm" action="login.do" onsubmit="return loginValidate();">
		        <h2 class="form-login-heading">&nbsp;로그인</h2>
		        <div class="login-wrap col-md-8" style="float:right;">
		          <input type="text" name="empId" id="empId" class="form-control" placeholder="아이디" autofocus>
		          <br>
		          <input type="password" name="empPwd" id="empPwd" class="form-control" placeholder="비밀번호">
		            <a href="enrollForm.do">회원가입</a> |
		            <a href="#" data-toggle="modal" data-target="#myModal">비밀번호 찾기</a>
		          <button id="login" class="btn btn-primary btn-block" type="submit"><i class="fa fa-lock"></i> 로그인 </button>
		          <hr>
		        </div>
		      </form>
		</div>
	</div>
	<br clear="both">
	
	<!-- modal창 시작 부분 -->
	<div id="myModal" class="modal fade" role="dialog">
	  <div class="modal-dialog">
	
	    <!-- Modal content-->
	    <div class="modal-content">
	      <div class="modal-header">
	        <h4 class="modal-title">비밀번호 찾기</h4>
	        <button type="button" class="close" data-dismiss="modal">&times;</button>
	      </div>
	      <form action="findPwd.do" method="post">
		      <div class="modal-body">
		      	<label for="findEmpId" class="mr-sm-2">ID : </label>
		      	<input type="text" class="form-control mb-2 mr-sm-2" required placeholder="아이디를 입력하세요." name="findEmpId">
                <label for="email" class="mr-sm-2">Email :</label>
                <input type="email" class="form-control mb-2 mr-sm-2" required placeholder="이메일을 입력하세요." id="email" name="email">
		      </div>
		      <div class="modal-footer">
		      	<button type="submit" class="btn btn-primary">비밀번호 찾기</button>
		        <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
		      </div>
	      </form>
	    </div>
	  </div>
	</div>
	<script>
		// 로그인 아이디, 비밀번호 모두 기입 했을때만 버튼 클릭 가능위해 유효성 검사
		function loginValidate(){
			if($('#empId').val().trim().length == 0){
				alert('아이디를 입력하세요.');
				$('#empId').focus();
				return false;
			}
			if($('#empPwd').val().trim().length == 0){
				alert('비밀번호를 입력하세요.');
				$('#empPwd').focus();
				return false;
			}
			return true;
		}
	</script>
</body>
</html>