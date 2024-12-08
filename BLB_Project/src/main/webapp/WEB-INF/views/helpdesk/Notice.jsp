<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>공지사항 목록</title>
    <link rel="stylesheet" href="resources/css/helpdesk/Notice.css"> <!-- 스타일 시트 링크 -->
</head>
<body class="body-offset">
    
    <%@ include file="/WEB-INF/views/common/header.jsp" %>

    <div class="container-fluid">
        <div class="container">
        <h1>고객센터</h1>
		    <div class="tabs">
		        <a class="tab-button" href="Faq.blb">FAQ</a>
		        <a class="tab-button" href="list.io">1:1문의</a>
		        <a class="tab-button active" href="list.no">공지사항</a>
		    </div>
            
            <c:if test="${ not empty sessionScope.loginUser }">
            	<!-- 로그인 후 상태일 경우만 보여지는 글쓰기 버튼 -->
            	<a class="btn btn-secondary" style="float:right;" 
            								 href="NoticeEnrollForm.no">
            		글쓰기
            	</a>
            </c:if>
            
            <br>
            <br>
            <table id="noticeList" class="table table-hover" align="center">
                <thead>
                    <tr>
                        <th>글번호</th>
                        <th></th>
                        <th>내용</th>
                        <th>조회수</th>
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
            <br>

            <div id="pagingArea">
                <ul class="pagination">
	                
	                <c:choose>
	                	<c:when test="${ requestScope.pi.currentPage eq 1 }">
		                    <li class="page-item disabled">
		                    	<a class="page-link" href="#">
		                    		Previous
		                    	</a>
		                    </li>
		                </c:when>
		                <c:otherwise>
		                	<li class="page-item">
		                    	<a class="page-link" href="list.no?cpage=${ requestScope.pi.currentPage - 1 }">
		                    		Previous
		                    	</a>
		                    </li>
		                </c:otherwise>
	                </c:choose>
                    
                    <c:forEach var="p" begin="${ requestScope.pi.startPage }"
                    				   end="${ requestScope.pi.endPage }" 
                    				   step="1">
                    	<c:choose>
                    		<c:when test="${ p ne requestScope.pi.currentPage }">			   
			                    <li class="page-item">
			                    	<a class="page-link" href="list.no?cpage=${ p }">
			                    		${ p }
			                    	</a>
			                    </li>
		                    </c:when>
		                    <c:otherwise>
		                    	<li class="page-item disabled">
			                    	<a class="page-link" href="list.no?cpage=${ p }">
			                    		${ p }
			                    	</a>
			                    </li>
	                    	</c:otherwise>
	                    </c:choose>
                    </c:forEach>
                    
                    <c:choose>
                    	<c:when test="${ requestScope.pi.currentPage ne requestScope.pi.maxPage }">
                   			<li class="page-item">
                   				<a class="page-link" href="list.no?cpage=${ requestScope.pi.currentPage + 1 }">
                   					Next
                   				</a>
                   			</li>
                   		</c:when>
                   		<c:otherwise>
                   			<li class="page-item disabled">
                   				<a class="page-link" href="#">
                   					Next
                   				</a>
                   			</li>
                   		</c:otherwise>
                   	</c:choose>
                </ul>
            </div>

            <br clear="both"><br>

            <form id="searchForm" action="" method="get" align="center">
                <div class="select">
                    <select class="custom-select" name="condition">
                        <option value="writer">작성자</option>
                        <option value="title">제목</option>
                        <option value="content">내용</option>
                    </select>
                </div>
                <div class="text">
                    <input type="text" class="form-control" name="keyword">
                </div>
                <button type="submit" class="searchBtn btn btn-secondary">검색</button>
            </form>
            <br><br>
        </div>
        <br><br>
	
    </div>
	<script src="resources/js/helpdesk/Notice.js"></script> <!-- JS 파일 경로 -->
    <%@ include file="/WEB-INF/views/common/footer.jsp" %>

</body>
</html>
