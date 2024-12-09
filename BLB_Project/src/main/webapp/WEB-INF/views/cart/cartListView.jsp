<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>장바구니 | 뷰라밸</title>
<link rel="stylesheet" type="text/css" href="${ pageContext.request.contextPath }/resources/css/cart/cartListView.css">
<!-- <link rel="stylesheet" type="text/css" href="../../../resources/css/cart/cartListView.css"> -->
<!-- 부트스트랩 -->
<!-- <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous"> -->
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
                    <th><input type="checkbox" checked colspan="4"></th>
                    <th>전체선택</th>
                    <th colspan="3"></th>
                    <th class="delete-btn-td"><button id="select-detlete">선택 삭제</button></th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td><input type="checkbox" checked></td>
                    <td><img src="set_product.jpg" alt="기초 & 선라인 세트" class="product-image"></td>
                    <td class="product-info">
                        <div class="product-detail">
                            <p class="product-title">[한정수량] 기초&선라인 1+1SET 특가</p>
                            <p class="product-option">[옵션: 01. 블랙티 스크럽밤 [44%▼]/[44%▼] 스크럽밤 3+3SET (+58,000)]</p>
                            <p class="product-quantity">수량: 1개</p>
                            <p class="product-price">75,800원</p>
                        </div>
                        <select>
                            <option checked>- [필수] 옵션을 선택해 주세요. -</option>
                            <option>01. 선크림</option>
                            <option>02. 선스틱</option>
                        </select>
                    </td>
                    <td>
                        <div class="item-quantity">
                            <span class="quantity-decrease">-</span>
                            <input type="text" value="1" class="quantity-input" readonly>
                            <span class="quantity-increase">+</span>
                        </div>
                    </td>
                    <td class="product-price">21,800원</td>
                    <td class="delete-btn-td"><button class="btn-delete">X</button></td>
                </tr>
                <tr>
                    <td><input type="checkbox" checked></td>
                    <td><img src="lipbalm.jpg" alt="립밤 세트" class="product-image"></td>
                    <td class="product-info">
                        <div class="product-detail">
                            <p class="product-title">립밤 세트</p>
                            <p class="product-option">[옵션: 내 맘대로 골라담기 SET (44%▼)/립밤 1+1개 ★27% 할인★/내추럴 레드 2개]</p>
                            <p class="product-quantity">수량: 1개</p>
                            <p class="product-price">21,800원</p>
                        </div>
                        <select>
                            <option>- [필수] 옵션을 선택해 주세요. -</option>
                            <option>01. 선크림</option>
                            <option>02. 선스틱</option>
                        </select>
                    </td>
                    <td>
                        <div class="item-quantity">
                            <span class="quantity-decrease">-</span>
                            <input type="text" value="1" class="quantity-input" readonly>
                            <span class="quantity-increase">+</span>
                        </div>
                    </td>
                    <td class="product-price">75,800원</td>
                    <td class="delete-btn-td"><button class="btn-delete">X</button></td>
                </tr>
            </tbody>
        </table>

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


</body>
</html>