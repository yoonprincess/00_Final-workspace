<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 상세조회</title>
</head>
<body>
        
   <%@ include file="/WEB-INF/views/common/header.jsp" %>

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
                    		<c:when test="${ empty requestScope.n.originName }">
                    		    첨부파일이 없습니다.
                    		</c:when>
                    		<c:otherwise>
                    			<a href="${ pageContext.request.contextPath }/${ requestScope.n.changeName }" 
                    			   download="${ requestScope.n.originName }">
                    				${ requestScope.n.originName }
                    			</a>
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

			<c:if test="${ sessionScope.loginUser.memberId eq admin }">
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
	            		   value="${ requestScope.n.changeName }">
	            </form>
	            
            </c:if>
            
            <br><br>
        </div>
        <br><br>

    </div>
    
    <%@ include file="/WEB-INF/views/common/footer.jsp" %>
    
</body>
</html>
