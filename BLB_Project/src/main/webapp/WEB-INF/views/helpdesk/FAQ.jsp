<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="resources/css/helpdesk/CustomerServiceCenter.css"> <!-- CSS 파일 경로 -->
    <title>FAQ</title>
</head>
<body>
<jsp:include page="../common/header.jsp"/>
	<div class="container-fluid">
		<h1>고객센터</h1>
	        <div class="tabs">
	            <button class="tab-button active" data-tab="faq" onclick="location.href='Faq.blb';">FAQ
	            </button>
	            <button class="tab-button" data-tab="inquiry">
	            <a href="Inquiry.blb">1:1 문의</a>
	            </button>
	            <button class="tab-button" data-tab="notice">
	            <a href="Notice.blb">공지사항</a>
	            </button>
	        </div>
	
	    <div id="faq" class="tab-content active">
	        <div class="sub-tabs">
	            <button class="sub-tab-button active" data-category="all">전체</button>
	            <button class="sub-tab-button" data-category="product">상품</button>
	            <button class="sub-tab-button" data-category="delivery">배송</button>
	            <button class="sub-tab-button" data-category="order">주문</button>
	            <button class="sub-tab-button" data-category="payment">결제/환불</button>
	        </div>
	        <div class="faq-list">
	            <!-- FAQ 항목들이 여기에 동적으로 추가됩니다 -->
	        </div>
	    </div>
	    <script src="resources/js/helpdesk/CustomerServiceCenter.js"></script> <!-- JS 파일 경로 -->
    </div>
</body>
</html>
