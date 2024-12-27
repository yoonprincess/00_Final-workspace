<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지 | 뷰라밸 (Beauty Life Balance)</title>
<link rel="stylesheet" href="resources/css/member/myPage.css">
<script src="resources/js/member/myPage.js"></script>   
 
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
                  <div class="user-info" style="margin-right:40px;">
                      <span class="text-gray-600">뷰라밸의 소중한 회원</span>
                      <h2> ${ loginUser.memberName }님, 반갑습니다.</h2>
                      <div class="monthly-info">
                        <span class="bold" style="color : #a6e3e9 "> [MINT] </span> 까지 남은 구매금액은 <span class="bold">30,000원</span> 입니다.
                          <br>
                          승급 기준에 따른 매장 금액이므로 총구매 금액과 달라질 수 있습니다.
                      </div>
                  </div>
                  
                  <div class="grade" align="center" style="background-color:white;">
                      <div class="tier ${ loginUser.gradeName }" data-label="${ loginUser.gradeName }">
					     <span class="badge">${fn:substring(loginUser.gradeName, 0, 1)}</span>
					  </div>
					  <div style="display:flex; flex-direction:row; text-align:center;">
                      	<span class="label" style="margin-left:30px; margin-right:10px;">회원등급</span>
                     	<button type="button" id="openModal" class="i-icon" >i</button>
                     </div>
                  </div>
                  <div class="divider" style="margin-left: 20px;"></div>
                  <div class="points-coupons">
                      <div class="points" align="center">
                       <a href="${ pageContext.request.contextPath }/pointList.me" >
                          <div class="icon">P</div>
                          <div class="amount">
                          	   <fmt:formatNumber value="${loginUser.totalPoints}" type="number"/><span class="unit">P</span>
                          </div>
                          <div class="label">적립금</div>
                       </a>
                      </div>
                      <div class="divider"></div>
                      <div class="cart" align="center">
	                      <a href="${ pageContext.request.contextPath }/list.ct" >
	                          <div class="icon"><i class="fas fa-shopping-cart"></i></div>
	                          <div class="amount">${ cartCount }건</div>
	                          <div class="label">장바구니</div>
	                      </a>     
                      </div>
                  </div>
              </div>
              
              <!-- GRADE_MODAL -->
			      <div id="modal" class="modal">
			        <div class="modal-content">
			            <span class="close">&times;</span>
			            <h4>[회원 등급제 안내]</h4>
			            <p class="subtitle">*최근 1년간 누적 구매 금액 기준</p>
			            <div class="tier-chart">
						    
						     <div class="tier BABY" data-label="BABY">
						        <span class="badge">B</span>
						    </div>
						    <div class="tier MINT" data-label="MINT">
						        <span class="badge">M</span>
						    </div>
						 
						    <div class="tier GOLD" data-label="GOLD">
						        <span class="badge">G</span>
						    </div>
						       <div class="tier VIP" data-label="VIP">
						        <span class="badge">V</span>
						    </div>
						</div>
			
			            <table>
			                <tr>
			                    <th>등급기준<br>(금액 조건시)</th>
			                    <td>신규가입<br>3만원 미만</td>
			                    <td>3만원 이상<br>5만원 미만</td>
			                    <td>5만원 이상<br>10만원 미만</td>
			                    <td>10만원 이상</td>
			                </tr>
			                <tr>
			                    <th>구매적립금</th>
			                    <td>1%</td>
			                    <td>2%</td>
			                    <td>3%</td>
			                    <td>5%</td>
			                </tr>
			            </table>
			            <br><br>
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
                          <span class="status-count">${myOrderDelivery}</span>
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
                        <span class="material-symbols-outlined" style="font-size:40px; color:#7AB2D3;">error</span>
                        <br>
                        <div style="color:#7AB2D3;"> 찜한 상품이 없습니다. </div>
                    </div>
                  </c:if>
                  <div class="product-grid">
                  <c:if test="${not empty wlist}">
	                  <c:forEach var="wish" items="${wlist}">
	                   
	                      <div class="product-card">
	                          <div class="product-image">
	                            <a href="${ pageContext.request.contextPath }/detail.pr?pno=${wish.prodNo}">
	                               <img src="${pageContext.request.contextPath}/${wish.thumbImg}" alt="${wish.prodName}" >
	                            </a>
	                              <button class="like-btn" onclick="deleteWish(${wish.prodNo});" style="color:orangeRed; border:none;">♥</button>
	                          </div>
	                          <div class="product-info">
	                              <div class="product-tags">
	                                  <span class="tag">신상</span>
	                                  <span class="tag">베스트픽</span>
	                              </div>
	                              <h3 class="product-name">${wish.prodName}</h3>
	                              <div class="product-price">
	                                  <span class="current-price">
	                                  	<fmt:formatNumber value="${wish.prodPrice}" type="number"/><span class="unit">원</span>
	                                  </span>
	                                  <span class="original-price">
	                                  	<fmt:formatNumber value="${wish.prodPrice*1.2}" type="number"/><span class="unit">원</span>
	                                  </span>
	                              </div>
	                          </div>
	                      </div>
	                    
	                  </c:forEach> 
                  </c:if>
                      
                    
                  </div>
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
			                          <span class="material-symbols-outlined" style="font-size:40px; color:#7AB2D3;"">error</span>
			                           <br>
			                          <div style="color:#7AB2D3;"> 최근 1개월간 문의하신 내용이 없습니다.</div>
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
			                          <span class="material-symbols-outlined" style="font-size:40px; color:#7AB2D3;">error</span>
			                          <br>
			                          <div style="color:#7AB2D3;"> 최근 1개월간 문의하신 내용이 없습니다.</div>
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