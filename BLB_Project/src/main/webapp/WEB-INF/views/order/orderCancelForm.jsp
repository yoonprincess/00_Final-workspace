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
                            <input type="hidden" id="orderNo" value="${p.orderNo}">
                            <img src="${pageContext.request.contextPath}${p.thumbImg}" alt="${p.prodName}" style="width: 100px; height: 100px;">
                            <div class="product-detail">
                                <p class="product-title-${p.optNo}">${p.prodName}</p>
                                <p class="product-option-${p.optNo}"
                                   data-opt-no="${p.optNo}">
                                    옵션: ${p.optName} (+ 
                                    <fmt:formatNumber value="${p.optAddPrice}" /> 원) (재고: ${p.remainQty})
                                </p>
                                <p class="product-price-${p.optNo}"
                                   data-prod-price="${p.prodPrice}">
                                    상품 가격: <fmt:formatNumber value="${p.prodPrice}" />원
                                </p>
                                <p class="product-quantity-${p.optNo}"
                                   data-order-qty="${p.orderQty}">
                                    수량: ${p.orderQty}개
                                </p>
                                <p class="product-total-amt-${p.optNo}"
                                   data-total-amt="${p.totalAmt}"
                                   style="font-weight: bold;">
                                   <fmt:formatNumber value="${p.totalAmt}" />원
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
                        <option value="">[필수] 사유를 선택해 주세요.</option>
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
        <table id="refund-details">
            <tbody>
                <tr>
                    <td>
                        <p>환불 금액</p>
                        <p class="value" id="refundAmount">0원</p>
                    </td>
                    <td></td>
                    <td>
                        <p>할인 금액 차감</p>
                        <p class="value" id="refundDiscount">0원</p>
                    </td>
                    <td></td>
                    <td>
                        <p>포인트 반환</p>
                        <p class="value" id="refuntPoint"></p>
                    </td>
                </tr>
            </tbody>
            <tfoot>
                <tr>
                    <td colspan="5" class="footer">
                        <p style="text-align: right;">${order.paymentMethod} 결제 취소</p>
                        <p class="final-total">
                            총 환불 예상 금액 최소 
                            <span class="final-refund">
                                <span style="font-size: 30px; font-weight: bold;"
                                      id="finalRefund">
                                </span>
                            </span>
                        </p>
                    </td>
                </tr>
            </tfoot>
        </table>
        <hr class="custom-hr">


        <!-- 버튼 영역 -->
        <div class="action-buttons">
            <a onclick="history.back()" class="btn btn-secondary">이전으로</a></button>
            <a class="btn btn-primary" id="submitCancel">취소신청</a>
        </div>
    </div>
    

    <!-- js 파일 -->
    <script src="${pageContext.request.contextPath}/resources/js/order/orderCancelForm.js"></script>
</body>
</html>
