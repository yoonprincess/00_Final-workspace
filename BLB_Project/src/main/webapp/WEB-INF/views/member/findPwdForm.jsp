<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호찾기 | 뷰라밸 (Beauty Life Balance)</title>
<link rel="stylesheet" href="resources/css/member/findPwdForm.css">
<script src="resources/js/member/findPwdForm.js" defer></script> 
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
             	<h4 align="center"><b>비밀번호찾기</b></h4>
              <form action="findId.me" method="post" id="findIdForm">
	              <div class="div-container outer" id="findId">
	                 <div style="padding-left:60px;"><b>회원 비밀번호 찾기</b></div>
	                 <div  id="radio-input" >
	                    <input type="radio" class="radio-field" name="checkType" id="email" value="email" checked >
	                    <label for="email">이메일</label>
	                    <input type="radio" class="radio-field" name="checkType" id="phone" value="phone">
	              		<label for="phone">휴대번호</label>
	              	</div>
	              	<div id="inputAndBtn" >
		                 <div id="input-wrapper" >
		                 	<span >아이디</span>
		                 	<input type="text" class="input-field" name="memberId" id="checkId" required>
		                   	<span >이름</span>
		                    <input type="text" class="input-field" name="name" id="checkName" required>
		                    <div id="email-label" >이메일</div>
		                    <input type="email" class="input-field" name="email" id="checkEmail" >
		                    <div id="phone-label" style="display:none;">휴대번호</div>
		                    <input type="text" class="input-field" name="phone" id="checkPhone" 
		                    		placeholder="- 빼고 작성" style="display:none;">
		              	</div>
	              	</div>
	             	<div class="submit-row">
	             		<button type="submit" id="findPwdBtn" class="btn btn-outline-info">비밀번호찾기</button>
			            <button type="button" class="btn btn-outline-info findPwd" onclick="goFindId()">아이디찾기</button>
			       </div>
	              </div>
	               
             </form>
            </div>
			
			<div class="container-fluid outer" id="result-page" style="display:none;">
			
			</div>
			 
			
 <%@ include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>