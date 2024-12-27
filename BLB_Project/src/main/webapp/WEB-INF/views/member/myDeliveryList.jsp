<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>배송지 관리 |  뷰라밸 (Beauty Life Balance)</title>

<link rel="stylesheet" href="resources/css/member/myDeliveryList.css">
<script src="resources/js/member/myDeliveryList.js" ></script>   
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.0/css/all.min.css" integrity="sha512-10/jx2EXwxxWqCLX/hHth/vu2KY3jCF70dCQB8TSgNjbCVAC/8vai53GfMDrO2Emgwccf2pJqxct9ehpzG+MTw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    
</head>
<body class="body-offset">
 <%@ include file="/WEB-INF/views/common/header.jsp" %>
 <div class="outer container-fluid">
  <div id="main" >
    <%@ include file="/WEB-INF/views/member/menubar.jsp" %>
      <div class="outer">
        <div class="container">
         <div class="tabs">
            <button class="tab active">배송지</button>
         </div>
      	 <p class="notice">배송지는 최대 <span class="highlight">10</span>개까지 등록 가능합니다.</p>
		
        <table>
            <thead>
                <tr>
                    <th style="width:100px;">배송지명</th>
                    <th style="width:100px;">받는사람</th>
                    <th >주소</th>
                    <th style="width:150px;">연락처</th>
                    <th style="width:150px;">관리</th>
                </tr>
            </thead>
            <tbody>
             <c:if test="${empty dlist}">
	            <tr class="result">
	                <td colspan="5">
	                    <div style="display: flex; flex-direction: column; align-items: center;">
	                       <br>
	                       <span class="material-symbols-outlined" style="font-size:90px; color:#7AB2D3;">error</span>
	                        <br>
	                       <div style="color:#7AB2D3"> 등록된 배송지가 없습니다.</div>
	                       <br>
	                    </div>
	                </td>
	            </tr>
	        </c:if>
	        
           		<c:forEach var="d" items="${dlist}">
	                <tr class="result">
	                    <td>${d.deliNickname}</td>
	                    <td>${d.deliName}</td>
	                    <td>
	                    	<div class="badge">${d.deliDefault}</div>
	                        <div>(${d.postcode})</div>
	                        <div>${d.deliAddress}</div>
	                        <div>${d.detailAddress}</div>
	                        <hr>
	                        <div>공동현관 출입방법</div>
	                        <div>${d.deliComment}</div>
	                    </td>
	                    <td id="deliPhone">${d.deliPhone}</td>
	                    <td>
	                        <div class="button-group">
	                            <button class="button" onclick="updateDelivery('${d.deliCode}');">수정</button>
	                            <button class="button" onclick="deleteDelivery('${d.deliCode}');">삭제</button>
	                        </div>
	                        <c:if test="${d.deliDefault != '기본배송지'}">
	                        <div class="button-group">
	                            <button class="button" style="font-size:14px;" onclick="setDefaultDelivery('${d.deliCode}');">기본배송지설정</button>
	                        </div>
	                        </c:if>
	                    </td>
	                </tr>
                </c:forEach>
              
            </tbody>
        </table>
        <button class="register-button" onclick="goEnrollForm();">배송지 등록</button>
   	 </div>
   
	            <br><br>
	            
<!-- 페이지네이션 -->
			<nav>
				<ul class="pagination" style="width:1024px;">
					<!-- 이전 페이지 그룹 -->
					<c:if test="${ pi.startPage > 1 }">
						<li class="page-item">
							<a href="list.pr?category=${ category }&sortBy=${ param.sortBy }&boardLimit=${ param.boardLimit }&ppage=${ pi.startPage - pi.pageLimit }&<c:forEach var='sub' items='${ paramValues.subcategories }'>subcategories=${ sub }&</c:forEach>">
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
								<a href="#">
									${ p }
								</a>
							</li>
						</c:if>
					</c:forEach>
					
					<!-- 다음 페이지 그룹 -->
					<c:if test="${ pi.endPage < pi.maxPage }">
						<li class="page-item">
							<a href="list.pr?category=${ category }&sortBy=${ param.sortBy }&boardLimit=${ param.boardLimit }&ppage=${ pi.startPage + pi.pageLimit }&<c:forEach var='sub' items='${ paramValues.subcategories }'>subcategories=${ sub }&</c:forEach>">
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