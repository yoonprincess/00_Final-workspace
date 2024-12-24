<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="resources/css/member/menubar.css">
 
<!-- Noto Sans font-->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap" rel="stylesheet">
 
<!-- Font Awesome -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
  
</head>
<body>
	<div id="menubar">
	 <a class="sub-menu-link" href="${ pageContext.request.contextPath }/myPage.me">
         <div class="my-page"><h3>마이페이지</h3></div>
     </a>    
         <div class="menu-section">
             <hr class="custom-hr"> <hr class="custom-hr">
             <div class="menu-item">마이 쇼핑</div>
            
             <a class="sub-menu-link" href="${ pageContext.request.contextPath }/orderList.me">
             	<div id="selected" class="sub-menu-item" >주문/배송 조회</div>
             </a>
            
             <a  class="sub-menu-link" href="${ pageContext.request.contextPath }/list.ct">
             	 <div class="sub-menu-item" >장바구니</div>
            	</a>
             <a class="sub-menu-link" href="${ pageContext.request.contextPath }/wishList.me">	
             	<div class="sub-menu-item" >찜한리스트</div>
             </a>
         </div>
         <br>
         <hr class="custom-hr"> <hr class="custom-hr">
         <div class="menu-section">
             <div class="menu-item">마이활동</div>
             <a class="sub-menu-link" href="${ pageContext.request.contextPath }/list.io">
		       <div  class="sub-menu-item" >1:1 문의내역</div>
		     </a>
           	 
             <a class="sub-menu-link" href="${ pageContext.request.contextPath }/reviewList.me">
           		  <div class="sub-menu-item" >리뷰 (${sessionScope.listCount})</div>
             </a>
              <a class="sub-menu-link" href="${ pageContext.request.contextPath }/pointList.me">
		       <div  class="sub-menu-item" >적립금</div>
		      </a>
         </div>
         <br>
         <hr class="custom-hr"> <hr class="custom-hr">
         <div class="menu-section">
             <div class="menu-item">마이 정보</div>
            <a  class="sub-menu-link" href="${ pageContext.request.contextPath }/updateForm.me">
     	        <div class="sub-menu-item" >회원정보 수정</div>
    	  </a>
    	  <a  class="sub-menu-link" href="${ pageContext.request.contextPath }/deliveryList.me">
             <div class="sub-menu-item">내 배송지 관리</div>
          </a>   
            <a  class="sub-menu-link" href="${ pageContext.request.contextPath }/deleteForm.me">
             <div class="sub-menu-item">회원탈퇴</div>
            </a>
         </div> 
   </div>
</body>
</html>