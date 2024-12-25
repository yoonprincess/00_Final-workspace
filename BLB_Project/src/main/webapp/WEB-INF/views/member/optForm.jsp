<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
    <title>옵션 선택</title>
    <!-- jQuery 3.7.1 -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <!-- header CSS -->
    <link rel="stylesheet" href="${ pageContext.request.contextPath }/resources/css/common/header.css">
    <!-- Bootstrap 4.6.2 CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
    <!-- Google Fonts NotoSansKR -->
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&family=Oregano&display=swap" />
    <!-- Google Fonts Icon -->
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
    <!-- awesome Icon -->
	<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" rel="stylesheet">

    <!--  Alertify 라이브러리 연동구문 (CDN) -->
	<!-- JavaScript -->
	<script src="//cdn.jsdelivr.net/npm/alertifyjs@1.14.0/build/alertify.min.js"></script>
	<!-- CSS -->
	<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/alertifyjs@1.14.0/build/css/alertify.min.css"/>
	<!-- Default theme -->
	<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/alertifyjs@1.14.0/build/css/themes/default.min.css"/>
	<!-- Semantic UI theme -->
	<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/alertifyjs@1.14.0/build/css/themes/semantic.min.css"/>

    <style>
        body {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            width: 100%;
            height: 100%;
        }
        /* 컨테이너 스타일 */
        .option-container {
            width: 100%; /* 부모의 크기를 기준으로 조정 */
            margin: 0 auto; /* 중앙 정렬 */
            border: 1px solid #ddd;
            border-radius: 10px;
            padding: 20px;
            background-color: #fff;
        }

        /* 버튼 스타일 */
        .btn-submit {
            width: 100%;
            background-color: #4A628A;
            color: white;
            border: none;
            padding: 10px 15px;
            font-size: 16px;
            font-weight: bold;
            border-radius: 5px;
            cursor: pointer;
        }
        #dropdown{
	        width:100%;  
	        color: #4A628A; 
	        padding-left:5px; 
	        height:30px;
	        border-radius:5px;
        }
        #dropdown:focus{
	        border:none;
	        border-radius:5px;
        }
        .btn-group{
        	display:flex;
        	flex-direction:row;
        	gap:20px;
        	 justify-content: center; /* 수평 가운데 정렬 */
  			align-items: center;     /* 수직 가운데 정렬 (필요시) */
        }
    </style>
</head>
<body>
    <div class="option-container" id="firstModal">
        <!-- 문의 작성 폼 -->
        <form id="insertCartForm" action="insertCart.me" method="post" enctype="multipart/form-data">
            <input type="hidden" id="prodNo" name="prodNo" value="${optList[0].prodNo}">
            <!-- 문의 작성 -->
            <div class="form-group">
            <h5>옵션 선택</h5>
            <hr>
               <select id="dropdown" name="optNo" style="color:#4A628A;">
                  <option style="padding-left:10px;" >옵션을 선택해주세요</option>
                  <c:forEach var="opt" items="${optList}">
                    <option value="${opt.optNo}"
		                    data-name="${opt.optName}" 
		                    data-price="${opt.optAddPrice}" 
		                    data-stock="${opt.remainQty}"
		                    >
		               ${opt.optName}
		              	  <c:if test="${opt.optAddPrice > 0}">
		              	  	(+<fmt:formatNumber value="${opt.optAddPrice}" type="number" pattern="#,###"/>원)
		              	  </c:if>
		                (재고: ${opt.remainQty})
		                 
		            </option>
                  </c:forEach>
                </select>
            </div>
            <button type="submit" class="btn-submit">장바구니 담기</button>
        </form>
    </div>
    
	<div class="option-container modal" id="customModal"  style="display:none;">
      
            <input type="hidden" id="prodNo" name="prodNo" value="${optList[0].prodNo}">
            <!-- 문의 작성 -->
            <div class="form-group" align="center;">
            <h5>선택완료</h5>
            <hr>
            <p id="modalMessage" style="text-align:center;"></p>
              <div class="btn-group" align="center;">
		        <button class="btn-outline-primary blb-btn" onclick="closeModal();">쇼핑계속하기</button>
		        <button class="btn-outline-primary blb-btn" onclick="goCart();">장바구니이동</button>
		    </div>
            </div>
           
       
    </div>

    <script>
        $(document).ready(function () {

            $('#insertCartForm').on('submit', function (e) {
                e.preventDefault(); // 기본 폼 제출 방지
                
                const selectedOption = $('#dropdown').val(); // 드롭다운에서 선택된 값
              	  if (selectedOption === "" || selectedOption === "옵션을 선택해주세요") {
               	 
              		alertify.error("옵션을 선택해주세요"); // 옵션이 선택되지 않으면 경고 메시지 출력
                    return; // 선택되지 않으면 폼 제출을 막고 함수 종료
               	 }
                
                const formData = new FormData(this);
                
                $.ajax({
                    url: 'insertCart.me',
                    type: 'POST',
                    data: formData,
                    contentType: false,
                    processData: false,
                    success: function (response) {
                        if (response.success) {
                            // 성공 메시지
                             openModal(response.message);
                            
                            // 일정 시간 후 창 닫기
                            setTimeout(function () {
                                parent.$('#reviewIframeContainer').hide();
                                parent.location.reload(); 
                            }, 8000); // 1초 후 창 닫기
                        } else {
                            // 실패 메시지
                            alertify.error(response.message);
                            setTimeout(function () {
                                parent.$('#reviewIframeContainer').hide();
                                parent.location.reload(); // 부모 페이지 새로고침
                            }, 1000); // 1초 후 창 닫기
                        }
                    },
                    error: function () {
                    	
                        alertify.error("서버 오류가 발생했습니다. 다시 시도해주세요.");
                        // 일정 시간 후 창 닫기
                        setTimeout(function () {
                                parent.$('#reviewIframeContainer').hide();
                                parent.location.reload(); // 부모 페이지 새로고침
                            }, 1000); // 1초 후 창 닫기
                    }
                });
            });
        });
        
        // 장바구니 담은 후 성공시 띄우는 모달창 
        function openModal(message) {
		    // 모달에 메시지 설정
		    document.getElementById('modalMessage').textContent = message;
		    // 모달 열기
		    document.getElementById('customModal').style.display = 'block';
		    document.getElementById('firstModal').style.display = 'none';
		    
		}
		
		function closeModal() {
            parent.$('#reviewIframeContainer').hide();
            parent.location.reload(); // 부모 페이지 새로고침
		}
		
		function goCart() {
		    parent.$('#reviewIframeContainer').hide();
		   	parent.window.location.href = '${pageContext.request.contextPath}/list.ct'; // 장바구니 페이지로 이동
		}

    </script>

    
    <!-- Popper JS -->
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>

    <!-- Bootstrap 4.6.2 JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
    
    <!-- header Javascript -->
    <script src="${ pageContext.request.contextPath }/resources/js/common/header.js"></script>
</body>
</html>
