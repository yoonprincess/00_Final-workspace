<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>공지사항 상세보기</title>
    <link rel="stylesheet" href="../resources/css/helpdesk/NoticeDetailView.css"> <!-- 스타일 시트 링크 -->
</head>
<body class="body-offset">
<%@ include file="/WEB-INF/views/common/header.jsp" %>
    <div class="container-fluid">
    <div class="container">
        <div class="notice-detail">
            <div class="notice-header">
                <h2 class="notice-title">${ requestScope.n.noticeTitle }</h2>
                <div class="notice-meta">
                    <span class="author">작성자: BLB 관리자</span>
                    <span class="date">${ requestScope.n.noticeRegDate }</span>
                </div>
            </div>

            <div class="notice-content">
                <div class="text-content">
                    <p>${ requestScope.n.noticeContent }</p>
                    <br>
                    <c:choose>
                   		<c:when test="${ empty requestScope.na }">
                   		    첨부파일이 없습니다.
                   		</c:when>
                   		<c:otherwise>
                   			<c:forEach var="a" items="${ requestScope.na }">
                   				<img src="${pageContext.request.contextPath }/${ a.savePath }${a.saveFileName}" width="1200px;">
                   			</c:forEach>
                   		</c:otherwise>
                   	</c:choose>
                </div>
            </div>

            <div class="notice-footer">
                <button type="button" class="btn btn-back" onclick="goList();">목록</button>
                    
                </div>
                
                <c:if test="${ sessionScope.loginUser.memberId eq 'admin' }">
	            <div align="center">
	                <!-- 수정하기, 삭제하기 버튼은 이 글이 본인이 작성한 글일 경우에만 보여져야 함 -->
	                <button type="button" class="btn btn-edit" onclick="postFormSubmit(1);">수정</button>
	                <button type="button" class="btn btn-delete" onclick="postFormSubmit(2);">삭제</button>
	            </div>
	            
	            <form id="postForm" action="" method="post">
	            	<input type="hidden" 
	            		   name="nno" 
	            		   value="${ requestScope.n.noticeNo }">
	            	<input type="hidden"
	            		   name="filePath"
	            		   value="${ requestScope.a.saveFileName }">
	            		   
	            </form>
	            
	            <script>
	            function postFormSubmit(num) {
	                if (num === 1) { // 수정하기를 클릭했을 경우
	                    $("#postForm").attr("action", "../NoticeUpdateForm.no").submit();
	                } else { // 삭제하기를 클릭했을 경우
	                    if (confirm("삭제하시겠습니까?")) { // 사용자 확인
	                        $("#postForm").attr("action", "../NoticeDelete.no").submit();
	                        alert("공지사항이 삭제되었습니다.")
	                    } else {
	                        return "redirect://../NoticeUpdateForm.no";
	                    }
	                }
	            }
	            </script>
            </c:if>
            </div>
        </div>
    </div>
    
    </div>
    <%@ include file="/WEB-INF/views/common/footer.jsp" %>

    <script>
        // 관리자 확인 및 버튼 표시 로직
        const isAdmin = localStorage.getItem('userId') === 'admin';
        const adminControls = document.getElementById('adminControls');
        if (isAdmin) {
            adminControls.style.display = 'flex';
        }
        
        function goList(){
        	location.href="../list.no";
        }
    </script>
</body>
</html>

