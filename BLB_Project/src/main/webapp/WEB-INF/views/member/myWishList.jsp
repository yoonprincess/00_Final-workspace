<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>찜한 리스트 | 뷰라밸 (Beauty Life Balance)</title>
<link rel="stylesheet" href="resources/css/member//myWishList.css">

<script src="resources/js/member/myWishList.js" defer></script>   

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.0/css/all.min.css" integrity="sha512-10/jx2EXwxxWqCLX/hHth/vu2KY3jCF70dCQB8TSgNjbCVAC/8vai53GfMDrO2Emgwccf2pJqxct9ehpzG+MTw==" crossorigin="anonymous" referrerpolicy="no-referrer" />

</head>
<body class="body-offset">
    <div class="outer container-fluid">
    <%@ include file="/WEB-INF/views/common/header.jsp" %> 
        <div id="main">
             <%@ include file="/WEB-INF/views/member/menubar.jsp" %>
             <div class="container">
              <div class="tabs">
            	<button class="tab active">찜한 리스트</button>
         	  </div>
      	 	  <p class="notice">찜한 상품은 최대 120일간 보관됩니다.</p>
              <div class="highlight" style="padding:0px 20px;">전체  <span style="color:#7AB2D3; font-weight : 600;">${listCount}</span>건</div>        
       <br>
       <div id="overlay" class="overlay">
        <span class="material-symbols-outlined" id="heart">heart_minus</span>
        <p id="message"></p>
	  </div>
	<table class="order-table">
    <thead>
        <tr>
            <th colspan="2">상품</th>
            <th >가격</th>
            <th >관리</th>
        </tr>
    </thead>
    <tbody>
        <c:if test="${empty wlist}">
            <tr class="result">
                <td colspan="4">
                    <div style="display: flex; flex-direction: column; align-items: center;">
                        <span class="material-symbols-outlined" style="font-size:40px;">error</span>
                        <br>
                        <div> 찜한 상품이 없습니다. </div>
                    </div>
                </td>
            </tr>
        </c:if>

        <c:if test="${not empty wlist}">
            <c:forEach var="wish" items="${wlist}">
                <tr class="result">
                    <td>
                      <a href="detail.pr?pno=${wish.prodName}">
                        <div class="product">
                          <img src="${pageContext.request.contextPath}/${wish.thumbImg}" alt="${wish.prodName}" >
                        </div>
                     </a>  
                    </td>            
                    <td>
                      <div class="product-info">
                          <div>${wish.prodName}</div>
                      </div>
                    </td>
                    <td>
                        <div>29,500원</div>
                        <div>${wish.prodPrice}</div>
                    </td>
                    <td>
                        <div class="button-group">
                            <button class="button" onclick="updateReview(${wish.prodNo});">장바구니</button>
                        </div>
                        <div class="button-group">
                            <button class="button" id="delete-wishlist" onclick="deleteWish(${wish.prodNo});">삭제</button>
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
								<a href="wishList.me?ppage=${ pi.startPage - pi.pageLimit }">
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
									<a href="wishList.me?ppage=${ p }">
										${ p }
									</a>
								</li>
							</c:if>
						</c:forEach>
						
						<!-- 다음 페이지 그룹 -->
						<c:if test="${ pi.endPage < pi.maxPage }">
							<li class="page-item">
								<a href="wishList.me?ppage=${ pi.startPage + pi.pageLimit }">
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