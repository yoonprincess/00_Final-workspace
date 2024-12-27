<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>뷰라밸 (Beauty Life Balance)</title>
<!-- Slick Slider CSS -->
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css"/>
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick-theme.css"/>
<!-- product CSS -->
<link rel="stylesheet" href="${ pageContext.request.contextPath }/resources/css/product/product.css">
<style>

    .container {
        max-width: 1200px;
        margin: 0 auto;
        padding: 20px 15px;
    }

    /* 메인 배너 스타일 */
    .main-banner .carousel-item {
        height: 40vh;
    }

    .main-banner .carousel-item img {
        width: 100%;
        height: 100%;
        object-fit: cover;
        object-position: center; /* 이미지 가운데 정렬 */
    }

    .main-banner .carousel-caption {
        background: rgba(255, 255, 255, 0.8);
        padding: 20px;
        border-radius: 10px;
        color: #333;
        bottom: 40px;
        left: 50%;
        transform: translateX(-50%);
        width: auto;
        max-width: 80%;
    }

    .main-banner .carousel-caption h5 {
        font-size: 1.5em;
        margin-bottom: 10px;
    }

    .main-banner .carousel-caption p {
        font-size: 1.2em;
        margin-bottom: 0;
    }

    .carousel-indicators {
        gap: 5px;
        z-index: 3;
        margin-bottom: 0px;
    }
    .carousel-indicators li {
        background-color: #7AB2D3 !important;
        width: 10px; /* 버튼의 너비와 높이 동일 설정 */
        height: 10px; /* 버튼의 높이 */
        border-radius: 50%; /* 완전한 원형 */
        opacity: 0.5;
        border: none;
    }
    .carousel-indicators .active {
        opacity: 1;
    }
    .carousel-control-next, .carousel-control-prev {
        width: 5% !important;    
    }
    .carousel-control-prev-icon,
    .carousel-control-next-icon {
        padding: 15px;
    }

    /* 좌우 화살표 위치를 container-fluid 안으로 조정 */
    .carousel-control-prev {
        left: calc(50% - min(720px, 50%)) !important; /* 최대 1200px까지 유지하고, 창 크기에 맞춰서 줄어듦 */
    }

    .carousel-control-next {
        right: calc(50% - min(720px, 50%)) !important; /* 최대 1200px까지 유지하고, 창 크기에 맞춰서 줄어듦 */
    }

    /* 베스트 상품 스타일 */
    .tab-main {
        height: 60px; /* 버튼 높이 */
        display: flex; /* 텍스트 정렬을 위한 Flexbox */
        align-items: flex-end; /* 하단 정렬 */
        justify-content: center; /* 가로 가운데 정렬 */
        font-size: 20px; /* 글자 크기 */
        font-weight: bold;
        color: gray;
    }
    .tab-main.active {
        font-size: 24px; /* 글자 크기 */
        text-decoration: underline; /* 밑줄 */
        text-underline-offset: 5px; /* 밑줄과 글자 간격 조절 */
        text-decoration-thickness: 1px; /* 밑줄 두께 조절 */
        text-decoration-color: #4A628A; /* 밑줄 색상 */
        /* transition: all 0.3s ease; 호버 시 부드러운 전환 효과 */
        color: #4A628A;
    }

    .product-section {
        margin-bottom: 30px;
    }

    /* MD 추천 스타일 */
    .md-picks {
        margin: 0px 0;
        margin-bottom: 50px
    }

    .md-picks .slick-slide {
        margin: 0 15px;
    }

    .md-item {
        position: relative;
        height: 350px;
    }

    .md-item img {
        width: 100%;
        height: 100%;
        object-fit: cover;
        /* border-radius: 15px; */
        box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
    }

    .md-caption {
        position: absolute;
        bottom: 20px;
        left: 50%;
        transform: translateX(-50%);
        /* background: rgba(255, 255, 255, 0.9); */
        padding: 15px;
        /* border-radius: 10px; */
        text-align: center;
        width: 80%;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
    }

    .md-caption h5 {
        margin-bottom: 5px;
        font-size: 1.2em;
        color: #333;
    }

    .md-caption p {
        margin-bottom: 0;
        font-size: 0.9em;
        color: #666;
    }

    .slick-prev, .slick-next {
        z-index: 1;
        width: 40px;
        height: 40px;
        opacity: 0.5;
    }

    .slick-prev {
        left: -20px;
    }

    .slick-next {
        right: -20px;
    }

    .slick-prev:before, .slick-next:before {
        font-size: 40px;
        color: #7AB2D3;
        opacity: 0.3;
    }

    .slick-center {
        transform: scale(1.1);
        transition: transform 0.3s ease-in-out;
    }

    .section-title {
        text-align: left;
        padding-left: 16px;
        margin-bottom: 0;
    }

    .section-title p {
        font-size: 24px;
        color: #4A628A;
        position: relative;
        display: inline-block;
        text-decoration: underline; /* 밑줄 */
        text-underline-offset: 5px; /* 밑줄과 글자 간격 조절 */
        text-decoration-thickness: 1px; /* 밑줄 두께 조절 */
        text-decoration-color: #4A628A; /* 밑줄 색상 */
    }

    .more-btn-container {
        text-align: center;
        margin-top: 20px;
    }

    .more-btn {
        display: inline-flex; /* 텍스트와 아이콘 정렬을 위해 flex 사용 */
        justify-content: center; /* 가로 가운데 정렬 */
        align-items: center; /* 세로 가운데 정렬 */
        width: 200px; /* 버튼 너비 */
        height: 50px; /* 버튼 높이 */
        font-size: 18px; /* 텍스트 크기 */
        font-weight: bold; /* 텍스트 굵기 */
        color: #4A628A; /* 텍스트 색상 */
        text-decoration: none; /* 밑줄 제거 */
        background-color: #C4EFF8; /* 버튼 배경색 */
        border: none; /* 테두리 없음 */
        border-radius: 50px; /* 둥근 테두리 */
        cursor: pointer; /* 클릭 가능한 커서 */
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1); /* 부드러운 그림자 */
        transition: background-color 0.3s ease, transform 0.2s ease; /* 호버 및 클릭 효과 */
    }
    .more-btn:hover {
        background-color: #A8D8E9; /* 호버 시 배경색 변경 */
        transform: translateY(-2px); /* 약간의 상승 효과 */
        text-decoration: none;
    }
</style>
</head>
<body>

<!-- 메인 배너 섹션 -->
<div id="mainBanner" class="carousel slide main-banner" data-ride="carousel">
    <div class="carousel-indicators">
        <c:set var="index" value="0" />
        <c:forEach var="pb" items="${ requestScope.pbList }">
            <c:if test="${ not empty pb.bannerPath }">
                <li data-target="#mainBanner" 
                    data-slide-to="${ index }" 
                    class="${ index == 0 ? 'active' : '' }" 
                    aria-label="Slide ${ index + 1 }"></li>
                <c:set var="index" value="${ index + 1 }" />
            </c:if>
        </c:forEach>
    </div>
    <div class="carousel-inner">
        <c:set var="firstActive" value="true" />
        <c:forEach var="pb" items="${ requestScope.pbList }">
            <c:if test="${ not empty pb.bannerPath }">
                <div class="carousel-item ${ firstActive ? 'active' : '' }">
                    <a href="detail.pr?pno=${ pb.prodNo }">
                        <img src="${ pageContext.request.contextPath }${ pb.bannerPath }${ pb.saveFileName }" 
                            class="d-block w-100" alt="${ pb.origFileName }">
                    </a>
                </div>
                <!-- <div class="carousel-caption">
                    <h5>유기농 스킨케어 세트</h5>
                    <p>89,000원</p>
                </div> -->
                <c:set var="firstActive" value="false" />
            </c:if>
        </c:forEach>
    </div>
    <div class="container-fluid">
    <a class="carousel-control-prev" href="#mainBanner" role="button" data-slide="prev">
        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
        <span class="sr-only">이전</span>
    </a>
    <a class="carousel-control-next" href="#mainBanner" role="button" data-slide="next">
        <span class="carousel-control-next-icon" aria-hidden="true"></span>
        <span class="sr-only">다음</span>
    </a>
    </div>
</div>

<!-- 베스트 상품 섹션 -->
<div class="container product-section">
    <ul class="nav main-tabs" id="mainTabs" role="tablist">
        <li class="nav-item">
            <a class="tab-main nav-link active" id="best-tab" data-toggle="tab" href="#best" role="tab">베스트 상품</a>
        </li>
        <li class="nav-item">
            <a class="tab-main nav-link" id="new-tab" data-toggle="tab" href="#new" role="tab">신상품</a>
        </li>
    </ul>
    <div class="tab-content" id="productTabsContent">
        <div class="tab-pane fade show active" id="best" role="tabpanel">
            <div class="row" id="productList">
                <c:forEach var="p" items="${ requestScope.pList }">
                    <div class="col-md-3 col-sm-4 col-6 mb-4">
                        <div class="card product-card position-relative" data-id="1" onclick="location.href='detail.pr?pno=${ p.prodNo }';">
                            <div class="card-img-container">
                                <img src="${ pageContext.request.contextPath }${ p.thumbImg }" class="card-img-top" alt="상품 이미지">
                                <div class="overlay">
                                    <button class="btn btn-light btn-sm rounded-circle shadow add-cart" title="장바구니 추가"
                                            data-prodno="${ p.prodNo }"
                                            data-memberid="${sessionScope.loginUser.memberId}">
                                        <!-- <i class="fas fa-cart-arrow-down"></i> -->
                                        <span class="material-symbols-outlined active">
                                            add_shopping_cart
                                        </span>
                                    </button>
                                    <button class="btn btn-light btn-sm rounded-circle shadow wishlist-btn" title="찜하기" 
                                            data-iswished="${p.isWished}" data-prodno="${ p.prodNo }"
                                            data-memberid="${sessionScope.loginUser.memberId}">
                                        <span class="material-symbols-outlined ${p.isWished > 0 ? 'active' : ''}">
                                            favorite
                                        </span>
                                    </button>
                                </div>
                            </div>
                            <div class="card-body text-center">
                                <h5 class="card-title">${ p.prodName }</h5>
                                <p class="card-text text-muted">${ p.prodContent }</p>
                                
                                <p class="card-text font-weight-bold">
                                    <fmt:formatNumber value="${ p.prodPrice }" type="number" pattern="#,###" /><small>원</small><br>
                                    <small class="text-danger" style="text-decoration: line-through;">
                                        <fmt:formatNumber value="${ p.prodPrice * 1.2 }" type="number" pattern="#,###" />원
                                    </small>
                                    <span class="text-danger">20% 할인</span>
                                </p>
                                <p class="card-text">
                                    <span class="review-stars">
                                        <c:forEach begin="1" end="5" var="i">
                                            <c:choose>
                                                <c:when test="${i <= p.avgRating}"><!-- 가득 찬 별 -->
                                                    <i class="fas fa-star"></i>
                                                </c:when>
                                                <c:when test="${i - 0.5 < p.avgRating && i > p.avgRating}"><!-- 반 개 별 -->
                                                    <i class="fas fa-star-half-alt"></i>
                                                </c:when>
                                                <c:otherwise><!-- 빈 별 -->
                                                    <i class="far fa-star"></i>
                                                </c:otherwise>
                                            </c:choose>
                                        </c:forEach>
                                    </span>
                                    <span>${p.avgRating}</span>
                                    <span class="text-muted small">(${p.reviewCount})</span>
                                </p>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
            <div class="more-btn-container">
                <a href="${ pageContext.request.contextPath }/list.pr?sortBy=sales" class="more-btn">더보기 +</a>
            </div>
        </div>
        <div class="tab-pane fade fade" id="new" role="tabpanel">
            <div class="row" id="productList">
                <c:forEach var="n" items="${ requestScope.nList }">
                    <div class="col-md-3 col-sm-4 col-6 mb-4">
                        <div class="card product-card position-relative" data-id="1" onclick="location.href='detail.pr?pno=${ n.prodNo }';">
                            <div class="card-img-container">
                                <img src="${ pageContext.request.contextPath }${ n.thumbImg }" class="card-img-top" alt="상품 이미지">
                                <div class="overlay">
                                    <button class="btn btn-light btn-sm rounded-circle shadow add-cart" title="장바구니 추가"
                                            data-prodno="${ n.prodNo }"
                                            data-memberid="${sessionScope.loginUser.memberId}">
                                        <!-- <i class="fas fa-cart-arrow-down"></i> -->
                                        <span class="material-symbols-outlined active">
                                            add_shopping_cart
                                        </span>
                                    </button>
                                    <button class="btn btn-light btn-sm rounded-circle shadow wishlist-btn" title="찜하기" 
                                            data-iswished="${n.isWished}" data-prodno="${ n.prodNo }"
                                            data-memberid="${sessionScope.loginUser.memberId}">
                                        <span class="material-symbols-outlined ${n.isWished > 0 ? 'active' : ''}">
                                            favorite
                                        </span>
                                    </button>
                                </div>
                            </div>
                            <div class="card-body text-center">
                                <h5 class="card-title">${ n.prodName }</h5>
                                <p class="card-text text-muted">${ n.prodContent }</p>
                                
                                <p class="card-text font-weight-bold"><fmt:formatNumber value="${ n.prodPrice }" type="number" pattern="#,###" /><small>원</small>
                                <small class="text-danger">${product.discountRate}% 할인</small></p>
                                <p class="card-text">
                                    <span class="review-stars">
                                        <c:forEach begin="1" end="5" var="i">
                                            <c:choose>
                                                <c:when test="${i <= n.avgRating}"><!-- 가득 찬 별 -->
                                                    <i class="fas fa-star"></i>
                                                </c:when>
                                                <c:when test="${i - 0.5 < n.avgRating && i > n.avgRating}"><!-- 반 개 별 -->
                                                    <i class="fas fa-star-half-alt"></i>
                                                </c:when>
                                                <c:otherwise><!-- 빈 별 -->
                                                    <i class="far fa-star"></i>
                                                </c:otherwise>
                                            </c:choose>
                                        </c:forEach>
                                    </span>
                                    <span>${n.avgRating}</span>
                                    <span class="text-muted small">(${n.reviewCount})</span>
                                </p>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
            <div class="more-btn-container">
                <a href="${ pageContext.request.contextPath }/list.pr?sortBy=recent" class="more-btn">더보기 +</a>
            </div>
        </div>
    </div>
</div>

<!-- MD 추천 섹션 -->
<div class="container">
    <div class="section-title">
        <p>이달의 MD 추천</p>
    </div>
</div>
<div class="container-fluid">
    <div class="md-picks">
        <c:forEach var="pb" items="${ requestScope.pbList }">
            <c:if test="${ not empty pb.mdPath }">
                <div class="md-item">
                    <a href="detail.pr?pno=${ pb.prodNo }">
                        <img src="${ pageContext.request.contextPath }${ pb.mdPath }${ pb.saveFileName }" 
                            alt="${ pb.origFileName }">
                        <!-- <div class="md-caption">
                            <h5>겨울철 수분 케어 아이템</h5>
                            <p>건조한 겨울 피부를 위한 특별 케어</p>
                        </div> -->
                    </a>
                </div>
            </c:if>
        </c:forEach>
    </div>
</div>

<!-- Slick Slider JS -->
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>

<script>
$(document).ready(function() {
    // 메인 배너 자동 슬라이드 설정
    $('#mainBanner').carousel({
        interval: 5000
    });

    // MD 추천 슬릭 슬라이더 설정
    $('.md-picks').slick({
        centerMode: true,
        centerPadding: '60px',
        slidesToShow: 3,
        slidesToScroll: 1,
        autoplay: true,
        autoplaySpeed: 5000,
        responsive: [
            {
                breakpoint: 768,
                settings: {
                    arrows: false,
                    centerMode: true,
                    centerPadding: '40px',
                    slidesToShow: 1
                }
            }
        ]
    });

    // 탭 전환 함수
    window.changeTab = function(type) {
        $('.tab-buttons button').removeClass('active');
        $(`.tab-buttons button[onclick*='${type}']`).addClass('active');
        
        if(type === 'new') {
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
});
</script>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>
<!-- product JS -->
<script src="${ pageContext.request.contextPath }/resources/js/product/product.js"></script>
</body>
</html>