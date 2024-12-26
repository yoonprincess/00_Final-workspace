<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<!-- product CSS -->
    <link rel="stylesheet" href="${ pageContext.request.contextPath }/resources/css/product/product.css">
<title>뷰라밸 - 제품상세보기</title>
</head>
<body class="body-offset">

	<div class="container-fluid">
	<div class="container mt-5">
        <div class="row">
            <!-- 상품 이미지 -->
            <div class="col-lg-6 mb-4">
                <div id="productCarousel" class="carousel slide" data-ride="carousel">
                    <c:set var="firstActive" value="true" />
                    <div class="carousel-inner">
                    	<c:forEach var="pa" items="${ requestScope.paList }">
					        <c:if test="${ not empty pa.thumbPath }">
							    <div class="carousel-item ${ firstActive ? 'active' : '' }">
						            <img src="${ pageContext.request.contextPath }${ pa.thumbPath }${ pa.saveFileName }" 
						                 class="d-block w-100 product-image" 
						                 alt="${ pa.origFileName }">
							    </div>
                                <c:set var="firstActive" value="false" />
					        </c:if>
						</c:forEach>
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
					<c:forEach var="pa" items="${ requestScope.paList }" varStatus="status">
						<c:if test="${ not empty pa.thumbPath }">
	                    	<img src="${ pageContext.request.contextPath }${ pa.thumbPath }${ pa.saveFileName }" class="thumbnail mr-2 ${status.first ? 'active-thumbnail' : ''}" data-target="#productCarousel" data-slide-to="${ status.index }">
	                    </c:if>
                    </c:forEach>
                </div>
            </div>
            
            <!-- 상품 정보 -->
            <div class="col-lg-6 sticky-wrapper">
                <div class="product-info">
                    <h1 class="mb-3">${ requestScope.p.prodName }</h1>
                    <p class="text-muted">${ requestScope.p.prodContent }</p>
                    <div class="mb-3 top-review">
                        <span class="review-stars">
                            <c:forEach begin="1" end="5" var="i">
                                <c:choose>
                                    <c:when test="${i <= reviewStats.avgRating}"><!-- 가득 찬 별 -->
                                        <i class="fas fa-star"></i>
                                    </c:when>
                                    <c:when test="${i - 0.5 < reviewStats.avgRating && i > reviewStats.avgRating}"><!-- 반 개 별 -->
                                        <i class="fas fa-star-half-alt"></i>
                                    </c:when>
                                    <c:otherwise><!-- 빈 별 -->
                                        <i class="far fa-star"></i>
                                    </c:otherwise>
                                </c:choose>
                            </c:forEach>
                        </span>
                        <span class="ml-1 font-weight-bold">${reviewStats.avgRating}</span>
                        <span class="text-muted small">(${reviewStats.totalReviews})</span>
                    </div>
                    <h2 class="mb-3">
                        <fmt:formatNumber value="${ p.prodPrice }" type="number" pattern="#,###" /><small>원</small>
                        <small class="text-danger" style="text-decoration: line-through;">
                            <fmt:formatNumber value="${ p.prodPrice * 1.2 }" type="number" pattern="#,###" />원
                        </small>
                        <small class="text-danger">20% 할인</small>
                    </h2>
                    <input type="hidden" id="base-price" value="${ requestScope.p.prodPrice }">
                    <p>배송비: 3,000원 (50,000원 이상 구매 시 무료)</p>
                    <p>적립금: L.POINT 1,000원 / 롯데카드 5% 추가</p>
                    
                    <form id="productForm">
	                    <div class="form-group">
						    <label for="product-option">옵션 선택</label>
						    <select class="form-control" id="product-option">
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
						</div>
                        <div id="selectedOptions"></div>
                        <div class="form-group">
                            <label>총 상품금액</label>
                            <h2 id="totalPrice"><fmt:formatNumber value="${ requestScope.p.prodPrice }" type="number" pattern="#,###" /><small>원</small></h2>
                        </div>
                        <div class="form-group">
                            <button type="button" class="btn btn-outline-primary btn-lg mr-2 blb-btn" id="cartAddForm"
                                    data-prodno="${ p.prodNo }"
                                    data-memberid="${sessionScope.loginUser.memberId}">
                                <i class="fas fa-cart-arrow-down mr-0"></i>
                                <!-- <span class="material-symbols-outlined">add_shopping_cart</span> -->
                                장바구니
                            </button>
                            <button type="button" class="btn btn-primary btn-lg mr-2 blb-btn" id="buyNow">
                                바로구매
                            </button>
                            <button class="btn btn-outline-danger blb-btn wishlist-btn" title="찜하기" 
                                    data-iswished="${isWished}" data-prodno="${ p.prodNo }"
                                    data-memberid="${sessionScope.loginUser.memberId}">
                                <span class="material-symbols-outlined ${isWished > 0 ? 'active' : ''}">
                                    favorite
                                </span>
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <!-- 탭 고정 위치 -->
        <div class="origin-tab-location"></div>

        <!-- 탭 메뉴 -->
        <ul class="nav nav-tabs body-offset" id="productTabs" role="tablist">
            <li class="nav-item">
                <a class="tab-item nav-link active" id="details-tab" data-toggle="tab" href="#details" role="tab">상세정보</a>
            </li>
            <li class="nav-item">
                <a class="tab-item nav-link" id="reviews-tab" data-toggle="tab" href="#reviews" role="tab">상품리뷰 <span class="badge badge-secondary">${ revPi.listCount }</span></a>
            </li>
            <li class="nav-item">
                <a class="tab-item nav-link" id="qna-tab" data-toggle="tab" href="#qna" role="tab">상품문의 <span class="badge badge-secondary">${ qnaPi.listCount }</span></a>
            </li>
        </ul>
        <div class="tab-content" id="productTabsContent">
            <div class="tab-pane fade show active" id="details" role="tabpanel">
            	<c:forEach var="pa" items="${ requestScope.paList }" varStatus="status">
					<c:if test="${ empty pa.thumbPath }">
                    	<img src="${ pageContext.request.contextPath }${ pa.savePath }${ pa.saveFileName }" 
                             alt="${ pa.origFileName }" 
                             class="img-fluid full-width-image">
                    </c:if>
                </c:forEach>
                <div class="container pt-2 pb-5">
                    <!-- 화장품 성분 -->
                    <div class="cosmetic-ingredients mb-4">
                        <h2 class="section-title">화장품 성분</h2>
                        <div class="content-box">${ requestScope.p.prodOrigin }</div>
                    </div>
                
                    <!-- 주의사항 -->
                    <div class="cosmetic-warnings">
                        <h2 class="section-title">사용 시 주의사항</h2>
                        <div class="content-box">${ requestScope.p.prodCaution }</div>
                    </div>
                </div>
            </div>


            <!-- 상품 리뷰 -->
            <div class="tab-pane fade" id="reviews" role="tabpanel">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h2>상품리뷰</h2>
                    <button 
                        class="btn btn-primary blb-btn" 
                        id="writeReviewBtn" 
                        data-prodno="${p.prodNo}" 
                        data-memberid="${sessionScope.loginUser.memberId}">
                        리뷰 작성하기
                    </button>
                </div>
                <c:choose>
                    <c:when test="${empty revList}">
                        <div class="text-center">
                            <p>등록된 리뷰가 없습니다.</p>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="row mb-4 review-score-distribution">
                            <div class="col-md-6">
                                <div class="d-flex align-items-center mb-2">
                                    <span class="h2 font-weight-bold mr-2">${reviewStats.avgRating}</span>
                                    <div class="review-stars">
                                        <c:forEach begin="1" end="5" var="i">
                                            <c:choose>
                                                <c:when test="${i <= reviewStats.avgRating}"><!-- 가득 찬 별 -->
                                                    <i class="fas fa-star"></i>
                                                </c:when>
                                                <c:when test="${i - 0.5 < reviewStats.avgRating && i > reviewStats.avgRating}"><!-- 반 개 별 -->
                                                    <i class="fas fa-star-half-alt"></i>
                                                </c:when>
                                                <c:otherwise><!-- 빈 별 -->
                                                    <i class="far fa-star"></i>
                                                </c:otherwise>
                                            </c:choose>
                                        </c:forEach>
                                    </div>
                                </div>
                                <!-- 별점 분포 -->
                                <div class="custom-rating-distribution">
                                    <div class="custom-rating-row">
                                        <span class="custom-rating-label">아주 좋아요</span>
                                        <div class="custom-progress">
                                            <div class="custom-progress-bar bg-warning" role="progressbar"
                                                style="width: <fmt:formatNumber value="${(reviewStats.rating5 * 100) / reviewStats.totalReviews}" type="number" minFractionDigits="1" maxFractionDigits="1"/>%;"
                                                aria-valuenow="<fmt:formatNumber value="${(reviewStats.rating5 * 100) / reviewStats.totalReviews}" type="number" minFractionDigits="1" maxFractionDigits="1"/>"
                                                aria-valuemin="0" aria-valuemax="100">
                                            </div>
                                        </div>
                                        <span class="custom-rating-count">${reviewStats.rating5}</span>
                                    </div>

                                    <div class="custom-rating-row">
                                        <span class="custom-rating-label">맘에 들어요</span>
                                        <div class="custom-progress">
                                            <div class="custom-progress-bar bg-warning" role="progressbar"
                                                style="width: <fmt:formatNumber value="${(reviewStats.rating4 * 100) / reviewStats.totalReviews}" type="number" minFractionDigits="1" maxFractionDigits="1"/>%;"
                                                aria-valuenow="<fmt:formatNumber value="${(reviewStats.rating4 * 100) / reviewStats.totalReviews}" type="number" minFractionDigits="1" maxFractionDigits="1"/>"
                                                aria-valuemin="0" aria-valuemax="100">
                                            </div>
                                        </div>
                                        <span class="custom-rating-count">${reviewStats.rating4}</span>
                                    </div>

                                    <div class="custom-rating-row">
                                        <span class="custom-rating-label">보통이에요</span>
                                        <div class="custom-progress">
                                            <div class="custom-progress-bar bg-warning" role="progressbar"
                                                style="width: <fmt:formatNumber value="${(reviewStats.rating3 * 100) / reviewStats.totalReviews}" type="number" minFractionDigits="1" maxFractionDigits="1"/>%;"
                                                aria-valuenow="<fmt:formatNumber value="${(reviewStats.rating3 * 100) / reviewStats.totalReviews}" type="number" minFractionDigits="1" maxFractionDigits="1"/>"
                                                aria-valuemin="0" aria-valuemax="100">
                                            </div>
                                        </div>
                                        <span class="custom-rating-count">${reviewStats.rating3}</span>
                                    </div>

                                    <div class="custom-rating-row">
                                        <span class="custom-rating-label">그냥 그래요</span>
                                        <div class="custom-progress">
                                            <div class="custom-progress-bar bg-warning" role="progressbar"
                                                style="width: <fmt:formatNumber value="${(reviewStats.rating2 * 100) / reviewStats.totalReviews}" type="number" minFractionDigits="1" maxFractionDigits="1"/>%;"
                                                aria-valuenow="<fmt:formatNumber value="${(reviewStats.rating2 * 100) / reviewStats.totalReviews}" type="number" minFractionDigits="1" maxFractionDigits="1"/>"
                                                aria-valuemin="0" aria-valuemax="100">
                                            </div>
                                        </div>
                                        <span class="custom-rating-count">${reviewStats.rating2}</span>
                                    </div>

                                    <div class="custom-rating-row">
                                        <span class="custom-rating-label">별로에요</span>
                                        <div class="custom-progress">
                                            <div class="custom-progress-bar bg-warning" role="progressbar"
                                                style="width: <fmt:formatNumber value="${(reviewStats.rating1 * 100) / reviewStats.totalReviews}" type="number" minFractionDigits="1" maxFractionDigits="1"/>%;"
                                                aria-valuenow="<fmt:formatNumber value="${(reviewStats.rating1 * 100) / reviewStats.totalReviews}" type="number" minFractionDigits="1" maxFractionDigits="1"/>"
                                                aria-valuemin="0" aria-valuemax="100">
                                            </div>
                                        </div>
                                        <span class="custom-rating-count">${reviewStats.rating1}</span>
                                    </div>
                                </div>
                            </div>
                            <!-- 모든 첨부파일 썸네일 -->
                            <div class="col-md-6 all-thumbnails">
                                <div class="thumbnail-container short-thumbnails">
                                    <c:forEach var="image" items="${allRevAttList}">
                                        <img src="${ pageContext.request.contextPath }${image.savePath}${image.saveFileName}" alt="${iamge.origFileName}" class="review-thumbnail" onclick="openThumbModal('${ pageContext.request.contextPath }${image.savePath}${image.saveFileName}')">
                                    </c:forEach>
                                </div>
                                <button class="show-more-thumbnails-btn">더보기</button>
                            </div>
                            <!-- 이미지 모달 -->
                            <div id="thumbModal" class="modal review-image" style="display: none;" onclick="closeThumbModal()">
                                <span class="close-modal review-image" onclick="closeThumbModal()">&times;</span>
                                <div class="modal-content review-image">
                                    <img id="fullImage" src="" alt="확대 이미지">
                                </div>
                            </div>
                        </div>
                        <div id="reviewList">
                            <c:forEach var="review" items="${revList}">
                                <div class="card mb-3">
                                    <div class="card-body review-card">
                                        <div class="d-flex justify-content-between align-items-center mb-3">
                                            <!-- 리뷰 상단: 별점, 작성자, 작성일 -->
                                            <div>
                                                <span class="review-stars">
                                                    <c:forEach var="i" begin="1" end="${review.revRating}">
                                                        <i class="fas fa-star"></i>
                                                    </c:forEach>
                                                    <c:forEach var="i" begin="1" end="${5 - review.revRating}">
                                                        <i class="far fa-star"></i>
                                                    </c:forEach>
                                                </span>
                                                <span class="ml-2 font-weight-bold">${review.memberId}</span>
                                            </div>
                                            <small class="text-muted">
                                                <fmt:formatDate value="${review.revEnrollDate}" pattern="yyyy-MM-dd hh:mm" />
                                            </small>
                                        </div>
                        
                                        <!-- 리뷰 내용 -->
                                        <div class="review-content-container mb-3">
                                            <div class="review-content short-content">
                                                <p class="review-text">${review.revContent}</p>
                                            </div>
                                            <button class="show-more-btn" style="display: none;">더보기</button>
                                        </div>
                        
                                        <!-- 리뷰 이미지 썸네일 (최대 4개) -->
                                        <div class="review-images d-flex flex-wrap mb-3">
                                            <c:forEach var="image" items="${review.reviewAttList}" end="4">
                                                <div class="thumbnail-container">
                                                    <img src="${pageContext.request.contextPath}${image.savePath}${image.saveFileName}"
                                                        alt="리뷰 이미지" class="thumbnail"
                                                        onclick="openThumbModal('${pageContext.request.contextPath}${image.savePath}${image.saveFileName}')">
                                                </div>
                                            </c:forEach>
                                        </div>
                        
                                        <!-- 버튼 액션: 수정, 삭제, 좋아요 -->
                                        <div class="product-actions d-flex justify-content-between align-items-center">
                                            <button 
                                                class="like-btn btn btn-outline-secondary btn-sm" 
                                                id="likeReview"
                                                data-revno="${review.revNo}"
                                                data-memberid="${sessionScope.loginUser.memberId}">
                                                <i class="fas fa-thumbs-up"></i> <span>좋아요</span> <span class="like-count">0</span>
                                            </button>
                                            <c:if test="${sessionScope.loginUser.memberId == review.memberId}">
                                                <div>
                                                    <button 
                                                        class="btn btn-sm btn-outline-primary mr-2"
                                                        id="editReviewBtn"
                                                        data-revno="${review.revNo}"
                                                        data-prodno="${p.prodNo}" 
                                                        data-memberid="${review.memberId}"
                                                        >
                                                        수정
                                                    </button>
                                                    <button 
                                                        class="btn btn-sm btn-outline-danger mr-2"
                                                        id="deleteReviewBtn"
                                                        data-revno="${review.revNo}"
                                                        data-prodno="${p.prodNo}" 
                                                        data-memberid="${review.memberId}">
                                                        삭제
                                                    </button>
                                                </div>
                                            </c:if>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                        <!-- 리뷰 페이지네이션 -->
                        <nav aria-label="Rev Page navigation">
                            <ul class="pagination" id="rev-pagination">
                                <!-- 이전 페이지 그룹 -->
                                <c:if test="${ revPi.startPage > 1 }">
                                    <li class="page-item">
                                        <a data-url="detail.pr?pno=${ requestScope.p.prodNo }&rpage=${ revPi.startPage - revPi.pageLimit }">
                                            ＜
                                        </a>
                                    </li>
                                </c:if>
                                <!-- 페이지 번호 -->
                                <c:forEach var="rp" begin="${revPi.startPage}" end="${revPi.endPage}">
                                    <li class="page-item">
                                        <a class="${rp == revPi.currentPage ? 'active' : ''}" 
                                            data-url="detail.pr?pno=${ requestScope.p.prodNo }&rpage=${rp}">
                                            ${rp}
                                        </a>
                                    </li>
                                </c:forEach>
                                <!-- 다음 페이지 그룹 -->
                                <c:if test="${ revPi.endPage < revPi.maxPage }">
                                    <li class="page-item">
                                        <a data-url="detail.pr?pno=${ requestScope.p.prodNo }&rpage=${ revPi.startPage + revPi.pageLimit }">
                                            ＞
                                        </a>
                                    </li>
                                </c:if>
                            </ul>
                        </nav>
                    </c:otherwise>
                </c:choose>
            </div>


            <!-- 상품 문의 -->
            <div class="tab-pane fade" id="qna" role="tabpanel">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h2>상품문의</h2>
                    <button 
                        class="btn btn-primary blb-btn" 
                        id="writeQnaBtn" 
                        data-prodno="${p.prodNo}" 
                        data-memberid="${sessionScope.loginUser.memberId}">
                        문의하기
                    </button>
                </div>
                <c:choose>
                    <c:when test="${empty qnaList}">
                        <div class="text-center">
                            <p>등록된 문의글이 없습니다.</p>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div id="qnaList">
                            <c:forEach var="qna" items="${qnaList}">
                                <div class="card mb-3">
                                    <div class="card-body">
                                        <!-- 문의글 -->
                                         <!-- 버튼 액션: 수정, 삭제, 좋아요 -->
                                        <div class="product-actions d-flex justify-content-between align-items-center">
                                            <!-- 문의 내용 -->
                                            <div class="review-content-container mb-3">
                                                <div class="review-content short-content">
                                                    <p class="review-text">${qna.inquiryContent}</p>
                                                </div>
                                                <button class="show-more-btn" style="display: none;">더보기</button>
                                            </div>
                                            <!-- <p>${qna.inquiryContent}</p> -->
                                            <c:if test="${sessionScope.loginUser.memberId == qna.memberId}">
                                                <div>
                                                    <button 
                                                        class="btn btn-sm btn-outline-primary mr-2"
                                                        id="editQnaBtn"
                                                        data-inquiryno="${qna.inquiryNo}"
                                                        data-memberid="${qna.memberId}"
                                                        >
                                                        수정
                                                    </button>
                                                    <button 
                                                        class="btn btn-sm btn-outline-danger mr-2"
                                                        id="deleteQnaBtn"
                                                        data-inquiryno="${qna.inquiryNo}"
                                                        data-memberid="${qna.memberId}">
                                                        삭제
                                                    </button>
                                                </div>
                                            </c:if>
                                        </div>
                                        <p class="text-muted" style="margin-bottom: 0rem;">
                                            <b>${qna.memberId}</b> | ${qna.inquiryCreateDate}
                                        </p>
                    
                                        <!-- 답변 -->
                                        <c:if test="${not empty qna.replyList}">
                                            <div class="mt-3 p-3 bg-light">
                                                <c:forEach var="reply" items="${qna.replyList}" varStatus="status">
                                                    <!-- 첫 번째 답변이 아닌 경우에만 <hr> 출력 -->
                                                    <c:if test="${!status.first}">
                                                        <hr>
                                                    </c:if>
                                                    <strong>답변:</strong>
                                                    <p>${reply.inquiryReplyContent}</p>
                                                    <small class="text-muted">
                                                        <b>${reply.memberId}</b> | ${reply.inquiryReplyCreateDate}
                                                    </small>
                                                </c:forEach>
                                            </div>
                                        </c:if>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                        <!-- 상품문의 페이지네이션 -->
                        <nav aria-label="QnA Page navigation">
                            <ul class="pagination" id="qna-pagination">
                                <c:if test="${qnaPi.startPage > 1}">
                                    <li class="page-item">
                                        <a data-url="detail.pr?pno=${ requestScope.p.prodNo }&qpage=${qnaPi.startPage - qnaPi.pageLimit}">
                                            ＜
                                        </a>
                                    </li>
                                </c:if>
                                <c:forEach var="qp" begin="${qnaPi.startPage}" end="${qnaPi.endPage}">
                                    <li class="page-item">
                                        <a class="${qp == qnaPi.currentPage ? 'active' : ''}" 
                                           data-url="detail.pr?pno=${ requestScope.p.prodNo }&qpage=${qp}">
                                           ${qp}
                                        </a>
                                    </li>
                                </c:forEach>
                                <c:if test="${qnaPi.endPage < qnaPi.maxPage}">
                                    <li class="page-item">
                                        <a data-url="detail.pr?pno=${ requestScope.p.prodNo }&qpage=${qnaPi.startPage + qnaPi.pageLimit}">
                                            ＞
                                        </a>
                                    </li>
                                </c:if>
                            </ul>
                        </nav>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
    </div>
	
	<%@ include file="/WEB-INF/views/common/footer.jsp" %>
	<!-- product JS -->
    <script src="${ pageContext.request.contextPath }/resources/js/product/product.js"></script>

</body>
</html>