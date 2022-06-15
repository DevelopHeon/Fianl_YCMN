<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>

<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta name="description" content="">
  <meta name="author" content="Dashboard">
  <meta name="keyword" content="Dashboard, Bootstrap, Admin, Template, Theme, Responsive, Fluid, Retina">
  <title>Dashio - Bootstrap Admin Template</title>

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

</head>

<body>
<jsp:include page="../main.jsp"/>
    <section id="main-content">
      <section class="wrapper site-min-height">
        <h3><i class="fa fa-angle-right"></i> 임직원 상세조회</h3>
        <div class="row mt">
          <div class="col-lg-12 mt">
            <div class="row content-panel">
              <!-- /panel-heading -->
              <div id="edit" class="tab-pane">
                <div class="row">
                  <div class="col-lg-8 col-lg-offset-2 detailed">
                    <h4 class="mb">Personal Information</h4>
                    <div class="profile-pic">
                      <p><img src="img/ui-sam.jpg" class="img-circle"></p>
                      <p>
                        <button class="btn btn-theme"><i class="fa fa-check"></i> Follow</button>
                        <button class="btn btn-theme02">Add</button>
                      </p>
                    </div>



                    <!-- updateForm 시작!!!!!!!!!!! -->
                    <form id="updateForm" class="form-horizontal" method="post" action="updateEmpDetail.do">
                      <div class="form-group">
                      <label class="col-lg-2 control-label">사번(임시)</label>
                      <div class="col-lg-6">
                        <input type="text" name="empNo" value="${ e.empNo }" class="form-control" readonly>
                      </div>
                    </div>
                    <div class="form-group">
                      <label class="col-lg-2 control-label">이름</label>
                      <div class="col-lg-6">
                        <input type="text" name="empName" value="${ e.empName }" class="form-control">
                      </div>
                    </div>
                    <div class="form-group">
                      <label class="col-lg-2 control-label">아이디</label>
                      <div class="col-lg-6">
                        <input type="text" name="empId" value="${ e.empId }" class="form-control" readonly>
                      </div>
                    </div>
                    <div class="form-group">
                      <label class="col-lg-2 control-label">이메일</label>
                      <div class="col-lg-6">
                        <input type="email" name="empEmail" value="${ e.empEmail }" class="form-control">
                      </div>
                    </div>
                    <div class="form-group">
                      <label class="col-lg-2 control-label">휴대번호</label>
                      <div class="col-lg-6">
                        <input type="text" name="empPhone" value="${ e.empPhone }" maxLength='11' class="form-control">
                      </div>
                    </div>
                    
                    <div class="form-group"> <!-- !!!!!!!!!!!!!!!!!!!!!!!!!! -->
                      <label class="col-lg-2 control-label">직위</label>
                      <div class="col-lg-6">
      <!-- 직위를 매칭해서 가져옴. -->
      <select name="posNo" id="posNo" class="form-control">
          <c:forEach items="${ getPosList }" var="pos">
          <c:choose>
            <c:when test="${e.posNo == pos.posNo}">
              <option value="${ pos.posNo }" selected>${ pos.posName }</option>
            </c:when>
            <c:otherwise>
                <option value="${ pos.posNo }">${ pos.posName }</option>
            </c:otherwise>
          </c:choose>
          
          </c:forEach>
      </select>
      
                      </div>
                    </div>
                    
                    <div class="form-group">
                      <label class="col-lg-2 control-label">부서</label>
                      <div class="col-lg-6">
                        <select name="depNo" id="depNo" class="form-control">
          <c:forEach items="${ getDepList }" var="dep">
          <c:choose>
            <c:when test="${e.depNo == dep.depNo}">
              <option value="${ dep.depNo }" selected>${ dep.depName }</option>
            </c:when>
            <c:otherwise>
                <option value="${ dep.depNo }">${ dep.depName }</option>
            </c:otherwise>
          </c:choose>
          </c:forEach>
      </select>
                      
                      </div>
                    </div>
                    
                    <div class="form-group">
                      <label class="col-lg-2 control-label">위치</label>
                      <div class="col-lg-6">
                        <input type="text" placeholder=" " name="empLoc" value="${ e.empLoc }" class="form-control">
                      </div>
                    </div>
                    
                    <div class="form-group">
                      <label class="col-lg-2 control-label">직원 상태</label>
                      <div class="col-lg-6">
                        <input type="radio" name="status" id="statusYes" value="Y"><label for="Yes">&nbsp;정상</label> &emsp;&emsp;
                        <input type="radio" name="status" id="statusNo" value="N"><label for="No">&nbsp;대기</label> &emsp;&emsp;
                        <input type="radio" name="status" id="statusStop" value="S"><label for="Stop">&nbsp;중지</label> &emsp;&emsp;
                        <script>
                         /* 상태 값에 따라 checked 옵션 설정 */
              $(function(){
                if("${e.status}" == "Y"){
                  $("#statusYes").attr("checked", true);
                }else if("${e.status}" == "N"){
                  $("#statusNo").attr("checked", true);
                }else if("${e.status}" == "S"){
                  $("#statusStop").attr("checked", true);
                }
              });
                   </script>
                      </div>
                    </div>

                <div class="col-lg-8 col-lg-offset-2 detailed mt">
                  <h4 class="mb">Detail Information</h4>
                    <div class="form-group">
                      <label class="col-lg-2 control-label">입사일</label>
                      <div class="col-lg-6">
<%--                               <input type="text" placeholder=" " name="hr.hireDate" value="${ e.hr.hireDate }" class="form-control">
--%>                            </div>
                    </div>
                    
                    <div class="form-group">
                      <label class="col-lg-2 control-label">생년월일</label>
                      <div class="col-lg-6">
<%--                               <input type="date" placeholder=" " name="hr.birthDate" value="${ e.hr.birthDate }" class="form-control">
--%>                            </div>
                    </div>
                    
                    <div class="form-group">
                      <label class="col-lg-2 control-label">성별</label>
                      <div class="col-lg-6">
                        <%-- <input type="text" placeholder=" " name="gender" value="${ e.hr.gender }" class="form-control"> --%>
                        <input type="radio" name="hr.gender" id="Male" value="M"><label for="Male">&nbsp;남자</label> &emsp;&emsp;
                        <input type="radio" name="hr.gender" id="Female" value="F"><label for="Female">&nbsp;여자</label> &emsp;&emsp;
                        <script>
                          /* 상태 값에 따라 checked 옵션 설정 */
            $(function(){
              if("${e.hr.gender}" == "M"){
                $("#Male").attr("checked", true);
              }else if("${e.hr.gender}" == "F"){
                $("#Female").attr("checked", true);
              }
            });
                   </script>
                      </div>
                    </div>
                    <div class="form-group">
                      <label class="col-lg-2 control-label">채용구분</label>
                      <div class="col-lg-6">
                        <input type="text" placeholder=" " name="hr.hireCategory" value="${ e.hr.hireCategory }" class="form-control">
                      </div>
                    </div>
                    <div class="form-group">
                      <label class="col-lg-2 control-label">급여 구분</label>
                      <div class="col-lg-6">
                        <input type="text" placeholder=" " name="hr.sarary" value="${ e.hr.sarary }" class="form-control">
                      </div>
                    </div>
                    <div class="form-group">
                      <label class="col-lg-2 control-label">결혼 여부</label>
                      <div class="col-lg-6">
                        <%-- <input type="text" placeholder=" " name="marryStatus" value="${ e.hr.marryStatus }" class="form-control"> --%>
                        <input type="radio" name="hr.marryStatus" id="marryYes" value="Y"><label for="marryYes">&nbsp;Y</label> &emsp;&emsp;
                        <input type="radio" name="hr.marryStatus" id="marryNo" value="N"><label for="marryNo">&nbsp;N</label> &emsp;&emsp;
                        <script>
                          /* 상태 값에 따라 checked 옵션 설정 */
        $(function(){
          if("${e.hr.marryStatus}" == "Y"){
            $("#marryYes").attr("checked", true);
          }else if("${e.hr.marryStatus}" == "N"){
            $("#marryNo").attr("checked", true);
          }
        });
                 </script>
                      </div>
                    </div>
                    <div class="form-group">
                      <label class="col-lg-2 control-label">병역 여부</label>
                      <div class="col-lg-6">
                        <%-- <input type="text" placeholder=" " name="miliStatus" value="${ e.hr.miliStatus }" class="form-control"> --%>
                        <input type="radio" name="hr.miliStatus" id="miliYes" value="Y"><label for="Yes">&nbsp;Y</label> &emsp;&emsp;
                        <input type="radio" name="hr.miliStatus" id="miliNo" value="N"><label for="No">&nbsp;N</label> &emsp;&emsp;
                        <script>
                          /* 상태 값에 따라 checked 옵션 설정 */
      $(function(){
        if("${e.hr.miliStatus}" == "Y"){
          $("#miliYes").attr("checked", true);
        }else if("${e.hr.miliStatus}" == "N"){
          $("#miliNo").attr("checked", true);
        }
      });
               </script>
                      </div>
                    </div>
                    <div class="form-group">
                      <label class="col-lg-2 control-label">인사평가</label>
                      <div class="col-lg-6">
                        <input type="text" placeholder=" " name="hr.personnelEval" value="${ e.hr.personnelEval }" class="form-control">
                      </div>
                    </div>
                    <div class="form-group">
                      <label class="col-lg-2 control-label">퇴사일</label>
                      <div class="col-lg-6">
<%--                               <input type="text" placeholder=" " name="hr.entDate" value="${ e.hr.entDate }" class="form-control">
--%>                            </div>
                    </div>
                    <div class="form-group">
                      <label class="col-lg-2 control-label">퇴사 사유</label>
                      <div class="col-lg-6">
                        <input type="text" placeholder=" " name="hr.entCon" value="${ e.hr.entCon }" class="form-control">
                      </div>
                    </div>
                    
                    <!-- 수정 버튼 div !!!!!!!!!! -->
                    <div class="form-group">
                      <div class="col-lg-offset-2 col-lg-10">
                        <button type="submit" class="btn btn-theme">회원 수정</button>
                      </div>
                    </div>
                    </div>
                  </form>
                  </div>
                  <!-- /col-lg-8 -->
                </div>
                <!-- /row -->
              </div>
              <!-- /tab-pane -->
            </div>
            <!-- /tab-content -->
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
<!--footer end-->
</section>
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
