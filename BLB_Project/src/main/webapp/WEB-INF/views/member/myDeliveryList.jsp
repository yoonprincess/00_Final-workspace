<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내 배송목록 |  뷰라밸 (Beauty Life Balance)</title>

 <!-- jQuery 라이브러리 -->
 <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

<link rel="stylesheet" href="resources/css/member/myDeliveryList.css">

<script src="resources/js/member/myDeliveryList.js" defer></script>   

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
              
                <div class="container">
        <div class="tabs">
            <button class="tab active">배송지</button>
            <button class="tab">환불계좌</button>
        </div>

        <p class="notice">배송지는 최대 <span class="highlight">20</span>개까지 등록 가능합니다.</p>

        <table>
            <thead>
                <tr>
                    <th>배송지명</th>
                    <th>받는사람</th>
                    <th>주소</th>
                    <th>연락처</th>
                    <th>관리</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>
                        <span class="badge">기본배송지</span>
                        오늘드림
                    </td>
                    <td>정희수</td>
                    <td>
                        <div>(07964)</div>
                        <div>서울 양천구 목동중앙서로 37 (목동, 목동금호어울림아파트) 102동 201호</div>
                    </td>
                    <td>010-****-5572</td>
                    <td>
                        <div class="button-group">
                            <button class="button">수정</button>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>오늘드림</td>
                    <td>정희수</td>
                    <td>
                        <div>(07209)</div>
                        <div>서울 영등포구 선유로 243 (양평동4가, 영등포세무서 어린이집) 테스트용</div>
                    </td>
                    <td>010-****-5572</td>
                    <td>
                        <div class="button-group">
                            <button class="button">삭제</button>
                            <button class="button">수정</button>
                        </div>
                    </td>
                </tr>
            </tbody>
        </table>

        <button class="register-button">배송지 등록</button>
    </div>
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