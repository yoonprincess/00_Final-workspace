<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title> 뷰라밸 (Beauty Life Balance)</title>
<link rel="stylesheet" href="resources/css/member//myOrderDetail.css">

<script src="resources/js/member/myReviewList.js" defer></script>   

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.0/css/all.min.css" integrity="sha512-10/jx2EXwxxWqCLX/hHth/vu2KY3jCF70dCQB8TSgNjbCVAC/8vai53GfMDrO2Emgwccf2pJqxct9ehpzG+MTw==" crossorigin="anonymous" referrerpolicy="no-referrer" />

</head>
<body class="body-offset">
<div class="outer container-fluid">
 <%@ include file="/WEB-INF/views/common/header.jsp" %> 
 <div id="main">
   <%@ include file="/WEB-INF/views/member/menubar.jsp" %>
    <div class="container">
      	<div class="tabs">
            	<div class="tab">상품정보</div>
        </div>
        <div class="order-info">
            <div class="order-date">구매일자 : <span>2024.09.14</span></div>
            <div class="order-type">주문번호 : <span>1</span></div>
        </div>

        <section class="product-list">
            <table>
                <thead>
                    <tr>
                        <th>상품명</th>
                        <th>판매가</th>
                        <th>수량</th>
                        <th>구매가</th>
                        <th>적립금액</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td class="product-info">
                            <div class="product-image">
                                <img src="/placeholder.svg" alt="제품 이미지">
                            </div>
                            <div class="product-details">
                                <p class="brand">웨이크메이크</p>
                                <p class="name">[NEW] 웨이크메이크 워터 글로우 프릭틴트</p>
                            </div>
                        </td>
                        <td>36,000원</td>
                        <td>1</td>
                        <td>25,200원</td>
                        <td>매장구매위시</td>
                    </tr>
                </tbody>
            </table>
        </section>

        <section class="payment-info">
		    <h2>결제 정보</h2>
		    <div class="payment-grid">
		        <div class="payment-column">
		            <div class="column-title">총상품금액</div>
		            <div class="amount">25,200<span class="unit">원</span></div>
		        </div>
		        <div class="payment-column">
		            <div class="column-title">쿠폰할인금액</div>
		            <div class="amount">0<span class="unit">원</span></div>
		        </div>
		        <div class="payment-column">
		            <div class="column-title">결제</div>
		            <div class="amount">25,200<span class="unit">원</span></div>
		            <div class="payment-details">
		                <div class="detail-row">
		                    <span class="detail-label">└ 적립금</span>
		                    <span class="detail-amount">6,180원</span>
		                </div>
		                <div class="detail-row">
		                    <span class="detail-label">└ 신용카드</span>
		                    <span class="detail-amount">19,020원</span>
		                </div>
		            </div>
		        </div>
		    </div>
		</section>
		<section class="total-payment">
		    <div class="total-row">
		        <span class="total-label">총 결제금액</span>
		        <span class="total-amount">25,200<span class="unit">원</span></span>
		    </div>
		</section>

        <p class="notice">* 매장에서 구매하신 상품의 교환 및 환불은 온라인 구매확인증으로 불가능합니다.</p>
		
		<div class="btn-container">
			<button class="confirm-btn" >확인</button>
		</div>
        
      </div>

	 </div>
   </div>
  <%@ include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>