<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>취소 요청 | 뷰라밸</title>

    <!-- css 파일 -->
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/order/orderCancelForm.css">
    <!-- jQuery 라이브러리 -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

</head>
<body class="body-offset">


    
    <div class="container-fluid">

        <!-- 상품 영역 -->
        <h3>취소 상품 선택</h3>
        <hr class="custom-hr">
        <div class="order-products">
            <c:choose>
                <c:when test="${not empty productList}">
                    <c:forEach var="p" items="${productList}">
                        <div class="order-product" data-opt-no="${p.optNo}">
                            <img src="${pageContext.request.contextPath}${p.thumbImg}" alt="${p.prodName}" style="width: 100px; height: 100px;">
                            <div class="product-detail">
                                <p class="product-title-${p.optNo}">${p.prodName}</p>
                                <p class="product-option-${p.optNo}" data-opt-no="${p.optNo}">
                                    옵션: ${p.optName} (+ 
                                    <fmt:formatNumber value="${p.optAddPrice}" pattern="###,###,###"/> 원) (재고: ${p.remainQty})
                                </p>
                                <p class="product-price-${p.optNo}" data-prod-price="${p.prodPrice}">
                                    상품 가격: <fmt:formatNumber value="${p.prodPrice}" />원
                                </p>
                                <p class="product-quantity-${p.optNo}" data-quantity="${p.orderQty}">
                                    수량: ${p.orderQty}개
                                </p>
                            </div>
                        </div>
                        <hr class="custom-hr">
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <p>취소 가능한 상품이 없습니다.</p>
                </c:otherwise>
            </c:choose>
        </div>

        <!-- 취소 사유 선택 -->
        <h3>취소사유 선택</h3>
        <hr class="custom-hr">
        <table class="refund-reason">
            <tr>
                <td>사유 <span class="required">*</span></td>
                <td>
                    <select id="reasonSelect">
                        <option value="">[필수] 사유를 선택해주세요</option>
                        <option value="단순 변심">단순 변심</option>
                        <option value="오배송">오배송</option>
                        <option value="상품 문제">상품 문제</option>
                    </select>
                </td>
            </tr>
        </table>

        <!-- 환불 내역 -->
        <h3>환불내역</h3>
        <hr class="custom-hr">
        <div class="refund-details">
            <table>
                <thead>
                    <tr>
                        <th>환불 금액</th>
                        <th>할인 금액 차감</th>
                        <th>포인트 반환</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td id="refundAmount">${order.orderTotalAmt}</td>
                        <td>0원</td>
                        <td>0원</td>
                    </tr>
                </tbody>
            </table>
        </div>
        <p style="text-align: right;">${order.paymentMethod} 결제 취소</p>
        <hr class="custom-hr">


        <!-- 버튼 영역 -->
        <div class="action-buttons">
            <a onclick="history.back()" class="btn btn-secondary">이전으로</a></button>
            <a href="${ pageContext.request.contextPath }/cancelCompeleteView.or" class="btn btn-primary">취소신청</a>
        </div>
    </div>
    

    <!-- js 파일 -->
    <script src="${pageContext.request.contextPath}/resources/js/order/orderCancelForm.js"></script>
</body>
</html>
