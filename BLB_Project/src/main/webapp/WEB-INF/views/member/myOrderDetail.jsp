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
            	<div class="tab">상세정보</div>
        </div>
        <div class="order-info">
            <div class="order-date">구매일자 : <span>${olist[0].orderDate}</span></div>
            <div class="order-type">주문번호 : <span>${olist[0].orderNo}</span></div>
        </div>

        <section class="product-list">
            <table>
                <thead>
                    <tr>
                        <th style="text-align : center;">상품명</th>
                        <th>판매가</th>
                        <th>수량</th>
                        <th>구매가</th>
                        <th>적립금액</th>
                    </tr>
                </thead>
                <tbody>
                
                <c:forEach var="order" items="${olist}">
                 <c:forEach var="productOrder" items="${order.productOrder}">
            		<c:forEach var="option" items="${productOrder.option}">
            		<c:forEach var ="product" items="${option.product}">
	                    <tr>
	                 
	                        <td class="product-info">
	                            <a href="detail.pr?pno=${product.prodNo}">
	                            <div class="product">
		                            <div class="product-image">
										<img src="${request.contextPath}/${product.thumbImg}" alt="${product.prodName}">
		                            </div>
		                            <div class="product-details">
		                                <p class="name">${product.prodName}</p>
		                                <p class="option">옵션 | ${option.optName}</p>
		                            </div>
		                         </div>
	                            </a>
	                        </td>
	                     
	                        <td>
	                        	<fmt:formatNumber value="${product.prodPrice}" type="number"/><span class="unit">원</span>
	                        </td>
	                        <td>${productOrder.orderQty}</td>
	                        <td>
	                        	<fmt:formatNumber value="${productOrder.totalAmt}" type="number"/><span class="unit">원</span>	
	                        </td>
	                        <td>
	                        	<fmt:formatNumber value="${fn:substringBefore(Math.floor(productOrder.totalAmt * 0.01), '.')}" type="number" /> p
	                        </td>
	                    </tr>
	                    </c:forEach>
                     </c:forEach>
                   </c:forEach>
                  </c:forEach>
                </tbody>
            </table>
        </section>

        <section class="payment-info">
		    <h2>결제 정보</h2>
		    <div class="payment-grid">
		        <div class="payment-column">
		            <div class="column-title">총상품금액</div>
		            <div class="amount">
		            	<fmt:formatNumber value="${olist[0].orderTotalAmt}" type="number"/>	<span class="unit">원</span>
		            </div>
		        </div>
		        <div class="payment-column">
		            <div class="column-title">쿠폰할인금액</div>
		            <div class="amount">0<span class="unit">원</span></div>
		        </div>
		        <div class="payment-column">
		            <div class="column-title">결제</div>
		            <div class="amount">
		            	<fmt:formatNumber value="${olist[0].orderTotalAmt}" type="number"/>	<span class="unit">원</span>
		            </div>
		            <div class="payment-details">
		                <div class="detail-row">
		                    
		                </div>
		                <div class="detail-row">
		                    <span class="detail-label">└ ${olist[0].paymentMethod}</span>
		                    <span class="detail-amount">${olist[0].orderTotalAmt}원</span>
		                </div>
		            </div>
		        </div>
		    </div>
		</section>
		<section class="total-payment">
		    <div class="total-row">
		        <span class="total-label">총 결제금액</span>
		        <span class="total-amount">
		        	<fmt:formatNumber value="${olist[0].orderTotalAmt}" type="number"/>	<span class="unit">원</span>
		        </span>
		    </div>
		</section>
		<c:if test="${not empty olist[0].refundDate}">
		<section class="payment-info">
		    <h2>환불 정보</h2>
		    <div class="payment-grid">
		        <div class="payment-column">
		            <div class="column-title">총상품금액</div>
		            <div class="amount">
		            	<fmt:formatNumber value="${olist[0].orderTotalAmt}" type="number"/>	<span class="unit">원</span>
		            </div>
		        </div>
		        <div class="payment-column">
		            <div class="column-title">배송비</div>
		            <div class="amount">0<span class="unit">원</span></div>
		        </div>
		        <div class="payment-column">
		            <div class="column-title">결제</div>
		            <div class="amount">
		            	<fmt:formatNumber value="${olist[0].orderTotalAmt}" type="number"/>	<span class="unit">원</span>
		            </div>
		            <div class="payment-details">
		                <div class="detail-row">
		                  
		                </div>
		                <div class="detail-row">
		                  
		                    <span class="detail-amount">19,020원</span>
		                </div>
		            </div>
		        </div>
		    </div>
		</section>
		<section class="total-payment">
		    <div class="total-row">
		        <span class="total-label">총 환불금액</span>
		        <span class="total-amount">
		        	<fmt:formatNumber value="${olist[0].orderTotalAmt}" type="number"/>	<span class="unit">원</span>
		        </span>
		    </div>
		</section>
		</c:if>
		
		<div class="btn-container">
			<button class="confirm-btn" onclick="history.back();" >확인</button>
		</div>
        
      </div>

	 </div>
   </div>
  <%@ include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>