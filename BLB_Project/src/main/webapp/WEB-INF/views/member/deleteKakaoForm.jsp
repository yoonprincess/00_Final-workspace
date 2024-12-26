<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원탈퇴 | 뷰라밸 (Beauty Life Balance)</title>
<link rel="stylesheet" href="resources/css/member/deleteForm2.css">
<script src="resources/js/member/deleteForm2.js" defer></script> 
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
			<br><br><br><br><br><br>
            <div class="container-fluid" id="check-page" align="center" >    
             	<h2 align="center"> 회원 탈퇴 </h2>
             	<br>
             	<p>카카오 계정을 탈퇴하면 복구할 수 없습니다. 계속 진행하시겠습니까?</p>
             	
             	<div id="deleteConfirmModal" class="modal" style="margin:0;">
				    <div class="modal-content">
				        <h2>정말 탈퇴하시겠습니까?</h2>
				        <p >카카오 계정을 탈퇴하면 복구할 수 없습니다. 탈퇴를 진행하시겠습니까?</p>
				        <br>
				        <div style="display:flex; flex-direction:row;  justify-content: center; 
				        			align-items: center; margin: 0;
				        			gap:10px;">
				         <button id="confirmDeleteBtn" class="btn-confirm"
				         		style="background-color:#FFCD00;">
				          <i class="fa fa-comment"></i>
				          탈퇴
				          </button>
				         <button id="cancelDeleteBtn" class="btn-cancel">취소</button>
				        </div>
				    </div>
				    <br>
				</div>
				    <div style="display:flex; flex-direction:row;  justify-content: center; align-items: center; margin: 0; gap:10px;">
	              		<button class="btn-outline-primary blb-btn" 
	              				style="width:200px;
	              				 display: flex; align-items: center;  height: 60px; 
	              				 justify-content: center;"
	              		onclick="showDeleteConfirmModal();">
						    탈퇴
		                 </button>
		                 <button class="btn-primary blb-btn" style="width:200px;  height: 60px;" 
	              		onclick="goBack();">
						    취소
		                 </button>
	                 </div>
            </div>
            
			<div class="container-fluid" id="result-page" style="display:none;">
			 <div class="outer" align="center">
	                    <span class="material-symbols-outlined" id="deleteIcon">move_location</span>
	                    <h4>회원탈퇴가 완료 되었습니다.</h4>
	                    <br>
	                    <h6>뷰라밸을 이용해 주시고 사랑해주셔서 감사합니다.</h6>
	                    <h6>더욱더 노력하고 발전하는 뷰라밸이 되겠습니다.</h6>
	                    <br><br>
	                    <button type="button" class="btn-outline-primary blb-btn main" onclick="goMain()">메인으로</button>
	                    
	                </div>
			 </div>
 <%@ include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>