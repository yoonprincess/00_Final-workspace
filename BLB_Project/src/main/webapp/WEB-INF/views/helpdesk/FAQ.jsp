<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>자주 묻는 질문 (FAQ)</title>
    <link rel="stylesheet" href="resources/css/helpdesk/FAQ.css"> <!-- CSS 파일 경로 -->
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
        <h1>자주 묻는 질문 (FAQ)</h1>
        <div class="form-group">
            <select>
                <option value="all">전체</option>
                <option value="order">주문/결제/배송</option>
                <option value="product">상품</option>
                <option value="return">반품/교환</option>
            </select>
        </div>
        <table>
            <thead>
                <tr>
                    <th>번호</th>
                    <th>카테고리</th>
                    <th>제목</th>
                    <th>작성일</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>1</td>
                    <td>주문/결제/배송</td>
                    <td>배송 기간은 얼마나 걸리나요?</td>
                    <td>2023-09-18</td>
                </tr>
                <tr>
                    <td>2</td>
                    <td>주문/결제/배송</td>
                    <td>주문 취소는 어떻게 하나요?</td>
                    <td>2023-09-18</td>
                </tr>
                <!-- Add more rows as needed -->
            </tbody>
        </table>
    </div>
    </div>
    <%@ include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>


