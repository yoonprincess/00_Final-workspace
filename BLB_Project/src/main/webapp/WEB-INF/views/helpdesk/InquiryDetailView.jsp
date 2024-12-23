<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>문의 상세</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/helpdesk/InquiryDetailView.css">
</head>
<body class="body-offset">
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<div class="container-fluid">
    <div class="inquiry-container">
        <br><br>
        <!-- 목록으로 가기 버튼 -->
        <div style="float:right;">
            <a href="../list.io" class="btn btn-primary">목록으로</a>
        </div>
        <h1>문의사항 상세조회</h1>
        <div class="inquiry-details">
            <c:choose>
            	<c:when test="${not empty requestScope.i.prodName}">
            		<p><span class="label">상품명:</span> ${requestScope.i.prodName}</p>
            	</c:when>
            	<c:otherwise></c:otherwise>
            </c:choose>
            <p><span class="label">문의 번호:</span> ${requestScope.i.inquiryNo}</p>
            <p><span class="label">문의자:</span> ${requestScope.i.memberId}</p>
            <p><span class="label">문의일:</span> ${requestScope.i.inquiryCreateDate}</p>
            <p><span class="label">문의내용:</span> <br><br>${requestScope.i.inquiryContent}</p>
            <c:choose>
                <c:when test="${empty requestScope.iatt}">
                    <!-- 첨부파일이 없는 경우 -->
                </c:when>
                <c:otherwise>
                    <c:forEach var="p" items="${requestScope.iatt}">
                        <img src="${pageContext.request.contextPath}/${p.savePath}${p.saveFileName}" width="1200px;">
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </div>

        <!-- 댓글 목록 섹션 -->
        <div class="comments-section">
            <table id="replyArea" class="table" align="center">
                <thead>
                    <tr>
                        <th>작성자</th>
                        <th>내용</th>
                        <th>작성일</th>
                    </tr>
                </thead>
                <tbody>
                </tbody>
            </table>
        </div>

        <!-- 댓글 작성 섹션 -->
        <div class="reply-input-section">
            <c:choose>
                <c:when test="${ empty sessionScope.loginUser}">
                    <textarea class="form-control" cols="55" rows="2" style="resize:none; width:100%;" readonly>
                        로그인한 사용자만 이용 가능한 서비스입니다. 로그인 후 이용 바랍니다.
                    </textarea>
                    <button class="btn btn-secondary" disabled>등록하기</button>
                </c:when>
                <c:otherwise>
                    <textarea class="form-control" id="inquiryReplyContent" cols="55" rows="2" style="resize:none; width:100%;"></textarea>
                    <div class="reply-buttons">
                        <button class="btn btn-secondary" onclick="addReply();">등록하기</button>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>

        
    </div>
</div>
<script>
    $(function() {
        selectReplyList();

        // 문의 내용 섹션 애니메이션
        gsap.from(".inquiry-detail", { opacity: 0, y: 50, duration: 1 });

        // 댓글 섹션 애니메이션
        gsap.from(".comments-section", { opacity: 0, y: 50, duration: 1, delay: 0.5 });

        // 댓글 목록 애니메이션
        gsap.from("#commentsTable tbody tr", { opacity: 0, y: 30, duration: 0.5, stagger: 0.2 });
        
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
                    }
                },
                error : function() {
                    console.log("댓글 작성용 ajax 통신 실패!");
                }
            });
        } else {
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

<script src="${pageContext.request.contextPath}/resources/js/helpdesk/Inquiry.js"></script>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>
