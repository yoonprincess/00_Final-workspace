<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>주문 완료 | 뷰라밸</title>
    <!-- <link rel="stylesheet" type="text/css" href="${ pageContext.request.contextPath }/resources/css/order/orderCompleteView.css"> -->
    <link rel="stylesheet" type="text/css" href="../../../resources/css/order/orderCompleteView.css">
</head>
<body class="body-offset">

    <div class="container-fluid">
        <form action="orderComplete.or" method="post">
            <!-- 주문 완료 안내 문구 영역 -->
            <div class="order-complete">
                <h1>
                    주문이 <span style="color: #7AB2D3;">완료</span>되었습니다.
                </h1>
                <div id="orderNo">
                    주문번호: <span>202412081111</span>
                </div>
            </div>
    
            <!-- 결제 정보 영역 -->
            <div class="payment-info-container">
                <h3 class="payment-title">결제 정보</h3>
                <table class="payment-table">
                    <tbody>
                        <tr>
                            <td>총 상품 금액</td>
                            <td class="amount">35,940원</td>
                        </tr>
                        <tr>
                            <td>총 배송비</td>
                            <td class="amount">0원</td>
                        </tr>
                        <tr>
                            <td>적립 금액</td>
                            <td class="amount negative">-1,460원</td>
                        </tr>
                    </tbody>
                    <tfoot>
                        <tr class="final-payment">
                            <td class="final-title">최종 결제 금액</td>
                            <td class="final-amount">
                                <div class="final-amount">34,480원</div>
                                <div class="payment-method">카카오페이</div>
                            </td>
                        </tr>
                        <tr class="pointAmt">
                            <td>구매 추가 적립</td>
                            <td class="amount positive">1,460원</td>
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
                            <th>받는분</th>
                            <td>윤예원</td>
                        </tr>
                        <tr>
                            <th>연락처</th>
                            <td>010-0000-0000</td>
                        </tr>
                        <tr>
                            <th>주소</th>
                            <td>경기도 부천시 길주로 00, 00</td>
                        </tr>
                        <tr>
                            <th>배송 요청 사항</th>
                            <td>문 앞</td>
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
                    <button class="btn btn-secondary" onclick="javascript:histoty.go(-1);">쇼핑 계속</button>
                    <a href="${ pageContext.request.contextPath }/myOrderList.me" class="btn btn-primary">주문 내역 조회</a>
                </div>
            </div>
        </form>
    </div>


</body>
</html>