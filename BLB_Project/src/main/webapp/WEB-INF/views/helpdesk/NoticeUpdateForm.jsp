<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 상세조회</title>	
	<link rel="stylesheet" href="../resources/css/helpdesk/NoticeDetailView.css"> <!-- 스타일 시트 링크 -->
</head>
<body class="body-offset">
<%@ include file="/WEB-INF/views/common/header.jsp" %>
    <div class="container-fluid">
    <div class="content">
        <br><br>
        <div class="innerOuter">
            <br>
            <a class="btn btn-secondary" style="float:right;" href="../list.no">목록으로</a>
            <br><br>
            <table id="contentArea" align="center" class="table">
                <tr>
                    <th width="100">제목</th>
                    <td colspan="3">${ requestScope.n.noticeTitle }</td>
                </tr>
                <tr>
                    <th>작성일</th>
                    <td>${ requestScope.n.noticeRegDate }</td>
                </tr>
                <tr>
                    <th>첨부파일</th>
                    <td colspan="3">
                    	<c:choose>
                    		<c:when test="${ empty requestScope.na }">
                    		    첨부파일이 없습니다.
                    		</c:when>
                    		<c:otherwise>
                    			<c:forEach var="a" items="${ requestScope.na }">
                    				<img src="${pageContext.request.contextPath }/${ a.savePath }${ a.saveFileName}" width="1200px;">
                    			</c:forEach>
                    		</c:otherwise>
                    	</c:choose>
                    </td>
                </tr>
                <tr>
                    <th>내용</th>
                    <td colspan="3"></td>
                </tr>
                <tr>
                    <td colspan="4">
                    	<p style="height:150px;">
                    		${ requestScope.n.noticeContent }
                    	</p>
                    </td>
                </tr>
            </table>
            <br>

			<c:if test="${ sessionScope.loginUser.memberId eq 'admin' }">
	            <div align="center">
	                <!-- 수정하기, 삭제하기 버튼은 이 글이 본인이 작성한 글일 경우에만 보여져야 함 -->
	                <a class="btn btn-primary" onclick="postFormSubmit(1);">
	                	수정하기
	                </a>
	                <a class="btn btn-danger" onclick="postFormSubmit(2);">
	                	삭제하기
	                </a>
	            </div>
	            
	            <form id="postForm" action="" method="post">
	            	<input type="hidden" 
	            		   name="nno" 
	            		   value="${ requestScope.n.noticeNo }">
	            	<input type="hidden"
	            		   name="filePath"
	            		   value="${ requestScope.a.saveFileName }">
	            		   
	            </form>
	            
	            <script>
	            function postFormSubmit(num) {
	                if (num === 1) { // 수정하기를 클릭했을 경우
	                    $("#postForm").attr("action", "../NoticeUpdateForm.no").submit();
	                } else { // 삭제하기를 클릭했을 경우
	                    if (confirm("삭제하시겠습니까?")) { // 사용자 확인
	                        $("#postForm").attr("action", "../NoticeDelete.no").submit();
	                        alert("공지사항이 삭제되었습니다.")
	                    } else {
	                        return "redirect://../NoticeUpdateForm.no";
	                    }
	                }
	            }
	            </script>
            </c:if>
            
            <br><br>
        </div>
        <br><br>

    </div>
    </div>
    <%@ include file="/WEB-INF/views/common/footer.jsp" %>
    
</body>
</html>
