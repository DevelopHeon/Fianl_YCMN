<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>

<head>
<meta charset="utf-8">
<title>회의실/비품 관리</title>

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
<!--main content start-->

<section id="main-content">
  <section class="wrapper" style="margin:0">
    <h3><i class="fa fa-angle-right"></i> 회의실/비품 관리</h3>
    <div class="row mt">
      <div class="col-lg-12">
        <div class="content-panel">

          <h4><i class="fa fa-angle-right"></i> 회의실 관리</h4>
          <section id="unseen">
            <div style="width:80%; text-align:right;">
              <a data-toggle="modal" data-target="#insertRoomModal">회의실 추가</a>&emsp;
              <a data-toggle="modal" data-target="#updateRoomModal" id="RoomUpdate">회의실 수정/삭제</a>
            </div>
            <table id="RoomListView" style="width:80%" class="table table-bordered table-striped table-condensed table-hover">
              <thead style="background-color:#5F7161;font-weight:bold;color:#FFFFFF;">
                <tr>
                  <th width="10%"></th>
                  <th width="20%">자원 명</th>
                  <th width="30%">자원 정보</th>
                  <th width="10%">자원 상태</th>
                </tr>
              </thead>
              <tbody>
              <c:if test="${ empty roomList }">
					<tr>
						<td colspan="4">추가된 자원이 없습니다.</td>
					</tr>
				</c:if>
                <c:forEach items="${ roomList }" var="Room">
                  <tr>
                    <td><input type="radio" name="rscNo1" value="${ Room.rscNo }"></td>
                    <td id="rscName" class="${ Room.rscName }">${ Room.rscName }</td>
                    <td id="rscEtc" class="${ Room.rscEtc }">${ Room.rscEtc }</td>
                    <td id="status" class="${ Room.status }">${ Room.status }</td>
                  </tr>
                </c:forEach>
              </tbody>
            </table>
          </section>

          <!-- 비품 관리 시작 -->
          <br><br><br>
          <h4><i class="fa fa-angle-right"></i> 비품 관리</h4>
          <section id="unseen">
            <div style="width:80%; text-align:right;">
              <a data-toggle="modal" data-target="#insertSupplyModal">비품 추가</a>&emsp;
              <a data-toggle="modal" data-target="#updateSupplyModal" id="SupplyUpdate">비품 수정/삭제</a>
            </div>
            <table id="SupplyListView" style="width:80%" class="table table-bordered table-striped table-condensed table-hover">
              <thead style="background-color:#5F7161;font-weight:bold;color:#FFFFFF;">
                <tr>
                  <th width="10%"></th>
                  <th width="20%">자원 명</th>
                  <th width="30%">자원 정보</th>
                  <th width="10%">자원 상태</th>
                </tr>
              </thead>
              <tbody>
                <c:if test="${ empty supplyList }">
					<tr>
						<td colspan="4">추가된 자원이 없습니다.</td>
					</tr>
				</c:if>
                <c:forEach items="${ supplyList }" var="supply">
                  <tr>
                    <td><input type="radio" name="rscNo2" value="${ supply.rscNo }"></td>
                    <td id="rscName" class="${ supply.rscName }">${ supply.rscName }</td>
                    <td id="rscEtc" class="${ supply.rscEtc }">${ supply.rscEtc }</td>
                    <td id="status" class="${ supply.status }">${ supply.status }</td>
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

<!-- 회의실 모달 -->
<div class="modal fade" id="insertRoomModal">
  <div class="modal-dialog modal-sm">
    <div class="modal-content">
      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title">회의실 추가</h4>
        <button type="button" class="close" data-dismiss="modal">&times;</button>
      </div>
      <form action="insertRsc.do" method="Post">
        <!-- Modal Body -->
        <div class="modal-body">
          <input type="hidden" id="rcNo" name="rcNo" value="1">
          <label for="rscName" class="mr-sm-2">회의실 명</label>
          <input type="text" class="form-control mb-2 mr-sm-2" placeholder="회의실 명을 입력하세요. (예시-A동 123호실)" id="rscName" name="rscName"
          pattern=".{1,15}" title="회의실 명은 필수 입력값입니다. 15자 이내로 작성해주세요." required><br>
          <label for="rscEtc" class="mr-sm-2">회의실 정보</label>
          <input type="text" class="form-control mb-2 mr-sm-2" placeholder="회의실 정보를 입력하세요." id="rscEtc" name="rscEtc"
          pattern=".{1,15}" title="15자 이내로 작성해주세요.">
        </div>
        <!-- Modal footer -->
        <div class="modal-footer">
          <button type="submit" class="btn btn-primary">추가</button>
          <button type="button" class="btn btn-danger" data-dismiss="modal">취소</button>
        </div>
      </form>
    </div>
  </div>
</div>

<div class="modal fade" id="updateRoomModal">
  <div class="modal-dialog modal-sm">
    <div class="modal-content">
      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title">회의실 수정/삭제</h4>
        <button type="button" class="close" data-dismiss="modal">&times;</button>
      </div>
      <form action="updateRsc.do" method="Post">
        <!-- Modal Body -->
        <div class="modal-body">
          <input type="hidden" class="form-control mb-2 mr-sm-2" id="rscNo1" name="rscNo" readonly>
          <label for="rscName" class="mr-sm-2">회의실 명</label>
          <input type="text" class="form-control mb-2 mr-sm-2" id="rscName1" name="rscName" 
          pattern=".{1,15}" title="회의 명은 필수 입력값입니다. 15자 이내로 작성해주세요." required><br>
          <label for="rscEtc" class="mr-sm-2">회의실 정보</label>
          <input type="text" class="form-control mb-2 mr-sm-2" id="rscEtc1" name="rscEtc"
          pattern=".{1,15}" title="15자 이내로 작성해주세요."><br>
          <label for="status" class="mr-sm-2">회의실 상태</label><br>
          <select id="status1" name="status" class="form-control mb-2 mr-sm-2">
            <option value="Y" <c:if test="${status eq 'Y'}">selected</c:if> >사용 가능</option>
            <option value="S" <c:if test="${status eq 'S'}">selected</c:if> >사용 중지</option>
          </select>
        </div>
        <!-- Modal footer -->
        <div class="modal-footer">
          <button type="submit" value="update" name="updateRscBtn" class="btn btn-primary">수정</button>
          <button type="submit" value="delete" name="updateRscBtn" class="btn btn-danger">삭제</button>
        </div>
      </form>
    </div>
  </div>
</div>

<script>
  $('#RoomUpdate').on('click', function () {
    var rscNo = $("input[name='rscNo1']:checked").val();

    if ($("input[name='rscNo1']:checked").length < 1) {
      alert('수정/삭제할 자원을 선택해주세요');
      return false;

    } else {
      $.ajax({
        url: "selectRsc.do",
        data: { rscNo: rscNo },
        type: "get",
        dataType: "json",
        contentType: "application/json; charset=UTF-8",
        success: function (obj) {
          console.log(obj);

          $("#rscNo1").val(obj.rscNo); // 회의실 번호
          $("#rscName1").val(obj.rscName); // 회의실 명
          $("#rscEtc1").val(obj.rscEtc); // 회의실 정보
          $("#status1").val(obj.status); // 회의실 상태
        },
        error: function () {
          console.log("실패");
          alert("error");
        }
      });
    }
  });
</script>
<!-- 비품 모달 -->
<div class="modal fade" id="insertSupplyModal">
  <div class="modal-dialog modal-sm">
    <div class="modal-content">
      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title">비품 추가</h4>
        <button type="button" class="close" data-dismiss="modal">&times;</button>
      </div>
      <form action="insertRsc.do" method="Post">
        <!-- Modal Body -->
        <div class="modal-body">
          <input type="hidden" id="rcNo" name="rcNo" value="2">
          <label for="rscName" class="mr-sm-2">비품 명</label>
          <input type="text" class="form-control mb-2 mr-sm-2" placeholder="비품 명을 입력하세요." id="rscName" name="rscName" 
          pattern=".{1,15}" title="비품 명은 필수 입력값입니다. 15자 이내로 작성해주세요." required><br>
          <label for="rscEtc" class="mr-sm-2">비품 정보</label>
          <input type="text" class="form-control mb-2 mr-sm-2" placeholder="비품 정보를 입력하세요." id="rscEtc" name="rscEtc"
          pattern=".{1,15}" title="15자 이내로 작성해주세요.">
        </div>
        <!-- Modal footer -->
        <div class="modal-footer">
          <button type="submit" class="btn btn-primary">추가</button>
          <button type="button" class="btn btn-danger" data-dismiss="modal">취소</button>
        </div>
      </form>
    </div>
  </div>
</div>

<div class="modal fade" id="updateSupplyModal">
  <div class="modal-dialog modal-sm">
    <div class="modal-content">
      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title">비품 수정/삭제</h4>
        <button type="button" class="close" data-dismiss="modal">&times;</button>
      </div>
      <form action="updateRsc.do" method="Post">
        <!-- Modal Body -->
        <div class="modal-body">
          <input type="hidden" class="form-control mb-2 mr-sm-2" id="rscNo2" name="rscNo" readonly>
          <label for="rscName" class="mr-sm-2">비품 명</label>
          <input type="text" class="form-control mb-2 mr-sm-2" id="rscName2" name="rscName" 
          pattern=".{1,15}" title="비품 명은 필수 입력값입니다. 15자 이내로 작성해주세요." required><br>
          <label for="rscEtc" class="mr-sm-2">비품 정보</label>
          <input type="text" class="form-control mb-2 mr-sm-2" id="rscEtc2" name="rscEtc"
          pattern=".{1,15}" title="15자 이내로 작성해주세요."><br>
          <label for="status" class="mr-sm-2">비품 상태</label><br>
          <select id="status2" name="status" class="form-control mb-2 mr-sm-2">
            <option value="Y" <c:if test="${status eq 'Y'}">selected</c:if> >사용 가능</option>
            <option value="S" <c:if test="${status eq 'S'}">selected</c:if> >사용 중지</option>
          </select>
        </div>
        <!-- Modal footer -->
        <div class="modal-footer">
          <button type="submit" value="update" name="updateRscBtn" class="btn btn-primary">수정</button>
          <button type="submit" value="delete" name="updateRscBtn" class="btn btn-danger">삭제</button>
        </div>
      </form>
    </div>
  </div>
</div>
<!-- 비품 모달 -->
<script>
  $('#SupplyUpdate').on('click', function () {
    var rscNo = $("input[name='rscNo2']:checked").val();

    if ($("input[name='rscNo2']:checked").length < 1) {
      alert('수정/삭제할 자원을 선택해주세요');
      return false;

    } else {
      $.ajax({
        url: "selectRsc.do",
        data: { rscNo: rscNo },
        type: "get",
        dataType: "json",
        contentType: "application/json; charset=UTF-8",
        success: function (obj) {
          console.log(obj);

          $("#rscNo2").val(obj.rscNo); // 자원 번호
          $("#rscName2").val(obj.rscName); // 비품 명
          $("#rscEtc2").val(obj.rscEtc); // 비품 정보
          $("#status2").val(obj.status); // 비품 상태
        },
        error: function () {
          console.log("실패");
          alert("error");
        }
      });
    }
  });
</script>
<!-- 비품 수정 끝 -->

<!--main content end-->
</body>

</html>