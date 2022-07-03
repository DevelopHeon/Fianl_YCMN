<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>임직원 관리</title>
  
<style>
table, tr>th{ text-align:center }
.table-head{ margin:10px }
#pagingArea{ margin-left: 40% }
</style>
</head>

<body>
	<jsp:include page="../common/menubar.jsp"/>
	
    <!--main content start-->
    <section id="main-content">
      <section class="wrapper">
        <h3><i class="fa fa-angle-right"></i> 인사 관리</h3>
        <div class="row mt">
          <div class="col-lg-12">
            <div class="content-panel">
              <h4><i class="fa fa-angle-right"></i> 임직원 관리</h4>
              <section id="unseen">

	          <div class="table-head" style="float: right">
              <!-- 검색을 위한 form -->
        	<form>
        		<select name="find" class="btn btn-theme01" style="border: 0.5px solid gray">
        			<option ${(param.find == "empNo")?"selected":""} value="empNo">사번</option>
        			<option ${(param.find == "empName")?"selected":""} value="empName">이름</option>
        			<option ${(param.find == "posName")?"selected":""} value="posName">직위</option>
        			<option ${(param.find == "depName")?"selected":""} value="depName">직무</option>
        		</select>
        		
        		<input type="text" name="keyword" value="${param.keyword}"/>
        		<input class="btn btn-search" type="submit" value="검색" />
        	</form>
        	</div>
        	
		        <!-- 사원 목록 엑셀 다운로드 -->
        	<div class="table-head" style="float: right">
	          <form action="empExcelDown.do" method="get">
	            <button type="submit" class="btn btn-theme01"><i class="fa fa-download"></i>&nbsp;&nbsp;목록 엑셀 다운로드</button>
	          </form>
	          </div>
              <form action="list" method="post">
                <table id="empList" class="table table-bordered table-striped table-condensed table-hover">
	                <thead >
			          <tr>
			            <th width="5%">사번</th>
			            <th width="10%">이름</th>
			            <th width="10%">아이디</th>
			            <th width="10%">직위</th>
			            <th width="10%">직무</th>
			            <th width="15%">이메일</th>
			            <th width="10%">전화번호</th>
			            <th width="5%">상태</th>
			          </tr>
	                </thead>
 					<tbody>
						<c:forEach items="${ list }" var="e">
		                    <tr>
		                        <td>${ e.empNo }</td>
		                        <td id="empName" style="cursor: pointer;">${ e.empName }</td>
		                        <td>${ e.empId }</td>
		                        <td>${ e.posName }</td><!-- 직위 -->
		                        <td>${ e.depName }</td><!-- 직무 -->
		                        <td>${ e.empEmail }</td>
		                        <td>${ e.empPhone }</td>
		                        <td>${ e.status }</td>
		                    </tr>
	                    </c:forEach>
                	</tbody> 
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
            <!-- 페이징 끝 -->
              </section>
            </div>
            <!-- /content-panel -->
          </div>
          <!-- /col-lg-4 -->
        </div>
        <!-- /row mt -->
      </section>
      <!-- /wrapper -->
    </section>
    <!-- /MAIN CONTENT -->
	<script>
		// update폼으로 이동. eno의 값을 받아가는 스크립트
		$(function(){
			$("#empList tbody tr #empName").click(function(){
				location.href="updateFormEmp.do?empNo=" + $(this).prev().text();
			});
		});
	</script>
	<!-- 엑셀 끝 -->
</body>

</html>
