<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>주문 완료 | 뷰라밸</title>
    <!-- <link rel="stylesheet" type="text/css" href="<c:url value='resources/css/order/orderSuccess.css'/>"> -->
    <link rel="stylesheet" type="text/css" href="../../../resources/css/order/orderSuccess.css">
</head>
<body class="body-offset">

    <jsp:include page="../common/header.jsp" />

    <div class="order-success-container">
        <h1>
            주문이 <span style="color: #7AB2D3;">완료</span>되었습니다.
        </h1>
        <div id="orderNo">
            주문번호: <span>202412081111</span>
        </div>
    </div>
    <jsp:include page="../common/footer.jsp" />

</body>
</html>