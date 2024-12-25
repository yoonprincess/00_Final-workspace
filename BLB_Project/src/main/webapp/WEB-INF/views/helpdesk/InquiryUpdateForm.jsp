<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>문의 수정</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/helpdesk/InquiryDetailView.css"> <!-- 스타일 시트 링크 -->
</head>
<body class="body-offset">
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<div class="container-fluid">
    <div class="container">
        <h2>문의사항 수정</h2>

        <!-- 상단 내비게이션 -->
        <nav>
            <ul>
                <li><a href="../list.io">목록</a></li>
                <li><a href="InquiryDelete.io">삭제</a></li>
            </ul>
        </nav>

        <!-- 수정 폼 -->
        <form id="editInquiryForm" action="InquiryUpdate.io" method="post">
            <input type="hidden" name="inquiryNo" value="${requestScope.i.inquiryNo}" readonly>
            
            <div class="form-group">
                <label for="prodName">상품명</label>
                <input type="text" id="prodName" name="prodName" value="${requestScope.i.prodName}" readonly>
            </div>
            
            <div class="form-group">
                <label for="memberId">문의자</label>
                <input type="text" id="memberId" name="memberId" value="${requestScope.i.memberId}" readonly>
            </div>
            
            <div class="form-group">
                <label for="inquiryCreateDate">문의일</label>
                <input type="text" id="inquiryCreateDate" name="inquiryCreateDate" value="${requestScope.i.inquiryCreateDate}" readonly>
            </div>
            
            <div class="form-group">
                <label for="inquiryContent">내용</label>
                <textarea id="inquiryContent" name="inquiryContent" rows="5" required>${requestScope.i.inquiryContent}</textarea>
            </div>
            
            <div class="form-group">
            	<label for="inquiryAtt">첨부파일</label>
            	<input type="file" id="inquiryAtt" name="inquiryAtt" value="${requestScope.i.inquiryAtt }"/>
            </div>
            
            <button type="submit">수정</button>
        </form>
    </div>
</div>
<script src="${pageContext.request.contextPath}/resources/js/helpdesk/Inquiry.js"></script> <!-- JS 파일 경로 -->
<%@ include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>
