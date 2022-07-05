<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>익명 게시판</title>
<style>
	table tr{
		height:10px;
	}
</style>
</head>
<body>
<jsp:include page="../common/menubar.jsp"/>
	<section id="main-content">
		<section class="wrapper">
			<h2 style="margin-left:45%; margin-bottom:7%;"><b>익명 게시판</b></h2>
 			<c:if test='${ empty list }'>
				<h4>조회된 게시글이 없습니다.</h4>
			</c:if>
			<div class="anonymList">
				<div class="searchBar form-inline">
					<input type="text" id="searchVal" style="margin-left:80%;width:15%;"  class="form-control" placeholder="Search">
					<button type="button" id="search" style="background-color:#22242a; color:white;" class="btn">검색</button>
				</div>	
				<table class="table table-hover" id="anonymList" style="text-align:center;">
				  <thead>
				    <tr>
				      <th scope="col">번호</th>
				      <th scope="col" style="width:50%;">제목</th>
				      <th scope="col">조회수</th>
				      <th scope="col">작성일</th>
				    </tr>
				  </thead>
				  <tbody class="table-group-divider">
					<c:forEach items="${ list }" var="anonym">
					    <tr>
					      <th>
					      	<input type='hidden' class='number' value="${ anonym.anoNo }">
					      	${ anonym.rowNum }
					      </th>
					      <td>${ anonym.anoTitle }&nbsp;<c:if test="${anonym.replyCnt != 0}">[<span style="color:#2c86dc;"><c:out value="${anonym.replyCnt }"/></span>]</c:if></td>
					      <td>${ anonym.count }</td>
					      <td>${ anonym.createDate }</td>
					    </tr>
				    </c:forEach>					  
				  </tbody>
				</table>
				<br>
				<input type='hidden' id="confirmUser" value="${ loginUser.empId }">
				<a class="btn btn-primary" style="float:right;" href="enrollFormAnonymBoard.do">글쓰기</a>
				<br clear="both">
				<div id="paginArea" style="margin-left:40%;">
					<ul class="pagination justify-content-center">
						<c:choose>
							<c:when test="${ pi.currentPage ne 1 }">
								<li class="page-item"><a class="page-link" href="anoBoardList.do?currentPage=${ pi.currentPage-1 }">Previous</a></li>
							</c:when>
							<c:otherwise>
								<li class="page-item disabled"><a class="page-link" href="#">Previous</a></li>
							</c:otherwise>
						</c:choose>
						
						<c:forEach begin="${ pi.startPage }" end="${ pi.endPage }" var="p">
							<c:choose>
								<c:when test="${ pi.currentPage ne p }">
									<li class="page-item"><a class="page-link" href="anoBoardList.do?currentPage=${ p }">${ p }</a></li>
								</c:when>
								<c:otherwise>
									<li class="page-item disabled"><a class="page-link" href="">${ p }</a></li>
								</c:otherwise>
							</c:choose>
						</c:forEach>
						
						<c:choose>
							<c:when test="${ pi.currentPage ne pi.maxPage }">
								<li class="page-item"><a class="page-link" href="anoBoardList.do?currentPage=${ pi.currentPage+1 }">Next</a></li>
							</c:when>
							<c:otherwise>
								<li class="page-item disabled"><a class="page-link" href="#">Next</a></li>
							</c:otherwise>
						</c:choose>
					</ul>
				</div>
			</div>
		</section>
	</section>
</body>
<script>
// 게시물 클릭시 상세조회 화면 전환 스크립트
$(function(){
	$(document).on("click","#anonymList tbody tr", function(){
		var anoNo = $(this).children().eq(0).find('input').val();
		var confirmUser = $("#confirmUser").val();
		console.log(confirmUser);
		console.log(anoNo);
		
		location.href = "detailAnonymBoard.do?anoNo="+anoNo+"&confirmUser="+confirmUser;
	});
});
</script>
<script>
	$("#search").click(function(){
		var searchVal = $("#searchVal").val();
		
		location.href = "searchAnoBoard.do?search=" + searchVal;
	});
</script>
</html>