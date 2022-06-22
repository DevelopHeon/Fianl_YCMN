<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div class="modal-dialog">
	<div class="modal-content">
		<div class="modal-header">
			<h3 class="modal-title">결재자 등록</h3>
			<button type="button" class="close" data-dismiss="modal">&times;</button>
		</div>
		<div class="modal-body">
		<div class="container-fluid">
			<div class="row">
				<div class="col-sm-5" style="color:#4ea4cd;">
					<h3 onclick='selectDeptEmp(0)'><i class="fa fa-plus-square" data-toggle="collapse" href="#deptList" aria-expanded="false" aria-controls="collapseExample"></i>&nbsp;&nbsp;개발웍스 </h3>
					<div id="deptList" class="collapse" style="margin-left:15%;"></div>
				</div>
				<div class="col-sm-7" id="approver">
				<input type="text" id="searchEmp" class="form-control" style="width:80%;" placeholder="사원의 이름을 입력하세요."><button type="button" onclick="searchEmpList()" class="btn btn-primary">검색</button>
					<table class="table table-bordered" style="width:100%; margin-top:3%;">
						<thead style="background:lightgray;">
							<tr>
								<th>선택</th>
								<th>이름</th>
								<th>직위</th>
								<th>부서</th>
								<th>사번</th>
							</tr>
						</thead>
						<tbody id="empList">
						
						</tbody>
					</table>
				</div>
			</div>
			</div>
		</div>
		<div class="modal-footer" id="modalBtn">
		</div>
	</div>
</div>
</body>
<script>
// 접었을때 폈을때 아이콘 변경
// Collapse로 화면이 펼치기 전에 호출    
	$('.collapse').on('show.bs.collapse', function () {
		// icon을 + 마크로 변경한다.      
		var target = $("[href='#"+$(this).prop("id")+"']");      
		target.removeClass("fa-plus-square");      
		target.addClass("fa-minus-square");    });    
		// Collapse로 화면이 펼친 후에 호출    
		$('.collapse').on('shown.bs.collapse', function () {      
		// icon을 + 마크로 변경한다.      
			var target = $("[href='#"+$(this).prop("id")+"']");      
			target.removeClass("fa-plus-square");      
			target.addClass("fa-minus-square");    
		});    
		// Collapse로 화면에 접기 전에 호출    
		$('.collapse').on('hide.bs.collapse', function () {
		// icon을 - 마크로 변경한다.      
		var target = $("[href='#"+$(this).prop("id")+"']");      
		target.removeClass("fa-minus-square");      
		target.addClass("fa-plus-square");    });    
		// Collapse로 화면에 접고 난 후에 호출    
		$('.collapse').on('hidden.bs.collapse', function () {
			// icon을 - 마크로 변경한다.      
			var target = $("[href='#"+$(this).prop("id")+"']");      
			target.removeClass("fa-minus-square");      
			target.addClass("fa-plus-square");    
			});
</script>
<script>
// 사원명 검색 조회
function searchEmpList(){
	if($('#searchEmp').val() == ""){
		alert("사원명을 입력해주세요.");
		return false;
	}
	$.ajax({
		url:"searchAppEmp.do",
		type:"get",
		data:{empName:$("#searchEmp").val(),
			empNo:$("#appWriterNo").val()},
		success:function(list){
			var value = "";
			if(list.length == 0){
				alert("조회된 사원이 없습니다.");
			}else{
				$.each(list, function(i, obj){
					value += "<tr><td><input type='radio' name='chk_approver' class='chk_approver' value="+ obj.empName +"><input type='hidden' class='form-control' value="+ obj.empNo +" name='empNo'></td>"
						   + "<td>"+obj.empName+"</td>"
						   + "<td>"+obj.posName+"</td>"
						   + "<td>"+obj.depName+"</td>"
						   + "<td>"+obj.empNo+"</td></tr>"
				});
			}
			$("#searchEmp").val('');
			$("#empList").html(value);
			
		},error:function(){
			console.log("사원 검색 조회 실패");
		}
	});
}
</script>
<script>
// 부서별 사원 조회
function selectDeptEmp(depNo){
	
 	 $.ajax({
		url:"selectDeptEmp.do",
		type:"get",
		data:{depNo:depNo,
			  empNo:$("#appWriterNo").val()},
		success:function(list){
			var deptEmp = "";
			$.each(list, function(i, obj){
				deptEmp += "<tr><td><input type='radio' name='chk_approver' class='chk_approver' value="+ obj.empName +"><input type='hidden' class='form-control' value="+ obj.empNo +" name='empNo'></td>"
					   + "<td>"+obj.empName+"</td>"
					   + "<td>"+obj.posName+"</td>"
					   + "<td>"+obj.depName+"</td>"
					   + "<td>"+obj.empNo+"</td></tr>"
			});
			
			$("#empList").html(deptEmp);
		},error:function(){
			console.log("부서별 사원 목록 조회 실패");
		}
	});
}
</script>
	<script>
		// 부서목록, 결재자 조회 ajax
		function selectApprover(num, empNo){
			$.ajax({
				url:"selectDept.do",
				type:"get",
				success:function(list){
					var deptList = "";
					$.each(list, function(i, obj){
						deptList += "<h4 onclick='selectDeptEmp("+obj.depNo+")'>"+obj.depName+"</h4>"
					});
					
					$("#deptList").html(deptList);
				},error:function(){
					console.log("부서목록 조회 실패");
				}
			});
			
			var insertVal = "";
			$.ajax({
				url:"selectApprover.do",
				type:"get",
				data:{empNo:empNo},
				success:function(list){
					var value = "";
					$.each(list, function(i, obj){
						value += "<tr><td><input type='radio' name='chk_approver' class='chk_approver' value="+ obj.empName +"><input type='hidden' class='form-control' value="+ obj.empNo +" name='empNo'></td>"
							   + "<td>"+obj.empName+"</td>"
							   + "<td>"+obj.posName+"</td>"
							   + "<td>"+obj.depName+"</td>"
							   + "<td>"+obj.empNo+"</td></tr>"
					});
					
					// 1,2에 따라서 결재자 추가 버튼 생성
					if(num == 1){
						insertVal += '<button type="button" onclick="insertApprover(1)" id="addBtn" class="btn btn-primary">추가</button>'
								  +  '<button type="button" class="btn btn-danger" data-dismiss="modal">취소</button>'
					}else{
						insertVal += '<button type="button" onclick="insertApprover(2)" id="addBtn" class="btn btn-primary">추가</button>'
							  +  '<button type="button" class="btn btn-danger" data-dismiss="modal">취소</button>'
					}
					
					$("#empList").html(value);
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