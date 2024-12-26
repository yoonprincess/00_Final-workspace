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
              <form action="findPwd.me" method="post" id="findPwdForm">
	              <div class="div-container outer" id="findPwd">
	                 <div ><b>회원 비밀번호 찾기</b></div>
	                 <p >본인 확인 완료 후 비밀번호를 재설정할 수 있습니다.</p>
	                 <div  id="radio-input" >
	                    <input type="radio" class="radio-field" name="checkType" id="email" value="email" checked >
	                    <label for="email">이메일</label>
	              	</div>
	              	<div id="inputAndBtn" >
		                 <div id="input-wrapper" >
		                 	<input type="text" class="input-field" name="memberId" id="checkId"
		                 	placeholder="아이디">
		                    <input type="text" class="input-field" name="memberName" id="checkName"
		                    placeholder="이름" >
		                    <input type="email" class="input-field" name="email" id="checkEmail"
		                    placeholder="가입한 이메일" >
		                    <input type="text" class="input-field" name="phone" id="checkPhone" 
		                    		placeholder="- 빼고 작성" style="display:none;">
		              	</div>
	              	</div>
	             	<div class="submit-row">
	             		<button type="submit" id="findPwdBtn" class="btn btn-primary blb-btn">확인</button>
	             		<button type="button" id="findPwdBtn" 
	             				class="btn btn-outline-secondary" 
	             				style="width:70px;"
	             				onclick="goMain();">취소</button>
			       </div>
	              </div>
             </form>
            </div>
			
			 
			
 <%@ include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>