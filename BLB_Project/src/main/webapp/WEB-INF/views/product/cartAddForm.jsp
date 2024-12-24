<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
    <title>리뷰 작성</title>
    <!-- jQuery 3.7.1 -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <!-- header CSS -->
    <link rel="stylesheet" href="${ pageContext.request.contextPath }/resources/css/common/header.css">
    <!-- Bootstrap 4.6.2 CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
    <!-- Google Fonts NotoSansKR -->
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&family=Oregano&display=swap" />
    <!-- Google Fonts Icon -->
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
    <!-- awesome Icon -->
	<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" rel="stylesheet">

    <!--  Alertify 라이브러리 연동구문 (CDN) -->
	<!-- JavaScript -->
	<script src="//cdn.jsdelivr.net/npm/alertifyjs@1.14.0/build/alertify.min.js"></script>
	<!-- CSS -->
	<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/alertifyjs@1.14.0/build/css/alertify.min.css"/>
	<!-- Default theme -->
	<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/alertifyjs@1.14.0/build/css/themes/default.min.css"/>
	<!-- Semantic UI theme -->
	<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/alertifyjs@1.14.0/build/css/themes/semantic.min.css"/>

    <style>
        body {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            width: 100%;
            height: auto;
        }
        /* 컨테이너 스타일 */
        .cart-container {
            width: 100%; /* 부모의 크기를 기준으로 조정 */
            height: auto;
            margin: 0 auto; /* 중앙 정렬 */
            border-radius: 10px;
            padding: 20px;
            background-color: #fff;
        }
        /* 상품 정보 */
        .product-info {
            display: flex;
            align-items: center;
            margin-bottom: 20px;
        }

        .product-thumbnail {
            width: 80px;
            height: 80px;
            margin-right: 15px;
            border-radius: 8px;
            overflow: hidden;
        }

        .product-thumbnail img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .product-details {
            flex: 1;
        }

        .product-name {
            font-size: 16px;
            font-weight: bold;
            margin-bottom: 5px;
        }

        .product-options {
            font-size: 14px;
            color: #888;
        }
        #selectedOptions {
            margin-top: 10px;
        }

        /* 버튼 스타일 */
        .btn-submit {
            width: 100%;
            background-color: #4A628A;
            color: white;
            border: none;
            padding: 10px 15px;
            font-size: 16px;
            font-weight: bold;
            border-radius: 5px;
            cursor: pointer;
        }
        .success-message {
            text-align: center;
            margin-top: 50px;
        }
        .success-buttons {
            display: flex;
            justify-content: center;
            gap: 10px;
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <div class="cart-container">
        <!-- 장바구니 담기 폼 -->
        <form id="cartAddForm" action="insert.ct" method="post" enctype="multipart/form-data">
            <input type="hidden" id="memberId" name="memberId" value="${memberId}">
            <input type="hidden" id="prodNo" name="prodNo" value="${prodNo}">
            <!-- 상품 정보 -->
      
            <div class="product-info" onclick="window.open('detail.pr?pno=${prodNo}', '_blank');" style="cursor: pointer;">
                <div class="product-thumbnail">
                    <img src="${ pageContext.request.contextPath }${ p.thumbImg }" alt="상품 썸네일">
                </div>
                <div class="product-details">
                    <div class="product-name">${p.prodName}</div>
                    <input type="hidden" id="base-price" value="${ p.prodPrice }">
                    <p><fmt:formatNumber value="${ p.prodPrice }" type="number" pattern="#,###" /><small>원</small></p>
                </div>
            </div>
            <!-- 옵션 정보 -->
            <label for="product-option">옵션 선택</label>
            <select class="form-control product-options" id="product-option">
                <!-- 기본 선택 옵션 -->
                <option value="">선택하세요</option>
                <!-- 옵션 리스트 출력 -->
                <c:forEach var="opt" items="${optList}">
                    <option value="${opt.optNo}" 
                            data-name="${opt.optName}" 
                            data-price="${opt.optAddPrice}" 
                            data-stock="${opt.remainQty}">
                        ${opt.optName} 
                        <c:if test="${opt.optAddPrice > 0}">(+<fmt:formatNumber value="${opt.optAddPrice}" type="number" pattern="#,###"/>원)</c:if>
                        (재고: ${opt.remainQty})
                    </option>
                </c:forEach>
            </select>
            <div id="selectedOptions"></div>
            <div class="form-group totalPrice">
                <label>총 상품금액</label>
                <h3 id="totalPrice"><fmt:formatNumber value="${ p.prodPrice }" type="number" pattern="#,###" /><small>원</small></h3>
            </div>
    
            <!-- 작성 버튼 -->
            <button type="submit" class="btn-submit">장바구니 담기</button>
        </form>
    </div>

    <script>
        $(document).ready(function () {
            
            // 옵션 선택 및 수량 변경
            let selectedOptions = [];

            // 옵션 선택 시 옵션 목록에 추가
            $('#product-option').change(function () {
                const optionId = $(this).val(); // 옵션 NO
                const optionName = $(this).find('option:selected').data('name'); // 옵션 이름
                const optionPrice = parseInt($(this).find('option:selected').data('price')) || 0; // 옵션 가격
                const optionStock = parseInt($(this).find('option:selected').data('stock')) || 0; // 옵션 재고

                if (optionId) {
                    let existingOption = selectedOptions.find(opt => opt.id == optionId); // `==`으로 비교
                    if (existingOption) {
                        existingOption.quantity++;
                    } else {
                        selectedOptions.push({ id: optionId, name: optionName, price: optionPrice, stock: optionStock, quantity: 1 });
                    }
                    updateSelectedOptions();
                    // 선택 값을 초기화하여 "선택하세요"로 변경
                    $(this).val("");
                }
            });

            // 선택된 옵션 업데이트
            function updateSelectedOptions() {
                let html = '';
                selectedOptions.forEach(option => {
                    html += `
                        <div class="selected-option mb-2 p-2 border rounded">
                            <div class="d-flex justify-content-between align-items-center">
                                <!-- 옵션 내용 (좌측 정렬) -->
                                <span style="flex: 1; text-align: left;">\${option.name}</span>
                                <!-- 옵션 재고 (우측 정렬, 조건부 스타일) -->
                                <span style="flex: 1; text-align: right; color: \${option.stock < 10 ? 'red' : 'inherit'}; margin-right: 5px;">
                                    재고: \${option.stock}개
                                </span>
                                <div>
                                    <button type="button" class="btn btn-sm btn-outline-secondary decrease-quantity" data-id="\${option.id}">-</button>
                                    <span class="mx-2 option-quantity">\${option.quantity}</span>
                                    <button type="button" class="btn btn-sm btn-outline-secondary increase-quantity" data-id="\${option.id}">+</button>
                                </div>
                            </div>
                        </div>
                    `;
                });
                $('#selectedOptions').html(html);
                updateTotalPrice();
                adjustIframeSize();
            }

            // 수량 증가
            $(document).on('click', '.increase-quantity', function(e) {
                e.preventDefault(); // 기본 동작 방지
                const id = $(this).data('id'); // data-id 가져오기
                const optionStock = parseInt($(this).find('option:selected').data('stock')) || 0; // 옵션 재고
                const option = selectedOptions.find(opt => opt.id == id); // `==`으로 비교
                if (option && option.quantity < option.stock) {
                    option.quantity++; // 수량 증가
                    updateSelectedOptions();
                }
            });

            // 수량 감소
            $(document).on('click', '.decrease-quantity', function(e) {
                e.preventDefault(); // 기본 동작 방지
                const id = $(this).data('id'); // data-id 가져오기
                const option = selectedOptions.find(opt => opt.id == id); // `==`으로 비교
                if (option) {
                    if (option.quantity > 1) {
                        option.quantity--; // 수량 감소
                    } else {
                        selectedOptions = selectedOptions.filter(opt => opt.id != id); // 옵션 제거
                    }
                    updateSelectedOptions();
                }
            });

            // 총 금액 계산
            function updateTotalPrice() {
                const basePrice = parseInt($("#base-price").val()) || 0; // 기본 가격
                const total = selectedOptions.reduce((sum, opt) => sum + (basePrice + opt.price) * opt.quantity, 0);
                $('#totalPrice').html(total.toLocaleString() + '<small>원</small>');
            }

            // 데이터 제출
            $('#cartAddForm').on('submit', function (e) {
                e.preventDefault(); // 기본 폼 제출 방지

                const memberId = $('#memberId').val();
                const prodNo = $('#prodNo').val();

                if (!memberId) {
                    alertify.error("로그인 후 이용 할 수 있습니다.");
                    // 페이지 이동
                    setTimeout(function() {
                        parent.location.href = `${contextPath}/loginForm.me`;
                    }, 1500); // 2초 후 이동
                    return; // 실행 중단
                }

                const cartData = selectedOptions.map(option => ({
                    memberId: memberId,
                    prodNo: prodNo,
                    optNo: option.id,
                    cartQty: option.quantity
                }));

                if (cartData.every(data => !data.optNo)) {
                    alertify.error("옵션을 선택해야 합니다.");
                    return; // 실행 중단
                }

                $.ajax({
                    url: 'insert.ct',
                    type: 'POST',
                    contentType: 'application/json',
                    data: JSON.stringify(cartData),
                    success: function (response) {
                        
                        if (response.success) {
                            // 성공 메시지
                            // parent.togglerEvent.active('shopping_bag', '', '장바구니 등록 성공!');
                            // alertify.success(response.message);
                            parent.$('#reviewIframeContainer').hide();
                            parent.showSuccessMessage();
                        } else {
                            // 실패 메시지
                            alertify.error(response.message);
                            // 일정 시간 후 창 닫기
                            setTimeout(function () {
                                parent.$('#reviewIframeContainer').hide();
                                parent.location.reload(); // 부모 페이지 새로고침
                            }, 1000); // 1초 후 창 닫기
                        }
                    },
                    error: function () {
                        alertify.error("서버 오류가 발생했습니다. 다시 시도해주세요.");
                        // 일정 시간 후 창 닫기
                        setTimeout(function () {
                                parent.$('#reviewIframeContainer').hide();
                                parent.location.reload(); // 부모 페이지 새로고침
                            }, 1000); // 1초 후 창 닫기
                    }
                });
            });

            // function showSuccessMessage() {
            //     $('.cart-container').html(`
            //         <div class="success-message">
            //             <h2>장바구니 담기 성공</h2>
            //             <p>상품이 장바구니에 성공적으로 담겼습니다.</p>
            //             <div class="success-buttons">
            //                 <button onclick="goToCart()" class="btn btn-primary">장바구니 보기</button>
            //                 <button onclick="continueShopping()" class="btn btn-secondary">계속 쇼핑하기</button>
            //             </div>
            //         </div>
            //     `);
            // }

            window.goToCart = function() {
                // iframe 모달 닫기
                parent.$('#reviewIframeContainer').hide(function() {
                    parent.$('#reviewIframeContainer iframe').attr('src', ''); // iframe URL 초기화
                });

                // 부모 페이지 URL 변경
                parent.window.location.href = 'list.ct';
            };

            window.continueShopping = function() {
                // iframe 모달 닫기
                parent.$('#reviewIframeContainer').hide(function() {
                    parent.$('#reviewIframeContainer iframe').attr('src', ''); // iframe URL 초기화
                });
                parent.location.reload(); // 부모 페이지 새로고침
            };
            function adjustIframeSize() {
                const iframe = parent.document.getElementById('reviewIframeContainer').querySelector('iframe');
                if (iframe) {
                    const iframeContent = iframe.contentWindow.document || iframe.contentDocument;
                    if (iframeContent) {
                        const iframeHeight = iframeContent.body.scrollHeight || iframeContent.documentElement.scrollHeight;
                        const iframeWidth = iframeContent.body.scrollWidth || iframeContent.documentElement.scrollWidth;

                        iframe.style.height = `\${iframeHeight}px`;
                        iframe.style.width = `\${iframeWidth}px`;
                    }
                }
            }
        });
    </script>

    
    <!-- Popper JS -->
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>

    <!-- Bootstrap 4.6.2 JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
    
    <!-- header Javascript -->
    <script src="${ pageContext.request.contextPath }/resources/js/common/header.js"></script>
</body>
</html>
