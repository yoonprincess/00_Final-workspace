<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>1:1 문의내역</title>
    <link rel="stylesheet" href="${ pageContext.request.contextPath }/resources/css/helpdesk/InquiryListView.css">
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
</head>
<body class="body-offset">
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<div class="container-fluid">
    <div class="container">
    <br><br><br><br>
    <!-- 네비게이션 메뉴 -->
        <div class="inquiry-menu">
		    <a href="list.fo">FAQ</a>
		    <a href="list.io" class="active">1:1 문의</a>
		    <a href="list.no">공지사항</a>
		</div>
        <br>
    <c:if test="${sessionScope.loginUser != null}">
        <div style="display: flex; align-items: center; float:right; margin-bottom: 20px;">           
			<a href="Inquiry.blb" class="button button-primary">
				<span class="material-symbols-outlined">
					support_agent
				</span>
				문의하기
			</a>
        </div>
        <table id="inquiryList">
            <thead>
                <tr>
                    <th>문의번호</th>
                    <th>분류</th>
                    <th>내용</th>
                    <th>등록일</th>
                    <th>답변상태</th>
                </tr>
            </thead>
            <tbody>
                <c:if test="${empty list}">
                    <tr>
                        <td colspan="6" style="pointer-events: none;">문의한 내용이 없습니다.</td>
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
							    <c:otherwise>답변 대기</c:otherwise>
							</c:choose>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
        <br><br>
        <!-- 페이지네이션 -->
        <nav>
            <ul class="pagination">
                <!-- 이전 페이지 그룹 -->
                <c:if test="${ pi.startPage > 1 }">
                    <li class="page-item">
                        <a href="list.io?cpage=${ pi.startPage - pi.pageLimit }">
                            ＜
                        </a>
                    </li>
                </c:if>
                
                <!-- 페이지 번호 -->
                <c:forEach var="p" begin="${ pi.startPage }" end="${ pi.endPage }" step="1">
                    <c:if test="${ p == pi.currentPage }">
                        <li class="page-item">
                            <a class="active" href="#">
                                ${ p }
                            </a>
                        </li>
                    </c:if>
                    <c:if test="${ p != pi.currentPage }">
                        <li class="page-item">
                            <a href="list.io?cpage=${ p }">
                                ${ p }
                            </a>
                        </li>
                    </c:if>
                </c:forEach>
                
                <!-- 다음 페이지 그룹 -->
                <c:if test="${ pi.endPage < pi.maxPage }">
                    <li class="page-item">
                        <a href="list.io?cpage=${ pi.startPage + pi.pageLimit }">
                            ＞
                        </a>
                    </li>
                </c:if>
            </ul>
        </nav>
        <!-- 페이지네이션 end -->
    </c:if>
    </div>
</div>
<script src="${ pageContext.request.contextPath }/resources/js/helpdesk/Inquiry.js"></script> <!-- JS 파일 경로 -->
<%@ include file="/WEB-INF/views/common/footer.jsp" %>

</body>
</html>
