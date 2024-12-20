<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 등록</title>
<link rel="stylesheet" href="${ pageContext.request.contextPath }/resources/css/helpdesk/NoticeEnrollForm.css"> <!-- 스타일 시트 링크 -->
</head>
<body>
        
    <%@ include file="/WEB-INF/views/common/header.jsp" %>

    <div class="content">
        <br><br>
        <div class="innerOuter">
            <h2>게시글 작성하기</h2>
            <br>

			<!-- 
				게시글 작성하기 요청 시
				http://localhost:8006/spring/insert.bo
				로 요청
				또한, 요청 시 전달값 중 첨부파일이 있을 경우에는
				마찬가지로 enctype 속성을 같이 기술해야함!!
			-->
            <form id="NoticeEnrollForm" method="post" 
            					  action="insert.no" 
            					  enctype="multipart/form-data">
                <table align="center">
                    <tr>
                        <th><label for="title" required>제목</label></th>
                        <td><input type="text" id="title" class="form-control" name="noticeTitle" required></td>
                    </tr>
                    <tr>
                        <th><label for="upfile">첨부파일</label></th>
                        <td>
                        	<div class="form-group">
                        	
                        		<div class="form-check row">
                        			<input type="file" id="upfile" class="form-control-file border" name="upfile">
                        		</div>
                        		<div class="form-check row">
                        			<input type="file" id="upfile" class="form-control-file border" name="upfile">
                        		</div>
                        		<div class="form-check row">
                        			<input type="file" id="upfile" class="form-control-file border" name="upfile">
                        		</div>
                        		<div class="form-check row">
                        			<input type="file" id="upfile" class="form-control-file border" name="upfile">
                        		</div>
                        		<div class="form-check row">
                        			<input type="file" id="upfile" class="form-control-file border" name="upfile">
                        		</div>
                        		
                        	</div>
                        </td>
                    </tr>
                    <tr>
                        <th><label for="content" required>내용</label></th>
                        <td><textarea id="content" class="form-control" rows="10" style="resize:none;" name="noticeContent" required></textarea></td>
                    </tr>
                </table>
                <br>

                <div align="center">
                    <button type="submit" class="btn btn-primary">등록하기</button>
                    <button type="reset" class="btn btn-danger">취소하기</button>
                </div>
            </form>
        </div>
        <br><br>

    </div>
    
    <script src="${ pageContext.request.contextPath }/resources/js/helpdesk/Notice.js"></script> <!-- JS 파일 경로 -->
    <%@ include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>




