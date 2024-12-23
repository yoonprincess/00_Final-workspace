<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지 | 뷰라밸 (Beauty Life Balance)</title>
<link rel="stylesheet" href="resources/css/member/myPage.css">
<script src="resources/js/member/myPage.js" defer></script>   
 
<!-- Noto Sans font-->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap" rel="stylesheet">
 
<!-- Font Awesome -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
  
</head>

<body class="body-offset">
    <%@ include file="/WEB-INF/views/common/header.jsp" %>
  <div class="container-fluid">
        <div id="main">
        <%@ include file="/WEB-INF/views/member/menubar.jsp" %>
             <div class="container">
              <!-- Header -->
              <div class="header">
                  <div class="user-info">
                      <span class="text-gray-600">뷰라밸의 소중한 회원</span>
                      <h2> ${ loginUser.memberName }님, 반갑습니다.</h2>
                      <div class="member-grade">
                          <span class="text-gray-600">회원등급</span>
                          <span class="i-icon">i</span>
                          <span class="bold">${ loginUser.gradeName } </span>
                          <span class="info-icon">B</span>
                      </div>
                      <div class="monthly-info">
                        <span class="bold" style="color : #a6e3e9 "> [MINT] </span> 까지 남은 구매금액은 <span class="bold">10,000원</span> 입니다.
                          <br>
                          승급 기준에 따른 매장 금액이므로 총구매 금액과 달라질 수 있습니다.
                      </div>
                  </div>
                  <div class="divider" style="margin-left: 80px;"></div>
                  <div class="points-coupons">
                      <div class="points">
                          <div class="icon">P</div>
                          <div class="amount">${ loginUser.currentPoints }원</div>
                          <div class="label">적립금</div>
                      </div>
                      <div class="divider"></div>
                      <div class="cart">
                          <div class="icon"><i class="fas fa-shopping-cart"></i></div>
                          <div class="amount">5건</div>
                          <div class="label">장바구니</div>
                      </div>
                      
                  </div>
              </div>
      
              <!-- Delivery Tracking -->
              <div class="section delivery-tracking" style="border : none;">
                  <div class="section-header">
                      <h4>주문/배송 조회</h4>
                      <button class="more-btn" onclick="location.href='${ pageContext.request.contextPath }/orderList.me'">
                       더보기 &gt;
                      </button>
                  </div>
                 
                  <div class="tracking-status">
                      <div class="status-item">
                          <span class="status-count">0</span>
                          <span class="status-label">주문접수</span>
                      </div>
                      <div class="arrow"><i class="fas fa-chevron-right"></i></div>
                      <div class="status-item">
                          <span class="status-count">0</span>
                          <span class="status-label">결제완료</span>
                      </div>
                      <div class="arrow"><i class="fas fa-chevron-right"></i></div>
                      <div class="status-item">
                          <span class="status-count">${myOrderWait}</span>
                          <span class="status-label">배송준비중</span>
                      </div>
                      <div class="arrow"><i class="fas fa-chevron-right"></i></div>
                      <div class="status-item">
                          <span class="status-count">0</span>
                          <span class="status-label">배송중</span>
                      </div>
                      <div class="arrow"><i class="fas fa-chevron-right"></i></div>
                      <div class="status-item completed">
                          <span class="status-count">${myOrderComplete}</span>
                          <span class="status-label">배송완료</span>
                      </div>
                  </div>
              </div>
      
              <!-- Likes Section -->
              <div class="section likes" style="border : none;">
                  <div class="section-header">
                      <h4>찜한 상품</h4>
                      	<button class="more-btn" 
                      			onclick="location.href='${ pageContext.request.contextPath }/wishList.me'">더보기 &gt;</button>
                    </div>
                    <c:if test="${empty wlist}">
                   <div style="display: flex; flex-direction: column; align-items: center;">
                        <span class="material-symbols-outlined" style="font-size:40px;">error</span>
                        <br>
                        <div> 찜한 상품이 없습니다. </div>
                    </div>
                  </c:if>
                  <div class="product-grid">
                  <c:if test="${not empty wlist}">
	                  <c:forEach var="wish" items="${wlist}">
	                      <div class="product-card">
	                          <div class="product-image">
	                               <img src="${pageContext.request.contextPath}/${wish.thumbImg}" alt="${wish.prodName}" >
	                              <button class="like-btn" onclick="deleteWish(${wish.prodNo});">♥</button>
	                          </div>
	                          <div class="product-info">
	                              <div class="product-tags">
	                                  <span class="tag">신상</span>
	                                  <span class="tag">베스트픽</span>
	                              </div>
	                              <h3 class="product-name">${wish.prodName}</h3>
	                              <div class="product-price">
	                                  <span class="current-price">${wish.prodPrice}</span>
	                                  <span class="original-price">32,000원</span>
	                              </div>
	                          </div>
	                      </div>
	                  </c:forEach> 
                  </c:if>
                      
                    
                  </div>
              </div>
              <div id="overlay" class="overlay">
		        <span class="material-symbols-outlined" id="heart">heart_minus</span>
		        <p id="message"></p>
			  </div>
      
              <!-- Inquiry Sections -->
	              <div class="inquiry-sections " >
	                  <div class="section inquiry" >
	                        <div class="section-header">
	                          <h4>1:1 문의내역</h4>
	                          	<button class="more-btn" onclick="location.href='${ pageContext.request.contextPath }/list.io'">
	                          		더보기 &gt;
	                          	</button>
	                        </div>
		                     <div class="qna-list">
		                      <c:if  test="${not empty list}">
			                    <c:forEach var="list" items="${list}">
			                     <a href="${ pageContext.request.contextPath }/inquiry/${list.inquiryNo}">
			                        <div class="qna-item">
			                          <div class="qna-details">
			                          <c:choose>
			                           <c:when test="${list.inquiryAnsweredYn == 'N'}">
			                            <span class="answer-status">답변대기</span>
			                            </c:when>
			                            <c:otherwise>
			                             <span class="answer-status">답변완료</span>
			                            </c:otherwise>
			                            </c:choose>
			                          </div>
			                            <div class="qna-title">${list.inquiryContent}</div>
			                            <div class="qna-date">${list.inquiryCreateDate}</div>
			                         </div>
			                       </a>
			                     </c:forEach>
			                    </c:if>
			                    <c:if test="${empty list}">
			                     	<div style="display: flex; flex-direction: column; align-items: center;">
			                          <span class="material-symbols-outlined" style="font-size:40px;">error</span>
			                           <br>
			                          <div> 최근 1개월간 문의하신 내용이 없습니다.</div>
			                        </div>
			                    </c:if>
			                  
		                     </div>
	                  </div>
	                  <div class="section inquiry" style="border:none;">
	                      <div class="section-header">
	                          <h4>상품 Q&A내역</h4>
	                          <button class="more-btn" onclick="location.href='${ pageContext.request.contextPath }/list.io'">
	                             더보기 &gt;
	                          </button>
	                      </div>
	                      <div class="qna-list">
	                     	 <c:if  test="${not empty qlist}">
			                    <c:forEach var="list" items="${qlist}">
			                    <a href="${ pageContext.request.contextPath }/inquiry/${list.inquiryNo}">
			                        <div class="qna-item">
			                          <div class="qna-details">
			                          <c:choose>
			                           <c:when test="${list.inquiryAnsweredYn == 'N'}">
			                            <span class="answer-status">답변대기</span>
			                            </c:when>
			                            <c:otherwise>
			                             <span class="answer-status">답변완료</span>
			                            </c:otherwise>
			                            </c:choose>
			                          </div>
			                            <div class="qna-title">${list.inquiryContent}</div>
			                            <div class="qna-date">${list.inquiryCreateDate}</div>
			                         </div>
			                       </a>
			                     </c:forEach>
			                    </c:if>
			                    <c:if test="${empty qlist}">
			                     	<div  style="display: flex; flex-direction: column; align-items: center;">
			                          <span class="material-symbols-outlined" style="font-size:40px;">error</span>
			                          <br>
			                          <div> 최근 1개월간 문의하신 내용이 없습니다.</div>
			                        </div>
			                    </c:if>
                        </div>
                    </div>
                  </div>
              </div>
          </div>
     

      <%@ include file="/WEB-INF/views/common/footer.jsp" %>
  </body>
</html>