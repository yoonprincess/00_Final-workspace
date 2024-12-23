<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>FAQ</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/helpdesk/FAQ.css">
</head>
<body class="body-offset">
    <%@ include file="/WEB-INF/views/common/header.jsp" %>
    <div class="container-fluid">
        <div class="container">
            <br><br><br><br>
            <!-- 네비게이션 메뉴 -->
            <div class="faq-menu">
                <a href="${pageContext.request.contextPath}/list.fo" class="active">FAQ</a>
                <a href="${pageContext.request.contextPath}/list.io">1:1 문의</a>
                <a href="${pageContext.request.contextPath}/list.no">공지사항</a>
            </div>
            <h1>FAQ</h1>
    
            <div class="section-header">
                <h2>많이 찾는 질문</h2>
            </div>

            <p class="description">
                찾으시는 내용이 없다면 1:1문의를 이용해주세요!
            </p>

            <div class="faq-list">
                <c:forEach var="faq" items="${list}">
                    <details>
                        <!-- 제목 및 내용 수정 영역 -->
                        <summary>
                            <form class="faq-edit" action="${pageContext.request.contextPath}/FaqUpdate.fo?fno=${faq.faqNo}" method="post" style="display: none;">
                                <input type="hidden" name="fno" value="${faq.faqNo}">
                                <!-- 제목 수정 -->
                                <input type="text" name="faqTitle" value="${faq.faqTitle}" style="width: 100%; margin-bottom: 5px;">
                                <!-- 내용 수정 -->
                                <textarea name="faqContent" rows="4" style="width: 100%;">${faq.faqContent}</textarea>
                                <div class="faq-actions">
                                    <button type="submit" class="save-button">저장</button>
                                    <button type="button" class="cancel-button" onclick="cancelEdit(this)">취소</button>
                                </div>
                            </form>

                            <div class="faq-title-display">${faq.faqTitle}</div>
                        </summary>

                        <div class="content">
                            <!-- 내용 표시 영역 -->
                            <div class="faq-display">
                                <p>${faq.faqContent}</p>
                                <!-- 관리자만 수정/삭제 버튼 표시 -->
                                <c:if test="${sessionScope.loginUser != null && sessionScope.loginUser.memberId == 'admin'}">
                                    <div class="faq-actions">
                                        <button type="button" class="update-button" onclick="editFaq(this)">수정</button>
                                        <form action="${pageContext.request.contextPath}/FaqDelete.fo" method="post" style="display: inline;">
                                            <input type="hidden" name="fno" value="${faq.faqNo}">
                                            <button type="submit" class="delete-button">삭제</button>
                                        </form>
                                    </div>
                                </c:if>
                            </div>
                        </div>
                    </details>
                </c:forEach>
            </div>

            <!-- 관리자만 FAQ 등록 버튼 표시 -->
            <c:if test="${sessionScope.loginUser != null && sessionScope.loginUser.memberId == 'admin'}">
                <button type="button" class="add-faq-button" onclick="showAddFaqForm()">FAQ 등록</button>
            </c:if>
            
            <!-- FAQ 등록 폼 -->
            <form class="faq-add-form" action="${pageContext.request.contextPath}/insert.fo" method="post" style="display: none;">
                <h3>새 FAQ 등록</h3>
                <input type="text" name="faqTitle" placeholder="제목을 입력하세요" required style="width: 100%; margin-bottom: 10px;">
                <textarea name="faqContent" placeholder="내용을 입력하세요" rows="4" required style="width: 100%;"></textarea>

                <!-- 분류 선택 -->
                <select name="faqType" required style="width: 100%; margin-bottom: 10px;">
                    <option value="">-- 분류를 선택하세요 --</option>
                    <option value="general">일반</option>
                    <option value="technical">기술</option>
                    <option value="account">계정 관련</option>
                    <option value="payment">결제 관련</option>
                </select>
                
                <div class="faq-actions">
                    <button type="submit" class="save-button">등록</button>
                    <button type="button" class="cancel-button" onclick="cancelAddFaq()">취소</button>
                </div>
            </form>
        </div>
    </div>
    <script>
        // 수정 버튼 클릭 시 수정 모드 활성화
        function editFaq(button) {
            const contentDiv = button.closest('.content');
            const displayDiv = contentDiv.querySelector('.faq-display');
            const editForm = contentDiv.closest('details').querySelector('.faq-edit');
            const titleDiv = contentDiv.closest('details').querySelector('.faq-title-display');

            titleDiv.style.display = 'none'; // 제목 숨기기
            displayDiv.style.display = 'none'; // 내용 숨기기
            editForm.style.display = 'block'; // 수정 폼 표시
        }

        // 취소 버튼 클릭 시 수정 모드 취소
        function cancelEdit(button) {
            const contentDiv = button.closest('.content');
            const displayDiv = contentDiv.querySelector('.faq-display');
            const editForm = contentDiv.closest('details').querySelector('.faq-edit');
            const titleDiv = contentDiv.closest('details').querySelector('.faq-title-display');

            titleDiv.style.display = 'block'; // 제목 표시
            displayDiv.style.display = 'block'; // 내용 표시
            editForm.style.display = 'none'; // 수정 폼 숨기기
        }

        // FAQ 등록 버튼 클릭 시 등록 폼 표시
        function showAddFaqForm() {
            const addForm = document.querySelector('.faq-add-form');
            addForm.style.display = 'block';
        }

        // 취소 버튼 클릭 시 등록 폼 숨기기
        function cancelAddFaq() {
            const addForm = document.querySelector('.faq-add-form');
            addForm.style.display = 'none';
        }
    </script>
    <%@ include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>
