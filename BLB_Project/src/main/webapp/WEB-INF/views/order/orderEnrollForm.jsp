<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="orderEnrollForm.css">
<title>주문서 작성/결제</title>
</head>
<body class="body-offset">
    <div class="order-form">

        <!-- 네비게이터 영역 -->
        <div class="navigator">
            <h2><b>주문서 작성/결제</b></h2>
            <!-- 지나온 페이지 표시 -->
            <div class="breadcrumb">
                <span class="inactive">01 장바구니</span> <!-- 비활성화된 상태-->
                <span class="separator">&gt;</span>
                <span class="active">02 주문서작성/결제</span>  <!-- 활성화된 상태 -->
                <span class="separator">&gt;</span>
                <span class="inactive">03 주문완료</span> <!-- 비활성화된 상태-->
            </div>
        </div>

        <!-- 배송 정보 입력 테이블  -->
        <table>
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
    </div>
</body>
</html>