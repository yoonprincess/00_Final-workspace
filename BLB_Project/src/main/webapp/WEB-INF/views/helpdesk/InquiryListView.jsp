<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="resources/css/helpdesk/FAQ.css">
    <link rel="stylesheet" href="resources/css/helpdesk/InquiryListView.css"> <!-- CSS 경로 -->
    <title>내 문의 내역</title>
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
    <c:if test="${sessionScope.loginUser != null}">
        <div class="inquiry-list">
		    <div class="form-buttons">
		        <a href="Inquiry.blb" class="btn btn-primary">문의하기</a>
		    </div>
            <table id="inquiryList">
                <thead>
                    <tr>
                        <th>문의번호</th>
                        <th>분류</th>
                        <th>문의내용</th>
                        <th>문의일</th>
                        <th>답변상태</th>
                    </tr>
                </thead>
                <tbody>
                    <c:if test="${empty list}">
                        <tr>
                            <td colspan="5">문의한 내용이 없습니다.</td>
                        </tr>
                    </c:if>
                    <c:forEach var="i" items="${requestScope.list}">
                        <tr>
                            <td class="ino">${i.inquiryNo}</td>
                            <td>${i.inquiryType}</td>
                            <td>${i.inquiryContent}</td>
                            <td>${i.inquiryCreateDate}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${i.inquiryAnsweredYn == 'Y'}">답변 완료</c:when>
                                    <c:otherwise>미답변</c:otherwise>
                                </c:choose>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
        <br><br>
    <!-- 페이지네이션 -->
	        <nav>
	            <ul class="pagination">
	                <li><a href="#">«</a></li>
	                <li><a href="#" class="active">1</a></li>
	                <li><a href="#">2</a></li>
	                <li><a href="#">3</a></li>
	                <li><a href="#">4</a></li>
	                <li><a href="#">5</a></li>
	                <li><a href="#">»</a></li>
	            </ul>
	        </nav>
    </c:if>
    <c:if test="${sessionScope.loginUser == null}">
        <a href="loginForm.me" class="btn btn-warning">로그인이 필요한 서비스 입니다.</a>
    </c:if>
    
</div>
</div>
<script src="resources/js/helpdesk/Inquiry.js"></script> <!-- JS 파일 경로 -->
<%@ include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>
