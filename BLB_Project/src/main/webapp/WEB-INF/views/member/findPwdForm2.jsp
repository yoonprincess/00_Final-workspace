<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
            <div class="container-fluid outer" id="check-page" style="display:none;" >    
             	<h4 align="center"><b>비밀번호찾기</b></h4>
              
	              <div class="div-container outer" id="findId">
	                 <div style="padding-left:60px;"><b>본인인증 확인</b></div>
	                 
	                 <div id="radio-input" >
	                 <span>인증방법</span>
	                    <input type="radio" class="radio-field" name="checkType" id="email" value="email" checked >
	                    <label for="email">이메일</label>
	              	</div>
	              	<div class="inputAndBtn" >
		                 <div class="input-wrapper" >
		                    <span id="email-label" >이메일</span>
		                    <span>${ckPwdMember.getEmail()}</span>  
		                    <button type="button" onclick="cert()" id="certBtn">인증</button>
		              	</div>
		              	 <div class="input-wrapper">
		                    <span class="cert-label" >인증코드</span>
		                    <input type="text" class="input-field" name="certKey" id="certKey">
		                    <span class="time">인증시간</span>
		                </div>
	              	</div>
	             	<div class="submit-row">
	             		<button type="submit" id="findPwdBtn" class="btn btn-outline-info">확인</button>
			       </div>
	              </div>
             
            </div>
			<div class="container-fluid outer" id="result-page">	
				<h4 align="center"><b>비밀번호 재설정</b></h4>
	              <form action="newPwd.me" method="post" id="newPwdForm">
		              <div class="div-container outer" id="findId">
		              	<div class="inputAndBtn" >
			                 <div class="input-wrapper" >
			                    <span id="id-label" >아이디</span>
			                    <span>${ckPwdMember.getMemberId()}</span>  
			                    <input type="hidden" name="ckMemberId" value="${ckPwdMember.getMemberId()}">
			                    
			              	</div>
	                      	
	                      	 <label class="form-label">새 비밀번호 </label>
			                <div class="form-input id-input">
			                    <div class="input-wrapper">
			                        <input type="password" class="input-field" name="newPwd" id="newPwd" required>
			                        <span class="input-notice" id="noticePwd">(영문대/소문자, 숫자, 특수문자 중 2가지 이상 조합, 8-16자)</span>
			                    </div>
								<div id="validatePwd" style="display:none;" ></div>
			                </div>
			            </div>
			
			            <div class="form-row">
			                <label class="form-label">새 비밀번호 확인 </label>
			                <div class="form-input id-input">
			                    <div class="input-wrapper">
			                         <input type="password" class="input-field" name="checkPwd" id="ckPwd" required>
			                    </div>
			                    <div id="checkPwd" style="display:none;" ></div>
			                </div>
			            </div>
	                    <input type="hidden" name="memberPwd" value="${ckPwdMember.getMemberPwd()}" >
		              	
		              	<div class="submit-row">
		             		<button type="submit"  class="btn btn-outline-info">확인</button>
		             		<button type="reset"  class="btn btn-outline-info">취소</button>
				        </div>
		              </div>
	             </form>
			</div>
			 
			
 <%@ include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>