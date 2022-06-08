<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<!-- CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<!-- 테마 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<!-- jQuery library -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<!-- Latest compiled JavaScript -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script> 
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div id="login-page">
		<div class="container" style="margin-top:15%">
			<div class="col-md-4">
				<img style="width:350px;" alt="회사사진" src="resources/img/common/로그인사진.jpg">
			</div>
			<%-- 아이디와 비밀번호가 모두 입력 되었을 경우에만 데이터 전송 --%>
			<form class="form-login" method="post" id="loginForm" onclick="goLogin()" onsubmit="return loginValidate();">
		        <h2 class="form-login-heading">로그인</h2>
		        <div class="login-wrap col-md-8">
		          <input type="text" name="empId" id="empId" class="form-control" placeholder="User ID" autofocus>
		          <br>
		          <input type="password" name="empPwd" id="empPwd" class="form-control" placeholder="Password">
		            <a href="enrollForm.do">회원가입</a> |
		            <a href="#">비밀번호 찾기</a>
		            
		          <button id="login" class="btn btn-primary btn-block" onclick="goLogin()"><i class="fa fa-lock"></i> 로그인 </button>
		          <hr>
		        </div>
		      </form>
		</div>
	</div>
	<script>
		function goLogin(){
			$("#loginForm").attr("action", "login.do");
		}
	
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