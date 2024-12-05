<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="resources/css/helpdesk/CustomerServiceCenter.css"> <!-- CSS 파일 경로 -->
    <title>공지사항</title>
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
    <div id="notice" class="tab-content">
        <div class="sub-tabs">
            <button class="sub-tab-button active" data-category="all">전체</button>
            <button class="sub-tab-button" data-category="general">일반</button>
            <button class="sub-tab-button" data-category="store">매장</button>
            <button class="sub-tab-button" data-category="event">이벤트</button>
        </div>
        <div class="notice-search">
            <input type="text" id="notice-search-input" placeholder="검색어를 입력하세요.">
            <button type="button" id="notice-search-btn">검색</button>
        </div>
        <table id="notice-table">
            <colgroup>
                <col style="width: 10%;"> <!-- 글번호 -->
                <col style="width: 20%;"> <!-- 분류 -->
                <col style="width: 50%;"> <!-- 내용 -->
                <col style="width: 20%;"> <!-- 작성일 -->
            </colgroup>
            <thead>
                <tr>
                    <th>글번호</th>
                    <th>분류</th>
                    <th>내용</th>
                    <th>작성일</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="n" items="${requestScope.list }">
                    <tr>
                        <td class="nno">${n.noticeNo }</td>
                        <td>${n.noticeTitle }</td>
                        <td>${n.noticeContent }</td>
                        <td>${n.noticeRegDate }</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
        <div id="pagingArea">
            <ul class="pagination">
                <!-- 페이징 코드 동일 -->
            </ul>
        </div>
    </div>
    <script src="resources/js/helpdesk/CustomerServiceCenter.js"></script> <!-- JS 파일 경로 -->
    </div>
</body>
</html>

