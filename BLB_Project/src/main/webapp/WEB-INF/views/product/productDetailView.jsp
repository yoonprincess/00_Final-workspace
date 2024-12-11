<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" rel="stylesheet">
	<!-- product CSS -->
    <link rel="stylesheet" href="${ pageContext.request.contextPath }/resources/css/product/product.css">
<title>뷰라밸 - 제품상세보기</title>
</head>
<body class="body-offset">
	<%@ include file="/WEB-INF/views/common/header.jsp" %>
	
	<div class="container-fluid">
	<div class="container mt-5">
        <div class="row">
            <!-- 상품 이미지 -->
            <div class="col-lg-6 mb-4">
                <div id="productCarousel" class="carousel slide" data-ride="carousel">
                    <div class="carousel-inner">
                        <div class="carousel-item active">
                            <img src="/placeholder.svg?height=500&width=500" class="d-block w-100 product-image" alt="Product 1">
                        </div>
                        <div class="carousel-item">
                            <img src="/placeholder.svg?height=500&width=500" class="d-block w-100 product-image" alt="Product 2">
                        </div>
                        <div class="carousel-item">
                            <img src="/placeholder.svg?height=500&width=500" class="d-block w-100 product-image" alt="Product 3">
                        </div>
                    </div>
                    <a class="carousel-control-prev" href="#productCarousel" role="button" data-slide="prev">
                        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                        <span class="sr-only">Previous</span>
                    </a>
                    <a class="carousel-control-next" href="#productCarousel" role="button" data-slide="next">
                        <span class="carousel-control-next-icon" aria-hidden="true"></span>
                        <span class="sr-only">Next</span>
                    </a>
                </div>
                <div class="d-flex mt-3 overflow-auto">
                    <img src="/placeholder.svg?height=100&width=100" class="thumbnail mr-2 active-thumbnail" data-target="#productCarousel" data-slide-to="0">
                    <img src="/placeholder.svg?height=100&width=100" class="thumbnail mr-2" data-target="#productCarousel" data-slide-to="1">
                    <img src="/placeholder.svg?height=100&width=100" class="thumbnail mr-2" data-target="#productCarousel" data-slide-to="2">
                </div>
            </div>
            
            <!-- 상품 정보 -->
            <div class="col-lg-6 sticky-wrapper">
                <div class="product-info">
                    <h1 class="mb-3">내추럴 커버 로션</h1>
                    <div class="mb-3">
                        <span class="review-stars">
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                        </span>
                        <span class="ml-2 font-weight-bold">4.9</span>
                    </div>
                    <h2 class="mb-3">
                        <fmt:formatNumber value="29800" type="number" pattern="#,###" /><small>원</small>
                        <small class="text-danger">21% 할인</small>
                    </h2>
                    <p>배송비: 3,000원 (50,000원 이상 구매 시 무료)</p>
                    <p>적립금: L.POINT 1,000원 / 롯데카드 5% 추가</p>
                    
                    <form id="productForm">
                        <div class="form-group">
                            <label for="option">옵션 선택</label>
                            <select class="form-control" id="option">
                                <option value="">선택하세요</option>
                                <option value="1" data-price="0">기본 옵션</option>
                                <option value="2" data-price="5000">프리미엄 옵션 (+5,000원)</option>
                            </select>
                        </div>
                        <div id="selectedOptions"></div>
                        <div class="form-group">
                            <label>총 상품금액</label>
                            <h3 id="totalPrice">29,800원</h3>
                        </div>
                        <div class="form-group">
                            <button type="button" class="btn btn-outline-primary btn-lg mr-2" id="addToCart">
                                <i class="fas fa-shopping-cart mr-2"></i>장바구니
                            </button>
                            <button type="button" class="btn btn-primary btn-lg" id="buyNow">바로구매</button>
                            <button class="btn btn-outline-danger"><span class="material-symbols-outlined">
                                favorite
                            </span></button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <!-- 탭 메뉴 -->
        <ul class="nav nav-tabs mt-5" id="productTabs" role="tablist">
            <li class="nav-item">
                <a class="nav-link active" id="details-tab" data-toggle="tab" href="#details" role="tab">상세정보</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" id="reviews-tab" data-toggle="tab" href="#reviews" role="tab">상품리뷰 <span class="badge badge-secondary">624</span></a>
            </li>
            <li class="nav-item">
                <a class="nav-link" id="qna-tab" data-toggle="tab" href="#qna" role="tab">상품문의 <span class="badge badge-secondary">12</span></a>
            </li>
        </ul>
        <div class="tab-content" id="productTabsContent">
            <div class="tab-pane fade show active" id="details" role="tabpanel">
                <img src="/placeholder.svg?height=1000&width=800" alt="Product Details" class="img-fluid">
                <pre>




















































































                </pre>
            </div>
            <div class="tab-pane fade" id="reviews" role="tabpanel">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h2>상품리뷰</h2>
                    <button class="btn btn-primary">리뷰작성</button>
                </div>
                <div class="row mb-4">
                    <div class="col-md-6">
                        <div class="d-flex align-items-center mb-2">
                            <span class="h2 font-weight-bold mr-2">4.9</span>
                            <div class="review-stars">
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                            </div>
                        </div>
                        <div class="progress mb-2" style="height: 20px;">
                            <div class="progress-bar bg-warning" role="progressbar" style="width: 90%;" aria-valuenow="90" aria-valuemin="0" aria-valuemax="100">5점 (90%)</div>
                        </div>
                        <div class="progress mb-2" style="height: 20px;">
                            <div class="progress-bar bg-warning" role="progressbar" style="width: 7%;" aria-valuenow="7" aria-valuemin="0" aria-valuemax="100">4점 (7%)</div>
                        </div>
                        <div class="progress mb-2" style="height: 20px;">
                            <div class="progress-bar bg-warning" role="progressbar" style="width: 2%;" aria-valuenow="2" aria-valuemin="0" aria-valuemax="100">3점 (2%)</div>
                        </div>
                        <div class="progress mb-2" style="height: 20px;">
                            <div class="progress-bar bg-warning" role="progressbar" style="width: 1%;" aria-valuenow="1" aria-valuemin="0" aria-valuemax="100">2점 (1%)</div>
                        </div>
                        <div class="progress mb-2" style="height: 20px;">
                            <div class="progress-bar bg-warning" role="progressbar" style="width: 0%;" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100">1점 (0%)</div>
                        </div>
                    </div>
                </div>
                <div id="reviewList"></div>
                <nav aria-label="Page navigation for reviews">
                    <ul class="pagination justify-content-center" id="reviewPagination"></ul>
                </nav>
            </div>
            <div class="tab-pane fade" id="qna" role="tabpanel">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h2>상품문의</h2>
                    <button class="btn btn-primary">문의하기</button>
                </div>
                <div id="qnaList"></div>
                <nav aria-label="Page navigation for qna">
                    <ul class="pagination justify-content-center" id="qnaPagination"></ul>
                </nav>
            </div>
        </div>
    </div>
    </div>
    
	
	<%@ include file="/WEB-INF/views/common/footer.jsp" %>
	<!-- product JS -->
    <script src="${ pageContext.request.contextPath }/resources/js/product/product.js"></script>
</body>
</html>