<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>메인 페이지</title>
    <style>
        /* 배너 영역 스타일 */
        .banner-section {
            margin-bottom: 30px;
        }

        .carousel .carousel-item img {
            height: 500px;
            object-fit: cover;
        }

        .carousel-caption {
            background-color: rgba(0, 0, 0, 0.5);
            padding: 10px;
            border-radius: 10px;
        }

        .carousel-indicators button {
            background-color: #4A628A;
        }

        .carousel-indicators .active {
            background-color: #FFD700;
        }

        /* 베스트 상품 및 신상품 영역 */
        .best-products-section h3 {
            font-size: 24px;
        }

        .best-products-section .card {
            box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1);
            border: none;
            border-radius: 10px;
            overflow: hidden;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .best-products-section .card:hover {
            transform: translateY(-5px);
            box-shadow: 0px 6px 10px rgba(0, 0, 0, 0.2);
        }

        .best-products-section .card-img-top {
            height: 200px;
            object-fit: cover;
        }

        /* MD 추천 영역 */
        .md-recommend-section h3 {
            font-size: 24px;
            text-align: center;
        }

        .carousel .carousel-item img {
            height: 300px;
            object-fit: cover;
        }

        .carousel-caption h5 {
            font-size: 18px;
            font-weight: bold;
        }

        .carousel-caption p {
            font-size: 14px;
            margin-top: 5px;
            color: #f0f0f0;
        }

        /* 공통 스타일 */
        .btn-primary {
            background-color: #4A628A;
            border-color: #4A628A;
        }

        .btn-primary:hover {
            background-color: #36537A;
            border-color: #36537A;
        }

        .btn-outline-primary {
            color: #4A628A;
            border-color: #4A628A;
        }

        .btn-outline-primary:hover {
            color: white;
            background-color: #4A628A;
            border-color: #4A628A;
        }

    </style>
</head>
<body>
    <!-- 배너 영역 -->
    <section class="banner-section">
        <div id="mainBannerCarousel" class="carousel slide" data-bs-ride="carousel">
            <div class="carousel-inner">
                <c:forEach var="banner" items="${bannerList}" varStatus="status">
                    <div class="carousel-item ${status.first ? 'active' : ''}">
                        <a href="detail.pr?pno=${banner.prodNo}">
                            <img src="${pageContext.request.contextPath}${banner.imagePath}" class="d-block w-100" alt="배너 이미지">
                        </a>
                        <div class="carousel-caption d-none d-md-block">
                            <h5>${banner.prodName}</h5>
                            <p><fmt:formatNumber value="${banner.prodPrice}" type="number" pattern="#,###" />원</p>
                        </div>
                    </div>
                </c:forEach>
            </div>
            <button class="carousel-control-prev" type="button" data-bs-target="#mainBannerCarousel" data-bs-slide="prev">
                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                <span class="visually-hidden">이전</span>
            </button>
            <button class="carousel-control-next" type="button" data-bs-target="#mainBannerCarousel" data-bs-slide="next">
                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                <span class="visually-hidden">다음</span>
            </button>
            <div class="carousel-indicators">
                <c:forEach var="banner" items="${bannerList}" varStatus="status">
                    <button type="button" data-bs-target="#mainBannerCarousel" data-bs-slide-to="${status.index}" class="${status.first ? 'active' : ''}" aria-current="${status.first ? 'true' : 'false'}"></button>
                </c:forEach>
            </div>
        </div>
    </section>

    <!-- 베스트 상품 및 신상품 영역 -->
    <section class="best-products-section mt-5">
        <div class="container">
            <div class="d-flex justify-content-between align-items-center mb-3">
                <h3 id="best-products-title" class="font-weight-bold">베스트 상품</h3>
                <button class="btn btn-outline-primary btn-sm" id="toggle-products">신상품 보기</button>
            </div>
            <div class="row" id="productList">
                <c:forEach var="product" items="${productList}">
                    <div class="col-md-3 col-sm-4 col-6 mb-4">
                        <div class="card product-card">
                            <a href="detail.pr?pno=${product.prodNo}">
                                <img src="${pageContext.request.contextPath}${product.thumbImg}" class="card-img-top" alt="상품 이미지">
                            </a>
                            <div class="card-body text-center">
                                <h5 class="card-title">${product.prodName}</h5>
                                <p class="card-text font-weight-bold">
                                    <fmt:formatNumber value="${product.prodPrice}" type="number" pattern="#,###" />원
                                </p>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
            <div class="text-center mt-3">
                <a href="list.pr?category=베스트" class="btn btn-primary">더보기</a>
            </div>
        </div>
    </section>

    <!-- 이달의 MD 추천 영역 -->
    <section class="md-recommend-section mt-5">
        <div class="container">
            <h3 class="font-weight-bold mb-3">이달의 MD 추천</h3>
            <div id="mdRecommendCarousel" class="carousel slide" data-bs-ride="carousel">
                <div class="carousel-inner">
                    <c:forEach var="md" items="${mdList}" varStatus="status">
                        <div class="carousel-item ${status.first ? 'active' : ''}">
                            <a href="detail.pr?pno=${md.prodNo}">
                                <img src="${pageContext.request.contextPath}${md.imagePath}" class="d-block w-100" alt="MD 추천 이미지">
                            </a>
                            <div class="carousel-caption d-none d-md-block">
                                <h5>${md.title}</h5>
                                <p>${md.subtitle}</p>
                            </div>
                        </div>
                    </c:forEach>
                </div>
                <button class="carousel-control-prev" type="button" data-bs-target="#mdRecommendCarousel" data-bs-slide="prev">
                    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                    <span class="visually-hidden">이전</span>
                </button>
                <button class="carousel-control-next" type="button" data-bs-target="#mdRecommendCarousel" data-bs-slide="next">
                    <span class="carousel-control-next-icon" aria-hidden="true"></span>
                    <span class="visually-hidden">다음</span>
                </button>
            </div>
        </div>
    </section>

    <%@ include file="/WEB-INF/views/common/footer.jsp" %>

    <script>
        $(document).ready(function () {
            // 자동 슬라이드 인터벌 설정 (Bootstrap 기본 기능 사용)
            $('.carousel').carousel({
                interval: 5000 // 5초 간격으로 슬라이드 전환
            });

            // 신상품 보기 / 베스트 상품 보기 토글 버튼
            $('#toggle-products').click(function () {
                const isBestView = $(this).text() === '신상품 보기';
                const newCategory = isBestView ? '신상품' : '베스트 상품';
                
                // 타이틀 변경
                $('#best-products-title').text(newCategory);
                $(this).text(isBestView ? '베스트 상품 보기' : '신상품 보기');
                
                // 상품 리스트 AJAX 요청 (category에 따라 변경)
                $.ajax({
                    url: 'getProductList.pr',
                    type: 'GET',
                    data: { category: newCategory },
                    success: function (data) {
                        // 서버에서 받아온 HTML로 리스트 변경
                        $('#productList').html(data);
                    },
                    error: function () {
                        alert('상품 목록을 불러오는데 실패했습니다.');
                    }
                });
            });

            // 배너 화살표 클릭 시 동작 (Bootstrap 기본 이벤트 활용)
            $('#mainBannerCarousel, #mdRecommendCarousel').on('slide.bs.carousel', function (event) {
                console.log('슬라이드 전환: ', event.relatedTarget);
            });

            // 배너 네비게이션 버튼 클릭 이벤트
            $('.carousel-indicators button').click(function () {
                const targetIndex = $(this).data('bs-slide-to');
                $('#mainBannerCarousel').carousel(targetIndex);
            });
        });

    </script>
</body>
</html>
