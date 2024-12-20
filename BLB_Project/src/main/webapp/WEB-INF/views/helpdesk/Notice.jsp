<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>공지사항</title>
    <link rel="stylesheet" href="${ pageContext.request.contextPath }/resources/css/helpdesk/Notice.css">
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
	    <c:if test="${ sessionScope.loginUser.memberId eq 'admin' }">
	     	<!-- 로그인 후 상태일 경우만 보여지는 글쓰기 버튼 -->
	     	<a class="btn btn-secondary" style="float:right;" 
	     								 href="NoticeEnrollForm.no">
	     		글쓰기
	     	</a>
	    </c:if>
        <h1>공지사항</h1>
        <div class="notice-search">
		    <form action="list.no" method="get">
		        <input type="text" name="searchKeyword" placeholder="검색어를 입력하세요" value="${ param.searchKeyword }">
		        <button type="submit">찾기</button>
		    </form>
		</div>

        <table id="noticeList">
            <thead>
                <tr>
                    <th>글번호</th>
                    <th>제목</th>
                    <th>내용</th>
                    <th>등록일</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="n" items="${ requestScope.list }">
                    <tr>
                        <td class="nno">${ n.noticeNo }</td>
                        <td>${ n.noticeTitle }</td>
                        <td>${ n.noticeContent }</td>
                        <td>${ n.noticeRegDate }</td>
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
							<a href="list.no?cpage=${ pi.startPage - pi.pageLimit }&searchKeyword=${searchKeyword}">
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
								<a href="list.no?cpage=${ p }&searchKeyword=${searchKeyword}">
									${ p }
								</a>
							</li>
						</c:if>
					</c:forEach>
					
					<!-- 다음 페이지 그룹 -->
					<c:if test="${ pi.endPage < pi.maxPage }">
						<li class="page-item">
							<a href="list.no?cpage=${ pi.startPage + pi.pageLimit }&searchKeyword=${searchKeyword}">
								＞
							</a>
						</li>
					</c:if>
				</ul>
			</nav>
			<!-- 페이지네이션 end -->
    </div>
    </div>
    <script src="${ pageContext.request.contextPath }/resources/js/helpdesk/Notice.js"></script> <!-- JS 파일 경로 -->
    <%@ include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>