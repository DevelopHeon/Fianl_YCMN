<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>

<head>
<meta charset="utf-8">
<title>직위/직무 관리</title>

<!-- Favicons -->
<link href="img/favicon.png" rel="icon">
<link href="img/apple-touch-icon.png" rel="apple-touch-icon">
<!-- Bootstrap core CSS -->
<link href="lib/bootstrap/css/bootstrap.min.css" rel="stylesheet">
<!--external css-->
<link href="lib/font-awesome/css/font-awesome.css" rel="stylesheet" />
<link href="lib/bootstrap-wysihtml5/bootstrap-wysihtml5.css" rel="stylesheet" />
<!-- Custom styles for this template -->
<link href="css/style.css" rel="stylesheet">
<link href="css/style-responsive.css" rel="stylesheet">
<!-- jquery -->
<script type="text/javascript" src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript"
    src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<style>
    table,
    tr>th {
        text-align: center;
    }

    a {
        cursor: pointer;
    }
</style>


<script type="text/javascript">
// 직위 정보 불러오기

    /* $(function () {
        $("#버튼아이디").click(function () {
            var posNo = $("#값받아올버튼아이디").val();
            $.ajax({
                url: "selectPos.do",
                data: { posNo: posNo },
                type: "get",
                dataType: "json",
                success: function (obj) {
                    console.log(obj);

                    $("#번호넣어줄 응답박스1").val(obj.posNo); // 직위 번호
                    $("#등급넣어줄 응답박스2").val(obj.posGrade); // 직위 등급
                    $("#이름넣어줄 응답박스3").val(obj.posName); // 직위 이름
                },
                error: function () {
                    console.log("ajax 통신 실패");
                }
            })
        })
    }) */


    /* function updatePos(posNo) {
        var check = $('#posNo');
        if($(':radio[name="posNo"]:checked').length < 1){
            alert('직위를 선택해주세요');                        
            check.focus();
            event.preventDefault();
        }else{
        $.ajax({
            url:"selectPos.do",
            type:"get",
            data: {posNo:posNo},
            dataType:"JSON",
            success:function(json){
                console.log(json)
                
                var html = "";
                
                html += "<label for="posGrade" class="mr-sm-2">직위 번호</label>";
                html += "<input type="text" class="form-control mb-2 mr-sm-2" id="posNo" name="posNo" value="json.posGrade">";
                html += "<label for="posGrade" class="mr-sm-2">등급</label>";
                html += "<input type="number" class="form-control mb-2 mr-sm-2" placeholder="등급을 입력하세요." id="posGrade" name="posGrade" value="json.posGrade">";
                html += "<label for="posName" class="mr-sm-2">직위 명</label>";
                html += "<input type="text" class="form-control mb-2 mr-sm-2" placeholder="직위 명을 입력하세요." id="posName" name="posName" value="json.posGrade" >";
                
                $("#updatePosModal .modal-body").html(html);
            },
            error: function(request, status, error){
                alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
            }
        });
    }} */

</script>
</head>

<body>
<jsp:include page="../main.jsp" />
<!-- **********************************************************************************************************************************************************
MAIN CONTENT
*********************************************************************************************************************************************************** -->
<!--main content start-->

<section id="main-content">
    <section class="wrapper">
        <h3><i class="fa fa-angle-right"></i> 직위/부서 관리</h3>
        <div class="row mt">
            <div class="col-lg-12">
                <div class="content-panel">

                    <h4><i class="fa fa-angle-right"></i> 직위 관리</h4>
                    <a data-toggle="modal" data-target="#insertPosModal">직위 추가</a>
                    <a data-toggle="modal" data-target="#updatePosModal" id="posUpdate">직위 수정/삭제</a>
                    <section id="unseen">
                        <table border="1" id="posListView">
                            <thead style="background-color:#5F7161;font-weight:bold;color:#FFFFFF;">
                                <tr>
                                    <th style="width:30px;"></th>
                                    <th style="width:70px;">등급</th>
                                    <th style="width:330px;">직위</th>
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
                    </section>


                    <div class="modal fade" id="insertPosModal">
                        <div class="modal-dialog modal-sm">
                            <div class="modal-content">
                                <!-- Modal Header -->
                                <div class="modal-header">
                                    <h4 class="modal-title">직위 추가</h4>
                                    <button type="button" class="close"
                                        data-dismiss="modal">&times;</button>
                                </div>
                                <form action="insertPos.do" method="post">
                                    <!-- Modal Body -->
                                    <div class="modal-body">
                                        <label for="posGrade" class="mr-sm-2">등급</label>
                                        <input type="number" class="form-control mb-2 mr-sm-2" placeholder="등급을 입력하세요." id="posGrade" name="posGrade"> <br>
                                        <label for="posName" class="mr-sm-2">추가할 직위 명</label>
                                        <input type="text" class="form-control mb-2 mr-sm-2" placeholder="직위 명을 입력하세요." id="posName" name="posName">
                                    </div>
                                    <!-- Modal footer -->
                                    <div class="modal-footer">
                                        <button type="submit" class="btn btn-primary">추가</button>
                                        <button type="button" class="btn btn-danger"
                                            data-dismiss="modal">취소</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>


                    <div class="modal fade" id="updatePosModal">
                        <div class="modal-dialog modal-sm">
                            <div class="modal-content">
                                <!-- Modal Header -->
                                <div class="modal-header">
                                    <h4 class="modal-title">직위 수정</h4>
                                    <button type="button" class="close"
                                        data-dismiss="modal">&times;</button>
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
                    
                    
                    
                    <!-- 부서 관리 시작 -->
                    <br><br><br>
                    <h4><i class="fa fa-angle-right"></i> 부서 관리</h4>
                    <a data-toggle="modal" data-target="#insertDeptModal">부서 추가</a>
                    <a data-toggle="modal" data-target="#updateDeptModal" id="deptUpdate">부서 수정/삭제</a>
                    <section id="unseen">
                        <table border="1" id="deptListView">
                            <thead style="background-color:#5F7161;font-weight:bold;color:#FFFFFF;">
                                <tr>
                                    <th style="width:30px;"></th>
                                    <th style="width:400px;">부서</th>
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
                                        <button type="submit" class="btn btn-primary">추가</button>
                                        <button type="button" class="btn btn-danger" data-dismiss="modal">취소</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>


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
                                    data: { depNo : depNo },
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

                </div>
                <!-- /content-panel -->
            </div>
            <!-- /col-lg-4 -->
        </div><!-- /row mt -->
    </section>
    <!-- /wrapper -->
</section>
<!-- /MAIN CONTENT -->
<!--main content end-->


<!-- js placed at the end of the document so the pages load faster -->
<script src="lib/jquery/jquery.min.js"></script>
<script src="lib/bootstrap/js/bootstrap.min.js"></script>
<script class="include" type="text/javascript" src="lib/jquery.dcjqaccordion.2.7.js"></script>
<script src="lib/jquery.scrollTo.min.js"></script>
<script src="lib/jquery.nicescroll.js" type="text/javascript"></script>
<!--common script for all pages-->
<script src="lib/common-scripts.js"></script>
<!--script for this page-->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
</body>

</html>