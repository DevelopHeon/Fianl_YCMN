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
			<h3 class="modal-title">결재자 등록</h3>
			<button type="button" class="close" data-dismiss="modal">&times;</button>
		</div>
		<div class="modal-body">
			<div id="dept"></div>
			<h4>총무부서 &nbsp;<a data-toggle="collapse" data-target="#dept1"><i class="bi bi-arrow-down"></i></a></h4>
			<div id="dept1" class="collapse"></div>
			<h4>인사부서&nbsp;<a data-toggle="collapse" data-target="#dept2"><i class="bi bi-arrow-down"></i></a></h4>
			<div id="dept2" class="collapse"></div>
			<h4>개발부서&nbsp;<a data-toggle="collapse" data-target="#dept3"><i class="bi bi-arrow-down"></i></a></h4>
			<div id="dept3" class="collapse"></div>
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
						$.each(list, function(i, obj){
							if(obj.depName == '총무'){
								value1 += "<div class='apperList'><input type='radio' name='chk_approver' class='chk_approver' value="+ obj.empName +">&nbsp;&nbsp;"
								  +   obj.empName + "/"+ obj.posName
								  +   "<input type='hidden' class='form-control' value="+ obj.empNo +" name='empNo'></div>";
							}else if(obj.depName == '인사'){
								value2 += "<div class='apperList'><input type='radio' name='chk_approver' class='chk_approver' value="+ obj.empName +">&nbsp;&nbsp;"
								  +   obj.empName + "/"+ obj.posName
								  +   "<input type='hidden' class='form-control' value="+ obj.empNo +" name='empNo'></div>";
							}else if(obj.depName == '개발'){
								value3 += "<div class='apperList'><input type='radio' name='chk_approver' class='chk_approver' value="+ obj.empName +">&nbsp;&nbsp;"
								  +   obj.empName + "/"+ obj.posName
								  +   "<input type='hidden' class='form-control' value="+ obj.empNo +" name='empNo'></div>";
							}else{
								value4 += "<div class='apperList'><input type='radio' name='chk_approver' class='chk_approver' value="+ obj.empName +">&nbsp;&nbsp;"
								  +   obj.empName + "/"+ obj.posName
								  +   "<input type='hidden' class='form-control' value="+ obj.empNo +" name='empNo'></div>";
							}
						});
						
						// 1,2에 따라서 결재자 추가 버튼 생성
						if(num == 1){
							insertVal += '<button type="button" onclick="insertApprover(1)" id="addBtn" class="btn btn-primary">추가</button>'
									  +  '<button type="button" class="btn btn-danger" data-dismiss="modal">취소</button>'
						}else{
							insertVal += '<button type="button" onclick="insertApprover(2)" id="addBtn" class="btn btn-primary">추가</button>'
								  +  '<button type="button" class="btn btn-danger" data-dismiss="modal">취소</button>'
						}
						
						$("#dept1").html(value1);
						$("#dept2").html(value2);
						$("#dept3").html(value3);
						$("#dept").html(value4);
						$("#modalBtn").html(insertVal);
						
					},error:function(){
						console.log("결재자 조회용 ajax 통신 실패");
					}
				});
			}
		</script>
		<script>
		// 결재자 추가 스크립트
			function insertApprover(num){
				var approver = $("input[name=chk_approver]:checked").val();
				var approverNo = $("input[name=chk_approver]:checked").next().val();
				
				// radio 체크 여부에 따라 추가 버튼 활성화
				if($('input[name=chk_approver]:checked').length < 1){
					alert('결재자 선택후 버튼을 눌러주세요.')
					return false;
				}
				
				// 중복 결재자이면 추가되지 않도록 체크
				if($("input[name=firstApprover]").val() == approverNo || $("input[name=lastApprover]").val() == approverNo){
					console.log(approverNo);
					alert("이미 추가된 결재자입니다. 다른 사원을 선택하세요.");
					return false;
				}
				
				// 선택한 사원 테이블에 추가
				if(num == 1){
					// DB에 저장할때 사용할 사번도 추가해준다.
					approver += "<input type='hidden' class='form-control' value="+ approverNo +" name='firstApprover'>";			
					$("#firstApprover").html(approver);
				}else{
					approver += "<input type='hidden' class='form-control' value="+ approverNo +" name='lastApprover'>";
					$("#lastApprover").html(approver);
				}
				
				$(".close").click();
				
			}
		</script>
</html>