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
 div{
 	border-radius:10px;
 }
.myphoto{
	width:50px;
}
tr.space{
	border-bottom:30px solid white;
}
</style>

</head>
<body>
<jsp:include page="common/menubar.jsp"/>
   <section id="main-content">
      <section class="wrapper" style="margin-top:10px;">
         <div class="row">
            <div class="col-sm-3" style="border:1px solid #d4d9d9; margin-right:5%; margin-left:2%;">
                        <c:if test="${ empInfo.empPfe eq null}">
                           <p class="empImg centered"><img src="resources/img/user.png" class="img-circle" width="80"></p>
                        </c:if>
                        <c:if test="${ !empty empInfo.empPfe }">
                            <p class="empImg centered"><img src="resources/empUpload_files/${empInfo.empPfe}" class="img-circle" width="80"></p>
                        </c:if>
                        <h3 class="centered">${ sessionScope.loginUser.empName }</h3>
                     <span class="centered"><button type="button" class="btn btn-round btn-default">결재 작성</button>&nbsp;&nbsp;&nbsp;<button type="button" class="btn btn-round btn-default">메일 작성</button></span>
                     <br>
                     <span class="centered"><button type="button" class="btn btn-round btn-default">주소록</button>&nbsp;&nbsp;&nbsp;<button type="button" class="btn btn-round btn-default">회의 예약</button></span>
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
            	다
            </div>
         </div>
         <%-- 아랫줄 레이아웃 --%>
         <div class="row" style="margin-top:3%;">
         	<div class="col-sm-3" style="border:1px solid #d4d9d9; margin-right:5%; margin-left:2%;">
         	가
         	</div>
         	<div class="col-sm-4" style="border:1px solid #d4d9d9;">
         		<h4>부서별 소통란</h4>
         		<div id="newSpeed" class="form-inline" style="margin-bottom:5%;">
         			<div class="form-group">
                   		<textarea class="form-control" id="commContent" rows="2" cols="60" style="resize:none;" placeholder="새로운 소식을 알려주세요."></textarea>
         				<button type="button" id="addComm" class="form-control btn btn-info" style="height:50px;" >게시</button>
         			</div>
         		</div>
         		<br>
         		<div id="newSpeedlist">
					<table id="newSpeedTable">
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
	// 부서별 소통란 조회 및 추가
	$(function(){
		selectCommList();
		
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
								value += "<tr>"
									  +		"<td><img class='myphoto img-circle' src='resources/img/common/basicimg.png'>&nbsp;&nbsp;&nbsp;</td>";
							}else{
								value += "<tr>"
									  +		"<td><img class='myphoto img-circle' src='resources/empUpload_files/"+obj.empPfe+"'>&nbsp;&nbsp;&nbsp;</td>";
							}
							
							value += "<td style='width:85%;'>"+obj.commWriter+"&nbsp;&nbsp;"+obj.createDate+"<br>"
								  +	 obj.commContent +"</td>"
								  +	 "<td>&nbsp;<span style='cursor:pointer;' onclick='deleteComm("+obj.commNo+")'><i class='bi bi-x-lg'></i></span></td>"
								  +  "<tr class='space'></tr>"
						});
					}
					$("#newSpeedTable tbody").html(value);
				}
			});
		}
	});

</script>
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
</html>