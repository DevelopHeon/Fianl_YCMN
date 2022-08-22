<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>휴지통</title>
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
                    	휴지통
                  </h4>
              </header>
              <div class="panel-body minimal">
                <div class="table-inbox-wrap ">
                	<form id="trashMail" action="realDelete.do" method="post">
                	<!-- 휴지통에 메일이 없을 경우 -->
                	<c:if test="${empty trashMail}">
                	 <table class="table table-inbox table-hover centered">
                	 	<tr>
                	 		<td>휴지통에 메일이 없습니다.</td>
                	 	</tr>
                	 </table>
                	</c:if>
                	
                	<c:if test="${!empty trashMail}">
						<input type="checkbox" name="checkNo" value="1" class="btn btn-group" onclick="selectAll(this);">전체 선택</button>
						<button type="button" class="btn btn-group" id="deleteBtn" onclick="trashMail();"><i class="fa fa-trash-o"></i> 선택 삭제</button>
					</c:if>
					<a data-original-title="Refresh" data-placement="top" data-toggle="dropdown" onclick="location.reload();" class="btn mini tooltips">
                      <i class=" fa fa-refresh"></i>
                      </a>
                  <table class="table table-inbox table-hover">
                  	<c:forEach items="${trashMail }" var="t">
                    <tbody>
                      <tr class="">
                        <td class="inbox-small-cells">
                          <input type="checkbox" class="mail-checkbox" id="checkSendTrash" name="checkNo" value="${t.receiveNo }">
                        </td>
                        <c:if test="${t.empNo eq loginUser.empNo }"> <!-- 메일번호가 로그인유저번호랑 같으면 보낸이가 삭제한 것 -->
                        <!-- 수신,참조,비밀참조 -->
                        <c:if test="${ t.status eq 'T'}"> 
                        <td class="view-message"><span class="label label-primary">수신</span></td>
                        </c:if>
                        <c:if test="${ t.status eq 'R'}"> 
                        <td class="view-message"><span class="label label-success">참조</span></td>
                        </c:if>
                        <c:if test="${ t.status eq 'S'}"> 
                        <td class="view-message inbox-small-cells"><span class="label label-default">비밀참조</span></td>
                        </c:if>
                        <!-- 이름 -->
                        <td class="dont-show">${t.employee.empName}</td>
                        <!-- 메일제목 -->
                        <td class="view-message">${t.mail.mailTitle}</td>
                        <!-- 첨부파일 유무 -->
                        <c:if test="${!empty t.mail.fileName}"> 
                        <td class="view-message inbox-small-cells"><i class="fa fa-paperclip"></i></td>
                        </c:if>
                        <c:if test="${empty t.mail.fileName}"> 
                        <td></td>
                        </c:if>
                        <!-- 수신확인 -->
                        <c:if test="${ t.confirmMail eq 0}"> 
                        <td class="view-message">읽지 않음</td>
                        </c:if>
                        <td class="view-message text-right">${t.timestamp}</td>
                        </c:if>
                        
                        <c:if test="${t.empNo ne loginUser.empNo }"> <!-- 메일번호가 로그인유저번호랑 다르면 받은이가 삭제한 것 -->
                        <td class="dont-show">받은 메일</td>
                        <!-- 메일제목 -->
                        <td class="view-message">${t.mail.mailTitle}</td>
                        <!-- 첨부파일 유무 -->
                        <c:if test="${!empty t.mail.fileName}"> 
                        <td class="view-message inbox-small-cells"><i class="fa fa-paperclip"></i></td>
                        </c:if>
                        <c:if test="${empty t.mail.fileName}"> 
                        <td></td>
                        </c:if>
                        <!-- 수신확인 -->
                        <c:if test="${ t.confirmMail eq 0}"> 
                        <td class="view-message">읽지 않음</td>
                        </c:if>
                        <td class="view-message text-right">${t.timestamp}</td>
                        </c:if>
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
	

</script>

  </section>

</body>
</html>