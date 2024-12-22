<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>1:1 문의하기</title>
    <link rel="stylesheet" href="${ pageContext.request.contextPath }/resources/css/helpdesk/Inquiry.css">
</head>
<body class="body-offset">
<%@ include file="/WEB-INF/views/common/header.jsp" %>
    <div class="container-fluid">
    <div class="container">
        <h1>1:1 문의하기</h1>
        <form id="insertInquiry" name="insertInquiry" action="insert.io" method="post" enctype="multipart/form-data">
        	 <input type="hidden" value="${ sessionScope.loginUser.memberId }" name="memberId" >
            <div class="form-group">
                <label for="inquiryType">문의유형</label>
                <select id="inquiryType" name="inquiryType" required>
                    <option value="">카테고리를 선택해주세요</option>
                    <option value="상품">상품</option>
                    <option value="배송">배송</option>
                    <option value="주문">주문</option>
                    <option value="결제/환불">결제/환불</option>
                </select>
            </div>
            <div class="form-group">
                <label for="inquiry-content">문의내용</label>
                <textarea id="inquiryContent" name="inquiryContent" rows="10" placeholder="문의하실 내용을 입력해주세요 (2000자 이내)" required></textarea>
            </div>
            <div class="form-group">
            	<label for="upfile">첨부파일</label>
          		<div class="form-check row">
          			<input type="file" id="upfile" class="form-control-file border" name="upfile">
          		</div>
          		<div class="form-check row">
          			<input type="file" id="upfile" class="form-control-file border" name="upfile">
          		</div>
          		<div class="form-check row">
          			<input type="file" id="upfile" class="form-control-file border" name="upfile">
          		</div>
          		<div class="form-check row">
          			<input type="file" id="upfile" class="form-control-file border" name="upfile">
          		</div>
          		<div class="form-check row">
          			<input type="file" id="upfile" class="form-control-file border" name="upfile">
          		</div>
          	</div>
            <div class="form-group">
                <label>
                    <input type="checkbox" id="email-notify" name="email"> 이메일로 답변 완료 시 알림 받기
                </label>
                <div class="email-input">
                    <input type="email" placeholder="이메일 주소를 입력해주세요">
                </div>
            </div>
            <div class="button-group">
                <button type="submit" class="button button-primary">등록</button>
                <button type="button" class="button button-secondary">취소</button>
            </div>
        </form>
    </div>
    <!-- 페이지네이션 -->
			<nav>
				<ul class="pagination">
					<!-- 이전 페이지 그룹 -->
					<c:if test="${ pi.startPage > 1 }">
						<li class="page-item">
							<a href="list.io?category=${ category }&sortBy=${ param.sortBy }&boardLimit=${ param.boardLimit }&ppage=${ pi.startPage - pi.pageLimit }&<c:forEach var='sub' items='${ paramValues.subcategories }'>subcategories=${ sub }&</c:forEach>">
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
								<a href="list.io?category=${ category }&sortBy=${ param.sortBy }&boardLimit=${ param.boardLimit }&ppage=${ p }&<c:forEach var='sub' items='${ paramValues.subcategories }'>subcategories=${ sub }&</c:forEach>">
									${ p }
								</a>
							</li>
						</c:if>
					</c:forEach>
					
					<!-- 다음 페이지 그룹 -->
					<c:if test="${ pi.endPage < pi.maxPage }">
						<li class="page-item">
							<a href="list.io?category=${ category }&sortBy=${ param.sortBy }&boardLimit=${ param.boardLimit }&ppage=${ pi.startPage + pi.pageLimit }&<c:forEach var='sub' items='${ paramValues.subcategories }'>subcategories=${ sub }&</c:forEach>">
								＞
							</a>
						</li>
					</c:if>
				</ul>
			</nav>
			<!-- 페이지네이션 end -->
    </div>
    <script src="${ pageContext.request.contextPath }/resources/js/helpdesk/Inquiry.js"></script> <!-- JS 파일 경로 -->
<%@ include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>




