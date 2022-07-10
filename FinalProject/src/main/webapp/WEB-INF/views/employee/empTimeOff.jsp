<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내 연차 내역 </title>
<link rel="icon" type="image/png" href="resources/img/favicon.ico">
  <!-- Bootstrap core CSS -->
  <link href="lib/bootstrap/css/bootstrap.min.css" rel="stylesheet">

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
		   			<c:if test="${ list.timeoffType eq 'FE' }">
		   				<td>경조사</td>
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
		   			<c:if test="${ list.appStatus eq 'R' }">
		   				<td style="color:red;">반려</td>
		   			</c:if>
		   		</tr>
		   	</c:forEach>
		   	</c:if>
		   	<c:if test="${ empty timeOffList }">
		   		<tr>
		   			<td colspan="7">사용 연차 내역이 없습니다.</td>
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

</body>
</html>