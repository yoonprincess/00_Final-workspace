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
}

.main-banner .carousel-item img {
    width: 100%;
    height: 100%;
    object-fit: cover;
}

.main-banner .carousel-caption {
    background: rgba(255, 255, 255, 0.7);
    padding: 20px;
    border-radius: 10px;
    color: #333;
    bottom: 40px;
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
    height: 200px;
    object-fit: cover;
    border-radius: 8px;
}

/* MD 추천 스타일 */
.md-picks .carousel-item {
    height: 300px;
}

.md-picks .carousel-item img {
    width: 100%;
    height: 100%;
    object-fit: cover;
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
    width: 80%;
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
    font-weight: bold;
}

.more-btn {
    display: block;
    width: 200px;
    margin: 30px auto;
    padding: 10px;
    border: 1px solid #ddd;
    border-radius: 5px;
    background: white;
    transition: all 0.3s;
}

.more-btn:hover {
    background: #f8f9fa;
}
</style>
</head>
<body>

<!-- 메인 배너 섹션 -->
<div id="mainBanner" class="carousel slide main-banner" data-bs-ride="carousel">
    <div class="carousel-indicators">
        <button type="button" data-bs-target="#mainBanner" data-bs-slide-to="0" class="active"></button>
        <button type="button" data-bs-target="#mainBanner" data-bs-slide-to="1"></button>
        <button type="button" data-bs-target="#mainBanner" data-bs-slide-to="2"></button>
    </div>
    <div class="carousel-inner">
        <div class="carousel-item active">
            <img src="https://via.placeholder.com/1920x400/C4EFF8/ffffff?text=Banner+1" class="d-block w-100" alt="배너1">
            <div class="carousel-caption">
                <h5>유기농 스킨케어 세트</h5>
                <p>89,000원</p>
            </div>
        </div>
        <div class="carousel-item">
            <img src="https://via.placeholder.com/1920x400/C4EFF8/ffffff?text=Banner+2" class="d-block w-100" alt="배너2">
            <div class="carousel-caption">
                <h5>프리미엄 마스크팩</h5>
                <p>32,000원</p>
            </div>
        </div>
        <div class="carousel-item">
            <img src="https://via.placeholder.com/1920x400/C4EFF8/ffffff?text=Banner+3" class="d-block w-100" alt="배너3">
            <div class="carousel-caption">
                <h5>비타민 세럼</h5>
                <p>45,000원</p>
            </div>
        </div>
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
            <button class="active" onclick="changeTab('best')">베스트 상품</button>
            <button onclick="changeTab('new')">신상품</button>
        </div>
    </div>
    <div class="product-grid" id="productGrid">
        <!-- 베스트 상품 8개 -->
        <div class="product-item">
            <img src="https://via.placeholder.com/200x200/ffffff/000000?text=Product+1" alt="상품1">
            <h5>베스트 상품 1</h5>
            <p>32,000원</p>
        </div>
        <div class="product-item">
            <img src="https://via.placeholder.com/200x200/ffffff/000000?text=Product+2" alt="상품2">
            <h5>베스트 상품 2</h5>
            <p>28,000원</p>
        </div>
        <!-- 나머지 6개의 상품 아이템 반복 -->
    </div>
    <button class="more-btn" onclick="location.href='${pageContext.request.contextPath}/products/best'">
        더보기
    </button>
</div>

<!-- MD 추천 섹션 -->
<div class="container">
    <div class="section-title">
        <h2>이달의 MD 추천</h2>
    </div>
    <div id="mdPicks" class="carousel slide md-picks" data-bs-ride="carousel">
        <div class="carousel-inner">
            <div class="carousel-item active">
                <img src="https://via.placeholder.com/1920x300/ffffff/000000?text=MD+Pick+1" alt="MD추천1">
                <div class="md-caption">
                    <h5>겨울철 수분 케어 아이템</h5>
                    <p>건조한 겨울 피부를 위한 특별 케어</p>
                </div>
            </div>
            <div class="carousel-item">
                <img src="https://via.placeholder.com/1920x300/ffffff/000000?text=MD+Pick+2" alt="MD추천2">
                <div class="md-caption">
                    <h5>민감성 피부 추천</h5>
                    <p>자극없이 순하게 관리하세요</p>
                </div>
            </div>
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
    // 메인 배너 자동 슬라이드 설정
    $('#mainBanner').carousel({
        interval: 5000
    });

    // MD 추천 자동 슬라이드 설정
    $('#mdPicks').carousel({
        interval: 4000
    });
});

// 탭 전환 함수
function changeTab(type) {
    $('.tab-buttons button').removeClass('active');
    $(`.tab-buttons button[onclick*='${type}']`).addClass('active');
    
    // 실제로는 여기서 상품 데이터를 교체하게 됩니다
    if(type === 'new') {
        // 임시로 텍스트만 변경
        $('.product-item h5').each(function(index) {
            $(this).text(`신상품 ${index + 1}`);
        });
        $('.more-btn').attr('href', '${pageContext.request.contextPath}/products/new');
    } else {
        $('.product-item h5').each(function(index) {
            $(this).text(`베스트 상품 ${index + 1}`);
        });
        $('.more-btn').attr('href', '${pageContext.request.contextPath}/products/best');
    }
}
</script>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>