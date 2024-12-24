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
        <div class="success-message">
            <h2>장바구니 담기 성공</h2>
            <p>상품이 장바구니에 성공적으로 담겼습니다.</p>
            <div class="success-buttons">
                <button onclick="goToCart()" class="btn btn-primary">장바구니 보기</button>
                <button onclick="continueShopping()" class="btn btn-secondary">계속 쇼핑하기</button>
            </div>
        </div>
    </div>

    <script>
        $(document).ready(function () {

            window.goToCart = function() {
                // iframe 모달 닫기
                parent.$('#reviewIframeContainer').fadeOut(function() {
                    parent.$('#reviewIframeContainer iframe').attr('src', ''); // iframe URL 초기화
                });

                // 부모 페이지 URL 변경
                parent.window.location.href = 'list.ct';
            };

            window.continueShopping = function() {
                // iframe 모달 닫기
                parent.$('#reviewIframeContainer').fadeOut(function() {
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
