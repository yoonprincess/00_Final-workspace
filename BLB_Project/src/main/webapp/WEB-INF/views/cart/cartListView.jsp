<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="resources/css/cart/cartListView.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<title>장바구니</title>
</head>
<body class="body-offset">

    <jsp:include page="../common/header.jsp"/>

    <div class="outer" align="center">

        <h2>장바구니</h2>
        
        <hr>

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
                    <td><img src="..." class="rounded mx-auto d-block" alt="..."></td>
                    <td class="product-info">
                        ${ requestScope.c.cartNo } <br>
                        <small>${requestScope.c.optName }</small><br>
                        <button class="btn-option">옵션변경</button>
                    </td>
                    <td>
                        <div class="item-quantity">
                            <span class="quantity-decrease">-</span>
                            <input type="text" value="1" class="quantity-input" readonly>
                            <span class="quantity-increase">+</span>
                        </div>
                    </td>
                    <td>21,800원</td>
                    <td class="delete-btn-td"><button class="btn-delete">X</button></td>
                </tr>
                <tr>
                    <td><input type="checkbox" checked></td>
                    <td><img src="..." class="rounded mx-auto d-block" alt="..."></td>
                    <td class="product-info">
                        [현장수령] 기초톤+4라인 1+1SET 특가<br>
                        <small>[옵션: 베스트톤 스크럽세트 (44% 할인) 1개 + 스크럽킷 3+SET (+58,000)]</small><br>
                        <button class="btn-option">옵션변경</button>
                    </td>
                    <td>
                        <div class="item-quantity">
                            <span class="quantity-decrease">-</span>
                            <input type="text" value="1" class="quantity-input" readonly>
                            <span class="quantity-increase">+</span>
                        </div>
                    </td>
                    <td>75,800원</td>
                    <td class="delete-btn-td"><button class="btn-delete">X</button></td>
                </tr>
            </tbody>
        </table>

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