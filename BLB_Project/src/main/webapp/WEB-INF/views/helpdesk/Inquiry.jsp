<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>공지사항 상세보기</title>
    <link rel="stylesheet" href="${ pageContext.request.contextPath }/resources/css/helpdesk/Inquiry.css">
</head>
<body class="body-offset">
    <%@ include file="/WEB-INF/views/common/header.jsp" %>
  <div class="container-fluid">
  <br><br>
    <div class="container">
    <form id="insertInquiry" name="insertInquiry" action="insert.io" method="post" enctype="multipart/form-data">
        <input type="hidden" value="${ sessionScope.loginUser.memberId }" name="memberId" >
        <div class="form-row">
            <label class="form-label">문의유형</label>
            <div style="display: flex; gap: 10px;">
                <select id="inquiryType" name="inquiryType" required>
                    <option value="">카테고리를 선택해주세요</option>
                    <option value="상품">상품</option>
                    <option value="배송">배송</option>
                    <option value="주문">주문</option>
                    <option value="결제/환불">결제/환불</option>
                </select>
            </div>
        </div>

        <div class="form-row">
            <label class="form-label">내용</label>
            <textarea id="inquiryContent" name="inquiryContent" class="content-textarea" placeholder="문의사항을 입력해주세요.(2000자 이내)" required></textarea>
            
            <!-- 파일 업로드 영역 HTML -->
				<div class="file-upload">
				    <label class="file-upload-button" for="upfile">
				        파일 선택
				    </label>
				    <input type="file" id="upfile" class="file-upload-input" name="upfile" multiple />
				    <div class="upload-limit-info">
				        * 10MB 이하의 이미지 파일(JPG, PNG, GIF)을 첨부할 수 있습니다. (최대 5개)
				    </div>
				    <div class="file-list" id="fileList">
				        <!-- 파일 목록이 여기에 동적으로 추가됩니다 -->
				    </div>
				</div>
				</div>
        <div class="contact-info"> 
            <label class="form-label" style="width:300px;">답변이 오면 알려드릴까요? (선택)</label>
            <div>
                <div style="margin-top: 10px;">
                    <input type="checkbox" id="email">
                    <label for="email">E-mail</label>
                    <div class="email-input">
                        <input type="text" placeholder="이메일">
                        <span>@</span>
                        <input type="text">
                        <select>
                            <option>직접입력</option>
                            <option>nate.com</option>
                            <option>gmail.com</option>
                        </select>
                    </div>
                </div>
            </div>
        </div>

        <div class="notice">
            - 정확하지 않거나 부족한 문의내용은 답변이 원활하지 않을 수 있습니다.
        </div>

        <div class="button-group">
            <button type="submit" class="submit-button">등록</button>
            <button type="button" class="cancel-button">취소</button>
        </div>
    </form>
    <br><br>
    </div>
    </div>
	<script src="${ pageContext.request.contextPath }/resources/js/helpdesk/Inquiry.js"></script> <!-- JS 파일 경로 -->
    <%@ include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>
