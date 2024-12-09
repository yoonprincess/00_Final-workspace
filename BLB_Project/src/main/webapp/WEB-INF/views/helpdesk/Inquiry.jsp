<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="resources/css/helpdesk/Inquiry.css"> <!-- CSS 파일 경로 -->
    <title>1:1 문의</title>
</head>
<body class="body-offset">
<%@ include file="/WEB-INF/views/common/header.jsp" %>
    <div class="container-fluid">
        <div class="container">
        	<h1>고객센터</h1>
            <div class="tabs">
                <a class="tab-button" href="Faq.blb">FAQ</a>
                <a class="tab-button active" href="list.io">1:1문의</a>
                <a class="tab-button" href="list.no">공지사항</a>
            </div>
            <div class="tab-content active">
                <form id="inquiry-form" action="insert.io" method="post" enctype="multipart/form-data">
                    <div class="form-container">
                        <div class="form-group">
                        <input type="hidden" value="${ sessionScope.loginUser.memberId }" name="memberId" >
                            <label for="inquiryType">문의유형</label>
                            <select id="inquiryType" name="inquiryType">
                                <option value="카테고리를 선택해주세요">카테고리를 선택해주세요</option>
                                <option value="상품">상품</option>
                                <option value="배송">배송</option>
                                <option value="주문">주문</option>
                                <option value="결제/환불">결제/환불</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="inquiryContent">문의내용</label>
                            <textarea id="inquiryContent" name="inquiryContent"></textarea>
                        </div>
                        <div class="form-group">
                            <label for="file-upload">파일 업로드</label>
                            <button type="button" id="file-upload-btn" class="file-upload-btn">파일 선택</button>
                            <div id="file-list"></div>
                            <span id="file-count">0/3</span>
                        </div>
                        <div class="form-group">
                            <label for="receive-email">
                                <input type="checkbox" id="receive-email" /> 답변 완료 시 이메일로 알림 받기
                            </label>
                        </div>
                        <div class="form-group">
                            <label for="email">이메일 주소</label>
                            <input type="text" id="email" name="email" disabled />
                        </div>
                        <div class="form-buttons1">
                            <button type="button" class="cancel" onclick="location.href='list.io'">뒤로가기</button>
                            <button type="submit">제출</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <script src="resources/js/helpdesk/Inquiry.js"></script> <!-- JS 파일 경로 -->
<%@ include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>
