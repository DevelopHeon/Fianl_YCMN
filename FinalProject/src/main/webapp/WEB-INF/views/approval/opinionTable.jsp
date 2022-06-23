<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<style>
.myphoto{
	width:40px;
}
tr.space{
	border-bottom:10px solid #f1efef;
}
</style>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div style="background:#f1efef; height:40px; width:100px;">
		<p class="text-center" style="font-size:1.8rem;">의견</p>
	</div>
		<table id="opinionArea" class="table" style="background:#f1efef; width:100%;" align="center">
           <thead>
               <tr>
               		<th colspan="2" style="width:93%;">
                    	<textarea class="form-control" id="opinionContent" rows="2" style="resize:none; width:100%" placeholder="의견을 남겨주세요."></textarea>
               		</th>
               	 	<th>
                	 	<button class="btn" style=" background:white; margin-bottom:10%; color:#2c86dc;" id="addOpinion">등록하기</button>
                	</th>
            	</tr>
            <tr>
            	<td colspan="2">의견 (<span id="rcount" style="color:#2c86dc;">0</span>) </td> 
            </tr>
        </thead>
	        <tbody>
	        
	        </tbody>
		</table>
</body>
<script>
   	$(function(){
   		selectOpinionList();
  		
  		$("#addOpinion").click(function(){
      		var appNo = ${ appMap.approval.appNo };

  			if($("#opinionContent").val().trim().length != 0){
  				
  				$.ajax({
  					url:"oinsertApp.do",
  					type:"post",
  					data:{opinionContent:$("#opinionContent").val(),
  						  refNo:appNo,
  						  opinionWriter:"${loginUser.empNo}"},
  					success:function(result){
  						if(result > 0){
  							$("#opinionContent").val("");
  							selectOpinionList();
  							
  						}else{
  							alert("의견 등록 실패");
  						}
  					},error:function(){
  						console.log("댓글 작성 ajax 통신 실패");
  					}
  				});
  				
  			}else{
  				alert("의견을 작성해주세요.");
  			}
  			
  		});
  	});
   	
   	function selectOpinionList(){
  		var appNo = ${ appMap.approval.appNo };
  		$.ajax({
  			url:"olistApp.do",
  			data:{refNo:appNo},
  			type:"get",
  			success:function(list){
  				$("#rcount").text(list.length);
  				
  				var value="";
  				$.each(list, function(i, obj){
  					console.log(obj.empPfe);
  					if(obj.empPfe == null){
  						value += "<tr><td style='width:5%;'><img class='myphoto' src='resources/img/common/basicimg.png'></td>";
  					}else{
  						value += "<tr><td style='width:5%;'><img class='myphoto' src='resources/empUpload_files/"+obj.empPfe+"'></td>";
  					}
  					
  					value += "<td>" + obj.opinionWriter +"&nbsp;&nbsp;"+ obj.createDate +
  							 "<br>"+ obj.opinionContent + "</td>"
  					if("${loginUser.empName}" == obj.opinionWriter){
  						value += "<td><span style='cursor:pointer; float:right;' onclick='deleteOpinion("+obj.opinionNo+")'><i class='bi bi-x-lg'></i></span></td>";
  						
  					}else{
  						value += "<td></td>";
  					}
  						value += "</tr><tr class='space'></tr>";
  				});
  				$("#opinionArea tbody").html(value);
  			},error:function(){
  				console.log("의견 리스트조회용 ajax 통신 실패");
  			}
  		});
  	}		
</script>
<script>
	function deleteOpinion(num){
		console.log(num);
		if(!confirm("선택한 의견을 삭제하시겠습니까?")){
			return false;
		}else{
			$.ajax({
				url:"deleteOpinion.do",
				type:"post",
				data:{opinionNo:num},
				success:function(result){
					if(result > 0){
						selectOpinionList();
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