<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.uni.spring.employee.model.dto.Employee"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>myPage</title>

  <!-- Favicons -->
  <link href="img/favicon.png" rel="icon">
  <link href="img/apple-touch-icon.png" rel="apple-touch-icon">

  <!-- Bootstrap core CSS -->
  <link href="lib/bootstrap/css/bootstrap.min.css" rel="stylesheet">
  <!--external css-->
  <link href="lib/font-awesome/css/font-awesome.css" rel="stylesheet" />
  <!-- Custom styles for this template -->
  <link href="css/style.css" rel="stylesheet">
  <link href="css/style-responsive.css" rel="stylesheet">

<style>

 #update {
	margin : 100px; 
 }
</style>
</head>

<body>
	<jsp:include page="../main.jsp"/>
	
    <!-- **********************************************************************************************************************************************************
        MAIN CONTENT
        *********************************************************************************************************************************************************** -->
    <!--main content start-->
    <section id="main-content">
      <section class="wrapper site-min-height">
        <div class="row mt">
          <div class="col-lg-12">
            <div class="row content-panel">
            <!-- /col-md-4 -->
            <form id="updateImg" method="post" enctype="multipart/form-data">
              <div class="col-md-4 profile-text mt mb centered right-divider">
                <div class="profile-pic">
                <c:if test="${ empty loginUser.empPfe}">
               		<p><img src="resources/img/user.png" class="img-circle"></p>
                </c:if>
                 <c:if test="${ !empty loginUser.empPfe }">
                	<p><img src="resources/empUpload_files/${loginUser.empPfe}" id="empImg" class="img-circle"></p>
                </c:if>
                  <p>
                  	<input type="file" name="file" style="display:none">
                  	
                  	<input type="text" name="empNo" value= "${loginUser.empNo}" style="display:none">
                    <button type="button" onclick="onclick=document.all.file.click()" class="btn btn-theme"><i class="fa fa-check"></i>변경하기</button>
                    <button type="submit" id="updateBtn" class="btn btn-theme"><i class="fa fa-check"></i>저장하기</button>
                    <button type="button" onclick="changeESTJ()" id="deleteBtn" class="btn btn-theme02">삭제하기</button>
                  </p>
                </div>
              </div>
             </form>
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
    					alert("하");
						$("#empImg").empty();
						$("#empImg").attr("src", "resources/empUpload_files/"+result);
						document.location.href = document.location.href;
    				},
    				error:function(e){
    					console.log(e);
    				}
    			})
    			
    		})
    		
    	function changeESTJ(){
    			var image = document.getElementById("empImg");
    			//image.src = "resources/img/user.png" 
    		}
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
    
    
    </script>
             
             
             
             
             
             
             
             
             
             
             
              <!-- /col-md-4 -->
              <form action="updateEmp.do" method="post">
               <div class="col-md-4 profile-text">
               <label>내 정보</label>
               <table class="detail" align="center">
				<tr>
					<td width="100px">이름 : </td>
					<td colspan="5"><input type="text"  name="empName" value="${ loginUser.empName }"><br></td>
					<td width="100px">사번 : </td>
					<td><input type="text"  name="empNo" value="${ loginUser.empNo }" readonly><br></td>
					<td width="100px">아이디 : </td>
					<td><input type="text"  name="empId" value="${ loginUser.empId }" readonly><br></td>
				</tr>
				<tr>
					<td width="100px">부서 : </td>
					<td colspan="5"><input type="text"  name="depName" value="${ loginUser.depName }" readonly><br></td>
					<td width="100px">직위 : </td>
					<td><input type="text"  name="posName" value="${ loginUser.posName }" readonly><br></td>
					<td width="100px">이메일 : </td>
					<td><input type="email"  name="empEmail" value="${ loginUser.empEmail }" style="width:180px"><br></td>
				</tr>
				<tr>
					<td width="100px">위치 : </td>
					<td colspan="5"><input type="text"  name="empLoc" value="${ loginUser.empLoc }"><br></td>
					<td width="100px">내선번호 : </td>
					<td><input type="text"  name="officeTel" value="${ loginUser.officeTel }"><br></td>
					<td width="100px">휴대번호 : </td>
					<td><input type="tel"  name="empPhone" value="${ loginUser.empPhone }"><br></td>
				</tr>		
			   </table>
               </div>
               <button id="update" type="submit" class="btn btn-primary">수정하기</button>
              </form>
              <!-- /col-md-4 -->
            </div> 
            <!-- /row -->
          </div>
          
          <!-- /col-lg-12 -->
          <div class="col-lg-12 mt">
            <div class="row content-panel">
              
              </div>
              <!-- /panel-body -->
            </div>
            <!-- /col-lg-12 -->
          </div>
          <!-- /row -->
        </div>
        <!-- /container -->
      </section>
      <!-- /wrapper -->
    </section>
    <!-- /MAIN CONTENT -->
    <!--main content end-->
    <!--footer start-->
    <footer class="site-footer">
      <div class="text-center">
        <p>
          &copy; Copyrights <strong>Dashio</strong>. All Rights Reserved
        </p>
        <div class="credits">
          <!--
            You are NOT allowed to delete the credit link to TemplateMag with free version.
            You can delete the credit link only if you bought the pro version.
            Buy the pro version with working PHP/AJAX contact form: https://templatemag.com/dashio-bootstrap-admin-template/
            Licensing information: https://templatemag.com/license/
          -->
          Created with Dashio template by <a href="https://templatemag.com/">TemplateMag</a>
        </div>
        <a href="profile.html#" class="go-top">
          <i class="fa fa-angle-up"></i>
          </a>
      </div>
    </footer>
    <!--footer end-->
  <!-- js placed at the end of the document so the pages load faster -->
  <script src="lib/jquery/jquery.min.js"></script>
  <script src="lib/bootstrap/js/bootstrap.min.js"></script>
  <script class="include" type="text/javascript" src="lib/jquery.dcjqaccordion.2.7.js"></script>
  <script src="lib/jquery.scrollTo.min.js"></script>
  <script src="lib/jquery.nicescroll.js" type="text/javascript"></script>
  <!--common script for all pages-->
  <script src="lib/common-scripts.js"></script>
  <!--script for this page-->
  <!-- MAP SCRIPT - ALL CONFIGURATION IS PLACED HERE - VIEW OUR DOCUMENTATION FOR FURTHER INFORMATION -->
  <script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?key=AIzaSyASm3CwaK9qtcZEWYa-iQwHaGi3gcosAJc&sensor=false"></script>
</body>
</html>