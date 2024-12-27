<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문/배송조회 | 뷰라밸 (Beauty Life Balance)</title>

<link rel="stylesheet" href="resources/css/member/myOrderList.css">

<script src="resources/js/member/myOrderList.js" defer></script>   
  
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
                          <span class="status-count">${myOrderWait}</span>
                          <span class="status-label">배송대기</span>
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
      
              
              <!-- search-filter -->
             <form action="orderList.me" method="get" id="searchForm">
              <div class="search-filters">
              <div class="search-filters-content">
               <p style="padding-left:5px;">구매기간</p>
                <div class="tabs">
                    <button type="submit" class="tab" id="one">1개월</button>
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
        <tr>
            <th>주문일자</th>
            <th>상품</th>
            <th>수량</th>
            <th>주문금액</th>
            <th style:width=120px;>
	            <select id="statusFilter" onchange="filterStatus()">
				    <option value="all">상태</option>
				    <option value="배송대기">배송대기</option>
				    <option value="배송완료">배송완료</option>
				    <option value="배송중">배송중</option>
				    <option value="환불/취소">환불/취소</option>
				</select>
            </th>
        </tr>
    </thead>
    <tbody>
			    <c:if test="${empty myListbyDate}">
				    <tr style="text-align:center;">
				        <td colspan="5">
				            <div style="display: flex; flex-direction: column; align-items: center;">
				              <br>
				               <span class="material-symbols-outlined" style="font-size:90px; color:#7AB2D3;">error</span>
				                <br>
				                 <div style="color:#7AB2D3"> 조회하신 기간 내 주문내역이 없습니다.</div>
				                 <br>
				            </div>
				        </td>
				    </tr>
				</c:if>
        <c:forEach var="entry" items="${myListbyDate}">
            <c:set var="orderDate" value="${entry.key}"/>
            <c:set var="myOrderList" value="${entry.value}"/>
            <c:set var="totalRowspan" value="0"/>
            
            <c:forEach var="myOrder" items="${myOrderList}">
                <c:forEach var="productOrder" items="${myOrder.productOrder}">
                    <c:forEach var="option" items="${productOrder.option}">
                        <c:forEach var="product" items="${option.product}">
                            <c:set var="totalRowspan" value="${totalRowspan + 1}"/>
                        </c:forEach>
                    </c:forEach>
                </c:forEach>
            </c:forEach>

            <c:set var="isFirstRow" value="true"/>
            <c:forEach var="myOrder" items="${myOrderList}">
                <c:forEach var="productOrder" items="${myOrder.productOrder}">
                    <c:forEach var="option" items="${productOrder.option}">
                        <c:forEach var="product" items="${option.product}">
                            <tr class="date-row">
                                <c:if test="${isFirstRow}">
                                    <td class="date" rowspan="${totalRowspan}" style="text-align :center;">
	                                    <div>${orderDate}</div>
	                                    <div>주문번호 | ${myOrder.orderNo}</div>
	                                    <input name="orderNo" type="hidden" value="${myOrder.orderNo}">
	                                    <a href="${ pageContext.request.contextPath }/orderDetail.me?orderNo=${myOrder.orderNo}" style=" text-decoration: underline; color:#7AB2D3">상세보기</a>
                                    </td>
                                    <c:set var="isFirstRow" value="false"/>
                                </c:if>
                                <td>
                                 <a href="detail.pr?pno=${product.prodNo}">
                                    <div class="product">
                                        <img src="${request.contextPath}/${product.thumbImg}" alt="${product.prodName}">
                                       <c:choose>
                                        <c:when test="${not empty myOrder.refundDate}">
	                                        <div class="product-info" style="color:#ddd;">
	                                            <div class="name">${product.prodName}</div>
	                                            <div class="option" style="color:#ddd;"><span>옵션 | </span>${option.optName}</div>
	                                        </div>
                                    	</c:when>
                                    	<c:otherwise>
	                                    	<div class="product-info">
	                                            <div class="name">${product.prodName}</div>
	                                            <div class="option"><span>옵션 | </span>${option.optName}</div>
		                                    </div>
		                                </c:otherwise>
	                                   </c:choose>
                                    </div>
                                  </a>
                                </td>
                                <td>
                                    <div class="quantity">${productOrder.orderQty}</div>
                                </td>
                                <td>
                                    <div class="price">
                                        <fmt:formatNumber value="${productOrder.totalAmt}" type="number" /> 원
                                    </div>
                                </td>
                                <td>
                                    <div class="status">
                                    
                                     <c:if test="${not empty myOrder.refundDate}">
                                      <span class="delivery-cancel" >환불/취소</span>
									  <p >취소일</p>
									  <span id="refund-date"> ${myOrder.refundDate}</span>
									 </c:if>
									 
									 <c:if test="${empty myOrder.refundDate}">
									 
                                         <c:if test="${myOrder.dlvrStatus == '배송대기'}">
									        <span class="delivery-waiting">${myOrder.dlvrStatus}</span>
										          <button 
							                        class="btn-outline-primary blb-btn" 
							                        id="cancelBtn"
                                                    data-order-no="${myOrder.orderNo}"
							                        style="width:70px; font-size:13px; padding:5px 2px;">
							                        취소 신청
							                    </button>
										    </c:if>
										    
										    <c:if test="${myOrder.dlvrStatus == '배송완료'}">
										        <span class="delivery-complete">${myOrder.dlvrStatus}</span>
										        	<c:if test="${productOrder.isWritten == 0}">
											          <button 
								                        class="btn-primary blb-btn" 
								                        id="writeReviewBtn" 
								                        style="width:70px; font-size:13px; padding:5px 2px;"
								                        data-prodno="${product.prodNo}" 
								                        data-serialno="${productOrder.serialNo}"
								                        data-memberid="${sessionScope.loginUser.memberId}">
								                        리뷰 작성
								                    </button>
							                      </c:if>
										    </c:if>
										    
										    <c:if test="${myOrder.dlvrStatus == '배송중'}">
										        <span class="delivery-other">${myOrder.dlvrStatus}</span>
										    </c:if>
									</c:if>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:forEach>
                </c:forEach>
            </c:forEach>
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
							<a href="blb/orderList.me?ppage=${ pi.startPage - pi.pageLimit }
												&year=${param.year}&month=${param.month}&day=${param.day}
												&year1=${param.year1}&month1=${param.month1}&day1=${param.day1}">
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
								<a href="blb/orderList.me?ppage=${ p }
											&year=${param.year}&month=${param.month}&day=${param.day}
											&year1=${param.year1}&month1=${param.month1}&day1=${param.day1}">
									${ p }
								</a>
							</li>
						</c:if>
					</c:forEach>
					
					<!-- 다음 페이지 그룹 -->
					<c:if test="${ pi.endPage < pi.maxPage }">
						<li class="page-item">
							<a href="blb/orderList.me?ppage=${ pi.startPage + pi.pageLimit }
												&year=${param.year}&month=${param.month}&day=${param.day}
												&year1=${param.year1}&month1=${param.month1}&day1=${param.day1}">
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
   <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

  </body>
</html>