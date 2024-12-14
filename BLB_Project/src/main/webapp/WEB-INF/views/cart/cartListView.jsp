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
<!-- css 파일 프리뷰 확인용 -->
<!-- <link rel="stylesheet" type="text/css" href="../../../resources/css/cart/cartListView.css"> -->
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
						<td colspan="6">장바구니가 비었습니다.</td>
					</tr>
				</c:if>
				<c:forEach var="ct" items="${ requestScope.list }">
	                <tr>
	                    <td><input type="checkbox" class="check-one" name="check-one" value="${ ct.cartNo }" checked></td>
	                    <td><img src="" alt="${ ct.prodName }" class="product-image"></td>
	                    <td class="product-info">
	                        <div class="product-detail">
	                            <p class="product-title">${ ct.prodName }</p>
	                            <p class="product-option">[옵션: ${ ct.optName }]</p>
	                            <p class="product-quantity">수량: ${ ct.cartQty }</p>
	                            <p class="product-price">
	                            	<fmt:formatNumber pattern="###,###,###" value="${ ct.prodPrice }" />원
	                            </p>
	                        </div>

							<!-- 옵션 선택 -->
							<select class="sel-prod-opt"
									name="newOptNo"
									data-cart-no="${ ct.cartNo }">

								<option selected>- [필수] 옵션을 선택해 주세요. -</option>
								<c:forEach var="opt" items="${ ct.optionList }">
									<option value="${ opt.optNo }">${ opt.optName }</option>
								</c:forEach>
								
							</select>

	                    </td>
	                    <td>
	                    	
	                        <div class="item-quantity">
	                            <span class="quantity-decrease">-</span>
	                            <input type="text" value="1" class="quantity-input" readonly>
	                            <span class="quantity-increase">+</span>
	                        </div>
	                        
	                    </td>
	                    <td class="product-price" id="product-total-price">21,800원</td>
	                    <td class="delete-btn-td">
	                    	<button class="btn-delete" onclick="deleteCartItem(${ ct.cartNo });">X</button>
	                    </td>
	                </tr>
				</c:forEach>
            </tbody>
        </table>
        
        <form id="deleteCart" action="${ pageContext.request.contextPath }/delete.ct" method="post">
		    <input type="hidden" name="cartNo" id="delCartNo">
		</form>

        <!-- 장바구니 결제 예정 금액 영역 -->
        <table id="cart-price">
            <thead>
                <tr>
                    <th>총 상품 금액</th>
                    <th></th>
                    <th>총 배송비</th>
                    <th></th>
                    <th style="font-weight: bold;">결제 예정 금액</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>97,600원</td>
                    <td>+</td>
                    <td>0원</td>
                    <td>=</td>
                    <td id="total-price">97,600원</td>
                </tr>
            </tbody>
        </table>

    </div>

<!-- JS 파일 -->
<script src="resources/js/cart/cart.js"></script>
</body>
</html>