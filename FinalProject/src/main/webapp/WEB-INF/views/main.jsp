<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta name="description" content="">
  <meta name="author" content="Dashboard">
  <meta name="keyword" content="Dashboard, Bootstrap, Admin, Template, Theme, Responsive, Fluid, Retina">
  <title>Dashio - Bootstrap Admin Template</title>

  <!-- 부트스트랩 아이콘 CDN -->
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css">
  <!-- Favicons -->
  <link href="resources/img/favicon.png" rel="icon">
  <link href="resources/img/apple-touch-icon.png" rel="apple-touch-icon">

  <!-- Bootstrap core CSS -->
  <link href="resources/lib/bootstrap/css/bootstrap.min.css" rel="stylesheet">
  <!--external css-->
  <link href="resources/lib/font-awesome/css/font-awesome.css" rel="stylesheet" />
  <link rel="stylesheet" type="text/css" href="resources/css/zabuto_calendar.css">
  <link rel="stylesheet" type="text/css" href="resources/lib/gritter/css/jquery.gritter.css" />
  <!-- Custom styles for this template -->
  <link href="resources/css/style.css" rel="stylesheet">
  <link href="resources/css/style-responsive.css" rel="stylesheet">
  <script src="resources/lib/chart-master/Chart.js"></script>
<style>

</style>

</head>
<body>
<jsp:include page="common/menubar.jsp"/>
	<section id="main-content">
		<section class="wrapper" style="margin-top:10px;">
			<div class="row">
				<div class="col-sm-3" style="border:1px solid #d4d9d9; margin-right:5%;">
				가
				</div>
				<div class="col-sm-4" style="border:1px solid #d4d9d9;">
					<h4>사내게시판 최신글</h4>
					<div class="board_comment_tab" id="approvalCommentsTab">
						<a href="#" id="nList">공지사항</a>
			        	<a href="#" id="anoList">익명게시판</a>
					</div>
					<hr style="opacity:0.4; margin-top:3px;">
					<table id="boardTable" class="table table-hover">
						<tbody>
						
						</tbody>
					</table>
				</div>
				<div class="col-sm-3" style="border:1px solid #d4d9d9; margin-left:5%;">
					
				</div>
				<script>
				$(function(){
					selectMainNotice();
					
					// a태그 공지사항 클릭시 리스트 불러오기
					$("#nList").on("click", function(){
						selectMainNotice();
					});
					
					function selectMainNotice(){
						$.ajax({
							url:"mainListNotice.do",
							success:function(list){
								var value="<b>공지사항</b>";
								$.each(list, function(i, obj){
									value += "<tr onclick='goDetail(1, "+obj.noticeNo+")'><td style='width:68%'>"
										  +  obj.noticeTitle+"</td>"
										  +  "<td>"+obj.createDate+"&nbsp;&nbsp;"+obj.noticeWriter+"&nbsp;"+obj.posName+"</td></tr>";
										  
								});
								$("#boardTable tbody").html(value);
							},error:function(){
								console.log("공지사항 목록 ajax 통신 실패");
							}
						});
					}
				});
				</script>
				<script>
				// 익명게시판 불러오기
				$("#anoList").on("click", function(){
					$.ajax({
						url:"mainAnoList.do",
						success:function(list){
							var value="<b>익명게시판</b>";
							$.each(list, function(i, obj){
								value += "<tr onclick='goDetail(2, "+obj.anoNo+")'><td style='width:65%'>" + obj.anoTitle;
								if(obj.replyCnt > 0){
									value += "&nbsp;[<span style='color:#2c86dc;'>"+obj.replyCnt+"</span>]";
								}
								value += "</td>"
									  +  "<td> 익명 > "+obj.createDate+"</td></tr>";
							});
							$("#boardTable tbody").html(value);
						},error:function(){
							console.log("메인화면 익명게시판목록 불러오기 실패");
						}
					});
				});
				</script>
				<script>
				// 상세화면 들어가기
				function goDetail(num, bno){
					var confirmUser = "${loginUser.empId}";
					
 					 if(num === 1){
						location.href="detailNotice.do?noticeNo="+bno;
					}else{
						location.href="detailAnonymBoard.do?anoNo="+bno+"&confirmUser="+confirmUser;
					}
				}
				</script>
				<div class="col-sm-4">
				</div>
			</div>
		</section>
	</section>			
</body>
</html>
