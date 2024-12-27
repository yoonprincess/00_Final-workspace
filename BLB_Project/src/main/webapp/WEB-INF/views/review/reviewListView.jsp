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
        
            <!-- 상품 리뷰 -->
            <div class="tab-pane fade show active" id="reviews" role="tabpanel">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h2>상품리뷰</h2>
                </div>
                <c:choose>
                    <c:when test="${empty revList}">
                        <div class="text-center">
                            <p>등록된 리뷰가 없습니다.</p>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="row mb-4 review-score-distribution">
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
                                        <a data-url="listAll.rv?rpage=${ revPi.startPage - revPi.pageLimit }">
                                            ＜
                                        </a>
                                    </li>
                                </c:if>
                                <!-- 페이지 번호 -->
                                <c:forEach var="rp" begin="${revPi.startPage}" end="${revPi.endPage}">
                                    <li class="page-item">
                                        <a class="${rp == revPi.currentPage ? 'active' : ''}" 
                                            data-url="listAll.rv?rpage=${rp}">
                                            ${rp}
                                        </a>
                                    </li>
                                </c:forEach>
                                <!-- 다음 페이지 그룹 -->
                                <c:if test="${ revPi.endPage < revPi.maxPage }">
                                    <li class="page-item">
                                        <a data-url="listAll.rv?rpage=${ revPi.startPage + revPi.pageLimit }">
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
	
	<%@ include file="/WEB-INF/views/common/footer.jsp" %>
	<!-- product JS -->
    <script src="${ pageContext.request.contextPath }/resources/js/product/product.js"></script>

</body>
</html>