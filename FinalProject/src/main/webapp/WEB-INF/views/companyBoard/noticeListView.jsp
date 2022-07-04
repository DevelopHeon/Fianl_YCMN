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
<script type="text/javascript" src="//code.jquery.com/jquery-1.11.0.min.js"></script>
	<jsp:include page="../common/menubar.jsp"/>
	<section id="main-content">
			<section class="wrapper">
			<h2 style="margin-left:45%; margin-bottom:7%;"><b>공지사항</b></h2>
 			<c:if test='${ empty list }'>
				<h4>조회된 공지사항이 없습니다.</h4>
			</c:if>
			<c:if test='${ loginUser.depName.equals("총무부서") }'>
				<a class="btn btn-primary" style="float:right;" href="enrollFormNotice.do">글쓰기</a>
			</c:if>
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
					      <th>
					      	<input type='hidden' class='number' value="${ notice.noticeNo }">
					      	${ notice.rowNum }
					      </th>
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
				<button id="moreView" style="color:#337ab7; border:1px solid #337ab7;" class="form-control btn btn-block col-sm-10 mx-auto">더 보기</button>
			</div>
		</section>
	</section>
</body>
<script>
	$(function(){
		var row = $('#noticeList tbody tr').length;
		
		console.log(row);
		if(row < 5 ){
			$("#moreView").hide();
		}
	});

	$("#moreView").click(function(){
		var rownum = $("#noticeList tbody tr").length; // 5개씩 페이징 처리
		var addMore = rownum + 5;
		
		var listHtml = ""; // 담아서 뿌려줄 변수 선언
		
		$.ajax({
			url:"selectNoticeList.do",
			type:"get",
			data:{rownum:addMore},
			success:function(list){
				if(list.length <= addMore){
					$("#moreView").hide(); // 5개 미만이라면 게시물이 더보기 버튼 삭제
				}
				
				$.each(list, function(i, obj){
					listHtml += "<tr><th><input type='hidden' class='number' value="+obj.noticeNo+">"
							 +  obj.rowNum + "</th>"
							 + "<td>"+obj.noticeTitle+"</td>"
							 + "<td>"+obj.noticeWriter+"</td>"
							 + "<td>"+obj.count+"</td>"
							 
							 if(obj.changeName != null){
							 	listHtml += "<td><i class='bi bi-star-fill' style='color:#ffd400;'></i></td>"
							 }else{
								 listHtml += "<td>&nbsp;</td>"
							 }
							 
							 listHtml += "<td>"+obj.createDate+"</td></tr>"
				});
				$("#noticeList tbody").html(listHtml);
			},error:function(){
				console.log("더보기 기능 실패");
			}
	
		});
	});
</script>
<script>
// 게시물 클릭시 상세조회 화면 전환 스크립트
// ajax 호출 후 클릭이 되지 않고 먹통이어서 바꿔줬다.. 이유는..?
$(function(){
	$(document).on("click","#noticeList tbody tr", function(){
		var noticeNo = $(this).children().eq(0).find('input').val();
		console.log(noticeNo);
		
		location.href = "detailNotice.do?noticeNo="+noticeNo;
	});
});
</script>
</html>