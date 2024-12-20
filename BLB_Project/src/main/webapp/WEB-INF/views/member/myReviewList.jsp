<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰 | 뷰라밸 (Beauty Life Balance)</title>
<link rel="stylesheet" href="resources/css/member//myReviewList.css">

<script src="resources/js/member/myReviewList.js" defer></script>   

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.0/css/all.min.css" integrity="sha512-10/jx2EXwxxWqCLX/hHth/vu2KY3jCF70dCQB8TSgNjbCVAC/8vai53GfMDrO2Emgwccf2pJqxct9ehpzG+MTw==" crossorigin="anonymous" referrerpolicy="no-referrer" />

</head>
<body class="body-offset">
    <div class="outer container-fluid">
    <%@ include file="/WEB-INF/views/common/header.jsp" %> 
        <div id="main">
             <%@ include file="/WEB-INF/views/member/menubar.jsp" %>
             <div class="container">
              <div class="tabs">
            	<button class="tab active">나의 리뷰</button>
         	  </div>
      	 	  <p class="notice">리뷰 정책 위반으로 블라인드 된 리뷰는 상품상세페이지 리뷰목록에 노출되지 않습니다.</p>
              <div class="highlight" style="padding:0px 20px;">누적 리뷰건수 <span style="color:#7AB2D3; font-weight : 600;">${listCount}</span>건</div>        
       <br>
	<table class="order-table">
    <thead>
        <tr>
            <th colspan="1">상품</th>
            <th colspan="2">리뷰</th>
        </tr>
    </thead>
    <tbody>
        <c:if test="${empty rlist}">
            <tr class="result">
                <td colspan="3">
                    <div style="display: flex; flex-direction: column; align-items: center;">
                        <span class="material-symbols-outlined" style="font-size:40px;">error</span>
                        <br>
                        <div> 최근 1개월간 문의하신 내용이 없습니다.</div>
                    </div>
                </td>
            </tr>
        </c:if>

        <c:if test="${not empty rlist}">
            <c:forEach var="r" items="${rlist}">
                <tr class="result">
                    <td>
                        <a href="detail.pr?pno=${r.PROD_NO}">
                            <div class="product">
                                <img src="${pageContext.request.contextPath}/${r.THUMB_IMG}" alt="${r.PROD_NAME}" >
                                <div class="product-info">
                                    <div><span>구매일자</span> ${r.ORDER_DATE}</div>
                                    <div>${r.PROD_NAME}</div>
                                    <div><span>옵션 | </span>${r.OPT_NAME}</div>
                                </div>
                            </div>
                        </a>  
                    </td>
                    <td>
                        <div><span>작성일자</span> ${r.REV_ENROLL_DATE}</div>
                        <div class="rating" style="color: #ffc107;">
                            <span class="review-stars">
                                <c:forEach var="i" begin="1" end="${r.REV_RATING}">
                                    <i class="fas fa-star"></i>
                                </c:forEach>
                                <c:forEach var="i" begin="1" end="${5 - r.REV_RATING}">
                                    <i class="far fa-star"></i>
                                </c:forEach>
                            </span>
                        </div>
                        <div>${r.REV_CONTENT}</div>
                    </td>
                    <td>
                        <div class="button-group">
                            <button class="button" onclick="updateReview('${r.REV_NO}');">수정하기</button>
                        </div>
                        <div class="button-group">
                            <button class="button" onclick="updateReview('${r.REV_NO}');">리뷰보기</button>
                        </div>
                    </td>
                </tr>
            </c:forEach>
        </c:if>
    </tbody>
</table>
	
	        
		            <br><br>
	 <!-- 페이지네이션 -->
				<nav>
					<ul class="pagination">
						<!-- 이전 페이지 그룹 -->
						<c:if test="${ pi.startPage > 1 }">
							<li class="page-item">
								<a href="reviewList.me?ppage=${ pi.startPage - pi.pageLimit }">
									＜
								</a>
							</li>
						</c:if>
						
						<!-- 페이지 번호 -->
						<c:forEach var="p" begin="${ pi.startPage }" end="${ pi.endPage }" step="1">
							<c:if test="${ p == pi.currentPage }">
								<li class="page-item">
									<a class="active" href="#">
										${ p }
									</a>
								</li>
							</c:if>
							<c:if test="${ p != pi.currentPage }">
								<li class="page-item">
									<a href="reviewList.me?ppage=${ p }">
										${ p }
									</a>
								</li>
							</c:if>
						</c:forEach>
						
						<!-- 다음 페이지 그룹 -->
						<c:if test="${ pi.endPage < pi.maxPage }">
							<li class="page-item">
								<a href="reviewList.me?ppage=${ pi.startPage + pi.pageLimit }">
									＞
								</a>
							</li>
						</c:if>
					</ul>
				</nav>
				<!-- 페이지네이션 end -->
	        </div>
	      </div>
	    </div>
   <%@ include file="/WEB-INF/views/common/footer.jsp" %>
  </body>
</html>