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
                <div class="tabs">
                    <button class="tab active">1개월</button>
                    <button class="tab">3주일</button>
                    <button class="tab">6개월</button>
                    <button class="tab">12개월</button>
                </div>
                
                <div class="date-selector">
                    <select name="year">
                        <option>2024</option>
                    </select>년
                    <select name="month">
                        <option>1</option>
                    </select>월
                    <select name="day">
                        <option>3</option>
                    </select>일
                    <span>~</span>
                    <select name="year">
	                    <option>2017</option>
	                    <option>2018</option>
	                    <option>2019</option>
	                    <option>2020</option>
	                    <option>2021</option>
	                    <option>2022</option>
	                 	<option>2023</option>
	                    <option>2024</option>
                    </select>년
                    <select name="month">
                        <option>1</option>
                        <option>2</option>
                        <option>3</option>
                        <option>4</option>
                        <option>5</option>
                        <option>6</option>
                        <option>7</option>
                        <option>8</option>
                        <option>9</option>
                        <option>10</option>
                        <option>11</option>
                        <option>12</option>
                        
                    </select>월
                    <select name="day">
                          <option>1</option>
						  <option>2</option>
						  <option>3</option>
						  <option>4</option>
						  <option>5</option>
						  <option>6</option>
						  <option>7</option>
						  <option>8</option>
						  <option>9</option>
						  <option>10</option>
						  <option>11</option>
						  <option>12</option>
						  <option>13</option>
						  <option>14</option>
						  <option>15</option>
						  <option>16</option>
						  <option>17</option>
						  <option>18</option>
						  <option>19</option>
						  <option>20</option>
						  <option>21</option>
						  <option>22</option>
						  <option>23</option>
						  <option>24</option>
						  <option>25</option>
						  <option>26</option>
						  <option>27</option>
						  <option>28</option>
						  <option>29</option>
						  <option>30</option>
						  <option>31</option>
                    </select>일
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
	        </div>
	      </div>
	    </div>
   <%@ include file="/WEB-INF/views/common/footer.jsp" %>
  </body>
</html>