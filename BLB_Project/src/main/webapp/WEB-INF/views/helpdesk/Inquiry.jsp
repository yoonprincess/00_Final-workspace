<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="resources/css/helpdesk/CustomerServiceCenter.css"> <!-- CSS 파일 경로 -->
    <title>1:1 문의</title>
</head>
<body>
<jsp:include page="../common/header.jsp"/>
	<div class="container-fluid">
		<h1>고객센터</h1>
	        <div class="tabs">
	            <button class="tab-button active" data-tab="faq">
	            <a href="Faq.blb">FAQ</a>
	            </button>
	            <button class="tab-button" data-tab="inquiry">
	            <a href="Inquiry.blb">1:1 문의</a>
	            </button>
	            <button class="tab-button" data-tab="notice">
	            <a href="Notice.blb">공지사항</a>
	            </button>
	        </div>
    <div id="inquiry" class="tab-content">
        <div class="header">
            BLB 고객센터입니다!
            <br />
            무엇을 도와드릴까요?
        </div>
        <div class="form-container">
            <div class="form-group">
                <label for="category">문의유형</label>
                <select id="category">
                    <option>카테고리를 선택해주세요</option>
                    <option>상품</option>
                    <option>배송</option>
                    <option>주문</option>
                    <option>결제/환불</option>
                </select>
            </div>
            <div class="form-group">
                <label for="content">내용</label>
                <textarea id="content" placeholder="문의내용을 입력해주세요. (2000자 이내)"></textarea>
            </div>
            <div class="form-group">
                <label for="file-upload">첨부파일</label>
                <button type="button" id="file-upload-btn" class="file-upload-btn">+</button>
                <span id="file-count">0/3</span>
                <p id="file-info" style="font-size: 12px; color: #7AB2D3;">10MB 이하 이미지 파일 (JPG, PNG, GIF) 3개를 첨부할 수 있습니다.</p>
                <div class="file-list" id="file-list"></div>
            </div>
            <div class="form-group">
                <label for="receive-email">
                    <input type="checkbox" id="receive-email"> 답변 완료 시 이메일로 알림 받기
                </label>
            </div>
            <div class="form-group" id="email-group">
                <label for="email">답변 받을 이메일</label>
                <div>
                    <input type="text" id="email" placeholder="답변 받을 이메일을 입력하세요." style="width: 55%;" disabled/>
                </div>
            </div>
            <div class="form-buttons">
                <button type="button" class="cancel" onclick="resetForm()">취소</button>
                <button type="button" class="submit" onclick="submitForm()">등록</button>
            </div>
        </div>
    </div>
    <script src="resources/js/helpdesk/CustomerServiceCenter.js"></script> <!-- JS 파일 경로 -->
    </div>
</body>
</html>

