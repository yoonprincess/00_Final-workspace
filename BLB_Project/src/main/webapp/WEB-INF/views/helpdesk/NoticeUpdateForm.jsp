<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>공지사항 수정</title>
    <link rel="stylesheet" href="resources/css/helpdesk/NoticeUpdateForm.css"> <!-- 스타일 시트 링크 -->
</head>
<body class="body-offset">
<%@ include file="/WEB-INF/views/common/header.jsp" %>
	<div class="container-fluied">
    <div class="container">
        <h2 class="page-title">공지사항</h2>
        
        <form class="edit-form" id="noticeUpdate" name="noticeUpdate" action="NoticeUpdate.no" method="post">
            <div class="form-group">
                <label for="title">제목</label>
                <input type="text" id="title" name="title" class="input-field" value="${ requestScope.n.noticeTitle }">
            </div>

            <div class="form-group">
                <label for="content">내용</label>
                <textarea id="content" name="content" class="input-field textarea">${requestScope.n.noticeContent }</textarea>
            </div>

            <div class="form-group">
                <label>첨부파일</label>
                <div class="file-upload-container">
                    <div class="file-preview-grid">
                        <div class="file-preview">
                            <c:choose>
                   		<c:when test="${ empty requestScope.na }">
                   		    첨부파일이 없습니다.
                   		</c:when>
                   		<c:otherwise>
                   			<c:forEach var="a" items="${ requestScope.na }">
                   				<img src="${pageContext.request.contextPath }/${ a.savePath }${a.saveFileName}" width="400px;" heigh="400px;">
                   				<button type="button" class="delete-btn" data-index="a">×</button>
                   			</c:forEach>
                   		</c:otherwise>
                   	</c:choose>
                            
                        </div>
                        <div class="file-upload-box">
                            <input type="file" id="upfile" name="upfile" accept="image/*" class="file-input">
                            <span class="upload-icon">+</span>
                        </div>
                    </div>
                    <p class="file-info">이미지는 최대 5개까지 업로드 가능합니다.</p>
                </div>
            </div>

            <div class="button-group">
                <button type="submit" class="btn btn-primary">수정하기</button>
                <button type="button" class="btn btn-danger">삭제하기</button>
            </div>
        </form>
    </div>
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>





