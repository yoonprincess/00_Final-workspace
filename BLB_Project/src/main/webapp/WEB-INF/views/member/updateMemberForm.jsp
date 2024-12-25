<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원정보수정 | 뷰라밸 (Beauty Life Balance)</title>

 <!-- jQuery 라이브러리 -->
 <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

<link rel="stylesheet" href="resources/css/member/updateMemberForm.css">

<script src="resources/js/member/updateMemberForm.js" defer></script>   

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.0/css/all.min.css" integrity="sha512-10/jx2EXwxxWqCLX/hHth/vu2KY3jCF70dCQB8TSgNjbCVAC/8vai53GfMDrO2Emgwccf2pJqxct9ehpzG+MTw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <!-- daum 지도검색 api -->
   <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    
    <script> var phone = "${loginUser.phone}"</script>
</head>
<body class="body-offset">
<%@ include file="/WEB-INF/views/common/header.jsp" %>
    <div class="container-fluid" id="custom-page">    
        <h3 align="center"> 회원정보 수정 </h3>
        

        <form class="registration-form outer" action="update.me" method="POST" id="updateForm">
            <div class="section-header">
                <h4>기본정보</h4> 
                <span class="required"><span class="required-mark" >*</span> 필수입력사항</span>
            </div>
            
            <div class="form-row">
             
                <label class="form-label">아이디 <span class="required-mark" ></span></label>
                <div class="form-input id-input">
                    <div class="input-wrapper">
                        <input type="text" class="input-field" name="memberId" id="memberId" 
                        value="${loginUser.memberId}" readonly  style="background-color: #F4F4F9;" >
                    </div>
                   
                </div>              
            </div>
		
            <div class="form-row">
                <label class="form-label">비밀번호 <span class="required-mark" >*</span></label>
                <div class="form-input id-input">
                
                    <div class="input-wrapper" style="flex-direction: column; align-items: flex-start;">
                     <c:if test="${loginUser.loginType == 'kakao'}">
                      	<button class="btn btn-outline-secondary" type="button" id="changePwd" style="display:none;"> 비밀번호 변경</button>
                     </c:if>
                      <c:if test="${loginUser.loginType != 'kakao'}"> 
                      	<button class="btn btn-outline-secondary" type="button" id="changePwd"> 비밀번호 변경</button>
                     </c:if>
                       <div class="input-wrapper">
                       <span class="input-label hidden"> 현재 비밀번호</span>
                      <input type="password" class="input-field hidden" name="currentPwd" id="memberPwd" >
                       </div>
                      <div class="input-wrapper">
                      	<span class="input-label hidden"> 새 비밀번호</span>
                    	<input type="password" class="input-field hidden" name="newPwd" id="newPwd" required >
                    	<span class="input-notice hidden" id="noticePwd">(영문대/소문자, 숫자, 특수문자 중 2가지 이상 조합, 8-16자)</span>
                      </div>
                      <div id="validatePwd"  class="hidden"></div>
                      <div class="input-wrapper" >
                        <span class="input-label hidden"> 새 비밀번호 확인</span>
                        <input type="password" class="input-field hidden" name="ckPwd" id="ckPwd" required>
                      </div>
                      <div id="checkPwd" class="hidden" ></div>
                    </div>
                    <input type="hidden" name="memberPwd" value="${loginUser.memberPwd}" >
                </div>
            </div>

            <div class="form-row">
                <label class="form-label">연락처 <span class="required-mark" >*</span></label>
                <c:if test="${loginUser.loginType == 'kakao'}">
	                <div class="form-input phone-input">
	                    <input type="text" class="input-field" id="phone1" maxlength="3" readonly style="background-color: #F4F4F9;">
	                    <span>-</span>
	                    <input type="text" class="input-field" id="phone2" maxlength="4"  readonly style="background-color: #F4F4F9;">
	                    <span>-</span>
	                    <input type="text" class="input-field" id="phone3" maxlength="4"  readonly style="background-color: #F4F4F9;">
	                    <input type="hidden" name="phone" id="phone"  maxlength="11"> 
	                </div>
                </c:if>
                <c:if test="${loginUser.loginType != 'kakao'}">
	                <div class="form-input phone-input">
	                    <input type="text" class="input-field" id="phone1" maxlength="3" required>
	                    <span>-</span>
	                    <input type="text" class="input-field" id="phone2" maxlength="4"  required>
	                    <span>-</span>
	                    <input type="text" class="input-field" id="phone3" maxlength="4"  required>
	                    <input type="hidden" name="phone" id="phone"  maxlength="11"> 
	                </div>
                </c:if>
            </div>
            <div class="form-row">
                <label class="form-label">이름 <span class="required-mark" ></span></label>
                <div class="form-input">
                    <input type="name" class="input-field" name="memberName" value="${loginUser.memberName}" readonly style="background-color: #F4F4F9;">
                </div>
            </div>
            <div class="form-row">
                <label class="form-label">이메일 <span class="required-mark" >*</span></label>
                <c:if test="${loginUser.loginType == 'kakao'}">
                <div class="form-input" id="email-form-input" >
                	<div class="input-wrapper" >
	                    <input type="email" class="input-field" name="email" required id="email" value="${loginUser.email}" readonly style="background-color: #F4F4F9;">
	                    <button type="button" class="btn-sm btn-outline-info" id="changebtn" style="display:none;" >변경</button>
	                    <button type="button" class="btn-sm btn-outline-info" id="certbtn"  onclick="cert();" style="display:none;">인증</button>
                   </div>
                   <div class="input-wrapper" style="display:none;" id="cert-email">
                         <input type="text" class="input-field" name="checkNo" id="certKey" >
                         <button type="button" class="btn-sm btn-outline-info" id="vali_email" onclick="validateEmail();">확인</button>
                   		 <span class="time" >인증시간</span>
                    </div> 
                </div>
                </c:if>
                <c:if test="${loginUser.loginType != 'kakao'}">
                <div class="form-input" id="email-form-input" >
                	<div class="input-wrapper" >
	                    <input type="email" class="input-field" name="email" required id="email" value="${loginUser.email}">
	                    <button type="button" class="btn-sm btn-outline-info" id="changebtn" >변경</button>
	                    <button type="button" class="btn-sm btn-outline-info" id="certbtn"  onclick="cert();" style="display:none;">인증</button>
                   </div>
                   <div class="input-wrapper" style="display:none;" id="cert-email">
                         <input type="text" class="input-field" name="checkNo" id="certKey" >
                         <button type="button" class="btn-sm btn-outline-info" id="vali_email" onclick="validateEmail();">확인</button>
                   		 <span class="time" >인증시간</span>
                    </div> 
                </div>
                </c:if>
            </div>
             <div class="form-row">
                <label class="form-label">이메일 수신여부 <span class="required-mark" >*</span></label>
                <div class="form-input">
                    <input type="radio" id="yes" class="input-field" name="receiveEmail" value="yes" checked>동의
                    <input type="radio" id="no" class="input-field" name="receiveEmail" value="no" >거부
                </div>
            </div>
            <br>
            <br>
            <div class="section-header">
                <h4>추가 정보 <span class="plus-notice">(선택)</span></h4>
            </div>
		
		<div class="form-row">
           <label class="form-label">생년월일 </label>
           <div class="form-input birthdate-input">
               <input type="date" class="input-field" style="width:280px;" name="birthdate" value="${loginUser.birthdate.substring(0,10)}" id="birthdate">
           </div>
        </div>
        
        <div class="form-row ">
            <label class="form-label">기본주소 <br>  </label>
            <div  class="form-input ">
                <div class="form-input-addr" >
                    <div class="zipcode-row " >
                        <input type="text" class="input-field address-field"  id="sample4_postcode" placeholder="우편번호" 
                        		name="postcode"  value="${d.postcode}" readonly>
                        <input type="button" class="btn-sm btn-outline-info" onclick="sample4_execDaumPostcode()" value="주소변경"><br>
                    </div>
                    <div class="address-row ">
                        <textarea class="input-field address-field" id="sample4_roadAddress" 
                                placeholder="도로명주소" name="deliAddress" readonly>${d.deliAddress}</textarea><br>
                        <input type="text"  class="input-field address-field" 
                                id="sample4_detailAddress" placeholder="상세주소" name="detailAddress" value="${d.detailAddress}">
                    </div>
                </div>
            </div>
        </div>   
               
        <div class="submit-row">
            <button type="submit" class="btn-lg btn-outline-primary">정보수정</button>
            <button type="button" class="btn-lg btn-outline-warning" onclick="goBack();">취소</button>
        </div>
        </form>
    </div>
    <%@ include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>