<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>

<head>
<meta charset="utf-8">
<title>임직원 관리</title>
<style>
  .form-control {
    width: 50%;
  }
</style>
</head>

<body style="background:#eaeaea;">
<jsp:include page="../common/menubar.jsp" />
<section id="container">
  <!--main content start-->
  <section id="main-content">
    <section class="wrapper"  style="margin:0">
      <h3><i class="fa fa-angle-right"></i> 임직원 조회</h3>
      <!-- BASIC FORM ELELEMNTS -->

      <form id="updateForm" class="form-horizontal" method="post" action="updateEmpDetail.do">
        <div class="row mt">
          <div class="col-lg-12">
            <div class="form-panel">
              <h4 class="mb"><i class="fa fa-angle-right"></i> Personal Information</h4>

              <!-- 수정 form 시작 ★★★ -->

              <div class="form-group">
                <label class="col-sm-2 col-sm-2 control-label">사번</label>
                <div class="col-sm-5">
                  <input type="text" name="empNo" value="${ e.empNo }" class="form-control" readonly>
                </div>
              </div>

              <div class="form-group">
                <label class="col-sm-2 col-sm-2 control-label">이름</label>
                <div class="col-sm-5">
                  <input type="text" name="empName" value="${ e.empName }" class="form-control">
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 col-sm-2 control-label">아이디</label>
                <div class="col-sm-5">
                  <input type="text" name="empId" value="${ e.empId }" class="form-control round-form" readonly>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 col-sm-2 control-label">이메일</label>
                <div class="col-sm-5">
                  <input type="email" name="empEmail" value="${ e.empEmail }" class="form-control">
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 col-sm-2 control-label">휴대폰</label>
                <div class="col-sm-5">
                  <input type="text" name="empPhone" value="${ e.empPhone }" maxLength='11' class="form-control">
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 col-sm-2 control-label">직위</label>
                <div class="col-sm-5">

                  <select name="posNo" id="posNo" class="form-control">
                    <c:if test="${e.posNo == null || e.posNo == 0}">
                      <option value="0" selected>직위 선택</option>
                    </c:if>
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
                <label class="col-sm-2 col-sm-2 control-label">부서</label>
                <div class="col-sm-5">

                  <select name="depNo" id="depNo" class="form-control">
                    <c:if test="${e.depNo == null || e.depNo == 0}">
                      <option value="0" selected>부서 선택</option>
                    </c:if>
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
                <label class="col-sm-2 col-sm-2 control-label">내선 번호</label>
                <div class="col-sm-5">
                  <input type="text" placeholder=" " name="officeTel" value="${ e.officeTel }" class="form-control">
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 col-sm-2 control-label">위치</label>
                <div class="col-sm-5">
                  <input type="text" placeholder=" " name="empLoc" value="${ e.empLoc }" class="form-control">
                </div>
              </div>

              <div class="form-group">
                <label class="col-sm-2 col-sm-2 control-label">직원 상태</label>
                <div class="col-sm-5">

                  <input type="radio" name="status" id="statusYes" value="Y"><label for="Yes">&nbsp;정상</label>
                  &emsp;&emsp;
                  <input type="radio" name="status" id="statusNo" value="N"><label for="No">&nbsp;대기</label>
                  &emsp;&emsp;
                  <input type="radio" name="status" id="statusStop" value="S"><label for="Stop">&nbsp;중지</label>
                  &emsp;&emsp;
                  <script>
                    /* 상태 값에 따라 checked 옵션 설정 */
                    $(function () {
                      if ("${e.status}" == "Y") {
                        $("#statusYes").attr("checked", true);
                      } else if ("${e.status}" == "N") {
                        $("#statusNo").attr("checked", true);
                      } else if ("${e.status}" == "S") {
                        $("#statusStop").attr("checked", true);
                      }
                    });
                  </script>

                </div>
              </div>

            </div>
          </div>
          <!-- col-lg-12-->
        </div>
        <!-- /row -->
        <div class="row mt">
          <div class="col-lg-12">
            <div class="form-panel">
              <h4 class="mb"><i class="fa fa-angle-right"></i> Detail Information</h4>

              <div class="row mt">
                <label class="col-sm-2 col-sm-2 control-label">입사일</label>
                <div class="col-sm-5">
                  <input type="date" placeholder=" " name="hr.hireDate" value="${ e.hr.hireDate }" class="form-control">
                </div>
              </div>

              <div class="row mt">
                <label class="col-sm-2 col-sm-2 control-label">생년월일</label>
                <div class="col-sm-5">
                  <input type="date" placeholder=" " name="hr.birthDate" value="${ e.hr.birthDate }" class="form-control">
                </div>

              </div>
              <div class="row mt">
                <label class="col-sm-2 col-sm-2 control-label">성별</label>
                <div class="col-sm-5">

                  <input type="radio" name="hr.gender" id="Male" value="M"><label for="Male">&nbsp;남자</label>
                  &emsp;&emsp;
                  <input type="radio" name="hr.gender" id="Female" value="F"><label for="Female">&nbsp;여자</label>
                  &emsp;&emsp;
                  <script>
                    /* 상태 값에 따라 checked 옵션 설정 */
                    $(function () {
                      if ("${e.hr.gender}" == "M") {
                        $("#Male").attr("checked", true);
                      } else if ("${e.hr.gender}" == "F") {
                        $("#Female").attr("checked", true);
                      }
                    });
                  </script>

                </div>
              </div>
              <div class="row mt">
                <label class="col-sm-2 col-sm-2 control-label">채용 구분</label>
                <div class="col-sm-5">
                  <input type="text" placeholder=" " name="hr.hireCategory" value="${ e.hr.hireCategory }" class="form-control">
                </div>
              </div>
              <div class="row mt">
                <label class="col-sm-2 col-sm-2 control-label">급여 구분</label>
                <div class="col-sm-5">
                  <input type="text" placeholder=" " name="hr.sarary" value="${ e.hr.sarary }" class="form-control">
                </div>
              </div>

              <div class="row mt">
                <label class="col-sm-2 col-sm-2 control-label">결혼 여부</label>
                <div class="col-sm-5">

                  <input type="radio" name="hr.marryStatus" id="marryYes" value="Y"><label for="marryYes">&nbsp;Y</label> &emsp;&emsp;
                  <input type="radio" name="hr.marryStatus" id="marryNo" value="N"><label for="marryNo">&nbsp;N</label> &emsp;&emsp;
                  <script>
                    /* 상태 값에 따라 checked 옵션 설정 */
                    $(function () {
                      if ("${e.hr.marryStatus}" == "Y") {
                        $("#marryYes").attr("checked", true);
                      } else if ("${e.hr.marryStatus}" == "N") {
                        $("#marryNo").attr("checked", true);
                      }
                    });
                  </script>

                </div>
              </div>

              <div class="row mt">
                <label class="col-sm-2 col-sm-2 control-label">병역 여부</label>
                <div class="col-sm-5">

                  <input type="radio" name="hr.miliStatus" id="miliYes" value="Y"><label for="Yes">&nbsp;Y</label>
                  &emsp;&emsp;
                  <input type="radio" name="hr.miliStatus" id="miliNo" value="N"><label for="No">&nbsp;N</label>
                  &emsp;&emsp;
                  <script>
                    /* 상태 값에 따라 checked 옵션 설정 */
                    $(function () {
                      if ("${e.hr.miliStatus}" == "Y") {
                        $("#miliYes").attr("checked", true);
                      } else if ("${e.hr.miliStatus}" == "N") {
                        $("#miliNo").attr("checked", true);
                      }
                    });
                  </script>

                </div>
              </div>
              <div class="row mt">
                <label class="col-sm-2 col-sm-2 control-label">인사 평가</label>
                <div class="col-sm-5">
                  <input type="text" placeholder=" " name="hr.personnelEval" value="${ e.hr.personnelEval }" class="form-control">
                </div>
              </div>

              <div class="row mt">
                <label class="col-sm-2 col-sm-2 control-label">퇴사 사유</label>
                <div class="col-sm-5">
                  <input type="text" placeholder=" " name="hr.entCon" value="${ e.hr.entCon }" class="form-control">
                </div>
              </div>

              <div class="row mt">
                <div class="col-lg-offset-3 col-lg-5 col-sm-offset-5 col-sm-5 col-md-offset-5 col-md-5">
                  <button type="submit" class="btn btn-theme" id="submitBtn">회원 수정</button>
                </div>
              </div>

              <!-- 수정 form 끝 ★★★ -->
            </div>
          </div>
          <!-- col-lg-12-->
        </div>
      </form>
      <!-- /row -->
      <script type="text/javascript">
        let posNo = $('select[name="posNo"]').val();
        let depNo = $('select[name="depNo"]').val();
        console.log(posNo);
        console.log(depNo);
        $('#submitBtn').click(function () {
          if (posNo == null || posNo == 0) {
            alert('직위를 설정해 주세요');
            $('select[name="posNo"]').focus();
          } else if (depNo == null || depNo == 0) {
            alert('부서를 설정해 주세요');
            $('select[name="depNo"]').focus();
          }
        })
      </script>
    </section>
    <!-- /wrapper -->
  </section>
  <!-- /MAIN CONTENT -->
  <!--main content end-->
</section>
</body>

</html>