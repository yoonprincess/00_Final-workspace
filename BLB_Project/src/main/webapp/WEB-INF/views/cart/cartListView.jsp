<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="orderListView.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<title>장바구니</title>
</head>
<body class="body-offset">

    <div class="outer">

        <h2>장바구니</h2>
        
        <hr>
        <br>

        <table id="cart-product">
            <thead>
                <tr>
                    <th><input type="checkbox" checked colspan="4"></th>
                    <th>전체선택</th>
                    <th colspan="3"></th>
                    <th><button id="select-detlete">선택 삭제</button></th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td><input type="checkbox" checked></td>
                    <td><img src="..." class="rounded mx-auto d-block" alt="..."></td>
                    <td class="product-info">
                        립밤 세트 최대 44% 할인<br>
                        <small>[옵션: 내 피부톤 클래식키트 SET (44% 할인) 1개 + 나스샤무엔 레드 2개]</small><br>
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
                    <td><button class="btn-delete">X</button></td>
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
                    <td><button class="btn-delete">X</button></td>
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
                    <th>결제 예정 금액</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>97,600원</td>
                    <td>+</td>
                    <td>0원</td>
                    <td>=</td>
                    <td>97,600원</td>
                </tr>
            </tbody>
        </table>
        
    </div>

</body>
</html>