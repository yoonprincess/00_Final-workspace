<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호찾기 | 뷰라밸 (Beauty Life Balance)</title>
<link rel="stylesheet" href="resources/css/member/findPwdForm2.css">
<script src="resources/js/member/findPwdForm2.js" defer></script> 
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
            <div class="container-fluid" id="check-page"  >    
             	<h4 align="center"><b>비밀번호찾기</b></h4>
              
	              <div class="div-container outer" id="findPwd">
	                 <div style="padding-left:60px;"><b>본인인증 확인</b></div>
	                 
	                 <div id="radio-input" >
	                 <span class="cert-label">인증방법</span>
	                    <input type="radio" class="radio-field" name="checkType" id="email" value="email" checked >
	                    <label for="email">이메일</label>
	              	</div>
	              	<div class="inputAndBtn" >
		                 <div class="input-wrapper" >
		                    <span id="email-label"  class="cert-label">이메일</span>
		                    <span style="padding-left:15px;" class="cert-label">${ckPwdMember.getEmail()}</span> 
		                    <input type="hidden" id="hiddenEmail" value="${ckPwdMember.getEmail()}"> 
		                    <button  type="button" onclick="cert()" id="certBtn" > 인증번호 받기</button>
		              	</div>
		              	 <div class="input-wrapper">
		                    <span class="cert-label" >인증코드</span>
		                    <input type="text" class="input-field" name="certKey" id="certKey">
		                    <span class="time"></span>
		                </div>
	              	</div>
	             	<div class="submit-row">
	             		<button type="button" id="validateBtn" class="btn btn-outline-primary blb-btn" onclick="validateEmail()">확인</button>
	             		<button type="reset"  class="btn btn-outline-primary blb-btn" onclick="goBack();">취소</button>
			       </div>
	              </div>
             
            </div>
              
             <div class="page-wrapper">
           		<div class="container-fluid" id="result-page" style="display : none;">
		        <h4><b>비밀번호 재설정</b></h4>
		        <div class="container">
		        <form action="newPwd.me" method="post" id="newPwdForm">
		            <div class="form-group">
		                <label for="memberId" class="label">아이디</label>
		                <div class="input-wrapper1">
		                     <span style="color:#4A628A; ">${ckPwdMember.getMemberId()}</span>  
			                 <input type="hidden" name="ckMemberId" value="${ckPwdMember.getMemberId()}">
		                </div>
		            </div>
		            <div class="form-group">
		                <label for="newPassword" class="label" style="margin-bottom:70px;">새 비밀번호</label>
		                <div class="input-wrapper1">
		                    <input type="password" id="newPwd" name="newPwd">
		                    <p id="noticePwd" class="helper-text">영문 대소문자/숫자/특수문자 중 2가지 이상 조합, (8~16자)</p>
		                    <p id="validatePwd" style="display:none;"></p>
		                </div>
		            </div>
		            <div class="form-group">
		                <label for="confirmPassword" class="label">새 비밀번호 확인</label>
		                <div class="input-wrapper1">
		                    <input type="password" id="ckPwd" name="ckPwd">
		                    <p id="checkPwd" style="display:none;"></p>
		                </div>
		            </div>
		            <div class="btn-wrapper">
		                <button type="submit" class="btn-primary blb-btn">비밀번호 변경</button>
		                <button type="button" class="btn btn-outline-secondary cancel-btn" style="width:130px;">취소</button>
		            </div>
		        </form>
		        </div>
    		</div>
			</div>
 <%@ include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>