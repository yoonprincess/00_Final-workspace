<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입 | 뷰라밸 (Beauty Life Balance)</title>

<link rel="stylesheet" href="resources/css/member/enrollForm.css">
<script src="resources/js/member/enrollForm.js" defer></script>   

    <!-- Latest compiled and minified CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">

    <!-- 간단한 동작을 정의해둔 js 파일 연동 -->
    <!-- jQuery 온라인 방식 -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

    <!-- Popper JS -->
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>

    <!-- Latest compiled JavaScript -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
  
     <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.0/css/all.min.css" integrity="sha512-10/jx2EXwxxWqCLX/hHth/vu2KY3jCF70dCQB8TSgNjbCVAC/8vai53GfMDrO2Emgwccf2pJqxct9ehpzG+MTw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
</head>
<body>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
    <div class="outer" >    
        <h2 align="center"> 회원가입 </h2>
        <br>
        <nav class="breadcrumb" align="center">
            <span>1. 약관동의 </span>
            <span>></span>
            <span>2. 정보입력</span>
            <span>></span>
            <span>3. 가입완료</span>
        </nav>

        <form class="registration-form" action="insert.me" method="post" id="enrollForm">
            <div class="section-header">
                <h2>기본정보</h2> 
                <span class="required"><span class="required-mark" >*</span> 필수입력사항</span>
            </div>
            <br>
            <div class="form-row">
                <label class="form-label">아이디 <span class="required-mark" >*</span></label>
                <div class="form-input">
                    <input type="text" class="input-field" name="memberId">
                    <span class="input-notice">(영문소문자/숫자/특수문자 중 2가지 조합, 4-16자)</span>
                </div>
            </div>

            <div class="form-row">
                <label class="form-label">비밀번호 <span class="required-mark" >*</span></label>
                <div class="form-input">
                    <input type="password" class="input-field" name="memberPwd">
                    <span class="input-notice">(영문대/소문자, 숫자, 특수문자 중 2가지 이상 조합, 10-16자)</span>
                </div>
            </div>

            <div class="form-row">
                <label class="form-label">비밀번호 확인 <span class="required-mark" >*</span></label>
                <div class="form-input">
                    <input type="password" class="input-field" name="checkPwd">
                </div>
            </div>
            <!--
            <div class="form-row">
                <label class="form-label">회원인증 <span class="required-mark" >*</span></label>
                <div class="form-input">
                    <button type="button" class="file-button">휴대폰인증</button>
                    <p class="file-notice">본인 명의의 휴대폰으로 본인인증을 진행합니다. </p>
                </div>
            </div>
            -->    
            <div class="form-row">
                <label class="form-label">연락처 <span class="required-mark" >*</span></label>
                <div class="form-input phone-input">
                    <input type="text" class="input-field" id="phone1" maxlength="3">
                    <span>-</span>
                    <input type="text" class="input-field" id="phone2" maxlength="4">
                    <span>-</span>
                    <input type="text" class="input-field" id="phone3" maxlength="4">
                    <input type="hidden" name="phone" id="phone"  maxlength="11"> 
                    <!-- 
                    <button type="button" class="confirm-button">본인인증</button>
                     -->
                </div>
            </div>

            <div class="form-row">
                <label class="form-label">이름 <span class="required-mark" >*</span></label>
                <div class="form-input">
                    <input type="name" class="input-field" name="memberName">
                </div>
            </div>
            <div class="form-row">
                <label class="form-label">생년월일 </label>
                <div class="form-input birthdate-input">
                    <input type="text" class="input-field" style="width:280px;"name="birthdate" >
                </div>
                
            </div>

            <div class="form-row">
                <label class="form-label">이메일 <span class="required-mark" >*</span></label>
                <div class="form-input">
                    <input type="text" class="input-field" name="email">
                    <!--  
                    <button type="button" class="confirm-button">중복확인</button>
                    -->
                </div>
            </div>
         
            <br>
            <div class="section-header">
                <h2>추가 정보 <span class="plus-notice">(선택)</span></h2>
            </div>
          
        <!--
            <div class="form-row">
                <label class="form-label">조건확인</label>
                <div class="form-input radio-group">
                    <label class="radio-label">
                        <input type="radio" name="condition" value="yes">
                        <span>예</span>
                    </label>
                    <label class="radio-label">
                        <input type="radio" name="condition" value="no">
                        <span>아니오</span>
                    </label>
                </div>
            </div>   
        -->
		<br>
        <div class="form-row">
            <label class="form-label">기본주소 <br> 등록 </label>
            <div class="form-input-addr">
                <div class="zipcode-row">
                    <input type="text" class="input-field address-field" placeholder="우편번호" disabled>
                    <button type="button" class="search-button" disabled>주소검색</button>
                </div>
                <div class="address-row">
                        <input type="text" class="input-field address-field" placeholder="기본주소" disabled>
                        <input type="text" class="input-field address-field" placeholder="상세주소" disabled>
                </div>
            </div>
        </div>
        <div class="submit-row">
            <button type="submit" class="btn-lg btn-outline-primary">회원가입</button>
            <button  class="btn-lg btn-secondary">초기화</button>
        </div>
        </form>
    </div>
    <%@ include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>