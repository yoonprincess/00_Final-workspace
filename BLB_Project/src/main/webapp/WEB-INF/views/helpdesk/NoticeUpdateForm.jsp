<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="resources/css/helpdesk/NoticeUpdateForm.css"></script>
</head>
<body class="body-offset">
        
    <%@ include file="/WEB-INF/views/common/footer.jsp" %>

    <div class="content">
        <br><br>
        <div class="innerOuter">
            <h2>게시글 수정하기</h2>
            <br>

			<!-- 
				게시글 수정 요청 시
				http://localhost:8006/spring/update.bo
				로 요청
			-->
            <form id="NoticeUpdateForm" method="post" 
            					  action="NoticeUpdate.no" enctype="multipart/form-data">
                
                <!-- 게시글 번호도 같이 넘기기 -->
                <input type="hidden" name="noticeNo" value="${ requestScope.n.noticeNo }">
                
                <table align="center">
                    <tr>
                        <th><label for="title">제목</label></th>
                        <td><input type="text" id="title" class="form-control" value="${ requestScope.n.noticeTitle }" name="noticeTitle" required></td>
                    </tr>
                    <tr>
                        <th><label for="upfile">첨부파일</label></th>
                        <td>
                            <input type="file" id="upfile" class="form-control-file border" name="reupfile">
                            
                            <c:if test="${ not empty requestScope.n.originName }">
	                            현재 업로드된 파일 : 
	                            <a href="${ requestScope.n.changeName }" 
	                               download="${ requestScope.n.originName }">
	                            	${ requestScope.n.originName }
	                            </a>
	                            
	                            <!-- 
	                            	기존의 첨부파일이 있었을 경우 
	                            	: 기존 첨부파일에 대한 정보들 (originName, changeName) 보내기	
	                            -->
	                            <input type="hidden" name="originName" 
	                            					 value="${ requestScope.n.originName }">
	                            <input type="hidden" name="changeName"
	                            					 value="${ requestScope.n.changeName }">
                            </c:if>
                        </td>
                    </tr>
                    <tr>
                        <th><label for="content">내용</label></th>
                        <td><textarea id="content" class="form-control" rows="10" style="resize:none;" name="noticeContent" required>${ requestScope.n.noticeContent }</textarea></td>
                    </tr>
                </table>
                <br>

                <div align="center">
                    <button type="submit" class="btn btn-primary">수정하기</button>
                    <button type="button" class="btn btn-danger" onclick="javascript:history.go(-1);">이전으로</button>
                </div>
            </form>
        </div>
        <br><br>

    </div>
    
    <script src="resources/js/helpdesk/Notice.js"></script> <!-- JS 파일 경로 -->
    <%@ include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>




