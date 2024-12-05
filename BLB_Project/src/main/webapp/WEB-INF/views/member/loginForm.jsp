<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 | 뷰라밸 (Beauty Life Balance)</title>
<link rel="stylesheet" href="resources/css/member/loginForm.css">
    
<!-- Noto Sans font-->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap" rel="stylesheet">
 
<!-- Font Awesome -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
  
    <style>
      
    </style>
</head>
<body>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
    <div id="outer">
        <div class="login-container">
        <h1 id="title" >로그인</h1>
        <div class="sub-title">로그인을 하시면 다양한 혜택을 누리실 수 있습니다.</div>
        <br><br><br>

            <form action="login.me" method="post">
                <input type="text" class="input-field" placeholder="아이디" required name="memberId">
                <input type="password" class="input-field" placeholder="비밀번호" required name="memberPwd">
            
                <div class="keep-login">
                    <label>
                        <input type="checkbox"> 아이디저장
                    </label>
                </div>
                <button type="submit" id="loginBtn"> 로그인 </button>
                <div class="links">
                    <a href="#">아이디 찾기</a>
                    <span class="divider"></span>
                    <a href="#">비밀번호 찾기</a>
                    <span class="divider"></span>
                    <a href="${ pageContext.request.contextPath }/enrollForm.me">회원가입</a>
                </div>
                <br>
                <hr>
                <br>
                <div class="sub-title">간편로그인</div>
                <br>
                <div class="social-login">
                    <div class="kakao-logo">
                        <span><i class="fa fa-comment"></i></span> 
                    </div>
                    <span class="separator">또는</span>
                    <div class="naver-logo">
                        <span>N</span> 
                    </div>
                </div>
            </form>
        </div>
    </div>
 <%@ include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>