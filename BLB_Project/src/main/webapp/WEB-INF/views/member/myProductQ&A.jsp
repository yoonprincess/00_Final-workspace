<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 Q&A | 뷰라밸 (Beauty Life Balance)</title>

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
             
             <div class="section-header">
               <h4>상품Q&A</h4>
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
            <th></th>
            <th></th>
            <th>답변상태</th>
        </tr>
    </thead>
     <tbody>
        <c:if test="${empty qlist}">
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

        <c:if test="${not empty qlist}">
            <c:forEach var="q" items="${qlist}">
                <tr class="result">
                    <td>
                        <a href="detail.pr?pno=${q.PROD_NO}">
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