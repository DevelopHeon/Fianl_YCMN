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
  <!-- 캘린더 -->
  <script src="lib/zabuto_calendar.js"></script>
  	<!-- CSS -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
	<!-- 테마 -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
	<!-- 자바스크립트 -->
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<style>
	.table, tr, td{
		border-style : hidden;
	}
	
	#section1{
		margin-top : 15px;
		border-bottom: 3px dashed #D0C9C0;
	}
	
	#section2{
		border-bottom: 3px dashed #D0C9C0;
	}
</style>

</head>
<body onload="checkMonth();">
<jsp:include page="common/menubar.jsp"/>
	<section id="main-content">
		<section class="wrapper" style="margin-top:10px;">
			<div class="row">
				<div class="col-sm-3" style="border:1px solid #d4d9d9; margin-right:5%; margin-left:2%; width:300px">
					<div id="section1">
                  		<c:if test="${ empInfo.empPfe eq null}">
                           <p class="empImg centered"><img src="resources/img/user.png" class="img-circle" width="80"></p>
                     	</c:if>
                     	<c:if test="${ !empty empInfo.empPfe }">
                         	<p class="empImg centered"><img src="resources/empUpload_files/${empInfo.empPfe}" class="img-circle" width="80"></p>
                     	</c:if>
                     	<h3 class="centered">${ sessionScope.loginUser.empName }</h3>
                     <!-- TABLE로 변경하기 -->
                     <table class="table centered">
                     	<tr>
                     		<td><button type="button" class="btn btn-round btn-default" onclick="location.href='approvalList.do'">결재 작성</button></td>
                     		<td><button type="button" class="btn btn-round btn-default" onclick="location.href='writeMail.do'">메일 작성</button></td>
                     	</tr>
                     	<tr>
                     		<td><button type="button" class="btn btn-round btn-default" onclick="location.href='empAddress.do'">주소록</button></td>
                     		<td><button type="button" class="btn btn-round btn-default" onclick="location.href='writeMail.do'">회의 예약</button></td>
                     	</tr>
                     </table>
               		</div>
               		<!-- WORKINGINFO -->
               		<div id="section2">
               		<h3 class="centered">6월 근무 시간</h3>
               			<table class="table centered">
             				<tr>
	             	  			<td id="thisMonthWork"></td>
	             	  			<td>
             	  					<div class="progress progress-striped active" style="width:130px">
                					<div id="bar" class="progress-bar" role="progressbar" aria-valuenow="30" aria-valuemin="0" aria-valuemax="100"></div>
              						</div>
              	  				</td>
             				</tr>
            			</table> 
               		</div>
               		 <!-- CALENDAR-->
               		 <br>
		            <div id="calendar" class="mb">
		              <div class="panel green-panel no-margin">
		                <div class="panel-body">
		                  <div id="date-popover" class="popover top" style="cursor: pointer; disadding: block; margin-left: 33%; margin-top: -50px; width: 175px;">
		                    <div class="arrow"></div>
		                    <h3 class="popover-title" style="disadding: none;"></h3>
		                    <div id="date-popover-content" class="popover-content"></div>
		                  </div>
		                  <div id="my-calendar"></div>
		                </div>
		              </div>
		            </div>
		            <!-- / calendar -->
            	</div>
            	<!-- 1 of 3 end -->
            	<script>
            	//달력 (부트스트랩)
            	 $(document).ready(function() {

            	      $("#my-calendar").zabuto_calendar({
            	        action: function() {
            	          return myDateFunction(this.id, false);
            	        },
            	        action_nav: function() {
            	          return myNavFunction(this.id);
            	        },
            	        ajax: {
            	          url: "show_data.php?action=1",
            	          modal: true
            	        },
            	        legend: [{
            	            type: "text",
            	            label: "Special event",
            	            badge: "00"
            	          },
            	          {
            	            type: "block",
            	            label: "Regular event",
            	          }
            	        ]
            	      });
            	    });
            	
            	 function checkMonth() {
            		 
            		 $.ajax({
         				url:"mainWorkingInfo.do",
         				success:function(result){
         					$("#thisMonthWork").html(result);
                			//이번달 필요 근무 시간
                    		    var start = new Date(2022, 5, 1); // 2022-6-1
                    		    var end = new Date(2022, 5, 30); // 2022-6-30

                    		    var count = 0;
                    			var mw = result.substring(0, result.indexOf('시'));
								
                    			while(true) {  
                    			    var tempDate = start;
                    			    if(tempDate.getTime() > end.getTime()) { //종료날짜를 넘어가면  break
                    			        console.log("count : " + count);
                    			    	var baseWorking = count * 8 //6월 최소 근무량 (주 40시간 기준)
                    			
                    			        break;
                    			    } else {
                    			        var tmp = tempDate.getDay();
                    			        if(tmp == 0 || tmp == 6) {
                    			            // 주말
                    			            console.log("주말");
                    			        } else {
                    			            // 평일
                    			            console.log("평일");
                    			            count++;//평일엔 카운트를 더함  
                    			        }
                    			        tempDate.setDate(start.getDate() + 1); 
                    			    }
                    			}
                    			
                    			$("#baseWork").html(baseWorking + " 시간");
                    			
                    			var p = (mw / baseWorking) * 100;//이달 근무 퍼센트
                    			console.log(p.toFixed(2)); //소수점 둘째자리까지
                    			$("#bar").html(p.toFixed(2)+"%");
                    			
                    			//근무 상태에 보일 퍼센트 바(bar)
                    			$(document).ready(function(){
                    				
                    				document.getElementById("bar").style.width = p.toFixed(2) + "%";
                    			})
         				},
         				error:function(){
         					console.log("근무시간  통신 실패");
         				}
         				
         			})



            		}
            	</script>
            	
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
