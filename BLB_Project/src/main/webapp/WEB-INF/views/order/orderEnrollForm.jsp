<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문서 작성/결제 | 뷰라밸</title>
<!-- <link rel="stylesheet" type="text/css" href="${ pageContext.request.contextPath }/resources/css/order/orderEnrollForm.css"> -->
<link rel="stylesheet" type="text/css" href="../../../resources/css/order/orderEnrollForm.css">
<!-- 부트스트랩 -->
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy" crossorigin="anonymous"></script>
</head>
<body class="body-offset">

    <jsp:include page="../common/header.jsp" />

    <div class="container-fluid">

        <!-- 네비게이터 영역 -->
        <div class="navigator">
            <h1><b>주문서 작성/결제</b></h1>
            <div class="breadcrumb"> <!-- 지나온 페이지 표시 -->
                <span class="inactive">01 장바구니</span> <!-- 비활성화된 상태-->
                <span class="separator">&gt;</span>
                <span class="active">02 주문서작성/결제</span>  <!-- 활성화된 상태 -->
                <span class="separator">&gt;</span>
                <span class="inactive">03 주문완료</span> <!-- 비활성화된 상태-->
            </div>
        </div>

        <br><br>

        <!-- 배송 정보 입력 테이블 영역 -->
        <h3>배송 정보 입력</h3>
        <hr class="custom-hr">

        <table id="delivery-form">
            <tr>
                <th>받는 사람 <span class="required">*</span></th>
                <td><input type="text" placeholder="받는 사람 이름을 입력하세요" required></td>
            </tr>
            <tr>
                <th>주소 <span class="required">*</span></th>
                <td>
                    <div class="address-container">
                        <input type="text" placeholder="우편번호" style="width: 120px;">
                        <button type="button" class="btn-search">주소검색</button>
                    </div>
                    <input type="text" placeholder="기본주소" style="width: 100%; margin-top: 10px;">
                    <input type="text" placeholder="나머지 주소" style="width: 100%; margin-top: 10px;">
                </td>
            </tr>
            <tr>
                <th>휴대전화 <span class="required">*</span></th>
                <td>
                    <div class="phone-container">
                        <select>
                            <option>010</option>
                            <option>011</option>
                            <option>016</option>
                        </select>
                        <span>-</span>
                        <input type="text" maxlength="4">
                        <span>-</span>
                        <input type="text" maxlength="4">
                    </div>
                </td>
            </tr>
            <tr>
                <th>이메일 <span class="required">*</span></th>
                <td>
                    <div class="email-container">
                        <input type="text" placeholder="이메일" style="width: 120px;">
                        <span>@</span>
                        <input type="text" placeholder="직접입력" style="width: 150px;">
                        <select name="email-domain" id="email-domain">
                            <option value="">직접입력</option>
                            <option value="naver.com">naver.com</option>
                            <option value="daum.net">daum.net</option>
                            <option value="nate.com">nate.com</option>
                            <option value="hotmail.com">hotmail.com</option>
                            <option value="yahoo.com">yahoo.com</option>
                            <option value="empas.com">empas.com</option>
                            <option value="korea.com">korea.com</option>
                            <option value="dreamwiz.com">dreamwiz.com</option>
                            <option value="gmail.com">gmail.com</option>
                        </select>
                    </div>
                </td>
            </tr>
            <tr>
                <th>배송 요청 사항</th>
                <td>
                    <select name="delivery-message" id="delivery-message">
                        <option value="">-- 메시지 선택 (선택사항) --</option>
                        <option>배송 전에 미리 연락바랍니다.</option>
                        <option>부재 시 경비실에 맡겨주세요.</option>
                        <option>부재 시 문 앞에 놓아주세요.</option>
                        <option>빠른 배송 부탁드립니다.</option>
                        <option>택배함에 보관해 주세요.</option>
                        <option>직접 입력</option>
                    </select>
                </td>
            </tr>
        </table>

        <hr>

        <!-- 주문 상품 목록 영역 -->
        <div class="order-products">

            <h3>주문 상품</h3>
            <hr class="custom-hr">
            <!-- 첫 번째 상품 -->
            <div class="order-product">
                <img src="lipbalm.jpg" alt="립밤 세트" class="product-image">
                <div class="product-detail">
                    <p class="product-title">립밤 세트</p>
                    <p class="product-option">[옵션: 내 맘대로 골라담기 SET (44%▼)/립밤 1+1개 ★27% 할인★/내추럴 레드 2개]</p>
                    <p class="product-quantity">수량: 1개</p>
                    <p class="product-price">21,800원</p>
                </div>
                <button class="delete-button" aria-label="상품 삭제">×</button>
            </div>
            <hr class="custom-hr">
            <!-- 두 번째 상품 -->
            <div class="order-product">
                <img src="set_product.jpg" alt="기초 & 선라인 세트" class="product-image">
                <div class="product-detail">
                    <p class="product-title">[한정수량] 기초&선라인 1+1SET 특가</p>
                    <p class="product-option">[옵션: 01. 블랙티 스크럽밤 [44%▼]/[44%▼] 스크럽밤 3+3SET (+58,000)]</p>
                    <p class="product-quantity">수량: 1개</p>
                    <p class="product-price">75,800원</p>
                </div>
                <button class="delete-button" aria-label="상품 삭제">×</button>
            </div>
            <hr class="custom-hr">

        </div>

        <!-- 결제 예상 금액 영역 -->
        <table id="order-price">
            <tbody>
                <tr>
                    <td>
                        <p>총 판매가</p>
                        <p class="value">97,600원</p>
                    </td>
                    <td>-</td>
                    <td>
                        <p>총 할인가</p>
                        <p class="value discount">6,320원</p>
                    </td>
                    <td>+</td>
                    <td>
                        <p>배송비</p>
                        <p class="value">2,500원</p>
                    </td>
                </tr>
            </tbody>
            <tfoot>
                <tr>
                    <td colspan="5" class="footer">
                        <p>배송비는 쿠폰 할인 금액 및 배송 옵션에 따라 변경될 수 있습니다.</p>
                        <p class="total-price">
                            총 결제 예상 금액 최소
                            <span class="final-price">
                                <span style="font-size: 30px;">18,180</span>원
                            </span>
                        </p>
                    </td>
                </tr>
            </tfoot>
        </table>

        <!-- 결제 수단 영역 -->
        <div class="payment-container">
            <h3>결제수단 선택</h3>
            <ul class="payment-options">
                <li class="payment-option selected">무통장입금</li>
                <li class="payment-option">신용카드</li>
                <li class="payment-option">카카오페이</li>
            </ul>
            <p class="payment-comment">
                = 소액 결제의 경우 PG사 정책에 따라 결제 금액 제한이 있을 수 있습니다.
            </p>
        </div>

        <!-- 결제 동의 약관 영역 -->
        <div class="terms-container">
            <div class="terms-header">
                <label>
                    <input type="checkbox" id="check-all">
                    <span>모든 약관 동의</span>
                </label>
            </div>
            <hr>
            <ul class="terms-list">
                <li class="terms-item">
                    <label>
                        <input type="checkbox" class="check-term">
                        <span>[필수] 쇼핑몰 이용약관 동의</span>
                    </label>
                    <button class="details-button">▶</button>
                </li>
                <li class="terms-item">
                    <label>
                        <input type="checkbox" class="check-term">
                        <span>[필수] 개인정보 수집 및 이용 동의</span>
                    </label>
                    <button class="details-button">▶</button>
                </li>
            </ul>
        </div>

        <p>주문 내용을 확인하였으며 약관에 동의합니다.</p>

        <!-- 결제하기 버튼 -->
        <button type="button" class="btn btn-primary payment-button">18,180원 결제하기</button>        
        
    </div>

    <jsp:include page="../common/footer.jsp" />

</body>
</html>