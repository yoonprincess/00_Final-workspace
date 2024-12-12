<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>공지사항</title>
    <link rel="stylesheet" href="resources/css/helpdesk/Notice.css">
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
	    <c:if test="${ not empty sessionScope.loginUser }">
	     	<!-- 로그인 후 상태일 경우만 보여지는 글쓰기 버튼 -->
	     	<a class="btn btn-secondary" style="float:right;" 
	     								 href="NoticeEnrollForm.no">
	     		글쓰기
	     	</a>
	    </c:if>
        <h1>공지사항</h1>
        <div class="notice-search">
            <div>
                <select>
                    <option>전체</option>
                    <option>제목</option>
                    <option>내용</option>
                </select>
                <input type="text" placeholder="검색어를 입력하세요">
                <button>찾기</button>
            </div>
        </div>
        <table id="noticeList">
            <thead>
                <tr>
                    <th>글번호</th>
                    <th></th>
                    <th>내용</th>
                    <th>등록일</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="n" items="${ requestScope.list }">
                    <tr>
                        <td class="nno">${ n.noticeNo }</td>
                        <td></td>
                        <td>${ n.noticeContent }</td>
                        <td>${ n.noticeRegDate }</td>
                    </tr>
                   </c:forEach>
            </tbody>
        </table>
        <div class="pagination">
            <a href="#" class="active">1</a>
            <a href="#">2</a>
            <a href="#">3</a>
            <a href="#">4</a>
        </div>
    </div>
    </div>
    <script src="resources/js/helpdesk/Notice.js"></script> <!-- JS 파일 경로 -->
    <%@ include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>
