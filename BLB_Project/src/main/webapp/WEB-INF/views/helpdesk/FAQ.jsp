<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="resources/css/helpdesk/FAQ.css"> <!-- CSS 파일 경로 -->
    <title>FAQ</title>
</head>
<body class="body-offset">
<%@ include file="/WEB-INF/views/common/header.jsp" %>
	<div class="container-fluid">
		<div class="container">
		<h1>고객센터</h1>
            <div class="tabs">
                <a class="tab-button active" href="Faq.blb">FAQ</a>
                <a class="tab-button" href="list.io">1:1문의</a>
                <a class="tab-button" href="list.no">공지사항</a>
            </div>
	    <div id="faq" class="tab-content active">
	    <h3>TOP 5</h3>
	        <div class="sub-tabs">
	            <button class="sub-tab-button active" data-category="product">상품</button>
	            <button class="sub-tab-button" data-category="delivery">배송</button>
	            <button class="sub-tab-button" data-category="order">주문</button>
	            <button class="sub-tab-button" data-category="payment">결제/환불</button>
	        </div>
	        <div class="faq-list">
	            <!-- FAQ 항목들이 여기에 동적으로 추가됩니다 -->
	        </div>
	    </div>
	    </div>
	    <script src="resources/js/helpdesk/FAQ.js"></script> <!-- JS 파일 경로 -->
    </div>
    <%@ include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>
