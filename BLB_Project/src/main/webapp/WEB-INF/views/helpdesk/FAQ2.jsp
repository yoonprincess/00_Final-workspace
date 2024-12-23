<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>FAQ</title>
    <link rel="stylesheet" href="${ pageContext.request.contextPath }/resources/css/helpdesk/FAQ.css">
</head>
<body class="body-offset">
    <%@ include file="/WEB-INF/views/common/header.jsp" %>
    <div class="container-fluid">
        <div class="container">
            <br><br><br><br>
            <!-- 네비게이션 메뉴 -->
            <div class="faq-menu">
			    <a href="Faq.blb" class="active">FAQ</a>
			    <a href="list.io">1:1 문의</a>
			    <a href="list.no">공지사항</a>
			</div>

            <div class="faq-search">
                <form action="list.no" method="get">
                    <input type="text" name="searchKeyword" placeholder="제목 또는 내용을 입력해주세요." value="${ param.searchKeyword }">
                    <button type="submit">검색</button>
                </form>
                <c:if test="${ sessionScope.loginUser.memberId eq 'admin' }">
                <!-- 로그인 후 상태일 경우만 보여지는 글쓰기 버튼 -->
                <a class="btn btn-secondary" style="float:right; background-color:#A4EBF3; border:none;" href="faqEnrollForm.no">글쓰기</a>
            </c:if>
            </div>

            <!-- FAQ 테이블 -->
            <table id="faqList">
                <thead>
                    <tr>
                        <th>질문</th>
                        <th>답변</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="f" items="${ requestScope.faqList }">
                        <tr class="faq-item">
                            <td>${ f.question }</td>
                            <td class="faq-answer">${ f.answer }</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
            <!-- 페이지네이션 -->
            <nav>
                <ul class="pagination">
                    <!-- 이전 페이지 그룹 -->
                    <c:if test="${ pi.startPage > 1 }">
                        <li class="page-item">
                            <a href="Faq.blb?cpage=${ pi.startPage - pi.pageLimit }&searchKeyword=${searchKeyword}">
                                ＜
                            </a>
                        </li>
                    </c:if>
                    
                    <!-- 페이지 번호 -->
                    <c:forEach var="p" begin="${ pi.startPage }" end="${ pi.endPage }" step="1">
                        <c:if test="${ p == pi.currentPage }">
                            <li class="page-item">
                                <a class="active" href="#">${ p }</a>
                            </li>
                        </c:if>
                        <c:if test="${ p != pi.currentPage }">
                            <li class="page-item">
                                <a href="Faq.blb?cpage=${ p }&searchKeyword=${searchKeyword}">${ p }</a>
                            </li>
                        </c:if>
                    </c:forEach>
                    
                    <!-- 다음 페이지 그룹 -->
                    <c:if test="${ pi.endPage < pi.maxPage }">
                        <li class="page-item">
                            <a href="Faq.blb?cpage=${ pi.startPage + pi.pageLimit }&searchKeyword=${searchKeyword}">
                                ＞
                            </a>
                        </li>
                    </c:if>
                </ul>
            </nav>
            <!-- 페이지네이션 end -->
        </div>
    </div>
    <script>
	    document.addEventListener("DOMContentLoaded", function() {
	        const faqItems = document.querySelectorAll(".faq-item");
	        
	        faqItems.forEach(item => {
	            item.addEventListener("click", function() {
	                const answer = this.querySelector(".faq-answer");
	                if (answer.style.display === "none" || !answer.style.display) {
	                    answer.style.display = "block";
	                } else {
	                    answer.style.display = "none";
	                }
	            });
	        });
	    });
    </script>
    <script src="${ pageContext.request.contextPath }/resources/js/helpdesk/FAQ.js"></script> <!-- JS 파일 경로 -->
    <%@ include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>
