<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%
	Date currentTime = new Date();
	SimpleDateFormat format = new SimpleDateFormat("M"); //M: 7, MM:07
%>
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
  <link rel="stylesheet" type="text/css" href="resources/lib/gritter/css/jquery.gritter.css" />
  <!-- Custom styles for this template -->
  <link href="resources/css/style.css" rel="stylesheet">
  <link href="resources/css/style-responsive.css" rel="stylesheet">
  <script src="resources/lib/chart-master/Chart.js"></script>
  	<!-- CSS -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
	<!-- 테마 -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
	<!-- 자바스크립트 -->
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<!-- jquery CDN -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<!-- fullcalendar CDN -->
<link href='https://cdn.jsdelivr.net/combine/npm/fullcalendar@5.11.0/main.min.css,npm/fullcalendar@5.11.0/main.min.css' rel='stylesheet' />
<script src='https://cdn.jsdelivr.net/combine/npm/fullcalendar@5.11.0/main.min.js,npm/fullcalendar@5.11.0'></script>
<!-- fullcalendar 언어 CDN -->
<script src='https://cdn.jsdelivr.net/npm/fullcalendar@5.11.0/locales-all.min.js'></script>
<!-- moment.js -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.3/moment.min.js"></script>

<style>
	 div{
	 	border-radius:10px;
	 }
	.myphoto{
		width:50px;
	}
	tr.space{
		border-bottom:30px solid white;
	}
	.table, tr, td{
		border-style : hidden;
	}
	
	#section1{
		margin-top : 15px;
		border-bottom: 3px dashed #D0C9C0;
	}

	#commDiv{
		position: relative;
		bottom : 50px;
	}
	td,
	.fc-toolbar-title {
	  color: black;
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
                     	<h4 class="centered">${ sessionScope.loginUser.depName } ${ sessionScope.loginUser.posName }</h4>
                     	<div class="approvalCnt" style="margin:5% 0% 5% 15%;"> 
	                     	<a href="listInbox.do?userNo=${ loginUser.empNo }">결재할 문서</a><span id="appCnt" style="margin-left:30%; margin-bottom:2%; height:25; width:25px;" class="badge bg-info"></span>
                     	</div>
                     	<script>
                     		// 결재 할 문서 개수 불러오기
                     		$(function(){
                     			var userNo = ${loginUser.empNo};
                     			$.ajax({
                     				url:"approvalCnt.do",
                     				type:"get",
                     				data:{userNo:userNo},
                     				success:function(result){
                     					$("#appCnt").text(result);
                     				},error:function(){
                     					console.log("결재문서 카운트 조회 실패");
                     				}
                     			});
                     		});
                     	</script>
                     <!-- TABLE로 변경하기 -->
                     <table class="table centered">
                     	<tr>
                     		<td><button type="button" class="btn btn-round btn-default" onclick="location.href='approvalList.do'"><i class="fa fa-book"></i> 결재 작성</button></td>
                     		<td><button type="button" class="btn btn-round btn-default" onclick="location.href='writeMail.do'"><i class="fa fa-envelope-o"></i> 메일 작성</button></td>
                     	</tr>
                     	<tr>
                     		<td><button type="button" class="btn btn-round btn-default" onclick="location.href='empAddress.do'"><i class="fa fa-address-book"></i> 주소록</button></td>
                     		<td><button type="button" class="btn btn-round btn-default" onclick="location.href='writeMail.do'"><i class="fa fa-pencil"></i> 회의 예약</button></td>
                     	</tr>
                     </table>
               		</div>
               		<!-- WORKINGINFO -->
               		<div id="section2">
               		<h3 class="centered"><%=format.format(currentTime) %>월 근무 시간</h3>
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

            	</div>
            	<!-- 1 of 3 end -->
            	<script>
            	 function checkMonth() {
            		 
            		 $.ajax({
         				url:"mainWorkingInfo.do",
         				success:function(result){
         					$("#thisMonthWork").html(result);
                			//이번달 필요 근무 시간
                    		    var start = new Date(2022, 6, 1); // 2022-7-1
                    		    var end = new Date(2022, 6, 31); // 2022-7-31
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
               <h3>사내게시판 최신글</h3>
               <div class="board_comment_tab" id="approvalCommentsTab">
                  <a href="#" id="nList">공지사항</a>
                    <a href="#" id="anoList">익명게시판</a>
               </div>
               <hr style="opacity:0.4; margin-top:3px;">
               <table id="boardTable" class="table table-hover">
                  <tbody>
                  
                  </tbody>
               </table>
               <!-- <hr>
               <br> -->
         	</div>
<!-- 예약 달력 시작 -->
			<div class="col-sm-12 col-md-12 col-lg-4" style="border:1px solid #d4d9d9; margin-left:5%;">
			    <script>
			        document.addEventListener('DOMContentLoaded', function () {
			            $(function () {
			                var request = $.ajax({
			                    url: "reserveList.do", // 변경하기
			                    method: "GET",
			                    dataType: "json"
			                });
			
			                request.done(function (data) {
			
			                    console.log(data); // log 로 데이터 찍어주기.
			                    var now = new Date();
			                    var calendarEl = document.getElementById('calendar');
			                    var calendar = new FullCalendar.Calendar(calendarEl, {
			
			                        initialDate: now, // 오늘 날짜 기준
			                        initialView: 'dayGridMonth',
			                        locale: 'ko',
			                        headerToolbar: {
			                            left: 'prev,next today',
			                            center: 'title',
			                            right: 'dayGridMonth,listWeek'
			                        },
			                        contentHeight: 600,
			                        eventClick: function(info) {
		                      		  $("#selectRezModal").modal("show");
		                      	  
			                      	  $("#rezWriter2").val(info.event._def.extendedProps.empName);
			                      	  $("#rscName2").val(info.event._def.extendedProps.rscName);
			                      	  $("#startTime2").val(moment(info.event.start).format('YYYY-MM-DDTHH:mm:ss'));
			                          $("#endTime2").val(moment(info.event.end).format('YYYY-MM-DDTHH:mm:ss'));
			                          $("#rezTitle2").val(info.event.title);
			                            
			                            info.el.style.borderColor = 'black';
			                      	  },
			                        events: data
			                    });
			
			                    calendar.render();
			                });
			
			                request.fail(function (jqXHR, textStatus) {
			                    alert("Request failed: " + textStatus);
			                });
			            });
			
			        });
			    </script>
			    <script>
			        document.addEventListener('DOMContentLoaded', function () {
			            var calendarEl = document.getElementById('calendar');
			            var calendar = new FullCalendar.Calendar(calendarEl, {
			                initialView: 'dayGridMonth'
			            });
			            calendar.render();
			        });
			    </script>
			
			    <div id='calendar'></div>
			    
			        <div class="modal fade" id="selectRezModal">
				      <div class="modal-dialog modal-dialog-centered">
				        <div class="modal-content">
				          <!-- Modal Header -->
				          <div class="modal-header">
				            <h4 class="modal-title">예약 상세 조회</h4>
				            <button type="button" class="close" data-dismiss="modal">&times;</button>
				          </div>
				            <!-- Modal Body -->
				            <div class="modal-body">
				              <label for="rezWriter" class="mr-sm-2">예약자 명</label>
				              <input type="text" class="form-control mb-2 mr-sm-2" id="rezWriter2" name="empName" readonly><br>
				
				              <label for="rscNo" class="mr-sm-2">예약 자원</label>
				              <input type="text" class="form-control mb-2 mr-sm-2" id="rscName2" name="rscNo" value="${rscNo}" readonly><br>
				
				              <label for="rezTime" class="mr-sm-2">예약 시간</label><br>
				              
				              <input type="datetime-local" class="mb-2 mr-sm-2" id="startTime2" name="startTime" readonly>&emsp;&emsp;~&emsp;&emsp;
				              <input type="datetime-local" class="mb-2 mr-sm-2" id="endTime2" name="endTime" readonly><br><br>
				
				              <label for="rezTitle" class="mr-sm-2">예약 명</label>
				              <input type="text" class="form-control mb-2 mr-sm-2" id="rezTitle2" name="rezTitle" readonly>
				            </div>
				                        <!-- Modal footer -->
				            <div class="modal-footer">
				              <button type="button" class="btn btn-primary" data-dismiss="modal">확인</button>
				            </div>
				        </div>
				      </div>
				    </div>
			</div>
            <!-- 예약 달력 끝 -->
         </div>
         <div class="row">
         	<div class="col-sm-3"></div>
         	<div id="commDiv" class="col-sm-4" style="border:1px solid #d4d9d9;">
         		<h3>부서별 소통란</h3>
         		<div id="newSpeed" class="form-inline" style="margin-bottom:5%;">
         			<div class="form-group">
                   		<textarea class="form-control" id="commContent" rows="2" cols="60" style="resize:none;" placeholder="새로운 소식을 알려주세요."></textarea>
         				<button type="button" id="addComm" class="form-control btn btn-info" style="height:50px;" >게시</button>
         			</div>
         		</div>
         		<br>
         		<div id="commListDiv">
					<table id="commTable">
         				<tbody>
         				</tbody>
       				</table>
         		</div>
         	</div>
         </div>
      </section>
   </section>         
</body>
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
	            var value = "<b>공지사항</b>";
	            
	            if(list.length < 0){
	            	value += "<tr><td><h3>조회된 공지사항이 없습니다.</h3><td></tr>"
	            }else{
		            $.each(list, function(i, obj){
		               value += "<tr onclick='goDetail(1, "+obj.noticeNo+")'><td style='width:68%'>"
		                    +  obj.noticeTitle+"</td>"
		                    +  "<td>"+obj.createDate+"&nbsp;&nbsp;"+obj.noticeWriter+"&nbsp;"+obj.posName+"</td></tr>";
		                    
		            });
	            }
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
	         
	         if(list.length < 0){
	        	 value += "<tr><td>조회된 게시글이 없습니다.</td></tr>"
	         }else{
		         $.each(list, function(i, obj){
		            value += "<tr onclick='goDetail(2, "+obj.anoNo+")'><td style='width:65%'>" + obj.anoTitle;
		            if(obj.replyCnt > 0){
		               value += "&nbsp;[<span style='color:#2c86dc;'>"+obj.replyCnt+"</span>]";
		            }
		            value += "</td>"
		                 +  "<td> 익명 > "+obj.createDate+"</td></tr>";
		         });
	         }
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
<script>
	// 부서별 소통란 조회 및 추가
	$(function(){
		selectCommList();
		
		$(document).on("click", "#commTable tbody tr span", function(){
			var commNo = $(this).find('input').val();
			
			if(!confirm("선택한 글을 지우시겠습니까?")){
				return false;
			}else{
				$.ajax({
					url:"commDelete.do",
					type:"post",
					data:{commNo:commNo},
					success:function(result){
						if(result > 0){
							selectCommList();
						}else{
							alert("소통글 삭제 실패");
						}
					},error:function(){
						console.log("소통 삭제 ajax 통신 실패");
					}
				});
			}
		});
		
		// 소통란 글 추가 ajax
		$(document).on("click", "#addComm", function(){
			
			if($("#commContent").val().trim().length != 0){
				$.ajax({
					url:"comminsert.do",
					type:"post",
					data:{
						depNo:${loginUser.depNo},
						commWriter:"${loginUser.empNo}",
						commContent:$("#commContent").val()
					},
					success:function(result){
						if(result > 0){
							$("#commContent").val("");
							selectCommList();
						}else{
							alert("등록 실패");
						}
					},error:function(){
						console.log("등록 ajax 통신 실패");
					}
				});
			}else{
				alert("글을 작성하세요");
			}
		});
		
		function selectCommList(){
			$.ajax({
				url:"commList.do",
				data:{depNo:${loginUser.depNo}},
				type:"get",
				success:function(list){
					var value="";
					if(list.length < 0){
						value += "<tr><td>조회된 글이 없습니다.</td></tr>"
					}else{
						$.each(list, function(i, obj){
							
							if(obj.empPfe == null){
								value +=  "<tr><td><img class='myphoto img-circle' src='resources/img/common/basicimg.png'>&nbsp;&nbsp;&nbsp;</td>";
							}else{
								value +=  "<tr><td><img class='myphoto img-circle' src='resources/empUpload_files/"+obj.empPfe+"'>&nbsp;&nbsp;&nbsp;</td>";
							}
							
							value += "<td style='width:85%;'>"+obj.commWriter+"&nbsp;&nbsp;"+obj.createDate+"<br>"
								  +	 obj.commContent +"</td>"
								  +	 "<td>&nbsp;<span style='cursor:pointer; margin-bottom:45px;' class='close'><input type='hidden' value="+obj.commNo+"><i class='bi bi-x-lg'></i></span></td>"
								  +  "</tr>"  
						});
					}
					$("#commTable tbody").html(value);
				}
			});
		}
	});
</script>
</html>