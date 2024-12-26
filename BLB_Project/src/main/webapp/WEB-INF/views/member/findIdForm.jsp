<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디찾기 | 뷰라밸 (Beauty Life Balance)</title>
<link rel="stylesheet" href="resources/css/member/findIdForm.css">
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
            <div class="container-fluid outer" id="check-page" >    
             	<h4 align="center"><b>아이디찾기</b></h4>
              <form action="findId.me" method="post" id="findIdForm">
	              <div class="div-container outer" id="findId">
	                 <div style="padding-left:15px;"><b>회원 아이디 찾기</b></div>
	                 <div  id="radio-input" sty>
	                    <input type="radio" class="radio-field" name="checkType" id="email" value="email" checked >
	                    <label for="email">이메일</label>
	                    
	              	</div>
	              	<div id="input-group">
		              	<div class="inputAndBtn" >
			                 <div class="input-wrapper" >
			                    <input type="text" class="input-field" name="memberName" id="checkName"
			                    placeholder="이름" required>
			                 </div >
			                 <div class="input-wrapper">
			                    <input type="email" class="input-field" name="email" id="checkEmail"
			                     placeholder="가입메일주소" required>
		                      <input type="text" class="input-field" name="phone" id="checkPhone" 
		                    		placeholder="가입휴대번호 (- 빼고 작성)"  style="display:none;">
			                 </div>
		              	</div>
		              	<div class="inputAndBtn"> 
		              		<button type="submit" id="findIdBtn" class="btn btn-outline-info">아이디찾기</button>
		              	</div>
	              	</div>
	             	<div class="submit-row">
			            <button type="button" class="btn btn-outline-info findPwd" onclick="goFindPwd()">비밀번호 찾기</button>
			            <button class="btn btn-outline-info goLogin" type="button" onclick="goLogin()">로그인하기</button>
			       </div>
	              </div>
	               
             </form>
            </div>
			
 <%@ include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>