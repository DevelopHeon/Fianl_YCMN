<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
	.content-panel{
		margin-left: 50px;
	}
	#searchBtn{
		display: block;
	}
	.address{
		margin-left:30px;
	}
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
       <h2>${loginUser.empName }님의 연차 내역</h2>
       <h2>잔여 연차 : ${timeOff.remainNum }일 / ${timeOff.totalNum }일</h2>
		
	   <hr>
	   
	   <table class="table centered">
	   	<thead>
	   		<tr>
	   			<th>상신일</th>
	   			<th>종류</th>
	   			<th>사유</th>
	   			<th>현재 연차</th>
	   			<th>사용 연차</th>
	   			<th>잔여 연차</th>
	   			<th>상태</th>
	   		</tr>
	   	</thead>
	   	<tbody>
		   	<c:if test="${ !empty timeOffList }">
		   	<c:forEach items="${timeOffList }" var="list">
		   		<tr>
		   			<!-- 상신일 -->
		   			<td>${list.today }</td>
		   			<!-- 연차종류 -->
		   			<c:if test="${ list.timeoffType eq 'L' }">
		   			<td>연차</td>
		   			</c:if>
				   	<c:if test="${ list.timeoffType eq 'AH' }">
		   			<td>오전반차</td>
		   			</c:if>
		   			<c:if test="${ list.timeoffType eq 'PH' }">
		   			<td>오후반차</td>
		   			</c:if>
		   			<c:if test="${ empty list.timeoffType }">
		   			<td>미승인</td>
		   			</c:if>
		   			<!-- 연차사유 -->
		   			<td>${list.timeoffContent }</td>
		   			<td>${list.totalNum }일</td>
		   			<td>${list.useNum }일</td>
		   			<td>${list.remainNum }일</td>
		   			<!-- 연차승인여부 -->
		   			<c:if test="${ list.appStatus eq 'W' }">
		   			<td>미승인</td>
		   			</c:if>
		   			<c:if test="${ list.appStatus eq 'C' }">
		   			<td>승인</td>
		   			</c:if>
		   		</tr>
		   	</c:forEach>
		   	</c:if>
		   	<c:if test="${ empty timeOffList }">
		   		<tr>
		   			<td>사용 연차 내역이 없습니다.</td>
		   		</tr>
		   	</c:if>
	   	</tbody>
	   </table>         
        <br>
        
         <div id="pagingArea" class="centered">
                <ul class="pagination">
                	<c:choose>
                		<c:when test="${ pi.currentPage ne 1 }">
                			<li class="page-item"><a class="page-link" href="timeOff.do?currentPage=${ pi.currentPage-1 }">Previous</a></li>
                		</c:when>
                		<c:otherwise>
                			<li class="page-item disabled"><a class="page-link" href="">Previous</a></li>
                		</c:otherwise>
                	</c:choose>
                	
                    <c:forEach begin="${ pi.startPage }" end="${ pi.endPage }" var="p">
                    	<c:choose>
	                		<c:when test="${ pi.currentPage ne p }">
                    			<li class="page-item"><a class="page-link" href="timeOff.do?currentPage=${ p }">${ p }</a></li>
	                		</c:when>
	                		<c:otherwise>
	                			<li class="page-item disabled"><a class="page-link" href="">${ p }</a></li>
	                		</c:otherwise>
	                	</c:choose>
                    </c:forEach>
                    
                    
                    <c:choose>
                		<c:when test="${ pi.currentPage ne pi.maxPage }">
                			<li class="page-item"><a class="page-link" href="timeOff.do?currentPage=${ pi.currentPage+1 }">Next</a></li>
                		</c:when>
                		<c:otherwise>
                			<li class="page-item disabled"><a class="page-link" href="timeOff.do?currentPage=${ pi.currentPage+1 }">Next</a></li>
                		</c:otherwise>
                	</c:choose>
                </ul>
            </div>
           
            <br clear="both"><br>
      </section>
    </section>
    <!-- /MAIN CONTENT -->
    <!--main content end-->
    <script>
    	
	
    </script>
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
        <a href="basic_table.html#" class="go-top">
          <i class="fa fa-angle-up"></i>
          </a>
      </div>
    </footer>
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
</body>
</html>