<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>보낸메일함</title>
</head>

<body>
	<jsp:include page="../common/menubar.jsp"/>	
  <section id="container">
   
    <!-- **********************************************************************************************************************************************************
        MAIN CONTENT
        *********************************************************************************************************************************************************** -->
    <!--main content start-->
    <section id="main-content">
      <section class="wrapper">
        <!-- page start-->
        <div class="row mt">
          <div class="col-sm-12">
            <section class="panel">
              <header class="panel-heading wht-bg">
                <h4 class="gen-case">
                    	보낸메일함
                  </h4>
              </header>
              <div class="panel-body minimal">
                <div class="table-inbox-wrap ">
                	<form id="trashMail" action="deleteTrashSMail.do" method="post">
                	<!-- 보낸메일이 없을 경우 -->
                	<c:if test="${empty sendList}">
                	 <table class="table table-inbox table-hover centered">
                	 	<tr>
                	 		<td>보낸 메일이 없습니다.</td>
                	 	</tr>
                	 </table>
                	</c:if>
                	<c:if test="${!empty sendList}">
						<input type="checkbox" name="checkNo" value="1" class="btn btn-group" onclick="selectAll(this);">전체 선택</button>
						<button type="button" class="btn btn-group" id="deleteBtn" onclick="trashMail();"><i class="fa fa-trash-o"></i> 선택 삭제</button>
					</c:if>
					<a data-original-title="Refresh" data-placement="top" data-toggle="dropdown" onclick="location.reload();" class="btn mini tooltips">
                      <i class=" fa fa-refresh"></i>
                      </a>
                  <table id="sendMailList" class="table table-inbox table-hover">
                  	<c:forEach items="${sendList }" var="s">
                    <tbody>
                      <tr class="">
                        <td class="inbox-small-cells">
                          <div><input type="checkbox" class="mail-checkbox" id="checkSendTrash" name="checkNo" value="${s.receiveNo }">
                        </div></td>
                        <td style="display:none">${s.mailNo}</td>
                        <!-- 수신,참조,비밀참조 -->
                        <c:if test="${ s.status eq 'T'}"> 
                        <td class="view-message"><span class="label label-primary">수신</span></td>
                        </c:if>
                        <c:if test="${ s.status eq 'R'}"> 
                        <td class="view-message"><span class="label label-success">참조</span></td>
                        </c:if>
                        <c:if test="${ s.status eq 'S'}"> 
                        <td class="view-message inbox-small-cells"><span class="label label-default">비밀참조</span></td>
                        </c:if>
                        <!-- 이름 -->
                        <td class="dont-show">${s.employee.empName}</td>
                        <!-- 메일제목 -->
                        <td class="view-message">${s.mail.mailTitle}</td>
                        <!-- 첨부파일 유무 -->
                        <c:if test="${!empty s.mail.fileName}"> 
                        <td class="view-message inbox-small-cells"><i class="fa fa-paperclip"></i></td>
                        </c:if>
                        <c:if test="${empty s.mail.fileName}"> 
                        <td></td>
                        </c:if>
                        <!-- 수신확인 -->
                        <c:if test="${ s.confirmMail eq 0}"> 
                        <td class="view-message">읽지 않음</td>
                        </c:if>
                        <c:if test="${ s.confirmMail ne 0}"> 
                        <td class="view-message">읽음</td>
                        </c:if>
                        <td class="view-message text-right">${s.timestamp}</td>
                      </tr>                 
                    </tbody>
                  	</c:forEach>
                  </table>
                  </form>
                </div>
              </div>
            </section>
          </div>
        </div>
        
                 <div id="pagingArea" class="centered">
                <ul class="pagination">
                	<c:choose>
                		<c:when test="${ pi.currentPage ne 1 }">
                			<li class="page-item"><a class="page-link" href="sendMail.do?currentPage=${ pi.currentPage-1 }">Previous</a></li>
                		</c:when>
                		<c:otherwise>
                			<li class="page-item disabled"><a class="page-link" href="">Previous</a></li>
                		</c:otherwise>
                	</c:choose>
                	
                    <c:forEach begin="${ pi.startPage }" end="${ pi.endPage }" var="p">
                    	<c:choose>
	                		<c:when test="${ pi.currentPage ne p }">
                    			<li class="page-item"><a class="page-link" href="sendMail.do?currentPage=${ p }">${ p }</a></li>
	                		</c:when>
	                		<c:otherwise>
	                			<li class="page-item disabled"><a class="page-link" href="">${ p }</a></li>
	                		</c:otherwise>
	                	</c:choose>
                    </c:forEach>
                    
                    
                    <c:choose>
                		<c:when test="${ pi.currentPage ne pi.maxPage }">
                			<li class="page-item"><a class="page-link" href="sendMail.do?currentPage=${ pi.currentPage+1 }">Next</a></li>
                		</c:when>
                		<c:otherwise>
                			<li class="page-item disabled"><a class="page-link" href="sendMail.do?currentPage=${ pi.currentPage+1 }">Next</a></li>
                		</c:otherwise>
                	</c:choose>
                </ul>
            </div>
      </section>
      <!-- /wrapper -->
    </section>
    <script>
	function selectAll(selectAll){
		const checkNo = document.querySelectorAll('input[type="checkbox"]');
		
		checkNo.forEach((checkbox) => {
			checkbox.checked = selectAll.checked
		})
		
	}
	
	function trashMail(){
		if($('input[name=checkNo]:checked').length < 1){
			alert('삭제할 메일을 선택하세요.')
			return false;
		}
		if(confirm("선택한 메일을 삭제 하시겠습니까?")){
			alert("삭제 되었습니다");
			$("#trashMail").submit();
		}
	}
	
	//글제목을 클릭해서 메일보기
	$(function(){
		$("#sendMailList tbody tr td:not(:has(input))").click(function(){
			var mno = $(this).parent().children().eq(1).text();

			location.href="detailSendMail.do?mno="+mno;
		})
	})
	

</script>
    <!-- /MAIN CONTENT -->
    <!--main content end-->
    <!--                       
    <tr class="unread">
      <td class="inbox-small-cells">
        <input type="checkbox" class="mail-checkbox">
      </td>
      <td class="inbox-small-cells"><i class="fa fa-star"></i></td>
      <td class="view-message  dont-show"><a href="mail_view.html">Google Inc.</a></td>
      <td class="view-message "><a href="mail_view.html">Your new account is ready.</a></td>
      <td class="view-message  inbox-small-cells"><i class="fa fa-paperclip"></i></td>
      <td class="view-message  text-right">08:10 AM</td>
    </tr>
    <tr class="">
      <td class="inbox-small-cells">
        <input type="checkbox" class="mail-checkbox">
      </td>
      <td class="inbox-small-cells"><i class="fa fa-star inbox-started"></i></td>
      <td class="dont-show">Facebook</td>
      <td class="view-message">Paul published on your wall</td>
      <td class="view-message inbox-small-cells"><i class="fa fa-paperclip"></i></td>
      <td class="view-message text-right">February 14</td>
    </tr>   
    -->
  </section>
</body>
</html>