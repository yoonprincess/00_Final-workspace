<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 | 뷰라밸 (Beauty Life Balance)</title>
<link rel="stylesheet" href="resources/css/member/loginForm.css">
<script src="resources/js/member/loginForm.js" defer></script> 
    
<!-- Noto Sans font-->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap" rel="stylesheet">
 
<!-- Font Awesome -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
  
    <style>
      
    </style>
</head>
<body  class="body-offset">
<%@ include file="/WEB-INF/views/common/header.jsp" %>
    <div id="outer" class="container-fluid">
        <div class="login-container">
        <h2 id="title" >로그인</h2>
        <div class="sub-title">로그인을 하시면 다양한 혜택을 누리실 수 있습니다.</div>
        <br><br><br>

            <form action="login.me" method="post">
               	<input type="hidden" name="redirectURL" id="redirectURL">
                <input type="text" class="input-field" placeholder="아이디" required name="memberId" value="${ cookie.saveId.value }">
                <input type="password" class="input-field" placeholder="비밀번호" required name="memberPwd">
            
                <div class="keep-login">
                   <c:choose>
                   		<c:when test="${ not empty cookie.saveId }">
	                    	<input type="checkbox" id="saveId" name="saveId" value="y" checked>
	                    	<label for="saveId" class="inline-label">아이디 저장</label>
	                    </c:when>
	                    <c:otherwise>
	                    	<input type="checkbox" id="saveId" name="saveId" value="y">
	                    	<label for="saveId" class="inline-label">아이디 저장</label>
                   		</c:otherwise>
                   	</c:choose>
                   	<div style="color:orangered;">아이디 또는 비밀번호가 잘못 되었습니다. 아이디와 비밀번호를 정확히 입력해주세요</div>
                </div>
                <button type="submit" id="loginBtn"> 로그인 </button>
                <div class="links">
                    <a href="${ pageContext.request.contextPath }/findIdForm.me">아이디 찾기</a>
                    <span class="divider"></span>
                    <a href="${ pageContext.request.contextPath }/findPwdForm.me">비밀번호 찾기</a>
                    <span class="divider"></span>
                    <a href="${ pageContext.request.contextPath }/agreement.me">회원가입</a>
                </div>
                <br>
                <hr>
                <br>
                
            </form>
        </div>
    </div>
 <%@ include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>