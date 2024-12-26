<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>주문 취소 | 뷰라밸</title>

    <!-- css 파일 -->
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/order/orderCancelCompleteView.css">
    <!-- jQuery 라이브러리 -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

</head>
<body class="body-offset">

    <jsp:include page="../common/header.jsp" />

    <div class="cancel-container">
        <h1 class="cancel-title">
            주문취소가 <span style="color: #7AB2D3;">완료</span>되었습니다.
        </h1>
        <p class="cancel-message">
            신용카드 결제 취소 시 바로 환불 가능하며,<br>
            계좌이체/무통장 입금일 경우 취소신청 후 영업일 기준 3~7일 이내에 결제금액 환불처리가 됩니다.<br>
            자세한 문의사항은 고객센터(1522-0882) 또는 1:1 상담으로 문의주시기 바랍니다.
        </p>
        <div class="action-buttons">
            <a class="btn btn-primary blb-btn" href="${pageContext.request.contextPath}/orderList.me">취소 내역 조회</a>
        </div>
    </div>
    
    <jsp:include page="../common/footer.jsp" />

</body>
</html>