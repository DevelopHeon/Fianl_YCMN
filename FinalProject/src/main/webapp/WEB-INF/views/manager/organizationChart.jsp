<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>

<head>
<title>개발웍스 - 조직도</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.0/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" />
<script type="text/javascript" charset="utf8" src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-treeview/1.2.0/bootstrap-treeview.min.js"></script>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-treeview/1.2.0/bootstrap-treeview.min.css" />
<style>
    table,
    tr>th {
        text-align: center
    }
</style>
</head>

<body style="background:#eaeaea;">
<jsp:include page="../common/menubar.jsp" />

<section id="main-content">
    <section class="wrapper" style="margin:0">
        <h3><i class="fa fa-angle-right"></i> 조직도</h3>
        <div class="row mt">
            <div class="col-lg-3 col-md-4 col-sm-12">
                <div class="col-lg-12">
                    <div class="content-panel" style="height:780px">
                        <div class="container-fluid">
                            <div class="col-sm-10" style="color:#4ea4cd;">
                                <h3 onclick='selectDeptEmp(0)'><i class="fa fa-plus-square" data-toggle="collapse" href="#deptList" aria-expanded="false" aria-controls="collapseExample"></i>&nbsp;&nbsp;개발웍스 </h3>
                                <div id="deptList" class="collapse" style="margin-left:15%;"></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-lg-9 col-md-8 col-sm-12">
                <div class="col-lg-12">
                    <div class="content-panel" style="height:780px">
                        <div class="container-fluid">

                            <div id="approver">
                                <div class="table-head" style="width:100%;">
                                    <button type="button" onclick="searchEmpList()" style="float: right; margin:10px" class="btn btn-primary">검색</button>
                                    <input type="text" id="searchEmp" style="float: right; width:30%; margin:10px" class="form-control" placeholder="사원의 이름을 입력하세요." />
                                </div>

                                <table class="table table-bordered table-striped table-condensed table-hover" style="width:100%; margin-top:3%;">
                                    <thead style="background:lightgray;">
                                        <tr>
                                            <th width="10%">이름</th>
                                            <th width="10%">직위</th>
                                            <th width="10%">부서</th>
                                            <th width="5%">사번</th>
                                        </tr>
                                    </thead>
                                    <tbody id="empList">

                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                    <!-- /content-panel -->
                </div>
                <!-- /col-lg-4 -->
            </div>
        </div>
        <!-- /row mt -->
    </section>
    <!-- /wrapper -->
</section>
<!-- /MAIN CONTENT -->
</body>
<script>
// 접었을때 폈을때 아이콘 변경
// Collapse로 화면이 펼치기 전에 호출    
$('.collapse').on('show.bs.collapse', function () {
    // icon을 + 마크로 변경한다.      
    var target = $("[href='#" + $(this).prop("id") + "']");
    target.removeClass("fa-plus-square");
    target.addClass("fa-minus-square");
});
// Collapse로 화면이 펼친 후에 호출    
$('.collapse').on('shown.bs.collapse', function () {
    // icon을 + 마크로 변경한다.      
    var target = $("[href='#" + $(this).prop("id") + "']");
    target.removeClass("fa-plus-square");
    target.addClass("fa-minus-square");
});
// Collapse로 화면에 접기 전에 호출    
$('.collapse').on('hide.bs.collapse', function () {
    // icon을 - 마크로 변경한다.      
    var target = $("[href='#" + $(this).prop("id") + "']");
    target.removeClass("fa-minus-square");
    target.addClass("fa-plus-square");
});
// Collapse로 화면에 접고 난 후에 호출    
$('.collapse').on('hidden.bs.collapse', function () {
    // icon을 - 마크로 변경한다.      
    var target = $("[href='#" + $(this).prop("id") + "']");
    target.removeClass("fa-minus-square");
    target.addClass("fa-plus-square");
});
</script>
<script>
// 사원명 검색 조회
function searchEmpList() {
    if ($('#searchEmp').val() == "") {
        alert("사원명을 입력해주세요.");
        return false;
    }
    $.ajax({
        url: "searchAppEmp.do",
        type: "get",
        data: {
            empName: $("#searchEmp").val(),
            empNo: $("#appWriterNo").val()
        },
        success: function (list) {
            var value = "";
            if (list.length == 0) {
                alert("조회된 사원이 없습니다.");
            } else {
                $.each(list, function (i, obj) {
                    value += "<tr><input type='hidden' class='form-control' value=" + obj.empNo + " name='empNo'>"
                        + "<td>" + obj.empName + "</td>";

                    if (obj.posName == "undefined" || obj.posName == null) {
                        value += "<td>미정</td>"
                            + "<td>미정</td>";
                    } else {
                        value += "<td>" + obj.posName + "</td>"
                            + "<td>" + obj.depName + "</td>"
                    }
                    value += "<td>" + obj.empNo + "</td></tr>"
                });
            }
            $("#searchEmp").val('');
            $("#empList").html(value);

        }, error: function () {
            console.log("사원 검색 조회 실패");
        }
    });
}
</script>
<script>
// 부서별 사원 조회
function selectDeptEmp(depNo) {

    $.ajax({
        url: "selectDeptEmp.do",
        type: "get",
        data: {
            depNo: depNo,
            empNo: $("#appWriterNo").val()
        },
        success: function (list) {
            var deptEmp = "";
            $.each(list, function (i, obj) {
                deptEmp += "<input type='hidden' value=" + obj.empNo + " name='empNo'>"
                    + "<td>" + obj.empName + "</td>"

                if (obj.posName == "undefined" || obj.posName == null) {
                    deptEmp += "<td>미정</td>"
                        + "<td>미정</td>";
                } else {
                    deptEmp += "<td>" + obj.posName + "</td>"
                        + "<td>" + obj.depName + "</td>"
                }
                deptEmp += "<td>" + obj.empNo + "</td></tr>"
            });
            
            $("#empList").html(deptEmp);
        }, error: function () {
            console.log("부서별 사원 목록 조회 실패");
        }
    });
}
</script>
<script>
$(function(){
<<<<<<< HEAD
	selectApprover();
=======
   selectApprover();
>>>>>>> refs/heads/master
});
// 부서목록, 결재자 조회 ajax
function selectApprover() {
    $.ajax({
        url: "selectDept.do",
        type: "get",
        success: function (list) {
            var deptList = "";
            $.each(list, function (i, obj) {
                deptList += "<h4 onclick='selectDeptEmp(" + obj.depNo + ")'>" + obj.depName + "</h4>"
            });
            $("#deptList").html(deptList);
        }, error: function () {
            console.log("부서목록 조회 실패");
        }
    });
}
</script>

</html>