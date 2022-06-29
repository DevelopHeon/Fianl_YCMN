<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
.myphoto{
	width:40px;
}
tr.space{
	border-bottom:10px solid #f1efef;
}
</style>
</head>
<body>
<jsp:include page="../common/menubar.jsp"/>
	<section id="main-content">
		<section class="wrapper">
			<div class="container" id="main-container">
				<h2 style="text-align:center;">익명게시판</h2>
				<hr>
				<h3>${ anoBoard.anoTitle }</h3>
				<b>${ anoBoard.createDate }</b>&nbsp;&nbsp;
				<small>조회수 : <c:out value="${ anoBoard.count }" /></small>
				<c:if test="${ anoBoard.anoWriter eq 'Y' }">
                	<button type="button" style="margin-left:67%;" class="btn btn-primary" onclick="anoBoardFormSubmit(1);">수정하기</button>
               		<button type="button" class="btn btn-danger" onclick="anoBoardFormSubmit(2);">삭제하기</button>
				</c:if>
				<form id="anoBoardForm" action="" method="post">
					<input type="hidden" name="anoNo" value="${ anoBoard.anoNo }">
				</form>
				<br>
				<hr style="opacity:0.4;">
				<br><br>
				<div id="anoContent">
					${ anoBoard.anoContent }					
				</div>
				<br>
				<hr>
				<br>
				<div align="center">
					<button type="button" class="btn btn-secondary btn-lg" onclick="location.href='anoBoardList.do';"><b>목록으로</b></button>
				</div>
				<div style="background:#f1efef; height:40px; width:100px;">
					<p class="text-center" style="font-size:1.8rem;">댓글</p>
				</div>
					<table id="replyArea" class="table" style="background:#f1efef; width:100%;" align="center">
			           <thead>
			               <tr>
			               		<th colspan="2" style="width:93%;">
			                    	<textarea class="form-control" id="replyContent" rows="2" style="resize:none; width:100%" placeholder="의견을 남겨주세요."></textarea>
			               		</th>
			               	 	<th>
			                	 	<button class="btn" style=" background:white; margin-bottom:10%; color:#2c86dc;" id="addReply">등록하기</button>
			                	</th>
			            	</tr>
			            <tr>
			            	<td colspan="2">댓글 (<span id="rcount" style="color:#2c86dc;">0</span>) </td> 
			            </tr>
			        </thead>
			        <tbody>
			        
			        </tbody>
				</table>
			</div>
		</section>
	</section>
</body>
<script>
// 수정, 삭제 스크립트
	function anoBoardFormSubmit(num){
		var anoBoardForm = $("#anoBoardForm");
		
		if(num == 1){
			anoBoardForm.attr("action", "updateFormAnoBoard.do");
		}else if(num ==2){
			if(confirm("정말 삭제하시겠습니까?")){
				anoBoardForm.attr("action", "deleteAnoBoard.do");
			}else{
				return false;
			}
		}
		anoBoardForm.submit();
	} 
</script>
<script>
$(function(){
   		selectReplyList();
  		
  		$("#addReply").click(function(){
      		var anoNo = ${ anoBoard.anoNo };

  			if($("#replyContent").val().trim().length != 0){
  				
  				$.ajax({
  					url:"rinsertAnoBoard.do",
  					type:"post",
  					data:{replyContent:$("#replyContent").val(),
  						  refNo:anoNo,
  						  replyWriter:"${loginUser.empId}"},
  					success:function(result){
  						if(result > 0){
  							$("#replyContent").val("");
  							selectReplyList();
  							
  						}else{
  							alert("댓글 등록 실패");
  						}
  					},error:function(){
  						console.log("댓글 작성 ajax 통신 실패");
  					}
  				});
  				
  			}else{
  				alert("댓글을 작성해주세요.");
  			}
  			
  		});
  	});
   	
   	function selectReplyList(){
  		var anoNo = ${ anoBoard.anoNo };
  		var confirmUser = "${ loginUser.empId }";
  		$.ajax({
  			url:"rlistAnoBoard.do",
  			data:{anoNo:anoNo,
  				  confirmUser:confirmUser},
  			type:"get",
  			success:function(list){
  				$("#rcount").text(list.length);
  				
  				var value="";
  				$.each(list, function(i, obj){
  					
					value += "<tr><td style='width:5%;'><img class='myphoto' src='resources/img/common/basicimg.png'></td>" +
  						     "<td>익명&nbsp;&nbsp;"+ obj.createDate +
  							 "<br>"+ obj.replyContent + "</td>"
  					if(obj.replyWriter === "Y"){
  						value += "<td><span style='cursor:pointer; float:right;' onclick='deleteReply("+obj.replyNo+")'><i class='bi bi-x-lg'></i></span></td>";
  					}else{
  						value += "<td></td>";
  					}
  						value += "</tr><tr class='space'></tr>";
  				});
  				$("#replyArea tbody").html(value);
  			},error:function(){
  				console.log("댓글 리스트조회용 ajax 통신 실패");
  			}
  		});
  	}		
</script>
<script>
	function deleteReply(num){
		console.log(num);
		if(!confirm("선택한 댓글을 삭제하시겠습니까?")){
			return false;
		}else{
			$.ajax({
				url:"rdeleteAnoBoard.do",
				type:"post",
				data:{replyNo:num},
				success:function(result){
					if(result > 0){
						selectReplyList();
					}else{
						alert("의견 삭제 실패");
					}
				},error:function(){
					console.log("댓글 삭제 ajax 통신 실패");
				}			
			});
		};
	}
</script>
</html>