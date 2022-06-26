<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<jsp:include page="../common/menubar.jsp"/>
	<section id="main-content">
			<section class="wrapper">
			<h2 style="margin-left:45%; margin-bottom:7%;"><b>공지사항</b></h2>
			<c:if test='${ empty list }'>
				<h4>조회된 공지사항이 없습니다.</h4>
			</c:if>
			<!-- 테스트 다 하고 나면 직급이나 관리자만 보이게 변경 -->
			<a class="btn btn-primary" style="float:right;" href="enrollFormNotice.do">글쓰기</a>
			<div class="noticeList">
				<table class="table table-hover" id="noticeList" style="text-align:center;">
				  <thead>
				    <tr>
				      <th scope="col">번호</th>
				      <th scope="col" style="width:50%;">제목</th>
				      <th scope="col">작성자</th>
				      <th scope="col">조회수</th>
				      <th scope="col" style="width:5%;">첨부파일</th>
				      <th scope="col">작성일</th>
				    </tr>
				  </thead>
				  <tbody class="table-group-divider">
				  <c:forEach items="${ list }" var="notice">
					    <tr>
					      <th>${ notice.rownum }</th>
					      <td>${ notice.noticeTitle }</td>
					      <td>${ notice.noticeWriter }</td>
					      <td>${ notice.count }</td>
					      <td>
					      	<c:choose>
					      		<c:when test='${ !empty notice.changeName }'>
									<i class="bi bi-star-fill" style="color:#ffd400;"></i>
								</c:when>
								<c:otherwise>
									&nbsp;	
								</c:otherwise>
							</c:choose>
					      </td>
					      <td>${ notice.createDate }</td>
					    </tr>
				    </c:forEach>
				  </tbody>
				</table>
			</div>
		</section>
	</section>
</body>
</html>