<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>공지사항 등록</title>
    <link rel="stylesheet" href="${ pageContext.request.contextPath }/resources/css/helpdesk/NoticeEnrollForm.css"> <!-- 스타일 시트 링크 -->

</head>
<body class="body-offset">
<%@ include file="/WEB-INF/views/common/header.jsp" %>
    <div class="container-fluid">
    <div class="container">
        <form id="NoticeEnrollForm" method="post" action="insert.no" enctype="multipart/form-data">
            <div class="form-group">
                <label for="title">제목</label>
                <input type="text" id="title" name="noticeTitle" placeholder="공지사항 제목을 입력하세요">
            </div>

            <div class="form-group">
                <label for="content">내용</label>
                <textarea id="content" name="noticeContent" placeholder="공지사항 내용을 입력하세요"></textarea>
            </div>

            <div class="form-group">
			    <label for="files">첨부파일</label>
			    <div class="file-upload-container">
			        <input type="file" id="upfile1" name="upfile" class="file-upload">
			        <input type="file" id="upfile2" name="upfile" class="file-upload">
			        <input type="file" id="upfile3" name="upfile" class="file-upload">
			        <input type="file" id="upfile4" name="upfile" class="file-upload">
			        <input type="file" id="upfile5" name="upfile" class="file-upload">
			    </div>
			    <div class="file-list" id="fileList"></div>
			    <p class="file-info">최대 5개의 파일을 첨부할 수 있습니다.</p>
			</div>

            <div class="button-group">
                <button type="button" class="btn btn-list" onclick="goList();">목록</button>
                <button type="submit" class="btn btn-submit">등록</button>
            </div>
        </form>
    </div>
	</div>
	<script src="${ pageContext.request.contextPath }/resources/js/helpdesk/Notice.js"></script> <!-- JS 파일 경로 -->
    <%@ include file="/WEB-INF/views/common/footer.jsp" %>

</body>
</html>
