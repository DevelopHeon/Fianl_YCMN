<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div class="modal-dialog modal-sm">
	<div class="modal-content">
		<div class="modal-header">
			<h3 class="modal-title">사원 추가</h3>
			<button type="button" class="close" data-dismiss="modal">&times;</button>
		</div>
		<div class="modal-body">	
			<h4>총무부서 &nbsp;<a data-toggle="collapse" data-target="#dept1"><i class="fa fa-plus-square"></i></a></h4>
			<div id="dept1" class="collapse"></div>
			<h4>인사부서&nbsp;<a data-toggle="collapse" data-target="#dept2"><i class="fa fa-plus-square"></i></a></h4>
			<div id="dept2" class="collapse"></div>
			<h4>개발부서&nbsp;<a data-toggle="collapse" data-target="#dept3"><i class="fa fa-plus-square"></i></a></h4>
			<div id="dept3" class="collapse"></div>
			<h4>영업부서&nbsp;<a data-toggle="collapse" data-target="#dept4"><i class="fa fa-plus-square"></i></a></h4>
			<div id="dept4" class="collapse"></div>
			<h4>연구부서&nbsp;<a data-toggle="collapse" data-target="#dept5"><i class="fa fa-plus-square"></i></a></h4>
			<div id="dept5" class="collapse"></div>
			<h4>연수중&nbsp;<a data-toggle="collapse" data-target="#dept6"><i class="fa fa-plus-square"></i></a></h4>
			<div id="dept6" class="collapse"></div>
		</div>
		<div class="modal-footer" id="modalBtn">
		</div>
	</div>
</div>
</body>
		<script>
			// 결재자 조회 ajax
			function selectApprover(num, empNo){
				var insertVal = "";
				$.ajax({
					url:"selectApprover.do",
					type:"get",
					data:{empNo:empNo},
					success:function(list){
						var value1 = "";
						var value2 = "";
						var value3 = "";
						var value4 = "";
						var value5 = "";
						var value6 = "";
						$.each(list, function(i, obj){
							if(obj.depName == '총무부서'){
								value1 += "<div class='addressList'><input type='radio' name='checkTo' class='checkTo' value="+ obj.empName +">&nbsp;&nbsp;"
								  +   obj.empName + "/"+ obj.posName
								  +   "<input type='hidden' class='form-control' value="+ obj.empNo +" name='empNo'></div>";
							}else if(obj.depName == '인사부서'){
								value2 += "<div class='addressList'><input type='radio' name='checkTo' class='checkTo' value="+ obj.empName +">&nbsp;&nbsp;"
								  +   obj.empName + "/"+ obj.posName
								  +   "<input type='hidden' class='form-control' value="+ obj.empNo +" name='empNo'></div>";
							}else if(obj.depName == '개발부서'){
								value3 += "<div class='addressList'><input type='radio' name='checkTo' class='checkTo' value="+ obj.empName +">&nbsp;&nbsp;"
								  +   obj.empName + "/"+ obj.posName
								  +   "<input type='hidden' class='form-control' value="+ obj.empNo +" name='empNo'></div>";
							}else if(obj.depName == '영업부서'){
								value4 += "<div class='addressList'><input type='radio' name='checkTo' class='checkTo' value="+ obj.empName +">&nbsp;&nbsp;"
								  +   obj.empName + "/"+ obj.posName
								  +   "<input type='hidden' class='form-control' value="+ obj.empNo +" name='empNo'></div>";
							}else if(obj.depName == '연구부서'){
								value5 += "<div class='addressList'><input type='radio' name='checkTo' class='checkTo' value="+ obj.empName +">&nbsp;&nbsp;"
								  +   obj.empName + "/"+ obj.posName
								  +   "<input type='hidden' class='form-control' value="+ obj.empNo +" name='empNo'></div>";
							}else{
								value6 += "<div class='addressList'><input type='radio' name='checkTo' class='checkTo' value="+ obj.empName +">&nbsp;&nbsp;"
								  +   obj.empName + "/ 연수생"
								  +   "<input type='hidden' class='form-control' value="+ obj.empNo +" name='empNo'></div>";
							}
						});
						
						// 1,2,3에 따라 수신, 참조, 비밀참조
						if(num == 1){
							insertVal += '<button type="button" onclick="insertApprover(1)" id="addBtn" class="btn btn-primary">추가</button>'
									  +  '<button type="button" class="btn btn-danger" data-dismiss="modal">취소</button>'
						}else if(num == 2){
							insertVal += '<button type="button" onclick="insertApprover(2)" id="addBtn" class="btn btn-primary">추가</button>'
								  +  '<button type="button" class="btn btn-danger" data-dismiss="modal">취소</button>'
						}else {
							insertVal += '<button type="button" onclick="insertApprover(3)" id="addBtn" class="btn btn-primary">추가</button>'
								  +  '<button type="button" class="btn btn-danger" data-dismiss="modal">취소</button>'
						}
						
						$("#dept1").html(value1);
						$("#dept2").html(value2);
						$("#dept3").html(value3);
						$("#dept4").html(value4);
						$("#dept5").html(value5);
						$("#dept6").html(value6);
						$("#modalBtn").html(insertVal);
						
					},error:function(){
						console.log("주소록 조회용 ajax 통신 실패");
					}
				});
			}
		</script>
		<script>
		// 결재자 추가 스크립트
			function insertApprover(num){
				var receiver = $("input[name=checkTo]:checked").val();
				var receiverNo = $("input[name=checkTo]:checked").next().val();
				
				// radio체크 여부에 따라 추가 버튼 활성화
				if($('input[name=checkTo]:checked').length < 1){
					alert('수신할 사원을 선택하세요.')
					return false;
				}
				
				// 중복이면 추가되지 않도록 체크
				if($("input[name=mailTo]").val() == receiverNo || $("input[name=mailRef]").val() == receiverNo || $("input[name=mailSec]").val() == receiverNo){
					console.log(receiverNo);
					alert("이미 추가된 사원입니다. 다른 사원을 선택하세요.");
					return false;
				}
				
				// 선택한 사원 테이블에 추가
				if(num == 1){
					receiver += "<input type='hidden' tabindex='1' class='form-control' value="+ receiverNo +" name='mailTo'>";			
					$("#mailTo").html(receiver);
				}else if(num == 2){
					receiver += "<input type='hidden' tabindex='2' class='form-control' value="+ receiverNo +" name='mailRef'>";
					$("#mailRef").html(receiver);
				}else{
					receiver += "<input type='hidden' tabindex='2' class='form-control' value="+ receiverNo +" name='mailSec'>";
					$("#mailSec").html(receiver);
				}
				
				$(".close").click();
				
			}
		</script>
</html>