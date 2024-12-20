<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>문의 상세</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/helpdesk/InquiryDetailView.css"> <!-- 스타일 시트 링크 -->
</head>
<body class="body-offset">
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<div class="container-fluid">
    <div class="container">
        <h2>문의사항 상세 보기</h2>

        <!-- 상단 내비게이션 -->
        <nav>
            <ul>
                <li><a href="${ pageContext.request.contextPath }/list.io">목록</a></li>
                
            </ul>
        </nav>

        <!-- 문의내용 -->
        <div class="inquiry-detail">
            <h3>문의 내용</h3>
            <p><strong>상품명:</strong> ${requestScope.i.prodName }</p>
            <p><strong>문의번호:</strong> ${requestScope.i.inquiryNo}</p>
            <p><strong>문의자:</strong> ${requestScope.i.memberId}</p>
            <p><strong>문의일:</strong> ${requestScope.i.inquiryCreateDate}</p>
            <p><strong>내용:</strong></p>
            
            <div class="text-content">
                <p>${ requestScope.i.inquiryContent }</p>
                <br>
                <c:choose>
               		<c:when test="${ empty requestScope.iatt }">
               		    첨부파일이 없습니다.
               		</c:when>
               		<c:otherwise>
               			<c:forEach var="p" items="${ requestScope.iatt }">
               				<img src="${pageContext.request.contextPath }/${ p.savePath }${p.saveFileName}" width="1200px;">
               			</c:forEach>
               		</c:otherwise>
               	</c:choose>
            </div>
        </div>

        <!-- 댓글 섹션 -->
        <div class="comments-section">
            <h3>댓글</h3>

            <!-- 댓글 목록 -->
            <table id="commentsTable">
                <thead>
                </thead>
                <tbody>
                    <c:forEach var="ir" items="${requestScope.inquiryReply}">
                        <tr>
                            <td>${ir.inquiryReplyNo}</td>
                            <td>${ir.inquiryReplyContent}</td>
                            <td>${ir.inquiryReplyCreateDate}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
			
			<!-- 댓글 작성  -->
            <table id="replyArea" class="table" align="center">
                <thead>
                    <tr>
                    	<c:choose>
                    		<c:when test="${ empty sessionScope.loginUser}">
                    			<!-- 로그인 전 : 댓글 작성 막기 -->
		                        <th colspan="2">
		                            <textarea class="form-control" cols="55" rows="2" 
		                            		  style="resize:none; width:100%;" readonly>로그인한 사용자만 이용 가능한 서비스입니다. 로그인 후 이용 바랍니다.</textarea>
		                        </th>
		                        <th style="vertical-align:middle"><button class="btn btn-secondary" disabled>등록하기</button></th>
                    		</c:when>
                    		<c:otherwise>
                    			<!-- 로그인 후 : 댓글 작성 풀기 -->
                    			<tr>
			                        <td colspan="3">댓글(<span id="rcount">0</span>)</td>
			                    </tr>
			                    <tr>
			                        <th>작성자</th>
			                        <th>내용</th>
			                        <th>작성일</th>
			                    </tr>
                    			<th colspan="2">
		                            <textarea class="form-control" id="inquiryReplyContent" cols="55" rows="2" style="resize:none; width:100%;"></textarea>
		                        </th>
		                        <th style="vertical-align:middle">
		                        	<button class="btn btn-secondary" onclick="addReply();">
		                        		등록하기
		                        	</button>
		                        	<input type="hidden" name="ino" value="${requestScope.ir.inquiryNo}">
		                        	<input type="hidden" name="inquiryReplyNo" value="${requestScope.ir.inquiryReplyNo }">
		                        	<input type="hidden" name="memberId" value="${requestScope.ir.memberId }">
		                        </th>
                    		</c:otherwise>
                    	</c:choose>
                    </tr>
                </thead>
                <tbody>
                </tbody>
            </table>
        </div>
    </div>
    	<form action="${ pageContext.request.contextPath }/InquiryUpdateForm.io" method="post">
        	<input type="hidden" name="ino" value="${requestScope.i.inquiryNo}">
        	<button type="submit">수정</button>                	
        </form>
        <form action="${ pageContext.request.contextPath }/InquiryDelete.io" method="post">
        	<input type="hidden" name="ino" value="${requestScope.i.inquiryNo}">
        	<button type="submit">삭제</button>                	
        </form>
	</div>
	
	<script>
   	$(function() {
   		
   		selectReplyList();
   		
   		// 실시간 댓글 등록 효과
   		setInterval(selectReplyList, 1000);
   	});
   	
   	// 댓글 작성용 함수
   	function addReply() {
   		let replyContent = $("#inquiryReplyContent").val();
   		if(replyContent.trim().length != 0) {
   			
   			$.ajax({
   				url : "../rinsert.io",
   				type : "post",
   				data : {
   					inquiryReplyContent : replyContent,
   					memberId : "${ sessionScope.loginUser.memberId}",
   					inquiryNo : ${ requestScope.i.inquiryNo }
   				},
   				success : function(result) {
   					
   					if(result == "success") {
   						
   						selectReplyList();
   						$("#inquiryReplyContent").val("");
   						
   					} else {
   						
   						alertify.alert("Alert", "댓글 작성 실패");
   						$("#inquiryReplyContent").val("");
   					}
   					
   				},
   				error : function() {
   					console.log("댓글 작성용 ajax 통신 실패!");
   				}
   			});
   			
   		} else {
   			// 댓글 내용이 없는 경우
   			// > alert 로 알려주기
   			
   			alertify.alert("Alert", "댓글 작성 후 등록해주세요.");
   		}
   	}
   	
   	// 댓글 목록 조회용 함수
   	function selectReplyList() {
   		
   		$.ajax({
   			url : "../rlist.io",
   			type : "get",
   			data : {
   				ino : ${ requestScope.i.inquiryNo }
   			},
   			success : function(result) {
   				
   				let resultStr = "";
   				
   				for(let r = 0; r < result.length; r++) {
   					
   					resultStr += "<tr>"
   									+ "<th>" + result[r].memberId + "</th>"
   									+ "<td>" + result[r].inquiryReplyContent + "</td>"
   									+ "<td>" + result[r].inquiryReplyCreateDate + "</td>"
   							   + "</tr>";
   				}
   				
   				$("#replyArea>tbody").html(resultStr);
   				$("#rcount").text(result.length);
   				
   			},
   			error : function() {
   				console.log("댓글리스트 조회용 ajax 통신 실패!");
   			}
   		});
   	}
    </script>
	
	
    <script src="${pageContext.request.contextPath}/resources/js/helpdesk/Inquiry.js"></script> <!-- JS 파일 경로 -->
	<%@ include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>