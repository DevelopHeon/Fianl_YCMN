<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>개발웍스- 회의실/비품 관리</title>

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
<jsp:include page="../common/menubar.jsp"/>
<!-- **********************************************************************************************************************************************************
MAIN CONTENT
*********************************************************************************************************************************************************** -->
<!--main content start-->

<section id="main-content">
    <section class="wrapper">
        <h3><i class="fa fa-angle-right"></i> 내 예약 관리</h3>
        <div class="row mt">
            <div class="col-lg-12">
                <div class="content-panel">
                    <h4><i class="fa fa-angle-right"></i> 내 예약 현황</h4>
                    <jsp:useBean id="date" class="java.util.Date" />
					<fmt:formatDate var="now" value="${date}" pattern="YYYY-MM-dd HH:mm:ss" />
                    <section id="unseen">
                        <table id="RezListView" class="table table-bordered table-striped table-condensed table-hover">
                            <thead style="background-color:#5F7161;font-weight:bold;color:#FFFFFF;">
                                <tr>
						           <th width="20%">예약 자산</th>
						           <th width="20%">예약 명</th>
						           <th width="30%">예약 시간</th>
						           <th width="10%">반납/취소</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${ myRezList }" var="rez">
                                    <fmt:parseDate var="rezTime" value="${rez.startTime}" pattern="YYYY-MM-dd HH:mm:ss" />
                                    <tr>
                                        <td id="rscName" class="${ rez.rscName }">${ rez.rscName }</td>
                                        <td id="rezTitle" class="${ rez.rezTitle }">${ rez.rezTitle }</td>
                                        <td id="rezTimee">${ rez.startTime } ~ ${ rez.endTime }</td>
                                        <td id="status" class="${ rez.status }">
                                        <form action="myRezManage.do" method="post"><!-- 반납/취소 -->
                                        	<input type="hidden" id="rezNo" name="rezNo" value="${ rez.rezNo }">
                                       	 <c:choose>
                                        	<c:when test="${ rez.status == 'Y' && now  > rez.startTime}">
                                        	<button type="submit" name="updateRezBtn" class="btn btn-success" value="N">반납</button></c:when>
                                        	
                                        	<c:when test="${ rez.status == 'Y' && now  < rez.startTime}">
                                        	<button type="submit" name="updateRezBtn" class="btn btn-danger" value="C">취소</button></c:when>
                                        	
                                        	<c:when test="${ rez.status == 'C' }">취소 완료</c:when>
                                        	<c:when test="${ rez.status == 'N' }">반납 완료</c:when>
                                        </c:choose>
									    </form>
                                        </td>
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
<!--main content end-->
</body>

</html>
