<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입 | 뷰라밸 (Beauty Life Balance)</title>
<link rel="stylesheet" href="resources/css/member/welcome.css">
<script src="resources/js/member/welcome.js" defer></script> 
<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
<!-- jQuery 라이브러리 -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

<!-- Noto Sans font-->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap" rel="stylesheet">
 
<!-- Font Awesome -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
  
</head>
<body  class="body-offset" id="custom">
<%@ include file="/WEB-INF/views/common/header.jsp" %>

            <div class="container-fluid" id="custom-page">    
               <h3 align="center"> 회원가입 </h3>
               <nav class="steps-container outer" align="center">
                   <span>1. 약관동의</span>
                   <span>></span>
                   <span>2. 정보입력</span>
                   <span>></span>
                   <span><b>3. 가입완료</b></span>
               </nav>
                 <br>
               <div class="outer" align="center">
                  <span class="material-icons" id="welcomeIcon">celebration</span>
                  <h4>회원가입이 완료 되었습니다.</h4>
                  <br>
                  <h5><b>${memberName}</b> 님은 <b>[BABY]</b> 회원이십니다.</h5>
                  <br><br>
                  <div class="rows">
                      <div class="form-row" style=" border-top: 1px solid #ddd;">
                          <label class="form-label">아이디 </label>
                          <div class="form-input">
                              <span> ${memberId}</span>
                          </div>
                      </div>
                      <div class="form-row">
                          <label class="form-label">이름 </label>
                          <div class="form-input ">
                              <span> ${memberName} </span>
                          </div>
                      </div>
                      <div class="form-row"style=" border-bottom: 1px solid #ddd;">
                          <label class="form-label">이메일 </label>
                          <div class="form-input ">
                              <span> ${email}</span>
                          </div>
                      </div>
                  </div>
               </div>
               <form action="loginForm.me" method="get">
               <div class="submit-row">
                   <button type="button" class="btn-lg btn-outline-primary back" onclick="goMain()">메인으로</button>
                   <button class="btn-lg btn-primary next" type="submit">로그인</button>
               </div>
               </form>
            </div>

            
            


 <%@ include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>