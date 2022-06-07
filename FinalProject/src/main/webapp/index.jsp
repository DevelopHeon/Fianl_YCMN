<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<!-- CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<!-- 테마 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<!-- 자바스크립트 -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div id="login-page">
		<div class="container">
			<img alt="회사사진" src="resources/img/common/로그인사진.jpg">
			<form class="form-login" action="login.do" method="post">
		        <h2 class="form-login-heading">로그인</h2>
		        <div class="login-wrap">
		          <input type="text" name="empId" class="form-control" placeholder="User ID" autofocus>
		          <br>
		          <input type="password" name="empPwd" class="form-control" placeholder="Password">
		          <label class="checkbox">
		            <input type="checkbox" value="remember-me"> 아이디 저장
		            <span class="pull-right">
		            <a data-toggle="modal" href="login.html#myModal"> 비밀번호 찾기</a>
		            </span>
		            </label>
		          <button class="btn btn-theme btn-block" href="index.html" type="submit"><i class="fa fa-lock"></i> SIGN IN</button>
		          <hr>
		        </div>
		      </form>
		      <a href="enrollForm.do">회원가입</a>
		</div>
	</div>
</body>
</html>