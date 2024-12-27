<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>공지사항 상세보기</title>
    <link rel="stylesheet" href="${ pageContext.request.contextPath }/resources/css/helpdesk/NoticeDetailView.css">
</head>
<body class="body-offset">
<%@ include file="/WEB-INF/views/common/header.jsp" %>
    <div class="container-fluid">
    <div class="container">
    <div class="notice-header">
    <br><br>
        <h1 class="notice-title">
            <span class="badge">공지</span>
            ${ requestScope.n.noticeTitle }
        </h1>
        <div class="notice-date">${ requestScope.n.noticeRegDate }</div>
    </div>

    <div class="notice-content">
        <div class="text-content">
           <p>${ requestScope.n.noticeContent }</p>
           <c:choose>
               <c:when test="${ empty requestScope.na }">
               </c:when>
               <c:otherwise>
                   <c:forEach var="a" items="${ requestScope.na }">
					    <div class="attachment-img-container">
					        <img src="${pageContext.request.contextPath }/${ a.savePath }${a.saveFileName}" 
					             alt="첨부된 파일 이미지" 
					             class="attachment-img">
					    </div>
					</c:forEach>

               </c:otherwise>
           </c:choose>
       </div>
    </div>

    <c:if test="${ sessionScope.loginUser.memberId eq 'admin' }">
                    <div align="center">
                        <button type="button" class="btn btn-edit" onclick="postFormSubmit(1);">수정</button>
                        <button type="button" class="btn btn-delete" onclick="postFormSubmit(2);">삭제</button>
                    </div>
                    <form id="postForm" action="" method="post">
                        <input type="hidden" name="nno" value="${ requestScope.n.noticeNo }">
                        <input type="hidden" name="filePath" value="${ requestScope.a.saveFileName }">
                    </form>
                    <script>
                    function postFormSubmit(num) {
                        if (num === 1) { 
                            $("#postForm").attr("action", "../NoticeUpdateForm.no").submit();
                        } else {
                            if (confirm("삭제하시겠습니까?")) { 
                                $("#postForm").attr("action", "../NoticeDelete.no").submit();
                                alert("공지사항이 삭제되었습니다.")
                            } else {
                                return "redirect://../NoticeUpdateForm.no";
                            }
                        }
                    }
                    </script>
                </c:if>
                

    <c:if test="${ previousNotice != null }">
	    <a href="${pageContext.request.contextPath}/notice/${previousNotice.noticeNo}" class="nav-item">
	        <span class="nav-label">이전글</span>
	        <span class="nav-title">${previousNotice.noticeTitle}</span>
	    </a>
	</c:if>
	<c:if test="${ nextNotice != null }">
	    <a href="${pageContext.request.contextPath}/notice/${nextNotice.noticeNo}" class="nav-item">
	        <span class="nav-label">다음글</span>
	        <span class="nav-title">${nextNotice.noticeTitle}</span>
	        <span class="badge-new">NEW</span>
	    </a>
	</c:if>

    <div class="button-container">
        <button type="button" class="list-button" onclick="goBack();">목록보기</button>
    </div>
    </div>
    </div>
    <script src="${ pageContext.request.contextPath }/resources/js/helpdesk/Notice.js"></script>
    <%@ include file="/WEB-INF/views/common/footer.jsp" %>

</body>
</html>