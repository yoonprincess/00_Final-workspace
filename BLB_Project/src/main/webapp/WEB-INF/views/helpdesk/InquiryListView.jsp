<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="resources/css/helpdesk/InquiryListView.css"> <!-- CSS 경로 -->
    <title>내 문의 내역</title>
</head>
<body>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<div class="container-fluid">
<div class="container">
    <h1>내 문의 내역</h1>
    <c:if test="${sessionScope.loginUser != null}">
        <div class="inquiry-list">
            <table>
                <thead>
                    <tr>
                        <th>번호</th>
                        <th>문의 제목</th>
                        <th>문의 유형</th>
                        <th>작성일</th>
                        <th>답변 상태</th>
                    </tr>
                </thead>
                <tbody>
                    <c:if test="${empty inquiryList}">
                        <tr>
                            <td colspan="5">문의한 내용이 없습니다.</td>
                        </tr>
                    </c:if>
                    <c:forEach var="i" items="${inquiryList}">
                        <tr>
                            <td>${i.inquiryNo}</td>
                            <td>${i.inquiryTitle}</td>
                            <td>${i.inquiryType}</td>
                            <td>${i.inquiryCreateDate}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${inquiry.inquiryAnsweredYn == 'Y'}">답변 완료</c:when>
                                    <c:otherwise>미답변</c:otherwise>
                                </c:choose>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </c:if>
    <c:if test="${sessionScope.loginUser == null}">
        <p>로그인 후 이용 가능합니다.</p>
    </c:if>
    <div class="form-buttons">
        <a href="Inquiry.blb" class="btn btn-primary">문의하기</a>
    </div>
</div>
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>
