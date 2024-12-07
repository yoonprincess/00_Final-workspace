<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<!-- product CSS -->
    <link rel="stylesheet" href="${ pageContext.request.contextPath }/resources/css/product/product.css">
    <!-- product JS -->
    <script src="${ pageContext.request.contextPath }/resources/js/product/product.js"></script>
<title>뷰라밸 - 제품보기</title>
</head>
<body class="body-offset">
	<%@ include file="/WEB-INF/views/common/header.jsp" %>
    <div class="banner" style="background-color: #CCF2F4;">
        <div class="container-fluid">
            <img src="${ pageContext.request.contextPath }/resources/images/product/all_banner.jpg">
        </div>
    </div>
    <div class="container-fluid">
	    <div class="container mt-5">
	        <!-- 필터 섹션 -->
	        <section class="filter-section mb-4">
	            <h4>PRODUCT</h4>
	            <table class="table">
	                <tbody>
	                    <tr>
	                        <th scope="row">품목별 제품</th>
	                        <td>
	                            <label><input type="checkbox" name="filter" value="스킨/토너"> 스킨/토너</label>
	                            <label><input type="checkbox" name="filter" value="로션/크림"> 로션/크림</label>
	                            <label><input type="checkbox" name="filter" value="클렌저"> 클렌저</label>
	                            <label><input type="checkbox" name="filter" value="마스크/팩"> 마스크/팩</label>
	                        </td>
	                    </tr>
	                </tbody>
	            </table>
	            <div class="d-flex justify-content-center">
	                <button id="resetFilters" class="btn btn-secondary btn-sm">초기화</button>
	                <button id="applyFilters" class="btn btn-success btn-sm">선택 조건 상품보기</button>
	            </div>
	        </section>
	
	        <!-- 정렬 및 보기 설정 -->
	        <div class="d-flex justify-content-between align-items-center mb-3">
	            <span>상품: <strong id="totalProducts">120</strong>개</span>
	            <div class="d-flex">
	                <select id="sortBy" class="form-control form-control-sm mr-2">
	                    <option value="recommended">추천순</option>
	                    <option value="popular">높은판매순</option>
	                    <option value="lowPrice">낮은가격순</option>
	                    <option value="highPrice">높은가격순</option>
	                </select>
	                <select id="itemsPerPage" class="form-control form-control-sm">
	                    <option value="20">20개씩</option>
	                    <option value="40">40개씩</option>
	                    <option value="80">80개씩</option>
	                </select>
	            </div>
	        </div>
	
	        <!-- 상품 리스트 -->
	        <div class="row" id="productList">
	            <!-- 상품 카드 -->
	            <div class="col-md-3 col-sm-4 col-6 mb-4">
	                <div class="card product-card position-relative" data-id="1" onclick="location.href='product-detail.html';">
	                    <div class="card-img-container">
	                        <img src="${ pageContext.request.contextPath }/resources/images/product/product1.jpg" class="card-img-top" alt="상품 이미지">
	                        <div class="overlay">
	                            <button class="btn btn-light btn-sm rounded-circle shadow add-cart" title="장바구니 추가" data-id="1">
	                                <span class="material-symbols-outlined">
	                                    shopping_bag
	                                </span>
	                            </button>
	                            <button class="btn btn-light btn-sm rounded-circle shadow add-wishlist" title="찜하기" data-id="1">
	                                <span class="material-symbols-outlined">
	                                    favorite
	                                </span>
	                            </button>
	                        </div>
	                    </div>
	                    <div class="card-body text-center">
	                        <h5 class="card-title">상품명1</h5>
	                        <p class="card-text text-muted">고순도 황(10%) 성분, 제주도 화산재 함유</p>
	                        <p class="card-text font-weight-bold">₩12,900</p>
	                        <p class="card-text text-warning">★ ★ ★ ★ ☆ (4.5)</p>
	                    </div>
	                </div>
	            </div>
	            <!-- 더 많은 상품 카드 추가 -->
	            <div class="col-md-3 col-sm-4 col-6 mb-4">
	                <div class="card product-card position-relative" data-id="1" onclick="location.href='product-detail.html';">
	                    <div class="card-img-container">
	                        <img src="${ pageContext.request.contextPath }/resources/images/product/product1.jpg" class="card-img-top" alt="상품 이미지">
	                        <div class="overlay">
	                            <button class="btn btn-light btn-sm rounded-circle shadow add-cart" title="장바구니 추가" data-id="1">
	                                <span class="material-symbols-outlined">
	                                    shopping_bag
	                                </span>
	                            </button>
	                            <button class="btn btn-light btn-sm rounded-circle shadow add-wishlist" title="찜하기" data-id="1">
	                                <span class="material-symbols-outlined">
	                                    favorite
	                                </span>
	                            </button>
	                        </div>
	                    </div>
	                    <div class="card-body text-center">
	                        <h5 class="card-title">상품명1</h5>
	                        <p class="card-text text-muted">고순도 황(10%) 성분, 제주도 화산재 함유</p>
	                        <p class="card-text font-weight-bold">₩12,900</p>
	                        <p class="card-text text-warning">★ ★ ★ ★ ☆ (4.5)</p>
	                    </div>
	                </div>
	            </div>
	            <div class="col-md-3 col-sm-4 col-6 mb-4">
	                <div class="card product-card position-relative" data-id="1" onclick="location.href='product-detail.html';">
	                    <div class="card-img-container">
	                        <img src="${ pageContext.request.contextPath }/resources/images/product/product1.jpg" class="card-img-top" alt="상품 이미지">
	                        <div class="overlay">
	                            <button class="btn btn-light btn-sm rounded-circle shadow add-cart" title="장바구니 추가" data-id="1">
	                                <span class="material-symbols-outlined">
	                                    shopping_bag
	                                </span>
	                            </button>
	                            <button class="btn btn-light btn-sm rounded-circle shadow add-wishlist" title="찜하기" data-id="1">
	                                <span class="material-symbols-outlined">
	                                    favorite
	                                </span>
	                            </button>
	                        </div>
	                    </div>
	                    <div class="card-body text-center">
	                        <h5 class="card-title">상품명1</h5>
	                        <p class="card-text text-muted">고순도 황(10%) 성분, 제주도 화산재 함유</p>
	                        <p class="card-text font-weight-bold">₩12,900</p>
	                        <p class="card-text text-warning">★ ★ ★ ★ ☆ (4.5)</p>
	                    </div>
	                </div>
	            </div>
	            <div class="col-md-3 col-sm-4 col-6 mb-4">
	                <div class="card product-card position-relative" data-id="1" onclick="location.href='product-detail.html';">
	                    <div class="card-img-container">
	                        <img src="${ pageContext.request.contextPath }/resources/images/product/product1.jpg" class="card-img-top" alt="상품 이미지">
	                        <div class="overlay">
	                            <button class="btn btn-light btn-sm rounded-circle shadow add-cart" title="장바구니 추가" data-id="1">
	                                <span class="material-symbols-outlined">
	                                    shopping_bag
	                                </span>
	                            </button>
	                            <button class="btn btn-light btn-sm rounded-circle shadow add-wishlist" title="찜하기" data-id="1">
	                                <span class="material-symbols-outlined">
	                                    favorite
	                                </span>
	                            </button>
	                        </div>
	                    </div>
	                    <div class="card-body text-center">
	                        <h5 class="card-title">상품명1</h5>
	                        <p class="card-text text-muted">고순도 황(10%) 성분, 제주도 화산재 함유</p>
	                        <p class="card-text font-weight-bold">₩12,900</p>
	                        <p class="card-text text-warning">★ ★ ★ ★ ☆ (4.5)</p>
	                    </div>
	                </div>
	            </div>
	            <div class="col-md-3 col-sm-4 col-6 mb-4">
	                <div class="card product-card position-relative" data-id="1" onclick="location.href='product-detail.html';">
	                    <div class="card-img-container">
	                        <img src="${ pageContext.request.contextPath }/resources/images/product/product1.jpg" class="card-img-top" alt="상품 이미지">
	                        <div class="overlay">
	                            <button class="btn btn-light btn-sm rounded-circle shadow add-cart" title="장바구니 추가" data-id="1">
	                                <span class="material-symbols-outlined">
	                                    shopping_bag
	                                </span>
	                            </button>
	                            <button class="btn btn-light btn-sm rounded-circle shadow add-wishlist" title="찜하기" data-id="1">
	                                <span class="material-symbols-outlined">
	                                    favorite
	                                </span>
	                            </button>
	                        </div>
	                    </div>
	                    <div class="card-body text-center">
	                        <h5 class="card-title">상품명1</h5>
	                        <p class="card-text text-muted">고순도 황(10%) 성분, 제주도 화산재 함유</p>
	                        <p class="card-text font-weight-bold">₩12,900</p>
	                        <p class="card-text text-warning">★ ★ ★ ★ ☆ (4.5)</p>
	                    </div>
	                </div>
	            </div>
	            <div class="col-md-3 col-sm-4 col-6 mb-4">
	                <div class="card product-card position-relative" data-id="1" onclick="location.href='product-detail.html';">
	                    <div class="card-img-container">
	                        <img src="${ pageContext.request.contextPath }/resources/images/product/product1.jpg" class="card-img-top" alt="상품 이미지">
	                        <div class="overlay">
	                            <button class="btn btn-light btn-sm rounded-circle shadow add-cart" title="장바구니 추가" data-id="1">
	                                <span class="material-symbols-outlined">
	                                    shopping_bag
	                                </span>
	                            </button>
	                            <button class="btn btn-light btn-sm rounded-circle shadow add-wishlist" title="찜하기" data-id="1">
	                                <span class="material-symbols-outlined">
	                                    favorite
	                                </span>
	                            </button>
	                        </div>
	                    </div>
	                    <div class="card-body text-center">
	                        <h5 class="card-title">상품명1</h5>
	                        <p class="card-text text-muted">고순도 황(10%) 성분, 제주도 화산재 함유</p>
	                        <p class="card-text font-weight-bold">₩12,900</p>
	                        <p class="card-text text-warning">★ ★ ★ ★ ☆ (4.5)</p>
	                    </div>
	                </div>
	            </div>
	            <div class="col-md-3 col-sm-4 col-6 mb-4">
	                <div class="card product-card position-relative" data-id="1" onclick="location.href='product-detail.html';">
	                    <div class="card-img-container">
	                        <img src="${ pageContext.request.contextPath }/resources/images/product/product1.jpg" class="card-img-top" alt="상품 이미지">
	                        <div class="overlay">
	                            <button class="btn btn-light btn-sm rounded-circle shadow add-cart" title="장바구니 추가" data-id="1">
	                                <span class="material-symbols-outlined">
	                                    shopping_bag
	                                </span>
	                            </button>
	                            <button class="btn btn-light btn-sm rounded-circle shadow add-wishlist" title="찜하기" data-id="1">
	                                <span class="material-symbols-outlined">
	                                    favorite
	                                </span>
	                            </button>
	                        </div>
	                    </div>
	                    <div class="card-body text-center">
	                        <h5 class="card-title">상품명1</h5>
	                        <p class="card-text text-muted">고순도 황(10%) 성분, 제주도 화산재 함유</p>
	                        <p class="card-text font-weight-bold">₩12,900</p>
	                        <p class="card-text text-warning">★ ★ ★ ★ ☆ (4.5)</p>
	                    </div>
	                </div>
	            </div>
	            <div class="col-md-3 col-sm-4 col-6 mb-4">
	                <div class="card product-card position-relative" data-id="1" onclick="location.href='product-detail.html';">
	                    <div class="card-img-container">
	                        <img src="${ pageContext.request.contextPath }/resources/images/product/product1.jpg" class="card-img-top" alt="상품 이미지">
	                        <div class="overlay">
	                            <button class="btn btn-light btn-sm rounded-circle shadow add-cart" title="장바구니 추가" data-id="1">
	                                <span class="material-symbols-outlined">
	                                    shopping_bag
	                                </span>
	                            </button>
	                            <button class="btn btn-light btn-sm rounded-circle shadow add-wishlist" title="찜하기" data-id="1">
	                                <span class="material-symbols-outlined">
	                                    favorite
	                                </span>
	                            </button>
	                        </div>
	                    </div>
	                    <div class="card-body text-center">
	                        <h5 class="card-title">상품명1</h5>
	                        <p class="card-text text-muted">고순도 황(10%) 성분, 제주도 화산재 함유</p>
	                        <p class="card-text font-weight-bold">₩12,900</p>
	                        <p class="card-text text-warning">★ ★ ★ ★ ☆ (4.5)</p>
	                    </div>
	                </div>
	            </div>
	        </div>
	        <!-- 페이지네이션 -->
	        <nav>
	            <ul class="pagination">
	                <li><a href="#">«</a></li>
	                <li><a href="#" class="active">1</a></li>
	                <li><a href="#">2</a></li>
	                <li><a href="#">3</a></li>
	                <li><a href="#">4</a></li>
	                <li><a href="#">5</a></li>
	                <li><a href="#">»</a></li>
	            </ul>
	        </nav>
	    </div>
	</div>
	<%@ include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>