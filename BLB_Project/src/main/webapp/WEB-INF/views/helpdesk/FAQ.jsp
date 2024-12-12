<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CONTACT</title>
    <link rel="stylesheet" href="resources/css/helpdesk/FAQ.css">
</head>
<body class="body-offset">
<%@ include file="/WEB-INF/views/common/header.jsp" %>
	<div class="container-fluid">
    <div class="container">
        <div class="grid">
            <div class="card">
                <div class="card-header">
                    <h2 class="card-title">CONTACT</h2>
                </div>
                <div class="card-content">
                    <div class="menu-items">
                        <a href="${ pageContext.request.contextPath }/list.no" class="menu-item">
                            <span class="font-medium">공지사항</span>
                            <span class="chevron-right">›</span>
                        </a>
                        <a href="${ pageContext.request.contextPath }/Faq.blb" class="menu-item">
                            <span class="font-medium">FAQ</span>
                            <span class="chevron-right">›</span>
                        </a>
                        <a href="${ pageContext.request.contextPath }/list.io" class="menu-item">
                            <span class="font-medium">고객 문의</span>
                            <span class="chevron-right">›</span>
                        </a>
                    </div>
                    <div class="notices" id="notices">
                        <!-- Notices will be dynamically inserted here -->
                    </div>
                </div>
            </div>

            <div class="card bg-light">
                <div class="card-content">
                    <div class="info-item">
                        <div class="info-label">운영 시간</div>
                        <div class="info-content">
                            <p class="font-medium">평일 13:00 ~ 17:00</p>
                            <p class="text-muted">주말 및 공휴일 휴무</p>
                        </div>
                    </div>
                    <div class="info-item">
                        <div class="info-label">전화 문의</div>
                        <div class="info-content">
                            <p class="font-medium">고객 문의 : 1544-6418</p>
                            <p class="font-medium">대표 문의 : 080-022-2285</p>
                        </div>
                    </div>
                    <div class="info-item">
                        <div class="info-label">대표 메일</div>
                        <div class="info-content">
                            <p class="font-medium">whole_member@hello.co.kr</p>
                            <p class="text-muted">문의 시간에 상담이 몰릴 경우 답변이 늦을 수 있음을 양해 부탁 드립니다</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="card mt-6">
            <div class="card-header">
                <h2 class="card-title">FAQ Top 10</h2>
                <a href="https://Faq.blb" class="text-muted">더보기 ›</a>
            </div>
            <div class="card-content">
                <div class="faq-grid" id="faqGrid">
                    <!-- FAQ items will be dynamically inserted here -->
                </div>
            </div>
        </div>
    </div>

    <script src="resources/js/helpdesk/FAQ.js"></script>
    </div>
    <%@ include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>



