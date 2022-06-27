<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>임직원 관리</title>

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
<style>
table, tr>th{text-align:center;}
</style>
</head>

<body>
	<jsp:include page="../common/menubar.jsp"/>
    <!-- **********************************************************************************************************************************************************
        MAIN CONTENT
        *********************************************************************************************************************************************************** -->
    <!--main content start-->
    <section id="main-content">
      <section class="wrapper">
        <h3><i class="fa fa-angle-right"></i> 인사 관리</h3>
        <div class="row mt">
          <div class="col-lg-12">
            <div class="content-panel">
              <h4><i class="fa fa-angle-right"></i> 임직원 관리</h4>
              <section id="unseen">
              <!-- 일괄 삭제를 위한 form -->
		        <!-- 사원 목록 엑셀 다운로드 -->
	          <form action="empExcelDown.do" method="get">
	            <button type="submit">목록 엑셀 다운로드</button>
	          </form>
        	<form>
        		<select name="find">
        			<option ${(param.find == "empNo")?"selected":""} value="empNo">사번</option>
        			<option ${(param.find == "empName")?"selected":""} value="empName">이름</option>
        			<option ${(param.find == "posName")?"selected":""} value="posName">직위</option>
        			<option ${(param.find == "depName")?"selected":""} value="depName">직무</option>
        			<option ${(param.find == "status")?"selected":""} value="status">상태</option>
        		</select>
        		<input type="text" name="keyword" value="${param.keyword}"/>
        		<input class="btn btn-search" type="submit" value="검색" />
        	</form>
        	
              <form action="list" method="post">
              	<input type="submit" class="btn-text btn-default" value="수정(임시)">
                <table id="empList" class="table table-bordered table-striped table-condensed">
	                <thead>
			          <tr>
			            <th style="width:3%;"><input type='checkbox' name='empNo' value='selectall' onclick='selectAll(this)'/></th>
			            <th>사번</th>
			            <th>이름</th>
			            <th>아이디(임시)</th>
			            <th>직위</th>
			            <th>직무</th>
			            <th>이메일</th>
			            <th>전화번호</th>
			            <th style="width:10%">사내 전화번호(임시)</th>
			            <th>상태</th>
			          </tr>
	                </thead>
 					<tbody>
						<c:forEach items="${ list }" var="e">
		                    <tr>
		                    	<td><input type="checkbox" name="empNo" value="${ e.empNo }"></td>
		                        <td>${ e.empNo }</td>
		                        <td id="empName" style="cursor: pointer;">${ e.empName }</td>
		                        <td>${ e.empId }</td>
		                        <td>${ e.posName }</td><!-- 직위 -->
		                        <td>${ e.depName }</td><!-- 직무 -->
		                        <td>${ e.empEmail }</td>
		                        <td>${ e.empPhone }</td>
		                        <td>${ e.officeTel }</td>
		                        <%-- <td><fmt:formatNumber value="${e.empPhone}" pattern=“###-####-####” /></td> --%>
		                        <td>${ e.status }</td>
		                    </tr>
	                    </c:forEach>
	                    <script>
	                    function selectAll(selectAll)  {
						  const checkboxes = document.getElementsByName('empNo');
						  
						  	checkboxes.forEach((checkbox) => {
						    checkbox.checked = selectAll.checked;
						  })
						}
	                    </script>
                	</tbody> 
                	<tfoot>
                	</tfoot>
                </table>
                </form>
                	<!-- 페이징 시작 -->
            <div id="pagingArea">
                <ul class="pagination">
                	<c:choose>
                		<c:when test="${ pi.currentPage ne 1 }">
                			<li class="page-item"><a class="page-link" href="listEmp.do?currentPage=${ pi.currentPage-1 }">Previous</a></li>
                		</c:when>
                		<c:otherwise>
                			<li class="page-item disabled"><a class="page-link" href="">Previous</a></li>
                		</c:otherwise>
                	</c:choose>
                	
                    <c:forEach begin="${ pi.startPage }" end="${ pi.endPage }" var="p">
                    	<c:choose>
	                		<c:when test="${ pi.currentPage ne p }">
                    			<li class="page-item"><a class="page-link" href="listEmp.do?currentPage=${ p }">${ p }</a></li>
	                		</c:when>
	                		<c:otherwise>
	                			<li class="page-item disabled"><a class="page-link" href="">${ p }</a></li>
	                		</c:otherwise>
	                	</c:choose>
                    </c:forEach>
                    
                    
                    <c:choose>
                		<c:when test="${ pi.currentPage ne pi.maxPage }">
                			<li class="page-item"><a class="page-link" href="listEmp.do?currentPage=${ pi.currentPage+1 }">Next</a></li>
                		</c:when>
                		<c:otherwise>
                			<li class="page-item disabled"><a class="page-link" href="listEmp.do?currentPage=${ pi.currentPage+1 }">Next</a></li>
                		</c:otherwise>
                	</c:choose>
                </ul>
            </div>
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
    <!--main content end-->
    <!--footer start-->

    <!--footer end-->
	<script>
		// update폼으로 이동. eno의 값을 받아가는 스크립트
		$(function(){
			$("#empList tbody tr #empName").click(function(){
				location.href="updateFormEmp.do?empNo=" + $(this).prev().text();
			});
		});
	</script>
	<!-- 엑셀 끝 -->
	
	<!-- js placed at the end of the document so the pages load faster -->
	<script src="lib/jquery/jquery.min.js"></script>
	<script src="lib/bootstrap/js/bootstrap.min.js"></script>
	<script class="include" type="text/javascript" src="lib/jquery.dcjqaccordion.2.7.js"></script>
	<script src="lib/jquery.scrollTo.min.js"></script>
	<script src="lib/jquery.nicescroll.js" type="text/javascript"></script>
	<!--common script for all pages-->
	<script src="lib/common-scripts.js"></script>
	<!--script for this page-->
</body>

</html>
