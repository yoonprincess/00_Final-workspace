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
              <div class="highlight" style="padding:0px 20px;">
              전체  <span style="color:#7AB2D3; font-weight : 600;">${listCount}</span>건
              <div style="float:right;">
                     <button class="button" id="all-delete" onclick="confirmDelete();" >전체삭제</button>
                </div>
              </div>        
 				
 				
       <br>
       
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
                        <br>
                        <span class="material-symbols-outlined" style="font-size:90px; color:#7AB2D3;">error</span>
                        <br>
                         <div style="color:#7AB2D3"> 찜한 상품이 없습니다. </div>
                         <br>
                    </div>
                </td>
            </tr>
        </c:if>

        <c:if test="${not empty wlist}">
            <c:forEach var="wish" items="${wlist}">
                <tr class="result">
                    <td>
                      <a href="detail.pr?pno=${wish.prodNo}">
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
                    <td style="text-align:center;">
                        <div >
                          <span class="unit_b"><s><fmt:formatNumber value="${wish.prodPrice *1.2}" type="number"/></s>원</span>
                        </div>
                        <div>
                       	  <fmt:formatNumber value="${wish.prodPrice}" type="number"/><span class="unit">원</span>
                        </div>
                        
                    </td>
                    <td>
                        <div class="button-group">
                            <button class="btn-outline-primary blb-btn" onclick="openModal(${wish.prodNo});">장바구니</button>
                            <button class="btn-outline-primary blb-btn" id="delete-wishlist" onclick="deleteWish(${wish.prodNo});">삭제</button>
                        </div>
                    </td>
                </tr>
            </c:forEach>
        </c:if>
    </tbody>
    
</table>
	<!-- 옵션선택 모달창  -->
	 <div id="optModal" class="modal">
        <div class="modal-content" id="reviewIframeContainer" >
            <span class="close" style="color: white; margin-left:380px; margin-bottom:10px;">&times;</span>
          	 <div class="options">
          	 	<iframe src="" style="height:210px;"></iframe>
            </div>
        </div>
   	 </div>
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