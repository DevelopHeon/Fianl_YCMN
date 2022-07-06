<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>

<head>
<meta charset="utf-8">
<title>직위/부서 관리</title>

<style>
  table,
  tr>th {
    text-align: center;
  }

  a {
    cursor: pointer;
  }
</style>
</head>

<body>
<jsp:include page="../common/menubar.jsp" />
<section id="main-content">
  <section class="wrapper" style="margin:0">
    <h3><i class="fa fa-angle-right"></i> 직위/부서 관리</h3>
    <div class="row mt">
      <div class="col-lg-12">
        <div class="content-panel">

          <section id="unseen">
            <h4><i class="fa fa-angle-right"></i> 직위 관리</h4>
            <div style="width:80%; text-align:right;">
              <a data-toggle="modal" data-target="#insertPosModal">직위 추가</a>&emsp;
              <a data-toggle="modal" data-target="#updatePosModal" id="posUpdate">직위 수정/삭제</a>
            </div>
            <table id="posListView" style="width:80%" class="table table-bordered table-striped table-condensed table-hover">
              <thead style="background-color:#5F7161;font-weight:bold;color:#FFFFFF;">
                <tr>
                  <th width="5%"></th>
                  <th width="35%">등급</th>
                  <th width="60%">직위</th>
                </tr>
              </thead>
              <tbody>
                <c:forEach items="${ posList }" var="pos">
                  <tr>
                    <td><input type="radio" name="posNo" value="${ pos.posNo }"></td>
                    <td id="posGrade" class="${ pos.posGrade }">${ pos.posGrade }</td>
                    <td id="posName" class="${ pos.posName }">${ pos.posName }</td>
                  </tr>
                </c:forEach>
              </tbody>
            </table>

            <!-- 부서 관리 시작 -->
            <br>
            <h4><i class="fa fa-angle-right"></i> 부서 관리</h4>
            <div style="width:80%; text-align:right;">
              <a data-toggle="modal" data-target="#insertDeptModal">부서 추가</a>&emsp;
              <a data-toggle="modal" data-target="#updateDeptModal" id="deptUpdate">부서 수정/삭제</a>
            </div>
            <table id="deptListView" style="width:80%" class="table table-bordered table-striped table-condensed table-hover">
              <thead style="background-color:#5F7161;font-weight:bold;color:#FFFFFF;">
                <tr>
                  <th style="width:5%;"></th>
                  <th style="width:95%;">부서</th>
                </tr>
              </thead>
              <tbody>
                <c:forEach items="${ depList }" var="dep">
                  <tr>
                    <td><input type="radio" name="depNo" value="${ dep.depNo }"></td>
                    <td>${ dep.depName }</td>
                  </tr>
                </c:forEach>
              </tbody>
            </table>
          </section>
        </div>
        <!-- /content-panel -->
      </div>
      <!-- /col-lg-4 -->
    </div><!-- /row mt -->
  </section>
  <!-- /wrapper -->
</section>
<!-- /MAIN CONTENT -->

<div class="modal fade" id="insertPosModal">
  <div class="modal-dialog modal-sm">
    <div class="modal-content">
      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title">직위 추가</h4>
        <button type="button" class="close" data-dismiss="modal">&times;</button>
      </div>
      <form action="insertPos.do" method="post">
        <!-- Modal Body -->
        <div class="modal-body">
          <label for="posGrade1" class="mr-sm-2">등급</label>
          <input type="number" class="form-control mb-2 mr-sm-2" placeholder="등급을 입력하세요." id="posGrade1" name="posGrade"> <br>
          <label for="posName1" class="mr-sm-2">추가할 직위 명</label>
          <input type="text" class="form-control mb-2 mr-sm-2" placeholder="직위 명을 입력하세요." id="posName1" name="posName">
        </div>
        <!-- Modal footer -->
        <div class="modal-footer">
          <button type="submit" id="jobAddBtn" class="btn btn-primary">추가</button>
          <button type="button" class="btn btn-danger" data-dismiss="modal">취소</button>
        </div>
      </form>
    </div>
  </div>
</div>
<script>
	$('#jobAddBtn').on('click', function(){
		
		if($('#posGrade1').val() == ""){	
			alert("직위 등급을 입력하세요.");
			$('#posGrade1').focus();
			return false;
		}else if($('#posName1').val() == ""){
			alert("직위 명을 입력하세요");
			$('#posName1').focus();
			return false;
		}
		return true;
	});
</script>

<div class="modal fade" id="updatePosModal">
  <div class="modal-dialog modal-sm">
    <div class="modal-content">
      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title">직위 수정</h4>
        <button type="button" class="close" data-dismiss="modal">&times;</button>
      </div>

      <form action="updatePos.do" method="post">
        <!-- Modal Body -->
        <div class="modal-body">
          <input type="hidden" class="form-control mb-2 mr-sm-2" id="posNo2" name="posNo" readonly>
          <label for="posGrade" class="mr-sm-2">등급</label>
          <input type="number" class="form-control mb-2 mr-sm-2" id="posGrade2" name="posGrade">
          <label for="posName" class="mr-sm-2">직위 명</label>
          <input type="text" class="form-control mb-2 mr-sm-2" id="posName2" name="posName">
        </div>

        <!-- Modal footer -->
        <div class="modal-footer">
          <button type="submit" value="update" name="updatePosBtn" class="btn btn-primary">수정</button>
          <button type="submit" value="delete" name="updatePosBtn" class="btn btn-danger">삭제</button>
        </div>
      </form>
    </div>
  </div>
</div>
<!-- 직위 모달 -->
<script>
  $('#posUpdate').on('click', function () {
    var posNo = $("input[name='posNo']:checked").val();

    if ($("input[name='posNo']:checked").length < 1) {
      alert('수정/삭제할 직위을 선택해주세요');
      return false;

    } else {
      $.ajax({
        url: "selectPos.do",
        data: { posNo: posNo },
        type: "get",
        dataType: "json",
        contentType: "application/json; charset=UTF-8",
        success: function (obj) {
          console.log(obj);

          $("#posNo2").val(obj.posNo); // 직위 번호
          $("#posGrade2").val(obj.posGrade); // 직위 등급
          $("#posName2").val(obj.posName); // 직위 이름
        },
        error: function () {
          console.log("실패");
          alert("error");
        }
      });
    }
  });
</script>

<div class="modal fade" id="insertDeptModal">
  <div class="modal-dialog modal-sm">
    <div class="modal-content">
      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title">부서 추가</h4>
        <button type="button" class="close" data-dismiss="modal">&times;</button>
      </div>

      <form action="insertDept.do" method="post">
        <!-- Modal Body -->
        <div class="modal-body">
          <label for="depName" class="mr-sm-2">추가할 부서 명</label>
          <input type="text" class="form-control mb-2 mr-sm-2" placeholder="부서 명을 입력하세요." id="depName" name="depName">
        </div>
        <!-- Modal footer -->
        <div class="modal-footer">
          <button type="submit" id="deptAddBtn" class="btn btn-primary">추가</button>
          <button type="button" class="btn btn-danger" data-dismiss="modal">취소</button>
        </div>
      </form>
    </div>
  </div>
</div>
<script>
	$('#deptAddBtn').click(function(){
		if($('#depName').val() == ""){
			alert("부서명을 입력하세요.");
			$('#depName').focus();
			return false;
		}
		return true;
	});
</script>

<!-- 부서 수정 -->
<div class="modal fade" id="updateDeptModal">
  <div class="modal-dialog modal-sm">
    <div class="modal-content">
      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title">부서 수정/삭제</h4>
        <button type="button" class="close" data-dismiss="modal">&times;</button>
      </div>

      <form action="updateDept.do" method="post">
        <!-- Modal Body -->
        <div class="modal-body">
          <input type="hidden" class="form-control mb-2 mr-sm-2" id="depNo2" name="depNo" readonly>
          <label for="depName" class="mr-sm-2">부서 명</label>
          <input type="text" class="form-control mb-2 mr-sm-2" placeholder="부서 명을 입력하세요." id="depName2" name="depName">
        </div>
        <!-- Modal footer -->
        <div class="modal-footer">
          <button type="submit" value="update" name="updateDepBtn" class="btn btn-primary">수정</button>
          <button type="submit" value="delete" name="updateDepBtn" class="btn btn-danger">삭제</button>
        </div>
      </form>
    </div>
  </div>
</div>
<script>
  $('#deptUpdate').on('click', function () {
    var depNo = $("input[name='depNo']:checked").val();

    if ($("input[name='depNo']:checked").length < 1) {
      alert('수정/삭제할 부서를 선택해주세요');
      return false;

    } else {
      $.ajax({
        url: "selectDep.do",
        data: { depNo: depNo },
        type: "get",
        dataType: "json",
        contentType: "application/json; charset=UTF-8",
        success: function (obj) {
          console.log(obj);

          $("#depNo2").val(obj.depNo); // 부서 번호
          $("#depName2").val(obj.depName); // 부서 이름
        },
        error: function () {
          console.log("실패");
          alert("error");
        }
      });
    }
  });
</script>
<!-- 부서 수정 끝 -->
<!--main content end-->
</body>

</html>