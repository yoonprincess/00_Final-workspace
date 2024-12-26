<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내 배송목록 |  뷰라밸 (Beauty Life Balance)</title>


<link rel="stylesheet" href="resources/css/member/updateDelivery.css">

<script src="resources/js/member/updateDelivery.js" defer></script>   

  
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.0/css/all.min.css" integrity="sha512-10/jx2EXwxxWqCLX/hHth/vu2KY3jCF70dCQB8TSgNjbCVAC/8vai53GfMDrO2Emgwccf2pJqxct9ehpzG+MTw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
   
	<!-- daum 지도검색 api -->
   <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
   <script> var deliPhone = "${d.deliPhone}"</script>
    <script> var deliComment = "${d.deliComment}"</script>
</head>
<body class="body-offset">
    <%@ include file="/WEB-INF/views/common/header.jsp" %>
    <div class="outer container-fluid">
        <div id="main">
             <%@ include file="/WEB-INF/views/member/menubar.jsp" %>
                <div class="container">
       <div class="container">
        <div class="tabs">
            <button class="tab active">배송지</button>
        </div>

        <form action="updateMyDelivery.me" method="post" id="updateDeliForm">
            <div class="form-section">
                <h2 class="section-title">배송지 수정</h2>
                <div class="form-group">
                    <label class="form-label">배송지명</label>
                    <div class="form-input">
                        <input type="text" placeholder="최대 10자" name="deliNickname" value="${d.deliNickname}">
                        <input type="hidden" name="deliDefault" value="${d.deliDefault}">
                    </div>
                </div>
                
				<!-- Hidden field for deliCode -->
				<input type="hidden" name="deliCode" value="${d.deliCode}">
				<!-- Hidden field for homeAddressYN -->
				<input type="hidden" name="homeAddressYN" value="${d.homeAddressYN != null ? d.homeAddressYN : 'N'}">
				
                <div class="form-group">
                    <label class="form-label required">받는분</label>
                    <div class="form-input">
                        <input type="text" placeholder="최대 10자" name="deliName" id="deliName" value="${d.deliName}">
                    </div>
                </div>

                <div class="form-group">
                    <label class="form-label required">연락처</label>
                    <div class="form-input phone-group">
                        <input type="text" class="phone-input" id="phone1" maxlength="3">
                        <span>-</span>
                        <input type="text" class="phone-input" id="phone2" maxlength="4">
                        <span>-</span>
                        <input type="text" class="phone-input" id="phone3" maxlength="4">
                         <input type="hidden" name="deliPhone" id="deliPhone"  maxlength="11"> 
                    </div>
                </div>

                <div class="form-group">
                    <label class="form-label required">주소</label>
                    <div class="form-input">
                     <div class="form-input-addr" >
                       <div class="zipcode-row " >
                        	<input type="text" class="input-field address-field"  id="sample4_postcode" placeholder="우편번호" name="postcode" value="${d.postcode}">
                       		 <input type="button" class="btn-sm btn-primary blb-btn" onclick="sample4_execDaumPostcode()" value="우편번호"><br>
		               </div>
	                   <div class="address-row ">
	                        <textarea class="input-field address-field" id="sample4_roadAddress" 
	                                placeholder="도로명주소" name="deliAddress" 
	                                style="height:100px; width:290px; resize:none; border: 1px solid #ddd;">${d.deliAddress}</textarea><br>
	                        <input type="text"  class="input-field address-field" 
	                        		style="width:290px;"
	                                id="sample4_detailAddress" placeholder="상세주소" name="detailAddress" value="${d.detailAddress}">
	                   </div>
	                 </div>
                    </div>
                </div>
            </div>

            <div class="form-section">
                <h2 class="section-title">배송지 요청사항</h2>
                
                <div class="form-group">
                    <label class="form-label required">공동현관 출입방법</label>
                    <div class="form-input radio-group">
                        <label class="radio-label">
                            <input type="radio" name="entry" value="비밀번호"  >
                            비밀번호
                        </label>
                        <label class="radio-label">
                            <input type="radio" name="entry" value="경비실호출">
                            경비실호출
                        </label>
                        <label class="radio-label">
                            <input type="radio" name="entry" value="자유출입가능">
                            자유출입가능
                        </label>
                        <label class="radio-label">
                            <input type="radio" name="entry" value="기타사항">
                            기타사항
                        </label>
                    </div>
                </div>

                <div class="form-group">
                    <label class="form-label required">추가요청사항</label>
                    <div class="form-input">
                        <input type="text" class="address-input" 
                        id="additionalInfo" placeholder="공동현관 비밀번호를 입력하세요"
                        style="width:300px;" value="${d.deliComment}">
                    </div>
                </div>
                 <input type="hidden" name="deliComment" id="deliComment">
            </div>

            <div class="notice">
                <ul>
                    <li>• 개인정보 수집목적: 상품구매시 배송처리</li>
                    <li>• 수집항목: 배송지명,수령인,연락처,주소(번호지, 주소, 공동현관 출입방법)</li>
                    <li>• 보유 및 이용기간: 정보 삭제요청시 혹은 회원탈퇴시까지</li>
                    <li>• 확인 버튼을 누르시면 위의 배송지 정보가 저장되거나 업데이트됩니다.</li>
                </ul>
            </div>

            <div class="checkbox-group">
                <input type="checkbox" id="agree">
                <label for="agree">위 개인정보 수집이용을 확인하고 배송지를 등록합니다.</label>
            </div>

            <div class="button-group">
                <button type="submit" class="button button-confirm" id="updateBtn">수정</button>
                <button type="button" class="button button-cancel">취소</button>
            </div>
        </form>
    </div>
	            <br><br>
	         
	        </div>
	      </div>
	    </div>
   <%@ include file="/WEB-INF/views/common/footer.jsp" %>
  </body>
</html>