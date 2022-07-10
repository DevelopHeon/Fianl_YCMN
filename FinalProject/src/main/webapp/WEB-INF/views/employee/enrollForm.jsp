<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>개발웍스 사원 가입</title>
<link rel="icon" type="image/png" href="resources/img/favicon.ico">
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">

<!-- jQuery library -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<!-- Latest compiled JavaScript -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script> 
<style>
    .innerOuter{
        margin:5% 20% 5% 20%;
    }
</style>
</head>
<body>
    <div class="content">
        <br><br>
        <div class="innerOuter">
            <h2>사원 등록</h2>
            <br>
            <form:form id="enrollForm" modelAttribute="employee"
            action="insertEmployee.do" method="post">
                <div class="form-group">
                    <label for="empId">* ID :</label>
                    <form:input path="empId" type="text" class="form-control" id="empId" name="empId" placeholder="Please Enter ID" required="required" />
                    <div style="color:red;"><form:errors path="empId" /></div>
                    <div style="font-size:0.8em; color:#007bff;">아이디는 최소 5자리 이상 입력해주세요.</div>
                    <div id="checkResult" style="display:none; font-size:0.8em"></div>
                    <!-- 아이디 중복 검사를 확인하는  div -->
                    <br>
                    
                    <label for="empPwd">* Password :</label>
                    <form:input path="empPwd" type="password" class="form-control" id="empPwd" name="empPwd" placeholder="Please Enter Password" required="required" /><br>
                    <div style="color:red;"><form:errors path="empPwd" /></div>
                    <label for="checkPwd">* Password Check :</label>
                    <input type="password" class="form-control" id="checkPwd" placeholder="Please Enter Password" required><br>
                    
                    <label for="empName">* Name :</label>
                    <form:input path="empName" type="text" class="form-control" id="empName" name="empName" placeholder="Please Enter Name" required="required" /><br>
                    <div style="color:red;"><form:errors path="empName" /></div>
                    <label for="empEmail">* Email :</label>
                    <form:input path="empEmail" type="email" class="form-control" id="empEmail" name="empEmail" placeholder="Please Enter Email" /><br>
                    <div style="color:red;"><form:errors path="empEmail" /></div>
                    <label for="empPhone">* Phone :</label>
                    <form:input path="empPhone" type="tel" class="form-control" id="empPhone" name="empPhone" placeholder="Please Enter Phone (-없이)" /><br>
                    <div style="color:red;"><form:errors path="empPhone" /></div>
                <div class="btns" align="center">
                    <button type="submit" id="enrollBtn" class="btn btn-primary" disabled>회원가입</button><!-- disabled  중복처리하고나서-->
                    <button type="reset" class="btn btn-danger"> 초기화</button>
                </div>
                </div>
            </form:form>
        </div>
        <br><br>
    </div>
    
    <script>
   // 아이디 중복체크 아직 안하는 경우 : 메세지 보여지지 않고 버튼 비활성화
   // 아이디 중복체크 후 사용불가능한 아이디일 경우 : 메세지로 "중복아이디 존재 사용불가능" 띄워주고 버튼 비활성화
   // 아이디 중복체크 후 사용가능한 아이디일 경우 : 메세지로 "사용 가능한 아이디" 띄워주고 버튼 활성화
     // 중복체크 나중에 
     function idCheckValidate(num){ 
          
          if(num == 0){ // 아직 중복체크를 하지 않는 경우 (아이디 적어도 5글자 이상은 되어야만 본격적으로 중복체크할 꺼임)
             $("#checkResult").hide();
             $("#enrollBtn").attr("disabled", true);
             
          }else if(num == 1){ // 중복된 아이디가 존재할 경우 
             $("#checkResult").css("color", "red").text("중복된 아이디가 존재합니다. 사용이 불가능합니다.");
             $("#checkResult").show();
             $("#enrollBtn").attr("disabled", true);
             
          }else if(num == 2){ // 중복된 아이디가 존재하지 않을 경우 ->사용 가능
             $("#checkResult").css("color", "green").text("사용 가능한 아이디입니다. ");
             $("#checkResult").show();
             $("#enrollBtn").removeAttr("disabled");
             
          }
          
       }

   $(function(){
          
          var $idInput = $("#enrollForm input[name=empId]"); // 아이디 입력하는 input 요소
          
          $idInput.keyup(function(){
             
             // 아이디는 최소 5글자 ~ 
             if($idInput.val().length >= 5){ // 5글자 이상되었을 때 본격적으로 중복체크
                
                  $.ajax({
                     url:"idCheck.do",
                     data:{empId:$idInput.val()},
                     type:"post",
                     success:function(result){
                        if(result > 0){ //중복된 아이디 존재
                           idCheckValidate(1);
                        }else{
                           idCheckValidate(2);
                        }
                     },error:function(){
                        console.log("아이디 중복체크용 ajax 통신 실패");
                     }
                  });
                  
             }else{
                idCheckValidate(0);
             }
             
          });
       });
    </script>
</body>
</html>