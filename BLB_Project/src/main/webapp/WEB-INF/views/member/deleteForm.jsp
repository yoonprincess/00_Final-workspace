<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원탈퇴 | 뷰라밸 (Beauty Life Balance)</title>
<link rel="stylesheet" href="resources/css/member/deleteForm.css">
<script src="resources/js/member/deleteForm.js" defer></script> 
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
               <h3 align="center"> 회원탈퇴 </h3>
               <nav class="steps-container outer" align="center">
                   <span>회원님의 정보를 안전하게 보호하기 위해<br> 비밀번호를 다시한번 확인합니다 </span>
                   
                   
               </nav>
                 <br>
               <div class="outer" align="center">
                  <span class="material-symbols-outlined" id="deleteIcon">move_location</span>
                  <h4>회원탈퇴가 완료 되었습니다.</h4>
                  <br>
                  <h6>뷰라밸을 이용해 주시고 사랑해주셔서 감사합니다.</h6>
                  <h6>더욱더 노력하고 발전하는 뷰라밸이 되겠습니다.</h6>
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
                      
                  </div>
               </div>
               <form action="loginForm.me" method="get">
               <div class="submit-row">
                   <button type="button" class="btn-lg btn-outline-primary" onclick="goBack()">취소</button>
                   <button class="btn-lg btn-primary next" type="submit">탈퇴</button>
               </div>
               </form>
            </div>

            
            


 <%@ include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>