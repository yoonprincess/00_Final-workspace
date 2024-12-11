<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>1:1 문의하기</title>
    <link rel="stylesheet" href="resources/css/helpdesk/Inquiry.css">
</head>
<body class="body-offset">
<%@ include file="/WEB-INF/views/common/header.jsp" %>
    <div class="container-fluid">
    <div class="container">
    
    <header>
        <nav>
            <a href="Faq.blb">고객센터</a>
            <a href="list.io">1:1문의</a>
            <a href="#">리뷰</a>
            <a href="list.no">공지사항</a>
        </nav>
    </header>
        <h1>1:1 문의하기</h1>
        <form>
        	 <input type="hidden" value="${ sessionScope.loginUser.memberId }" name="memberId" >
            <div class="form-group">
                <label for="inquiryType">문의유형</label>
                <select id="inquiryType">
                    <option value="">카테고리를 선택해주세요</option>
                    <option value="상품">상품</option>
                    <option value="배송">배송</option>
                    <option value="주문">주문</option>
                    <option value="결제/환불">결제/환불</option>
                </select>
            </div>
            <div class="form-group">
                <label for="inquiry-content">문의내용</label>
                <textarea id="inquiryContent" name="inquiryContent" rows="10" placeholder="문의하실 내용을 입력해주세요 (2000자 이내)"></textarea>
            </div>
            <div class="form-group">
                <label for="file-upload">첨부파일</label>
                <input type="file" id="file-upload" class="file-input">
                <input type="file" id="file-upload" class="file-input">
                <input type="file" id="file-upload" class="file-input">
                <input type="file" id="file-upload" class="file-input">
                <input type="file" id="file-upload" class="file-input">
            </div>
            <div class="form-group">
                <label>
                    <input type="checkbox" id="email-notify" name="email"> 이메일로 답변 완료 시 알림 받기
                </label>
                <div class="email-input">
                    <input type="email" placeholder="이메일 주소를 입력해주세요">
                </div>
            </div>
            <div class="button-group">
                <button type="submit" class="button button-primary">등록</button>
                <button type="button" class="button button-secondary">취소</button>
            </div>
        </form>
    </div>
    </div>
    <script src="resources/js/helpdesk/Inquiry.js"></script> <!-- JS 파일 경로 -->
<%@ include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>



