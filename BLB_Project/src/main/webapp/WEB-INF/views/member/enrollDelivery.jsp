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

<link rel="stylesheet" href="resources/css/member/enrollDelivery.css">

<script src="resources/js/member/enrollDelivery.js" defer></script>   

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

        <form>
            <div class="form-section">
                <h2 class="section-title">배송지 등록</h2>
                
                <div class="form-group">
                    <label class="form-label required">배송지명</label>
                    <div class="form-input">
                        <input type="text" placeholder="최대 10자">
                        <input type="checkbox" id="default-address">
                        <label for="default-address">기본배송지설정</label>
                    </div>
                </div>

                <div class="form-group">
                    <label class="form-label required">받는분</label>
                    <div class="form-input">
                        <input type="text" placeholder="최대 10자">
                    </div>
                </div>

                <div class="form-group">
                    <label class="form-label required">연락처1</label>
                    <div class="form-input phone-group">
                        <select class="phone-select">
                            <option>선택</option>
                            <option>010</option>
                            <option>011</option>
                        </select>
                        <span>-</span>
                        <input type="text" class="phone-input">
                        <span>-</span>
                        <input type="text" class="phone-input">
                    </div>
                </div>

                <div class="form-group">
                    <label class="form-label">연락처2</label>
                    <div class="form-input phone-group">
                        <select class="phone-select">
                            <option>선택</option>
                            <option>010</option>
                            <option>011</option>
                        </select>
                        <span>-</span>
                        <input type="text" class="phone-input">
                        <span>-</span>
                        <input type="text" class="phone-input">
                    </div>
                </div>

                <div class="form-group">
                    <label class="form-label required">주소</label>
                    <div class="form-input">
                        <div class="address-group">
                            <input type="text" placeholder="우편번호" readonly>
                            <button type="button" class="find-address">우편번호</button>
                        </div>
                        <input type="text" class="address-input" placeholder="도로명">
                        <input type="text" class="address-input" placeholder="지 번">
                        <input type="text" class="address-input" placeholder="상세주소를 입력하세요.">
                    </div>
                </div>
            </div>

            <div class="form-section">
                <h2 class="section-title">배송지 요청사항</h2>
                
                <div class="form-group">
                    <label class="form-label required">공동현관 출입방법</label>
                    <div class="form-input radio-group">
                        <label class="radio-label">
                            <input type="radio" name="entry" checked>
                            비밀번호
                        </label>
                        <label class="radio-label">
                            <input type="radio" name="entry">
                            경비실호출
                        </label>
                        <label class="radio-label">
                            <input type="radio" name="entry">
                            자유출입가능
                        </label>
                        <label class="radio-label">
                            <input type="radio" name="entry">
                            기타사항
                        </label>
                    </div>
                </div>

                <div class="form-group">
                    <label class="form-label required">공동현관 비밀번호</label>
                    <div class="form-input">
                        <input type="text" class="address-input">
                    </div>
                </div>
            </div>

            <div class="notice">
                <ul>
                    <li>• 개인정보 수집목적: 상품구매시 배송처리</li>
                    <li>• 수집항목: 배송지명,수령인,연락처,주소(번호지, 주소, 공동현관 출입방법)</li>
                    <li>• 보유 및 이용기간: 정보 삭제요청시 혹은 회원탈퇴시까지</li>
                    <li>• 확인 버튼을 누르시면 위의 배송지 정보가 저장되거나 업데이트됩니다.</li>
                </ul>
            </div>

            <div class="checkbox-group">
                <input type="checkbox" id="agree">
                <label for="agree">위 개인정보 수집이용을 확인하고 배송지를 등록합니다.</label>
            </div>

            <div class="button-group">
                <button type="submit" class="button button-confirm">확인</button>
                <button type="button" class="button button-cancel">취소</button>
            </div>
        </form>
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