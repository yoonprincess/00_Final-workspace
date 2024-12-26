<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>주문 완료 | 뷰라밸</title>

    <link rel="stylesheet" type="text/css" href="${ pageContext.request.contextPath }/resources/css/order/orderCompleteView.css">
    <!-- jQuery 라이브러리 -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    
</head>
<body class="body-offset">

    <div class="container-fluid">
        <!-- <form action="orderComplete.or?paymentCode=" method="get"> -->
            <!-- 주문 완료 안내 문구 영역 -->
            <div class="order-complete">
                <h1>
                    주문이 <span style="color: #7AB2D3;">완료</span>되었습니다.
                </h1>
                <div id="orderNo">
                    <c:set var="merchantUid" value="${sessionScope.merchantUid}" />
                    주문번호: <span>${sessionScope.merchantUid}</span>
                </div>
            </div>
    
            <!-- 결제 정보 영역 -->
            <div class="payment-info-container">
                <h3 class="payment-title">결제 정보</h3>
                <table class="payment-table">
                    <tbody>
                        <tr>
                            <td>총 상품 금액</td>
                            <td class="amount"
                                id="total-amt"
                                data-total-amt="${sessionScope.totalAmt}">
                                <fmt:formatNumber value="${totalAmt}" pattern="###,###,###" />원
                            </td>
                        </tr>
                        <tr>
                            <td>총 배송비</td>
                            <td class="amount" id="dlvr-fee">
                                <fmt:formatNumber value="${order.dlvrFee}" pattern="###,###,###" />원
                            </td>
                        </tr>
                        <tr>
                            <td>할인 금액</td>
                            <td class="amount negative">
                                <p id="discount"></p>
                            </td>
                        </tr>
                    </tbody>
                    <tfoot>
                        <tr class="final-payment">
                            <td class="final-title">최종 결제 금액</td>
                            <td class="final-amount">
                                <div class="final-amount"
                                     id="order-total-amt">
                                    <fmt:formatNumber value="${order.orderTotalAmt}" pattern="###,###,###" />원
                                </div>
                                <div class="payment-method">${order.paymentMethod}</div>
                            </td>
                        </tr>
                        <tr class="pointAmt">
                            <td>구매 추가 적립</td>
                            <td class="amount positive">
                                <p id="point-amt"></p>
                            </td>
                        </tr>
                    </tfoot>
                </table>
            </div>
    
            <!-- 베송 정보 영역 -->
            <div class="delivery-info-container">
                <h3 class="delivery-title">배송정보</h3>
                <table class="delivery-table">
                    <tbody>
                        <tr>
                            <th>받는 분</th>
                            <td>${order.rcvrName}</td>
                        </tr>
                        <tr>
                            <th>연락처</th>
                            <td>${order.rcvrPhone}</td>
                        </tr>
                        <tr>
                            <th>주소</th>
                            <td>${order.rcvrAddress}</td>
                        </tr>
                        <tr>
                            <th>배송 요청 사항</th>
                            <td>${order.dlvrReqMessage}</td>
                        </tr>
                    </tbody>
                </table>
            </div>
    
            <!-- 결제 확정 영역 -->
            <div class="order-footer-container">
                <p class="order-note">
                    ・ 주문취소는 [결제완료] 상태까지 가능합니다. [배송준비중], [배송중]에는 상품 수령 후 반품요청 부탁드립니다.
                </p>
                <div class="action-buttons">
                    <a href="${ pageContext.request.contextPath }/list.pr" class="btn btn-secondary">쇼핑 계속</a></button>
                    <a href="${ pageContext.request.contextPath }/orderList.me" class="btn btn-primary">주문 내역 조회</a>
                </div>
            </div>
        <!-- </form> -->
        <c:set var="checkedCartNos" value="${sessionScope.checkedCartNos}" />
    </div>

<!-- js 파일 -->
<script src="resources/js/order/orderCompleteView.js"></script>    
</body>
</html>