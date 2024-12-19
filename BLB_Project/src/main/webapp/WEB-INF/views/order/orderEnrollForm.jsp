<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문서 작성/결제 | 뷰라밸</title>
<link rel="stylesheet" type="text/css" href="${ pageContext.request.contextPath }/resources/css/order/orderEnrollForm.css">
<!-- <link rel="stylesheet" type="text/css" href="../../../resources/css/order/orderEnrollForm.css"> -->
<!-- 부트스트랩 -->
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy" crossorigin="anonymous"></script>
<!-- jQuery 라이브러리 -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

</head>
<body class="body-offset">

    <div class="container-fluid">
        <form id="order-form"
              action="orderEnrollForm"
              method="insert.or">
            
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
                            <select id="phone-prefix" name="phone-prefix">
                                <option value="010">010</option>
                                <option value="011">011</option>
                                <option value="016">016</option>
                                <option value="017">017</option>
                                <option value="018">018</option>
                                <option value="019">019</option>
                            </select>
                            <span>-</span>
                            <input type="text" maxlength="4">
                            <span>-</span>
                            <input type="text" maxlength="4">
                        </div>
                    </td>
                </tr>
                <tr>
                    <th>배송 요청 사항</th>
                    <td>
                        <select name="delivery-message" id="delivery-message">
                            <option value="default" selected>-- 메시지 선택 (선택사항) --</option>
                            <option>배송 전에 미리 연락바랍니다.</option>
                            <option>부재 시 경비실에 맡겨주세요.</option>
                            <option>부재 시 문 앞에 놓아주세요.</option>
                            <option>빠른 배송 부탁드립니다.</option>
                            <option>택배함에 보관해 주세요.</option>
                            <option value="custom">직접 입력</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <th></th>
                    <td>
                        <!-- 직접 입력 선택 시 나타남 -->
                        <textarea id="custom-comment" placeholder="상세 요청사항을 입력해 주세요."></textarea>
    
                        <script>
                            $(function () {

                                // 새로고침 시 기본 상태에서도 숨겨지게 설정
                                if ($("#delivery-message").val() !== "custom") {
                                    $("#custom-comment").hide(); // 기본 옵션 또는 다른 옵션 선택 시 textarea 숨김
                                }
                                
                                // select 요소의 change 이벤트 처리
                                $("#delivery-message").change(function () {
                                    // 선택된 값이 "custom"인지 확인
                                    if ($(this).val() === "custom") {
                                        $("#custom-comment").show(); // 직접 입력 시 textarea 표시
                                    } else {
                                        $("#custom-comment").hide(); // 다른 옵션 선택 시 숨김
                                    }
                                });
                            });
                            </script>
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
                    <img src="" alt="립밤 세트" class="product-image">
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
                    <img src="" alt="기초 & 선라인 세트" class="product-image">
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
                                    <span style="font-size: 30px;">93,780</span>원
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
                    <li class="payment-option" onclick="clickPay('무통장입금')">무통장입금</li>
                    <li class="payment-option" onclick="clickPay('신용카드')">신용카드</li>
                    <li class="payment-option" onclick="clickPay('카카오페이')">카카오페이</li>
                </ul>
                <p id="payment-comment" class="payment-comment">
                    결제 수단을 선택해주세요.
                </p>

                <!-- 무통장 입금 시 보여지는 영역 -->
                <div id="bank-info" style="display: none;">
                    <p>현금영수증</p>
                    <div id="receipt-yn">
                        <input type="radio" name="receipt" id="receipt-yes" value="신청">
                        <label for="receipt-yes">현금영수증 신청</label>
                        <input type="radio" name="receipt" id="receipt-no" value="신청안함" checked>
                        <label for="receipt-no">신청 안 함</label>
                    </div>
                </div>
            </div>

            <script>
                // 결제 옵션 클릭 이벤트
                $(document).ready(function () {
        
                    $(".payment-option").on("click", function () {
                        
                        $(".payment-option").removeClass("selected");
            
                        $(this).addClass("selected");
                    });
                });
        
                function clickPay(method) {
                    const payComment = {
                        "무통장입금": "현금 영수증 발생 여부를 선택해 주세요.",
                        "신용카드": "소액 결제의 경우 PG사 정책에 따라 결제 금액 제한이 있을 수 있습니다.",
                        "카카오페이": "카카오톡 앱을 설치한 후, 최초 1회 카드정보를 등록하셔야 사용 가능합니다. <br> 인터넷 익스플로러는 8 이상에서만 결제 가능합니다. <br> 카카오머니로 결제 시, 현금영수증 발급은 ㈜카카오페이에서 발급 가능합니다."
                    };
        
                    $("#payment-comment").html(payComment[method] || "결제 수단을 선택해주세요.");
        
                    if (method === "무통장입금") {
                        $("#bank-info").show(); // 무통장입금 입력 필드 표시
                    } else {
                        $("#bank-info").hide(); // 무통장입금 입력 필드 숨기기
                    }
                }
            </script>
      
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
                        
                        <!-- Button trigger modal -->
                        <button type="button" class="details-button" data-bs-toggle="modal" data-bs-target="#exampleModal1">
                            ▶
                        </button>
                        
                        <!-- Modal -->
                        <div class="modal fade" id="exampleModal1" tabindex="-1" aria-labelledby="exampleModalLabel1" aria-hidden="true">
                            <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h4 class="modal-title fs-5" id="exampleModalLabel1">쇼핑몰 이용약관</h4>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close">X</button>
                                </div>
                                <div class="terms-of-use">
                                    <h5>제 1조(목적)</h5>
                                    <ul>
                                        <li>이 약관은 주식회사 뷰라밸(전자상거래 사업자)가 운영하는 BLB 사이버 몰(이하 “몰”이라 한다)에서 제공하는 인터넷 관련 서비스(이하 “서비스”라 한다)를 이용함에 있어 사이버 몰과 이용자의 권리, 의무 및 책임사항을 규정함을 목적으로 합니다.</li>
                                        <li>※「PC통신, 무선 등을 이용하는 전자상거래에 대해서도 그 성질에 반하지 않는 한 이 약관을 준용합니다.」</li>
                                    </ul>
                                    <br>
                                    <h5>제 2조(정의)</h5>
                                    <ol>
                                        <li>① “몰”이란 주식회사 뷰라밸이 재화 또는 용역(이하 “재화 등”이라 함)을 이용자에게 제공하기 위하여 컴퓨터 등 정보통신설비를 이용하여 재화 등을 거래할 수 있도록 설정한 가상의 영업장을 말하며, 아울러 사이버몰을 운영하는 사업자의 의미로도 사용합니다.</li>
                                        <li>② “이용자”란 “몰”에 접속하여 이 약관에 따라 “몰”이 제공하는 서비스를 받는 회원 및 비회원을 말합니다.</li>
                                        <li>③ ‘회원’이라 함은 “몰”에 회원등록을 한 자로서, 계속적으로 “몰”이 제공하는 서비스를 이용할 수 있는 자를 말합니다.</li>
                                        <li>④ ‘비회원’이라 함은 회원에 가입하지 않고 “몰”이 제공하는 서비스를 이용하는 자를 말합니다.</li>
                                    </ol>
                                    <br>
                                    <h5>제 3조(약관 등의 명시와 설명 및 개정)</h5>
                                    <ol>
                                        <li>① “몰”은 이 약관의 내용과 상호 및 대표자 성명, 영업소 소재지 주소(소비자의 불만을 처리할 수 있는 곳의 주소를 포함), 전화번호·모사전송번호·전자우편주소, 사업자등록번호, 통신판매업 신고번호, 개인정보보호책임자 등을 이용자가 쉽게 알 수 있도록 BLB 사이버몰의 초기 서비스화면(전면)에 게시합니다. 다만, 약관의 내용은 이용자가 연결화면을 통하여 볼 수 있도록 할 수 있습니다.</li>
                                        <li>② “몰은 이용자가 약관에 동의하기에 앞서 약관에 정하여져 있는 내용 중 청약철회, 배송책임, 환불조건 등과 같은 중요한 내용을 이용자가 이해할 수 있도록 별도의 연결화면 또는 팝업화면 등을 제공하여 이용자의 확인을 구하여야 합니다.</li>
                                        <li>③ “몰”은 「전자상거래 등에서의 소비자보호에 관한 법률」, 「약관의 규제에 관한 법률」 등 관련 법을 위배하지 않는 범위에서 이 약관을 개정할 수 있습니다.</li>
                                        <li>④ “몰”이 약관을 개정할 경우에는 적용일자 및 개정사유를 명시하여 현행약관과 함께 몰의 초기화면에 공지합니다. 이용자에게 불리한 약관 변경 시 최소 30일의 사전 공지 기간을 제공합니다.</li>
                                        <li>⑤ 이용자가 개정약관 적용을 원하지 않는 경우 개정 전 약관이 적용되며, 이에 대한 동의를 받은 경우에는 개정약관이 적용됩니다.</li>
                                        <li>⑥ 이 약관에서 정하지 아니한 사항과 이 약관의 해석에 관하여는 전자상거래 등에서의 소비자보호에 관한 법률, 약관의 규제 등에 관한 법률, 공정거래위원회가 정하는 전자상거래 등에서의 소비자 보호지침 및 관계법령 또는 상관례에 따릅니다.</li>
                                    </ol>
                                    <br>
                                    <h5>제 4조(서비스의 제공 및 변경)</h5>
                                    <ol>
                                        <li>① “몰”은 다음과 같은 업무를 수행합니다.
                                            <ul>
                                                <li>1. 재화 또는 용역에 대한 정보 제공 및 구매계약의 체결</li>
                                                <li>2. 구매계약이 체결된 재화 또는 용역의 배송</li>
                                                <li>3. 기타 “몰”이 정하는 업무</li>
                                            </ul>
                                        </li>
                                        <li>② “몰”은 재화 또는 용역의 품절 등의 경우 계약에 의해 제공할 재화 내용을 변경할 수 있습니다.</li>
                                        <li>③ 계약 변경 시 이용자에게 이를 알리고, 손해가 발생한 경우 이를 배상합니다. 다만, 고의 또는 과실이 없는 경우에는 그러하지 아니합니다.</li>
                                    </ol>
                                    <br>
                                    <h5>제 5조(서비스의 중단)</h5>
                                    <ol>
                                        <li>① “몰”은 컴퓨터 등 정보통신설비의 보수점검, 교체 및 고장, 통신의 두절 등의 사유가 발생한 경우에는 서비스의 제공을 일시적으로 중단할 수 있습니다.</li>
                                        <li>② “몰”은 서비스 제공 중단으로 인해 이용자에게 발생한 손해를 배상합니다. 단, “몰”이 고의 또는 과실이 없음을 입증한 경우에는 그러하지 아니합니다.</li>
                                        <li>③ 사업종목 전환, 사업 포기, 업체 간 통합 등으로 서비스를 제공할 수 없게 되는 경우 “몰”은 이에 대해 이용자에게 통지하고 보상합니다.</li>
                                    </ol>
                                    <br>
                                    <h5>제 6조(회원가입)</h5>
                                    <ol>
                                        <li>① 이용자는 “몰”이 정한 가입 양식에 따라 회원정보를 기입한 후 이 약관에 동의함으로써 회원가입을 신청합니다.</li>
                                        <li>② “몰”은 다음 각 호에 해당하지 않는 한 회원으로 등록합니다.
                                            <ul>
                                                <li>1. 이전에 회원자격을 상실한 적이 있는 경우 (3년 경과 후 재가입 가능)</li>
                                                <li>2. 허위, 기재누락, 오기가 있는 경우</li>
                                                <li>3. 기술적 문제가 있는 경우</li>
                                            </ul>
                                        </li>
                                        <li>③ 회원가입 계약의 성립은 “몰”의 승낙이 회원에게 도달한 시점으로 합니다.</li>
                                        <li>④ 회원정보가 변경된 경우 회원은 이를 “몰”에 알릴 의무가 있습니다.</li>
                                    </ol>
                                    <br>
                                    <h5>부칙</h5>
                                    <p>이 약관은 2020년 9월 11일부터 시행합니다.</p>
                                </div>
                                <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                </div>
                            </div>
                            </div>
                        </div>
                    </li>
                    <li class="terms-item">
                        <label>
                            <input type="checkbox" class="check-term">
                            <span>[필수] 개인정보 수집 및 이용 동의</span>
                        </label>
                         <!-- Button trigger modal -->
                         <button type="button" class="details-button" data-bs-toggle="modal" data-bs-target="#exampleModal2">
                            ▶
                        </button>
                        
                        <!-- Modal -->
                        <div class="modal fade" id="exampleModal2" tabindex="-1" aria-labelledby="exampleModalLabel2" aria-hidden="true">
                            <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h4 class="modal-title fs-5" id="exampleModalLabel2">쇼핑몰 이용약관</h4>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close">X</button>
                                </div>
                                <div class="terms-of-use">
                                    <h5>1. 개인정보 수집목적 및 이용목적</h5>
                                    <ul>
                                        <li>비회원 구매 서비스 제공</li>
                                    </ul>
                                    <br>
                                    <h5>2. 수집하는 개인정보 항목</h5>
                                    <ul>
                                        <li>주문 시: 성명, 주소, 전화번호, 이메일, 결제정보, 비회원 결제 비밀번호</li>
                                        <li>취소/교환/반품 신청 시: 환불계좌정보(은행명, 계좌번호, 예금주)</li>
                                    </ul>
                                    <br>
                                    <h5>3. 개인정보의 보유기간 및 이용기간</h5>
                                    <ul>
                                        <li>원칙적으로, 개인정보 수집 및 이용목적이 달성된 후에는 해당 정보를 지체 없이 파기합니다.</li>
                                        <li>단, 다음의 정보에 대해서는 아래의 이유로 명시한 기간 동안 보존합니다.</li>
                                    </ul>
                                    <br>
                                    <h6>가. 회사 내부 방침에 의한 정보 보유 사유</h6>
                                    <ul>
                                        <li>부정거래 방지 및 쇼핑몰 운영방침에 따른 보관: 5년</li>
                                    </ul>
                                    <br>
                                    <h6>나. 관련 법령에 의한 정보보유 사유</h6>
                                    <ul>
                                        <li>
                                            o 계약 또는 청약철회 등에 관한 기록</><br>
                                            - 보존이유: 전자상거래등에서의소비자보호에관한법률<br>
                                            - 보존기간: 5년
                                        </li>
                                        <li>
                                            o 대금 결제 및 재화 등의 공급에 관한 기록</><br>
                                            - 보존이유: 전자상거래등에서의소비자보호에관한법률<br>
                                            - 보존기간: 5년
                                        </li>
                                        <li>
                                            o 소비자 불만 또는 분쟁처리에 관한 기록</><br>
                                            - 보존이유: 전자상거래등에서의소비자보호에관한법률<br>
                                            - 보존기간: 3년
                                        </li>
                                        <li>
                                            o 로그 기록</><br>
                                            - 보존이유: 통신비밀보호법<br>
                                            - 보존기간: 3개월
                                        </li>
                                    </ul>
                                    <br>
                                    <p>
                                        ※ 동의를 거부할 수 있으나 거부 시 비회원 구매 서비스 이용이 불가능합니다.
                                    </p>
                                </div>
                                <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                </div>
                            </div>
                            </div>
                        </div>
                    </li>
                </ul>
            </div>

            <p>주문 내용을 확인하였으며 약관에 동의합니다.</p>

            <script>
                // 약관 동의 체크박스
                $(document).ready(function () {
                    
                    // 모든 약관 동의
                    $("#check-all").on("change", function () {
                        const isChecked = $(this).is(":checked");
                        $(".check-term").prop("checked", isChecked); // 모든 개별 체크박스 체크/해제
                    });

                    // 개별 약관 체크박스 클릭 이벤트
                    $(".check-term").on("change", function () {
                        const total = $(".check-term").length; // 전체 약관 개수
                        const checked = $(".check-term:checked").length; // 체크된 약관 개수

                        // 모든 약관이 체크되면 "모든 약관 동의"도 체크, 아니면 해제
                        $("#check-all").prop("checked", total === checked);
                    });
                });
            </script>

            <!-- 결제하기 버튼 -->
            <button type="submit" class="btn btn-primary payment-button">18,180원 결제하기</button>        
        </form>

    </div>

</body>
</html>