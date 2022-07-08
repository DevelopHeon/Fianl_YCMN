<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.uni.spring.employee.model.dto.Employee"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>myPage</title>


<style>

/* table>thead>tr>th {
 	white-space : pre;
 	padding: 10px;
 } */

</style>
</head>

<body>
	<jsp:include page="../common/menubar.jsp"/>	
	
    <!-- **********************************************************************************************************************************************************
        MAIN CONTENT
        *********************************************************************************************************************************************************** -->
    <!--main content start-->
    <section id="main-content">
      <section class="wrapper site-min-height">
        <div class="row mt">
          <div class="col-lg-12">
            <div class="row">
            <!-- /col-md-4 -->
            <!-- 프로필 사진 -->

            <form id="updateImg" method="post" enctype="multipart/form-data">
              <div class="col-md-4 profile-text mt mb centered right-divider">
              <h4>프로필 사진</h4>
                <div class="profile-pic">
                 <c:if test="${ !empty empInfo.empPfe }">
                	<p><img src="resources/empUpload_files/${empInfo.empPfe}" id="empImg" class="img-circle"></p>
                </c:if>
                <c:if test="${ empty empInfo.empPfe}">
               		<p><img src="resources/img/user.png" class="img-circle"></p>
                </c:if>

                  <p>
                  	<input type="file" name="file" accept="image/gif, image/jpeg, image/png" style="display:none">                 	
                  	<input type="text" name="empNo" value= "${loginUser.empNo}" style="display:none">
                    <button type="button" onclick="onclick=document.all.file.click()" class="btn btn-theme"><i class="fa fa-check"></i>사진등록</button>
                    <button type="submit" id="updateBtn" class="btn btn-theme"><i class="fa fa-check"></i>저장하기</button>
                    <button type="button" onclick="changeESTJ();" id="deleteBtn" class="btn btn-theme02">삭제하기</button>
                  </p>
                </div>
              </div>
             </form>
             <!-- 프로필 사진 -->
    <script>
    	$(function(){
    		
    		$("#updateBtn").click(function(){
    				
   				var form = $("#updateImg")[0];
       			var data = new FormData(form);
       			
       			$.ajax({
       				type:"post",
       				enctype:'multipart/form-data',
       				url:"updateImg.do",
       				data:data,
       				async: false,
       				processData:false,
       				contentType:false,
       				cache:false,
       				success:function(result){
       					console.log(result);
       					alert("프로필 사진이 변경되었습니다.");

       				},
       				error:function(e){
       					console.log(e);
       				}
       			})
    		})
    		
    	
    		/*$("#deleteBtn").click(function(){
    			var form = $("#updateImg")[0];
    			var data = new FormData(form);
    			
    			$.ajax({
    				type:"post",
    				enctype:'multipart/form-data',
    				url:"deleteImg.do",
    				data:data,
    				async: false,
    				processData:false,
    				contentType:false,
    				cache:false,
    				success:function(result){
    					console.log(result);
    					alert("하");
    				},
    				error:function(e){
    					console.log(e);
    				}
    			})
    			
    		})*/
    		
    	})
    function changeESTJ(){
 			//image.src = "resources/img/user.png"
 			var form = $("#updateImg")[0];
 			var data = new FormData(form);
 			$.ajax({
 				type:"post",
 				enctype:'multipart/form-data',
 				url:"deleteImg.do",
 				data:data,
 				async: false,
 				processData:false,
 				contentType:false,
 				cache:false,
 				success:function(result){
 					console.log(result);
 					alert("프로필 사진이 삭제되었습니다.");
 					document.location.reload();
 				},
 				error:function(e){
 					console.log(e);
 				}
 			})
    	}
    
    </script>
   
              <!-- /col-md-4 -->
              <form action="updateEmp.do" method="post">
              
               <div class="col-md-8 profile-text mt mb centered right-divider">
               <h4>내 정보</h4>
               <table class="table">
				<tr>
					<th>이름 : </th>
					<td><input type="text"  name="empName" value="${ loginUser.empName }" class="col-sm-10 form-control" ></td>
					<th>사번 : </th>
					<td><input type="text"  name="empNo" value="${ loginUser.empNo }" readonly class="form-control"></td>
					<th>아이디 : </th>
					<td><input type="text"  name="empId" value="${ loginUser.empId }" readonly class="form-control"></td>
				</tr>
				<tr>
					<th>부서 : </th>
					<td><input type="text"  name="depName" value="${ loginUser.depName }" readonly class="form-control"></td>
					<th>직위 : </th>
					<td><input type="text"  name="posName" value="${ loginUser.posName }" readonly class="form-control"></td>
					<th>이메일 : </th>
					<td><input type="email"  name="empEmail" value="${ loginUser.empEmail }" style="width:180px" class="form-control"></td>
				</tr>
				<tr>
					<th>위치 : </th>
					<td><input type="text"  name="empLoc" value="${ loginUser.empLoc }" class="form-control"></td>
					<th>내선번호 : </th>
					<td><input type="text"  name="officeTel" value="${ loginUser.officeTel }" class="form-control"></td>
					<th width="100">휴대번호 : </th>
					<td><input type="tel"  name="empPhone" value="${ loginUser.empPhone }" class="form-control"></td>
				</tr>
			   </table>
			   <button id="update" type="submit" class="btn btn-primary">수정하기</button>
		       <button data-toggle="modal" type="button" class="btn btn-info" data-target="#myModal">비밀번호 변경하기 </button>
			   </div>
              </form>
              <!-- /col-md-4 -->
            </div> 
            <!-- /row -->
          </div>
          
          <!-- /col-lg-12 -->
          <div class="col-lg-12 mt">
            <div class="row content-panel">
              <h3>인사 정보</h3>
               <table class="table">
				<tr>
					<th>입사일 : </th>
					<td>${empPer.hireDate }</td>
					<th>생년월일 : </th>
					<td>${empPer.birthDate }</td>
					<th>성별 : </th>
					<td>${empPer.gender }</td>
					<th>채용구분 : </th>
					<td>${empPer.hireCategory }</td>
				</tr>
				<tr>
					<th>급여 : </th>
					<td>${empPer.sarary }</td>
					<th>결혼 : </th>
						<c:choose>
						<c:when test="${empPer.marryStatus eq 'Y'}">
					<td>기혼</td>
						</c:when>
						<c:otherwise>
					<td>미혼</td>
						</c:otherwise>
						</c:choose>
					<th>병역 : </th>
						<c:choose>
						<c:when test="${empPer.gender eq 'F' && empPer.miliStatus eq 'N'}">
					<td>면제 (여성)</td>
						</c:when>
						<c:when test="${empPer.miliStatus eq 'Y'}">
					<td>병장 만기전역</td>
						</c:when>
						<c:otherwise>
					<td>사유 : </td>
						</c:otherwise>
						</c:choose>
					<th>인사 : </th>
						<c:if test="${ empty empPer.personnelEval}">
					<td>신입</td>
						</c:if>
					<td>${empPer.personnelEval }</td>
				</tr>
			   </table>
              </div>
              <!-- /panel-body -->
            </div>
            <!-- /col-lg-12 -->
          </div>
          <!-- /row -->
        
        <!-- /container -->
      </section>
      <!-- /wrapper -->
    </section>
    <!-- /MAIN CONTENT -->
    <!--main content end-->
    <!-- modal창 시작 부분 -->
	<div id="myModal" class="modal fade" role="dialog">
	  <div class="modal-dialog">
	    <!-- Modal content-->
	    <div class="modal-content">
	      <div class="modal-header">
	        <h4 class="modal-title">비밀번호 변경하기</h4>
	        <button type="button" class="close" data-dismiss="modal">&times;</button>
	      </div>
	      <form action="changePwd.do" method="post" onsubmit="return changePwdValidate();">
		      <div class="modal-body">
		      	<input type="hidden" value="${ loginUser.empNo }" name="empNo">
		      	<label for="empPwd" class="mr-sm-2">현재 비밀번호</label>
		      	<input type="password" class="form-control mb-2 mr-sm-2" required placeholder="현재 비밀번호를 입력하세요." id="empPwd" name="empPwd">
                <label for="newPwd" class="mr-sm-2">새 비밀번호</label>
                <input type="password" class="form-control mb-2 mr-sm-2" required placeholder="새 비밀번호를 입력하세요." id="newPwd" name="newPwd" maxlength='20'>
                <label for="newPwdCheck" class="mr-sm-2">새 비밀번호 확인</label>
                <input type="password" class="form-control mb-2 mr-sm-2" required placeholder="새 비밀번호를 입력하세요." id="newPwdCheck" name="newPwdCheck" maxlength='20'>
		      </div>
		      <div class="modal-footer">
		      	<button type="submit" class="btn btn-primary">비밀번호 변경하기</button>
		        <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
		      </div>
	      </form>
	    </div>
	  </div>
	</div>
	<!-- 비밀번호 변경하기 유효성 검사 -->
	<script>
		function changePwdValidate(){
			var empPwd = $('#empPwd').val();
			var newPwd = $('#newPwd').val();
			var newPwdCheck = $('#newPwdCheck').val();
			console.log(empPwd);
			if(empPwd == newPwd){
				alert("현재 비밀번호와 다른 비밀번호를 입력하세요.");
				return false;
			}else if(newPwd != newPwdCheck){
				alert("새 비밀번호와 새 비밀번호 확인이 일치하지 않습니다.");
				return false;
			}else if(empPwd == ""){
				alert("현재 비밀번호는 필수 입력 값입니다");
				return false;
			}else if(newPwd == ""){
				alert("새 비밀번호는 필수 입력 값입니다.");
				return false;
			}else if(newPwdCheck == ""){
				alert("새 비밀번호 확인은 필수 입력 값입니다.");
				return false;
			}else if(newPwd.length < 4){
				alert("비밀번호는 최소 4자리 이상입니다.");
				return false;
			}
			
			return true;
		}
	</script>

</body>
</html>