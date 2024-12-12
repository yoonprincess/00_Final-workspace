<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>뷰라밸 (Beauty Life Balance)</title>

 <!-- jQuery 라이브러리 -->
 <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

<link rel="stylesheet" href="resources/css/member/myOrderList.css">

<script src="resources/js/member/myOrderList.js" defer></script>   

    <!-- Latest compiled and minified CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">

    <!-- 간단한 동작을 정의해둔 js 파일 연동 -->
    <!-- jQuery 온라인 방식 -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

    <!-- Popper JS -->
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>

    <!-- Latest compiled JavaScript -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
  
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.0/css/all.min.css" integrity="sha512-10/jx2EXwxxWqCLX/hHth/vu2KY3jCF70dCQB8TSgNjbCVAC/8vai53GfMDrO2Emgwccf2pJqxct9ehpzG+MTw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    
</head>
<body class="body-offset">
    <%@ include file="/WEB-INF/views/common/header.jsp" %>
    <div class="outer container-fluid">
        <div id="main">
             <%@ include file="/WEB-INF/views/member/menubar.jsp" %>
             <div class="container">
              
              <!-- Delivery Tracking -->
              <div class="section delivery-tracking" style="border : none;">
                  <div class="section-header">
                      <h4>주문/배송 조회</h4>
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
      
              
              <!-- Header -->
             
              <div class="search-filters">
               <p>구매기간</p>
                <div class="tabs">
                    <button class="tab active" id="one">1개월</button>
                    <button class="tab" id="three">3개월</button>
                    <button class="tab" id="six">6개월</button>
                    <button class="tab" id="twelve">12개월</button>
                </div>
                
                <div class="date-selector">
                    <select name="year">
                        <option value="2017">2017</option>
	                    <option value="2018">2018</option>
	                    <option value="2019">2019</option>
	                    <option value="2020">2020</option>
	                    <option value="2021">2021</option>
	                    <option value="2022">2022</option>
	                 	<option value="2023">2023</option>
	                    <option value="2024">2024</option>
                    </select>
                    <span>년</span>
                    <select name="month">
                        <option value="1">1</option>
                        <option value="2">2</option>
                        <option value="3">3</option>
                        <option value="4">4</option>
                        <option value="5">5</option>
                        <option value="6">6</option>
                        <option value="7">7</option>
                        <option value="8">8</option>
                        <option value="9">9</option>
                        <option value="10">10</option>
                        <option value="11">11</option>
                        <option value="12">12</option>
                    </select>
                    <span>월</span>
                    <select name="day">
                        <option value="1">1</option>
                        <option value="2">2</option>
                        <option value="3">3</option>
                        <option value="4">4</option>
                        <option value="5">5</option>
                        <option value="6">6</option>
                        <option value="7">7</option>
                        <option value="8">8</option>
                        <option value="9">9</option>
                        <option value="10">10</option>
                        <option value="11">11</option>
                        <option value="12">12</option>
                        <option value="13">13</option>
                        <option value="14">14</option>
                        <option value="15">15</option>
                        <option value="16">16</option>
                        <option value="17">17</option>
                        <option value="18">18</option>
                        <option value="19">19</option>
                        <option value="20">20</option>
                        <option value="21">21</option>
                        <option value="22">22</option>
                        <option value="23">23</option>
                        <option value="24">24</option>
                        <option value="25">25</option>
                        <option value="26">26</option>
                        <option value="27">27</option>
                        <option value="28">28</option>
                        <option value="29">29</option>
                        <option value="30">30</option>
                        <option value="31">31</option>
                    </select><span>일</span>
                    <span style="width:100px;">&nbsp;&nbsp;&nbsp;~&nbsp;&nbsp;&nbsp;</span>
                    <select name="year1">
	                    <option value="2017">2017</option>
	                    <option value="2018">2018</option>
	                    <option value="2019">2019</option>
	                    <option value="2020">2020</option>
	                    <option value="2021">2021</option>
	                    <option value="2022">2022</option>
	                 	<option value="2023">2023</option>
	                    <option value="2024">2024</option>
                    </select><span>년</span>
                    <select name="month1">
                        <option value="1">1</option>
                        <option value="2">2</option>
                        <option value="3">3</option>
                        <option value="4">4</option>
                        <option value="5">5</option>
                        <option value="6">6</option>
                        <option value="7">7</option>
                        <option value="8">8</option>
                        <option value="9">9</option>
                        <option value="10">10</option>
                        <option value="11">11</option>
                        <option value="12">12</option>
                    </select><span>월</span>
                    <select name="day1">
                        <option value="1">1</option>
                        <option value="2">2</option>
                        <option value="3">3</option>
                        <option value="4">4</option>
                        <option value="5">5</option>
                        <option value="6">6</option>
                        <option value="7">7</option>
                        <option value="8">8</option>
                        <option value="9">9</option>
                        <option value="10">10</option>
                        <option value="11">11</option>
                        <option value="12">12</option>
                        <option value="13">13</option>
                        <option value="14">14</option>
                        <option value="15">15</option>
                        <option value="16">16</option>
                        <option value="17">17</option>
                        <option value="18">18</option>
                        <option value="19">19</option>
                        <option value="20">20</option>
                        <option value="21">21</option>
                        <option value="22">22</option>
                        <option value="23">23</option>
                        <option value="24">24</option>
                        <option value="25">25</option>
                        <option value="26">26</option>
                        <option value="27">27</option>
                        <option value="28">28</option>
                        <option value="29">29</option>
                        <option value="30">30</option>
                        <option value="31">31</option>
                    </select><span>일</span>
                    <button type="button"> 조회</button>
                </div>
            </div>
            
            <table class="order-table">
                <thead>
                    <tr>
                        <th>주문일자</th>
                        <th>상품</th>
                        <th>수량</th>
                        <th>주문금액</th>
                        <th>상태</th>
                    </tr>
                </thead>
                <tbody>
                    <tr class="date-row">
                        <td class="date" rowspan="2">2024.11.06</td>
                        <td class="product">
                            <img src="https://image.oliveyoung.co.kr/cfimages/cf-goods/uploads/images/thumbnails/550/10/0000/0017/A00000017427236ko.jpg?l=ko" alt="페리페라무드글로이밤">
                            <div class="product-info">
                                <div class="name">페리페라 무드 글로이 밤</div>
                                <div class="seller">페리페라</div>
                            </div>
                        </td>
                        <td class="quantity">1</td>
                        <td class="price">10,400원</td>
                        <td class="status">
                            <span class="delivery-complete">배송완료</span>
                        </td>
                    </tr>
                    <tr>
                        <td class="product">
                            <img src="https://image.oliveyoung.co.kr/cfimages/cf-goods/uploads/images/thumbnails/550/10/0000/0018/A00000018677926ko.jpg?l=ko" alt="바세린 립테라피">
                            <div class="product-info">
                                <div class="name">바세린 립테라피</div>
                                <div class="seller">바세린</div>
                            </div>
                        </td>
                        <td class="quantity">1</td>
                        <td class="price">15,000원</td>
                        <td class="status">
                            <span class="delivery-complete">배송완료</span>
                        </td>
                    </tr>
                    <tr class="date-row">
                        <td class="date" rowspan="1">2024.11.05</td>
                        <td class="product">
                            <img src="https://image.oliveyoung.co.kr/cfimages/cf-goods/uploads/images/thumbnails/550/10/0000/0012/A00000012374104ko.jpg?l=ko" alt="아베다로즈메리샴푸">
                            <div class="product-info">
                                <div class="name">아베다 로즈메리 민트 샴푸</div>
                                <div class="seller">아베다</div>
                            </div>
                        </td>
                        <td class="quantity">1</td>
                        <td class="price">9,900원</td>
                        <td class="status">
                            <span class="delivery-complete">배송완료</span>
                        </td>
	                    </tr>
	                </tbody>
	            </table>
	            
	            <br><br>
	            
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
	    </div>
   <%@ include file="/WEB-INF/views/common/footer.jsp" %>
  </body>
</html>