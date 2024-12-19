<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

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
    <div class="outer container-fluid">
    <%@ include file="/WEB-INF/views/common/header.jsp" %> 
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
                          <span class="status-count">${myOrderComplete}</span>
                          <span class="status-label">배송준비중</span>
                      </div>
                      <div class="arrow"><i class="fas fa-chevron-right"></i></div>
                      <div class="status-item">
                          <span class="status-count">0</span>
                          <span class="status-label">배송중</span>
                      </div>
                      <div class="arrow"><i class="fas fa-chevron-right"></i></div>
                      <div class="status-item completed">
                          <span class="status-count">${myOrderWait}</span>
                          <span class="status-label">배송완료</span>
                      </div>
                  </div>
              </div>
      
              
              <!-- search-filter -->
             <form action="orderList.me" method="get" id="searchForm">
              <div class="search-filters">
              <div class="search-filters-content">
               <p style="padding-left:5px;">구매기간</p>
                <div class="tabs">
                    <button type="submit" class="tab active" id="one">1개월</button>
                    <button type="submit" class="tab" id="three">3개월</button>
                    <button type="submit" class="tab" id="six">6개월</button>
                    <button type="submit" class="tab" id="twelve">12개월</button>
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
                </div>
            </div>
            <button type="submit" id="submitBtn"> 조회</button>
         </div>
        </form>
            
            <table class="order-table">
                <thead>
                    <tr >
                        <th>주문일자</th>
                        <th >상품</th>
                        <th>수량</th>
                        <th>주문금액</th>
                        <th>상태</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="entry" items="${myListbyDate}">
                        <c:set var="myOrderList" value="${entry.value}"/>
                        <c:set var="orderDate" value="${entry.key}"/>
                        <c:set var="orderCount" value="${fn:length(myOrderList)}"/>

                        <tr class="date-row" > 
                            <td class="date" rowspan="${orderCount}">${orderDate}</td>
                            <td >
                                <c:forEach var="myOrder" items="${myOrderList}">  
                                    <div class="order-item">
                                        <c:forEach var="productOrder" items="${myOrder.productOrder}">
                                        <c:forEach var="option" items="${productOrder.option}">
                                        <c:forEach var="product" items="${option.product}">
                                            <div class="product">
                                                <img src="${request.contextPath}/${product.thumbImg}" alt="${product.prodName}">
                                                <div class="product-info">
                                                    <div class="name">${product.prodName}</div>
                                                    <div class="option">${option.optName}</div>
                                                </div>

                                                <div class="quantity" >${productOrder.orderQty}</div>
                                                <div class="price" >
                                                    <fmt:formatNumber value="${productOrder.totalAmt}" type="number" /> 원
                                                </div>
                                                <div class="status">
                                                    <span class="delivery-complete">${myOrder.dlvrStatus}</span>
                                                </div>
                                            </div>
                                        </c:forEach>
                                        </c:forEach>
                                        </c:forEach>  
                                    </div>
                                </c:forEach>
                            </td> 
                        </tr>


                    </c:forEach>
                </tbody>
            </table>
	            <br><br>
 <!-- 페이지네이션 -->
			<nav>
				<ul class="pagination">
					<!-- 이전 페이지 그룹 -->
					<c:if test="${ pi.startPage > 1 }">
						<li class="page-item">
							<a href="orderList.me?ppage=${ pi.startPage - pi.pageLimit }">
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
								<a href="orderList.me?ppage=${ p }">
									${ p }
								</a>
							</li>
						</c:if>
					</c:forEach>
					
					<!-- 다음 페이지 그룹 -->
					<c:if test="${ pi.endPage < pi.maxPage }">
						<li class="page-item">
							<a href="orderList.me?ppage=${ pi.startPage + pi.pageLimit }">
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