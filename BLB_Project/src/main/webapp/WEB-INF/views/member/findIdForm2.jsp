<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디찾기 | 뷰라밸 (Beauty Life Balance)</title>
<link rel="stylesheet" href="resources/css/member/findIdForm2.css">
<script src="resources/js/member/findIdForm.js" defer></script> 
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
			<br><br><br><br>
				<h4 align="center"><b>아이디찾기</b></h4>
           	<br>
            <div class="container-fluid outer" id="check-page" >    
	             <div class="div-container outer" id="findId" align="center;">
	                 <div id="input-wrapper" style="width:100%;">
	                  <p  style="font-size:20px;">  ${findIdMember.memberName} 회원님의 아이디는</p>
	                  <p style="font-size:20px;"><b>${findId} </b>입니다.</p>
	              	</div>
	             	<div class="submit-row">
			            <button type="button" class="btn btn-outline-primary blb-btn findPwd" onclick="goFindPwd()">비밀번호 찾기</button>
			            <button class="btn btn-outline-info goLogin" type="button" onclick="goLogin">로그인하기</button>
			       </div>
	             </div>
            </div>
 <%@ include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>