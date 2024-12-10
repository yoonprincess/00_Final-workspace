<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<!-- product CSS -->
    <link rel="stylesheet" href="${ pageContext.request.contextPath }/resources/css/product/product.css">
<title>뷰라밸 - 제품보기</title>
</head>
<body class="body-offset">
	<%@ include file="/WEB-INF/views/common/header.jsp" %>
    <div class="banner">
        <div class="container-fluid">
            <img src="${ pageContext.request.contextPath }/resources/images/product/all_banner.jpg">
        </div>
    </div>
    <div class="container-fluid">
	    <div class="container mt-5">
	        <!-- 필터 섹션 -->
	        <section class="filter-section mb-4">
	        	
	            <form action="list.pr" method="GET">
				    <h4>${ category }</h4>
				    <table class="table">
				        <input type="hidden" name="category" value="${ category }">
				        <tbody>
				            <c:choose>
				                <c:when test="${ category eq '전체제품' }">
				                    <tr>
				                        <th scope="row">스킨케어</th>
				                        <td>
				                            <label>
				                                <input type="checkbox" name="subcategories" value="스킨/에센스"
				                                    <c:if test="${ subcategories.contains('스킨/에센스') }">checked</c:if>> 
				                                스킨/에센스
				                            </label>
				                            <label>
				                                <input type="checkbox" name="subcategories" value="크림/로션"
				                                    <c:if test="${ subcategories.contains('크림/로션') }">checked</c:if>> 
				                                크림/로션
				                            </label>
				                            <label>
				                                <input type="checkbox" name="subcategories" value="클렌징"
				                                    <c:if test="${ subcategories.contains('클렌징') }">checked</c:if>> 
				                                클렌징
				                            </label>
				                            <label>
				                                <input type="checkbox" name="subcategories" value="선케어"
				                                    <c:if test="${ subcategories.contains('선케어') }">checked</c:if>> 
				                                선케어
				                            </label>
				                        </td>
				                    </tr>
				                    <tr>
				                        <th scope="row">메이크업</th>
				                        <td>
				                            <label>
				                                <input type="checkbox" name="subcategories" value="립"
				                                    <c:if test="${ subcategories.contains('립') }">checked</c:if>> 
				                                립
				                            </label>
				                            <label>
				                                <input type="checkbox" name="subcategories" value="베이스"
				                                    <c:if test="${ subcategories.contains('베이스') }">checked</c:if>> 
				                                베이스
				                            </label>
				                            <label>
				                                <input type="checkbox" name="subcategories" value="아이"
				                                    <c:if test="${ subcategories.contains('아이') }">checked</c:if>> 
				                                아이
				                            </label>
				                        </td>
				                    </tr>
				                    <tr>
				                        <th scope="row">맨즈</th>
				                        <td>
				                            <label>
				                                <input type="checkbox" name="subcategories" value="스킨"
				                                    <c:if test="${ subcategories.contains('스킨') }">checked</c:if>> 
				                                스킨
				                            </label>
				                            <label>
				                                <input type="checkbox" name="subcategories" value="메이크업"
				                                    <c:if test="${ subcategories.contains('메이크업') }">checked</c:if>> 
				                                메이크업
				                            </label>
				                            <label>
				                                <input type="checkbox" name="subcategories" value="헤어"
				                                    <c:if test="${ subcategories.contains('헤어') }">checked</c:if>> 
				                                헤어
				                            </label>
				                        </td>
				                    </tr>
				                    <tr>
				                        <th scope="row">헤어/바디</th>
				                        <td>
				                            <label>
				                                <input type="checkbox" name="subcategories" value="샴푸"
				                                    <c:if test="${ subcategories.contains('샴푸') }">checked</c:if>> 
				                                샴푸
				                            </label>
				                            <label>
				                                <input type="checkbox" name="subcategories" value="린스"
				                                    <c:if test="${ subcategories.contains('린스') }">checked</c:if>> 
				                                린스
				                            </label>
				                            <label>
				                                <input type="checkbox" name="subcategories" value="바디로션"
				                                    <c:if test="${ subcategories.contains('바디로션') }">checked</c:if>> 
				                                바디로션
				                            </label>
				                        </td>
				                    </tr>
				                </c:when>
				                <c:when test="${ category eq '스킨케어' }">
				                    <tr>
				                        <th scope="row">품목별 제품</th>
				                        <td>
				                            <label>
				                                <input type="checkbox" name="subcategories" value="스킨/에센스"
				                                    <c:if test="${ subcategories.contains('스킨/에센스') }">checked</c:if>> 
				                                스킨/에센스
				                            </label>
				                            <label>
				                                <input type="checkbox" name="subcategories" value="크림/로션"
				                                    <c:if test="${ subcategories.contains('크림/로션') }">checked</c:if>> 
				                                크림/로션
				                            </label>
				                            <label>
				                                <input type="checkbox" name="subcategories" value="클렌징"
				                                    <c:if test="${ subcategories.contains('클렌징') }">checked</c:if>> 
				                                클렌징
				                            </label>
				                            <label>
				                                <input type="checkbox" name="subcategories" value="선케어"
				                                    <c:if test="${ subcategories.contains('선케어') }">checked</c:if>> 
				                                선케어
				                            </label>
				                        </td>
				                    </tr>
				                </c:when>
				                <c:when test="${ category eq '메이크업' }">
				                    <tr>
				                        <th scope="row">품목별 제품</th>
				                        <td>
				                            <label>
				                                <input type="checkbox" name="subcategories" value="립"
				                                    <c:if test="${ subcategories.contains('립') }">checked</c:if>> 
				                                립
				                            </label>
				                            <label>
				                                <input type="checkbox" name="subcategories" value="베이스"
				                                    <c:if test="${ subcategories.contains('베이스') }">checked</c:if>> 
				                                베이스
				                            </label>
				                            <label>
				                                <input type="checkbox" name="subcategories" value="아이"
				                                    <c:if test="${ subcategories.contains('아이') }">checked</c:if>> 
				                                아이
				                            </label>
				                        </td>
				                    </tr>
				                </c:when>
				                <c:when test="${ category eq '맨즈' }">
				                    <tr>
				                        <th scope="row">품목별 제품</th>
				                        <td>
				                            <label>
				                                <input type="checkbox" name="subcategories" value="스킨"
				                                    <c:if test="${ subcategories.contains('스킨') }">checked</c:if>> 
				                                스킨
				                            </label>
				                            <label>
				                                <input type="checkbox" name="subcategories" value="메이크업"
				                                    <c:if test="${ subcategories.contains('메이크업') }">checked</c:if>> 
				                                메이크업
				                            </label>
				                            <label>
				                                <input type="checkbox" name="subcategories" value="헤어"
				                                    <c:if test="${ subcategories.contains('헤어') }">checked</c:if>> 
				                                헤어
				                            </label>
				                        </td>
				                    </tr>
				                </c:when>
				                <c:when test="${ category eq '헤어/바디' }">
				                    <tr>
				                        <th scope="row">품목별 제품</th>
				                        <td>
				                            <label>
				                                <input type="checkbox" name="subcategories" value="샴푸"
				                                    <c:if test="${ subcategories.contains('샴푸') }">checked</c:if>> 
				                                샴푸
				                            </label>
				                            <label>
				                                <input type="checkbox" name="subcategories" value="린스"
				                                    <c:if test="${ subcategories.contains('린스') }">checked</c:if>> 
				                                린스
				                            </label>
				                            <label>
				                                <input type="checkbox" name="subcategories" value="바디로션"
				                                    <c:if test="${ subcategories.contains('바디로션') }">checked</c:if>> 
				                                바디로션
				                            </label>
				                        </td>
				                    </tr>
				                </c:when>
				            </c:choose>
				        </tbody>
				    </table>
				    <div class="d-flex justify-content-center">
				        <button id="resetFilters" class="btn btn-secondary btn-sm" type="button"
				                onclick="location.href='list.pr?category=${ category }'">초기화</button>
				        <button type="submit" class="btn btn-success btn-sm">선택 조건 상품보기</button>
				    </div>
				</form>
	        </section>
	
	        <!-- 정렬 및 보기 설정 -->
	        <div class="d-flex justify-content-between align-items-center mb-3">
	            <span>상품: <strong id="totalProducts">${ pi.listCount }</strong>개</span>
	            <div class="d-flex">
	                <select id="sortBy" class="form-control form-control-sm mr-2">
	                	<option value="recent" ${ sortBy == 'recent' ? 'selected' : '' }>최신순</option>
					    <option value="recommended" ${ sortBy == 'recommended' ? 'selected' : '' }>추천순</option>
					    <option value="popular" ${ sortBy == 'popular' ? 'selected' : '' }>높은판매순</option>
					    <option value="lowPrice" ${ sortBy == 'lowPrice' ? 'selected' : '' }>낮은가격순</option>
					    <option value="highPrice" ${ sortBy == 'highPrice' ? 'selected' : '' }>높은가격순</option>
					</select>
					<select id="boardLimit" class="form-control form-control-sm">
					    <option value="12" ${ boardLimit == '12' ? 'selected' : '' }>12개씩</option>
					    <option value="20" ${ boardLimit == '20' ? 'selected' : '' }>20개씩</option>
					    <option value="40" ${ boardLimit == '40' ? 'selected' : '' }>40개씩</option>
					</select>
	            </div>
	        </div>
	
	        <!-- 상품 리스트 -->
	        <div class="row" id="productList">
	            <!-- 상품 카드 -->
	            <c:forEach var="p" items="${ requestScope.pList }">
		            <div class="col-md-3 col-sm-4 col-6 mb-4">
		                <div class="card product-card position-relative" data-id="1" onclick="location.href='detail.pr?pno=${ p.prodNo }';">
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
		                        <h5 class="card-title">${ p.prodName }</h5>
		                        <p class="card-text text-muted">${ p.prodContent }</p>
		                        <p class="card-text font-weight-bold">${ p.prodPrice }</p>
		                        <p class="card-text text-warning">★ ★ ★ ★ ☆ (4.5)</p>
		                    </div>
		                </div>
		            </div>
	            </c:forEach>
	            
	        </div>
	        <!-- 페이지네이션 -->
			<nav>
			    <ul class="pagination">
			        <c:choose>
			            <c:when test="${ requestScope.pi.currentPage ne 1 }">
			                <li class="page-item">
			                    <a href="list.pr?category=${ category }&sortBy=${ param.sortBy }&boardLimit=${ param.boardLimit }&ppage=${ requestScope.pi.currentPage - 1 }&<c:forEach var='sub' items='${ paramValues.subcategories }'>subcategories=${ sub }&</c:forEach>">
			                        ＜
			                    </a>
			                </li>
			            </c:when>
			        </c:choose>
			        
			        <c:forEach var="p" begin="${ requestScope.pi.startPage }" end="${ requestScope.pi.endPage }" step="1">
			            <c:choose>
			                <c:when test="${ p ne requestScope.pi.currentPage }">
			                    <li class="page-item">
			                        <a href="list.pr?category=${ category }&sortBy=${ param.sortBy }&boardLimit=${ param.boardLimit }&ppage=${ p }&<c:forEach var='sub' items='${ paramValues.subcategories }'>subcategories=${ sub }&</c:forEach>">
			                            ${ p }
			                        </a>
			                    </li>
			                </c:when>
			                <c:otherwise>
			                    <li class="page-item">
			                        <a class="active" href="list.pr?category=${ category }&sortBy=${ param.sortBy }&boardLimit=${ param.boardLimit }&ppage=${ p }&<c:forEach var='sub' items='${ paramValues.subcategories }'>subcategories=${ sub }&</c:forEach>">
			                            ${ p }
			                        </a>
			                    </li>
			                </c:otherwise>
			            </c:choose>
			        </c:forEach>
			        
			        <c:choose>
			            <c:when test="${ requestScope.pi.currentPage ne requestScope.pi.maxPage }">
			                <li class="page-item">
			                    <a href="list.pr?category=${ category }&sortBy=${ param.sortBy }&boardLimit=${ param.boardLimit }&ppage=${ requestScope.pi.currentPage + 1 }&<c:forEach var='sub' items='${ paramValues.subcategories }'>subcategories=${ sub }&</c:forEach>">
			                        ＞
			                    </a>
			                </li>
			            </c:when>
			        </c:choose>
			    </ul>
			</nav>
	        <!-- 페이지네이션 end -->
	    </div>
	</div>
	<%@ include file="/WEB-INF/views/common/footer.jsp" %>
	<!-- product JS -->
    <script src="${ pageContext.request.contextPath }/resources/js/product/product.js"></script>
</body>
</html>