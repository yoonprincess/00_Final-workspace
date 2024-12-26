<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입 | 뷰라밸 (Beauty Life Balance)</title>

<link rel="stylesheet" href="resources/css/member/enrollForm.css">

<script src="resources/js/member/enrollForm.js" defer></script>   

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.0/css/all.min.css" integrity="sha512-10/jx2EXwxxWqCLX/hHth/vu2KY3jCF70dCQB8TSgNjbCVAC/8vai53GfMDrO2Emgwccf2pJqxct9ehpzG+MTw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <!-- daum 지도검색 api -->
   <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    
</head>
<body class="body-offset">
<%@ include file="/WEB-INF/views/common/header.jsp" %>
    <div class="container-fluid" id="custom-page">    
        <h3 align="center"> 회원가입 </h3>
        
        <nav class="steps-container outer" align="center">
            <span>1. 약관동의 </span>
            <span>></span>
            <span><b>2. 정보입력</b></span>
            <span>></span>
            <span>3. 가입완료</span>
        </nav>

        <form class="registration-form outer" action="insert.me" method="post" id="enrollForm">
            <div class="section-header">
                <h4>기본정보</h4> 
                <span class="required"><span class="required-mark" >*</span> 필수입력사항</span>
            </div>
            
            <div class="form-row">
                <label class="form-label">아이디 <span class="required-mark" >*</span></label>
                <div class="form-input id-input">
                    <div class="input-wrapper">
                        <input type="text" class="input-field" name="memberId" id="memberId" required>
                        <span class="input-notice" id="noticeId">(5-20자의 영문소문자/숫자만)</span>
                    </div>
                    <div id="checkId" style="display:none;"></div>
                </div>              
            </div>
		
            <div class="form-row">
                <label class="form-label">비밀번호 <span class="required-mark" >*</span></label>
                <div class="form-input id-input">
                    <div class="input-wrapper">
                        <input type="password" class="input-field" name="memberPwd" id="memberPwd" required>
                        <span class="input-notice" id="noticePwd">(영문대/소문자, 숫자, 특수문자 중 2가지 이상 조합, 8-16자)</span>
                    </div>
					<div id="validatePwd" style="display:none;" ></div>
                </div>
            </div>

            <div class="form-row">
                <label class="form-label">비밀번호 확인 <span class="required-mark" >*</span></label>
                <div class="form-input id-input">
                    <div class="input-wrapper">
                         <input type="password" class="input-field" name="checkPwd" id="ckPwd" required>
                    </div>
                    <div id="checkPwd" style="display:none;" ></div>
                </div>
            </div>
            <div class="form-row">
                <label class="form-label">연락처 <span class="required-mark" >*</span></label>
                <div class="form-input phone-input">
                    <input type="text" class="input-field" id="phone1" maxlength="3" required>
                    <span>-</span>
                    <input type="text" class="input-field" id="phone2" maxlength="4" required>
                    <span>-</span>
                    <input type="text" class="input-field" id="phone3" maxlength="4" required>
                    <input type="hidden" name="phone" id="phone"  maxlength="11"> 
                </div>
            </div>
            <div class="form-row">
                <label class="form-label">이름 <span class="required-mark" >*</span></label>
                <div class="form-input">
                    <input type="name" class="input-field" name="memberName" required>
                </div>
            </div>
            <div class="form-row">
                <label class="form-label">이메일 <span class="required-mark" >*</span></label>
                <div class="form-input" id="email-form-input" >
                	<div class="input-wrapper" >
	                    <input type="email" class="input-field" name="email" required id="email">
	                    <button type="button" 
	                    		class="btn-sm btn-outline-primary blb-btn" 
	                    		id="certbtn"
	                    		style="height:35px; padding:0px 10px;" >인증</button>
                   </div>
                   <div class="input-wrapper" style="display:none;" id="cert-email">
                         <input type="text" class="input-field" name="checkNo" id="certKey" >
                         <button type="button" class="btn-sm btn-primary blb-btn" 
		                         id="vali_email" 
		                         style="height:35px; padding:0px 10px;"
		                         onclick="validateEmail();">확인</button>
                    	 <span class="time" >인증시간</span>
                    </div> 
                </div>
            </div>
            <input type="hidden" id="hiddenEmail" name="email">
            <br>
            <br>
            <div class="section-header">
                <h4>추가 정보 <span class="plus-notice">(선택)</span></h4>
            </div>
		
		<div class="form-row">
           <label class="form-label">생년월일 </label>
           <div class="form-input birthdate-input">
               <input type="date" class="input-field" style="width:280px;"name="birthdate" >
           </div>
        </div>
        
        <div class="form-row ">
            <label class="form-label">기본주소 <br> 등록 </label>
            <div  class="form-input ">
                <div class="form-input-addr" >
                    <div class="zipcode-row " >
                        <input type="text" class="input-field address-field "  id="sample4_postcode" placeholder="우편번호" name="postcode" >
                        <input type="button" class="btn-sm btn-outline-primary blb-btn" 
                        onclick="sample4_execDaumPostcode()" 
                        value="우편번호"
                        style="height:35px; padding:0px 10px;"><br>
                    </div>
                    <div class="address-row ">
                        <textarea class="input-field address-field" id="sample4_roadAddress" 
                                placeholder="도로명주소" name="deliAddress"></textarea><br>
                        <input type="text"  class="input-field address-field" 
                                id="sample4_detailAddress" placeholder="상세주소" name="detailAddress">
                    </div>
                </div>
                <input type="hidden" name="deliDefault" value="Y">
            </div>
        </div>   
               
        <div class="submit-row">
            <button type="submit" class="btn-lg btn-primary blb-btn" disabled id="submitBtn">회원가입</button>
            <button type="reset" onclick="window.location.reload();" 
			        class="btn-lg btn-outline-primary blb-btn" 
			        style="transition: none;" 
			        id="resetBtn">초기화</button>
        </div>
        </form>
    </div>
    <%@ include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>