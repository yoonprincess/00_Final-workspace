<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지 | 뷰라밸 (Beauty Life Balance)</title>
<link rel="stylesheet" href="resources/css/member/myPage.css">
 
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
                      <button class="more-btn">더보기 &gt;</button>
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
                          <span class="status-count">0</span>
                          <span class="status-label">배송준비중</span>
                      </div>
                      <div class="arrow"><i class="fas fa-chevron-right"></i></div>
                      <div class="status-item">
                          <span class="status-count">0</span>
                          <span class="status-label">배송중</span>
                      </div>
                      <div class="arrow"><i class="fas fa-chevron-right"></i></div>
                      <div class="status-item completed">
                          <span class="status-count">3</span>
                          <span class="status-label">배송완료</span>
                      </div>
                  </div>
              </div>
      
              <!-- Likes Section -->
              <div class="section likes" style="border : none;">
                  <div class="section-header">
                      <h4>찜한 상품</h4>
                      <button class="more-btn">더보기 &gt;</button>
                    </div>
                  <div class="product-grid">
                      <div class="product-card">
                          <div class="product-image">
                              <img src="https://image.oliveyoung.co.kr/cfimages/cf-goods/uploads/images/thumbnails/400/10/0000/0020/A00000020401414ko.jpg?l=ko" alt="한율 어린쑥 클렌징">
                              <button class="like-btn">♥</button>
                          </div>
                          <div class="product-info">
                              <div class="product-tags">
                                  <span class="tag">신상</span>
                                  <span class="tag">베스트픽</span>
                              </div>
                              <h3 class="product-name">[시카보다 4배*강한]한율 어린쑥 수분진정 플루이드 125ml</h3>
                              <div class="product-price">
                                  <span class="current-price">24,900원</span>
                                  <span class="original-price">32,000원</span>
                              </div>
                          </div>
                      </div>
                      <div class="product-card">
                          <div class="product-image">
                              <img src="https://image.oliveyoung.co.kr/cfimages/cf-goods/uploads/images/thumbnails/400/10/0000/0018/A00000018374408ko.jpg?l=ko" alt="한율 어린쑥 수분진정 플루이드">
                              <button class="like-btn">♥</button>
                          </div>
                          <div class="product-info">
                              <div class="product-tags">
                                  <span class="tag">특가</span>
                                  <span class="tag">베스트픽</span>
                              </div>
                              <h3 class="product-name">[피지흡착] 한율 어린쑥 클렌징 쑥떡팩폼 (120ml+15ml)</h3>
                              <div class="product-price">
                                  <span class="current-price">28,500원</span>
                              </div>
                          </div>
                      </div>
                      <div class="product-card">
                        <div class="product-image">
                            <img src="https://image.oliveyoung.co.kr/cfimages/cf-goods/uploads/images/thumbnails/10/0000/0019/A00000019832102ko.jpg?l=ko" alt="에스트라아토베리어로션">
                            <button class="like-btn">♥</button>
                        </div>
                        <div class="product-info">
                            <div class="product-tags">
                                <span class="tag">신상</span>
                                <span class="tag">오늘드림</span>
                            </div>
                            <h3 class="product-name">에스트라 아토베리어 365로션 150ml</h3>
                            <div class="product-price">
                                <span class="current-price">26,900원</span>
                                <span class="original-price">33,000원</span>
                            </div>
                        </div>
                    </div>
                    <div class="product-card">
                        <div class="product-image">
                            <img src="https://image.oliveyoung.co.kr/cfimages/cf-goods/uploads/images/thumbnails/10/0000/0021/A00000021270307ko.jpg?l=ko" alt="풀리 비건 그린 토마토 팩">
                            <button class="like-btn">♥</button>
                        </div>
                        <div class="product-info">
                            <div class="product-tags">
                                <span class="tag">특가</span>
                            </div>
                            <h3 class="product-name">[단독기획] 풀리 비건 그린 토마토 클레이팩 클렌저 120ml</h3>
                            <div class="product-price">
                                <span class="current-price">13,500원</span>
                                <span class="original-price">33,000원</span>
                            </div>
                        </div>
                    </div>
                  </div>
              </div>
      
              <!-- Inquiry Sections -->
	              <div class="inquiry-sections " >
	                  <div class="section inquiry" >
	                      <div class="section-header">
	                          <h4>1:1 문의내역</h4>
	                          <button class="more-btn">더보기 &gt;</button>
	                      </div>
	                      <p class="no-content">최근 1개월간 문의하신 내용이 없습니다.</p>
	                  </div>
	                  <div class="section inquiry" style="border:none;">
	                      <div class="section-header">
	                          <h4>상품 Q&A내역</h4>
	                          <button class="more-btn">더보기 &gt;</button>
	                      </div>
	                      <div class="qna-list">
	                        <div class="qna-item">
	                          <div class="qna-details">
	                            <span class="answer-status">답변대기</span>
	                          </div>
	                            <div class="qna-title">어떤 용도로 사용하는 건가요?</div>
	                            <div class="qna-date">2024-11-18</div>
	                          </div>
	                        </div>

                        <div class="qna-item">
                          <div class="qna-details">
                            <span class="answer-status">답변대기</span>
                          </div>
                            <div class="qna-title">사용기한이 궁금합니다.</div>
                            <div class="qna-date">2024-11-18</div>
                        </div>
                          <div class="qna-item">
                          <div class="qna-details">
                            <span class="answer-status">답변대기</span>
                          </div>
                            <div class="qna-title">사용기한이 궁금합니다.</div>
                            <div class="qna-date">2024-11-18</div>
                        </div>
                          <div class="qna-item">
                          <div class="qna-details">
                            <span class="answer-status">답변대기</span>
                          </div>
                            <div class="qna-title">사용기한이 궁금합니다.</div>
                            <div class="qna-date">2024-11-18</div>
                        </div>
                        </div>
                    </div>
                  </div>
              </div>
          </div>
     

      <%@ include file="/WEB-INF/views/common/footer.jsp" %>
  </body>
</html>