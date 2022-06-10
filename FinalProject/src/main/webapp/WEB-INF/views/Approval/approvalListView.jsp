<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<jsp:include page="../main.jsp"/>
		<!-- 결재양식 신청 목록 화면 -->
		<section id="main-content">
		<section class="wrapper">
		<div class="container" style="margin-top:10%;">
		<h1 style="color:black;">결재 문서 양식</h1>
		<hr>
			<table class="table table-hover">
				<thead style="background:lightgray;">
					<tr>
						<th style="width:7%;">번호</th>
						<th>제목</th>
						<th>등록일</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>1</td>
						<td>휴가 신청서</td>
						<td>2022-05-05</td>
					</tr>
					<tr>
						<td>2</td>
						<td>지출 결의서</td>
						<td>2022-05-03</td>
					</tr>
					<tr>
						<td>3</td>
						<td>프로젝트 업무 보고서</td>
						<td>2022-05-01</td>
					</tr>
				</tbody>
			</table>
			</div>
		</section>
	</section>
</body>
<script>
	// 결재 작성 폼으로 이동
	$(function(){
		$(".table>tbody>tr").click(function(){
			var ano = $(this).children().eq(0).text();
			console.log(ano);
			location.href = "enrollFormApproval.do?ano=" + ano;
		})
	})
	
</script>
</html>