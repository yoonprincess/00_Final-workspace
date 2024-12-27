<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>장바구니 | 뷰라밸</title>

<link rel="stylesheet" type="text/css" href="${ pageContext.request.contextPath }/resources/css/cart/cartListView.css">
<!-- 부트스트랩 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy" crossorigin="anonymous"></script>
<!-- jQuery 라이브러리 -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

</head>
<body class="body-offset">

	<%@ include file="/WEB-INF/views/common/header.jsp" %>

    <div class="container-fluid" align="center">

        <h2>장바구니</h2>
        
        <hr>

        <!-- 장바구니에 담은 상품 목록 -->
        <table id="cart-product">
            <thead>
                <tr>
                    <th><input type="checkbox" id="check-all" checked></th>
                    <th>전체선택</th>
                    <th colspan="3"></th>
                    <th class="delete-btn-td">
						<!-- 선택 삭제 버튼 -->
						<form id="checkDeleteForm"
							  action="${ pageContext.request.contextPath }/deleteCheck.ct"
							  method="post">
							<input type="hidden"
								   name="cartNos"
								   id="delCartNos">
						</form>
						<button type="button" id="select-detlete" onclick="checkDelete();">선택 삭제</button>
					</th>
                </tr>
            </thead>
            <tbody>
				<c:if test="${ empty list }">
					<tr>
						<td colspan="6">
							<div>
								장바구니가 비었습니다.
							</div>
						</td>
					</tr>
				</c:if>
				<c:forEach var="ct" items="${ requestScope.list }">
	                <tr>
	                    <td><input type="checkbox" class="check-one" name="check-one" value="${ct.cartNo}" checked></td>
	                    <td>
							<img src="${ pageContext.request.contextPath }${ ct.thumbImg }" alt="${ct.prodName}" class="product-image">
						</td>
	                    <td class="product-info">
	                        <div class="product-detail">
	                            <p class="product-title">${ct.prodName}</p>
	                            <p class="product-option-${ct.cartNo}">[옵션: ${ct.optName} (+ 
									<fmt:formatNumber pattern="###,###,###" value="${ct.optAddPrice}" />원)]</p>
	                            <p class="product-quantity-${ct.cartNo}">수량: ${ ct.cartQty }</p>
	                            <p class="product-price">
	                            	<fmt:formatNumber pattern="###,###,###" value="${ct.prodPrice}" />원
	                            </p>
	                        </div>

							<select id="prod-opt-${ct.cartNo}"
									class="prod-opt"
									data-cart-optno="${ct.optNo}">

								<option value="-1">- [필수] 옵션을 선택해 주세요. -</option>

								<c:forEach var="opt" items="${ ct.optionList }">
									<option class="sel-opt"
											value="${opt.optNo}"
											data-name="${opt.optName}"
											data-opt-value="${opt.optValue}"
											data-price="${opt.optAddPrice}"
											data-remainqty="${opt.remainQty}"
											data-cart-no="${ct.cartNo}">
										${opt.optName} ${opt.optValue} (+ 
										<fmt:formatNumber pattern="###,###,###" value="${opt.optAddPrice}" />원)
										(재고: ${opt.remainQty})
									</option>
								</c:forEach>

							</select>

	                    </td>
	                    <td>
							<!-- 수량 증감 -->
	                        <div class="item-quantity">
	                            <span class="quantity-decrease"
									  data-prod-price="${ct.prodPrice}"
									  data-cart-no="${ct.cartNo}">-</span>

	                            <input type="text" value="${ ct.cartQty }" class="quantity-input" readonly>
	                            <span class="quantity-increase"
									  data-prod-price="${ct.prodPrice}"
									  data-cart-no="${ct.cartNo}">+</span>
	                        </div>
	                    </td>

	                    <td class="product-price">
							<span id="updated-price-${ct.cartNo}">
								<fmt:formatNumber pattern="###,###,###" value="${ ct.prodPrice * ct.cartQty }" />원
							</span>
						</td>
	                    <td class="delete-btn-td">
	                    	<button class="btn-delete" onclick="deleteCartItem(${ ct.cartNo });">X</button>
	                    </td>
	                </tr>
				</c:forEach>
            </tbody>
        </table>
        
		<!-- 1개의 상품만 삭제할 때 form -->
        <form id="deleteCart" action="${ pageContext.request.contextPath }/delete.ct" method="post">
		    <input type="hidden" name="cartNo" id="delCartNo">
		</form>

        <!-- 장바구니 결제 예상 금액 영역 -->
        <table id="cart-price">
            <thead>
                <tr>
                    <th>총 상품 금액</th>
                    <th></th>
                    <th>배송비</th>
                    <th></th>
                    <th style="font-weight: bold;">결제 예상 금액</th>
                </tr>
            </thead>
            <tbody>
				<!-- 장바구니 총 가격 -->
                <tr>
                    <td id="total-prod-price">
						<!-- 총 상품 가격 -->
					</td>
                    <td>+</td>
                    <td id="dlvr-fee">
						<!-- 배송비 -->
					</td>
                    <td>=</td>
                    <td id="final-total"
						style="color: red;">
						<!-- 결제 예상 금액 -->
					</td>
                </tr>
            </tbody>
        </table>

		<!-- 결제하기 버튼 -->
		<form id="cartBuyForm"
			  method="POST"
			  action="${ pageContext.request.contextPath }/orderEnrollForm.or">
			<!-- 체크된 장바구니 번호들이랑 결제 예상 금액 넘기기 -->
			<input type="hidden" name="checkedCartNos" id="checkedCartNos" value="">
			<input type="hidden" name="orderTotalAmt" id="orderTotalAmt" value="">
		</form>
		<button type="button" class="btn btn-primary" id="cartBuy">
			총 <span id="checkedCartQty"></span>개 상품 구매
		</button>
		
    </div>

<!-- JS 파일 -->
<script src="resources/js/cart/cart.js"></script>
</body>
</html>