<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>뷰라밸 (Beauty Life Balance)</title>
<style>
/* 메인 배너 스타일 */
.main-banner .carousel-item {
    height: 400px;
    background-size: cover;
    background-position: center;
}

.main-banner .carousel-caption {
    background: rgba(255, 255, 255, 0.7);
    padding: 20px;
    border-radius: 10px;
    color: #333;
}

/* 베스트 상품 스타일 */
.product-grid {
    display: grid;
    grid-template-columns: repeat(4, 1fr);
    gap: 20px;
    margin: 20px 0;
}

.product-item {
    text-align: center;
    padding: 10px;
    transition: transform 0.3s;
}

.product-item:hover {
    transform: translateY(-5px);
}

.product-item img {
    width: 100%;
    height: auto;
    object-fit: cover;
}

/* MD 추천 스타일 */
.md-picks .carousel-item {
    height: 300px;
}

.md-caption {
    position: absolute;
    bottom: 20px;
    left: 50%;
    transform: translateX(-50%);
    background: rgba(255, 255, 255, 0.9);
    padding: 10px 20px;
    border-radius: 5px;
    text-align: center;
}

.section-title {
    margin: 40px 0 20px;
    text-align: center;
}

.tab-buttons {
    text-align: center;
    margin-bottom: 20px;
}

.tab-buttons button {
    border: none;
    background: none;
    padding: 10px 20px;
    margin: 0 10px;
    font-size: 1.2em;
    cursor: pointer;
}

.tab-buttons button.active {
    border-bottom: 2px solid #000;
}
</style>
</head>
<body>

<!-- 메인 배너 섹션 -->
<div id="mainBanner" class="carousel slide main-banner" data-bs-ride="carousel">
    <div class="carousel-indicators">
        <!-- 동적으로 생성됨 -->
    </div>
    <div class="carousel-inner">
        <!-- 동적으로 생성됨 -->
    </div>
    <button class="carousel-control-prev" type="button" data-bs-target="#mainBanner" data-bs-slide="prev">
        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
        <span class="visually-hidden">Previous</span>
    </button>
    <button class="carousel-control-next" type="button" data-bs-target="#mainBanner" data-bs-slide="next">
        <span class="carousel-control-next-icon" aria-hidden="true"></span>
        <span class="visually-hidden">Next</span>
    </button>
</div>

<!-- 베스트 상품 섹션 -->
<div class="container">
    <div class="section-title">
        <div class="tab-buttons">
            <button class="active" data-type="best">베스트 상품</button>
            <button data-type="new">신상품</button>
        </div>
    </div>
    <div class="product-grid" id="productGrid">
        <!-- 동적으로 생성됨 -->
    </div>
    <div class="text-center">
        <button class="btn btn-outline-primary" id="moreProductsBtn">더보기</button>
    </div>
</div>

<!-- MD 추천 섹션 -->
<div class="container">
    <div class="section-title">
        <h2>이달의 MD 추천</h2>
    </div>
    <div id="mdPicks" class="carousel slide md-picks" data-bs-ride="carousel">
        <div class="carousel-inner">
            <!-- 동적으로 생성됨 -->
        </div>
        <button class="carousel-control-prev" type="button" data-bs-target="#mdPicks" data-bs-slide="prev">
            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
            <span class="visually-hidden">Previous</span>
        </button>
        <button class="carousel-control-next" type="button" data-bs-target="#mdPicks" data-bs-slide="next">
            <span class="carousel-control-next-icon" aria-hidden="true"></span>
            <span class="visually-hidden">Next</span>
        </button>
    </div>
</div>

<script>
$(document).ready(function() {
    // 메인 배너 로드
    function loadMainBanner() {
        $.ajax({
            url: '${pageContext.request.contextPath}/api/banners/main',
            method: 'GET',
            success: function(banners) {
                const indicators = banners.map((banner, index) => `
                    <button type="button" 
                            data-bs-target="#mainBanner" 
                            data-bs-slide-to="${index}" 
                            class="${index === 0 ? 'active' : ''}"
                            aria-current="${index === 0 ? 'true' : 'false'}"
                            aria-label="Slide ${index + 1}">
                    </button>
                `).join('');

                const slides = banners.map((banner, index) => `
                    <div class="carousel-item ${index === 0 ? 'active' : ''}" 
                         onclick="location.href='${pageContext.request.contextPath}/product/detail?prodNo=${banner.prodNo}'">
                        <img src="${banner.imageUrl}" class="d-block w-100" alt="${banner.title}">
                        <div class="carousel-caption">
                            <h5>${banner.title}</h5>
                            <p>${banner.price.toLocaleString()}원</p>
                        </div>
                    </div>
                `).join('');

                $('.carousel-indicators').html(indicators);
                $('#mainBanner .carousel-inner').html(slides);
            }
        });
    }

    // 상품 목록 로드
    function loadProducts(type = 'best') {
        $.ajax({
            url: `${pageContext.request.contextPath}/api/products/${type}`,
            method: 'GET',
            success: function(products) {
                const productHtml = products.slice(0, 8).map(product => `
                    <div class="product-item">
                        <img src="${product.imageUrl}" alt="${product.name}">
                        <h5>${product.name}</h5>
                        <p>${product.price.toLocaleString()}원</p>
                    </div>
                `).join('');

                $('#productGrid').html(productHtml);
            }
        });
    }

    // MD 추천 로드
    function loadMdPicks() {
        $.ajax({
            url: '${pageContext.request.contextPath}/api/md-picks',
            method: 'GET',
            success: function(mdPicks) {
                const slides = mdPicks.map((pick, index) => `
                    <div class="carousel-item ${index === 0 ? 'active' : ''}">
                        <img src="${pick.imageUrl}" class="d-block w-100" alt="${pick.title}">
                        <div class="md-caption">
                            <h5>${pick.mainText}</h5>
                            <p>${pick.subText}</p>
                        </div>
                    </div>
                `).join('');

                $('#mdPicks .carousel-inner').html(slides);
            }
        });
    }

    // 탭 버튼 이벤트
    $('.tab-buttons button').click(function() {
        $('.tab-buttons button').removeClass('active');
        $(this).addClass('active');
        loadProducts($(this).data('type'));
    });

    // 더보기 버튼 이벤트
    $('#moreProductsBtn').click(function() {
        const type = $('.tab-buttons button.active').data('type');
        location.href = `${pageContext.request.contextPath}/products/${type}`;
    });

    // 초기 로드
    loadMainBanner();
    loadProducts();
    loadMdPicks();

    // 캐러셀 자동 재생 설정
    $('#mainBanner').carousel({
        interval: 5000
    });

    $('#mdPicks').carousel({
        interval: 4000
    });
});
</script>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>