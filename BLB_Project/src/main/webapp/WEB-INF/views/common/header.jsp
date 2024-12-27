<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>뷰라밸 (Beauty Life Balance)</title>
    <!-- jQuery 3.7.1 -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <!-- Bootstrap 4.6.2 CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
    <!-- Google Fonts NotoSansKR -->
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&family=Oregano&display=swap" />
    <!-- Google Fonts Icon -->
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
    <!-- awesome Icon -->
	<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" rel="stylesheet">

    
    <!-- header CSS -->
    <link rel="stylesheet" href="${ pageContext.request.contextPath }/resources/css/common/header.css">
	
    <!--  Alertify 라이브러리 연동구문 (CDN) -->
	<!-- JavaScript -->
	<script src="//cdn.jsdelivr.net/npm/alertifyjs@1.14.0/build/alertify.min.js"></script>
	<!-- CSS -->
	<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/alertifyjs@1.14.0/build/css/alertify.min.css"/>
	<!-- Default theme -->
	<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/alertifyjs@1.14.0/build/css/themes/default.min.css"/>
	<!-- Semantic UI theme -->
	<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/alertifyjs@1.14.0/build/css/themes/semantic.min.css"/>

	<!-- GSAP CDN 연동 구문 -->
	<script src="https://cdn.jsdelivr.net/npm/gsap@3.12.5/dist/gsap.min.js"></script>	
	

</head>
<body>
	<c:if test="${ not empty sessionScope.alertMsg }">
		<script>
		alertify.alert('Alert', '${ sessionScope.alertMsg }');
		</script>	
		<c:remove var="alertMsg" scope="session"/>
	</c:if>
	<c:if test="${ not empty sessionScope.errorMsg }">
		<script>
		alertify.error('${ sessionScope.errorMsg }');
		</script>	
		<c:remove var="errorMsg" scope="session"/>
	</c:if>
	<c:if test="${ not empty sessionScope.successMsg }">
		<script>
		alertify.success('${ sessionScope.successMsg }');
		</script>	
		<c:remove var="successMsg" scope="session"/>
	</c:if>
	
	<!-- iframe 작성하기 컨테이너 -->
	<div id="reviewIframeContainer" style="display: none;">
		<div style="position: relative;"> <!-- 닫기 버튼을 포함하는 컨테이너 -->
			<button class="close-btn review-enroll">&times;</button>
			<iframe src=""></iframe>
		</div>
	</div>
	<!-- 토글버튼 효과 -->
	<div class="overlay blb-toggler" style="display: none;">
		<div id="buttonDiv" >
			<span class="material-symbols-outlined" 
				id="" 
				style="text-align: center;">
			</span>
			<p id="toggler-message"></p>
		</div>
	</div>


    <nav class="navbar navbar-expand-md navbar-dark fixed-top transparent-navbar">
        <div class="container-fluid">
            <a class="navbar-brand" href="${ pageContext.request.contextPath }/">
                <img src="${ pageContext.request.contextPath }/resources/images/BLB_logo.png">
            </a>

            <!-- 메뉴 버튼 (토글러 좌측) -->
            <div class="ml-auto d-flex align-items-center order-md-2">
                <!-- 검색 버튼 -->
                <div class="search-container d-flex align-items-center">
                    <input type="text" id="searchBox" class="form-control search-box" placeholder="검색어를 입력하세요" value="${keyword}">
                    <a class="menu-btn" id="searchIcon">
                        <span class="material-symbols-outlined menu-icon">search</span>
                    </a>
                </div>
                <!-- 로그인 체크 -->
                <c:choose>
	                <c:when test="${ empty sessionScope.loginUser }">
                        <!-- 로그인 -->
		                <a class="menu-btn" href="${ pageContext.request.contextPath }/loginForm.me">
		                    <span class="material-symbols-outlined menu-icon">
		                        person
		                    </span>
		                </a>
	           		</c:when>
	           		
	           		<c:when test="${not empty sessionScope.loginUser && sessionScope.loginUser.memberId eq 'admin' }">	           			
	                	<a class="menu-btn" href="${ pageContext.request.contextPath }/admin.blb">
	                		<span class="material-symbols-outlined menu-icon">
								construction
							</span>
	                	</a>
						<div class="menu-btn notification-system">
						    <a id="notification-toggle" href="#" aria-label="알림 토글" aria-expanded="false">
						        <span class="material-symbols-outlined menu-icon">
						            notifications
						        </span>
						        <span class="notification-count">0</span>
						    </a>
					    <div class="notification-dropdown" aria-label="알림">
					        <div class="notification-actions">
					            <button class="action-btn" id="mark-all-read">모두 읽음</button>
					            <button class="action-btn" id="delete-all">모두 삭제</button>
					        </div>
					        <ul class="notification-list">
					            <!-- 알림 항목들이 여기에 동적으로 추가됩니다 -->
					        </ul>
					    </div>
						</div>
		                	
                        <a class="menu-btn" href="${ pageContext.request.contextPath }/wishList.me">
                            <span class="material-symbols-outlined menu-icon">
                                favorite
                            </span>
                        </a>
                        
                        <a class="menu-btn" href="${ pageContext.request.contextPath }/list.ct">
                            <span class="material-symbols-outlined menu-icon">
                                shopping_cart
                            </span>
                        </a>
                        
	                	<a class="menu-btn" href="${ pageContext.request.contextPath }/myPage.me">
		                    <span class="material-symbols-outlined menu-icon">
		                        person_check
		                    </span>
		                </a>	
	               	 	<a class="menu-btn" href="${ pageContext.request.contextPath }/logout.me">
		                    <span class="material-symbols-outlined menu-icon">
		                        Logout
		                    </span>
		              	</a>
			        </c:when>
	                <c:otherwise>
	                	<!--Start of Tawk.to Script-->
						<script type="text/javascript">
							var Tawk_API=Tawk_API||{}, Tawk_LoadStart=new Date();
							(function(){
							var s1=document.createElement("script"),s0=document.getElementsByTagName("script")[0];
							s1.async=true;
							s1.src='https://embed.tawk.to/6724699c2480f5b4f59728e5/1ibj3p3lr';
							s1.charset='UTF-8';
							s1.setAttribute('crossorigin','*');
							s0.parentNode.insertBefore(s1,s0);
							})();
						</script>
						<!--End of Tawk.to Script-->
                        <!-- 알림 -->
						<div class="menu-btn notification-system">
						    <a id="notification-toggle" href="#" aria-label="알림 토글" aria-expanded="false">
						        <span class="material-symbols-outlined menu-icon">
						            notifications
						        </span>
						        <span class="notification-count">0</span>
						    </a>
						    <div class="notification-dropdown" aria-label="알림">
						        <div class="notification-actions">
						            <button class="action-btn" id="mark-all-read">모두 읽음</button>
						            <button class="action-btn" id="delete-all">모두 삭제</button>
						        </div>
						        <ul class="notification-list">
						            <!-- 알림 항목들이 여기에 동적으로 추가됩니다 -->
						        </ul>
						    </div>
						</div>
                        
                        <!-- 찜 -->
                        <a class="menu-btn" href="${ pageContext.request.contextPath }/wishList.me">
                            <span class="material-symbols-outlined menu-icon">
                                favorite
                            </span>
                        </a>
                        
                        <!-- 장바구니 -->
                        <a class="menu-btn" href="${ pageContext.request.contextPath }/list.ct">
                            <span class="material-symbols-outlined menu-icon">
                                shopping_cart
                            </span>
                        </a>
                        
                        <!-- 마이페이지 -->
	                	<a class="menu-btn" href="${ pageContext.request.contextPath }/myPage.me">
		                    <span class="material-symbols-outlined menu-icon">
		                        person_check
		                    </span>
		                </a>	
                        <!-- 로그아웃 -->
	               	 	<a class="menu-btn" href="${ pageContext.request.contextPath }/logout.me">
		                    <span class="material-symbols-outlined menu-icon">
		                        Logout
		                    </span>
		              	</a>
	            	</c:otherwise>
            	</c:choose>
            </div>

            <!-- 토글 버튼 -->
            <button class="navbar-toggler order-md-3" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="toggler-icon"></span>
                <span class="toggler-icon"></span>
                <span class="toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse order-md-1" id="navbarNav">
                <ul class="navbar-nav">
                    <!-- 제품보기 드롭다운 메뉴 -->
	                <li class="nav-item dropdown custom-dropdown">
					    <a class="nav-link" href="${ pageContext.request.contextPath }/list.pr">제품보기</a>
					    <div class="custom-dropdown-menu">
					        <a class="dropdown-item" href="${ pageContext.request.contextPath }/list.pr">전체제품</a>
					        <a class="dropdown-item" href="${ pageContext.request.contextPath }/list.pr?category=스킨케어">스킨케어</a>
					        <a class="dropdown-item" href="${ pageContext.request.contextPath }/list.pr?category=메이크업">메이크업</a>
					        <a class="dropdown-item" href="${ pageContext.request.contextPath }/list.pr?category=맨즈">맨즈</a>
					        <a class="dropdown-item" href="${ pageContext.request.contextPath }/list.pr?category=헤어/바디">헤어/바디</a>
					    </div>
					</li>
                    <li class="nav-item">
                        <a class="nav-link" href="${ pageContext.request.contextPath }/list.pr?sortBy=sales">베스트</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${ pageContext.request.contextPath }/list.pr?sortBy=recent">신제품</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${ pageContext.request.contextPath }/listAll.rv">리뷰</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${ pageContext.request.contextPath }/list.fo">고객센터</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>
    <!-- Back to Top Button -->
    <button id="backToTop">
    	<span class="material-symbols-outlined bold-icon">vertical_align_top</span>
    </button>
    
    <!-- Popper JS -->
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>

    <!-- Bootstrap 4.6.2 JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
    
    <!-- header Javascript -->
    <script src="${ pageContext.request.contextPath }/resources/js/common/header.js"></script>
    
    <script>
    const contextPath = "${pageContext.request.contextPath}";

    $(document).ready(function() {
        const $notificationToggle = $('#notification-toggle');
        const $notificationDropdown = $('.notification-dropdown');
        const $notificationCount = $('.notification-count');
        const $notificationList = $('.notification-list');
        const $markAllReadBtn = $('#mark-all-read');
        const $deleteAllBtn = $('#delete-all');
        
        // 알림 토글 기능
        $notificationToggle.on('click', toggleNotificationDropdown);
        
        // 개별 알림 삭제 및 읽음 표시 기능
        $notificationList.on('click', handleNotificationAction);
        
        // 모든 알림 읽기 기능
        $markAllReadBtn.on('click', markAllAsRead);
        
        // 모든 알림 삭제 기능
        $deleteAllBtn.on('click', deleteAllNotifications);

        // 웹소켓 객체를 담을 전역변수
        let socket;

        // 웹소켓 연결 함수
        connectWebSocket();

        // 초기 알림 개수 설정
        updateNotificationCount();

        // 알림 개수 업데이트 함수
        function updateNotificationCount() {
            const unreadCount = $notificationList.find('.notification-item:not(.read)').length;
            $notificationCount.text(unreadCount);
            $notificationCount.css('display', unreadCount > 0 ? 'inline-block' : 'none');
        }

        // 알림 목록에 새 알림 추가
        function addNotification(msg) {
            const newNotification = $('<li class="notification-item"></li>');
            newNotification.html(`
                <div id="message_wrap3">${msg}</div>
                <div class="notification-actions">
                    <button class="read-notification" aria-label="알림 읽음">
                        <span class="material-symbols-outlined">done</span>
                    </button>
                    <button class="delete-notification" aria-label="알림 삭제">
                        <span class="material-symbols-outlined">close</span>
                    </button>
                </div>
            `);
            $notificationList.prepend(newNotification);
            updateNotificationCount();
        }

        // 알림 토글 기능
        function toggleNotificationDropdown(e) {
            e.preventDefault();
            const expanded = $(this).attr('aria-expanded') === 'true';
            $(this).attr('aria-expanded', !expanded);
            $notificationDropdown.css('display', expanded ? 'none' : 'block');
        }

        // 개별 알림 삭제 및 읽음 표시 기능
        function handleNotificationAction(e) {
            const $notificationItem = $(e.target).closest('.notification-item');
            if (!$notificationItem.length) return;

            if ($(e.target).closest('.delete-notification').length) {
                $notificationItem.remove();
                updateNotificationCount();
            } else if ($(e.target).closest('.read-notification').length) {
                $notificationItem.addClass('read');
                updateNotificationCount();
            }
        }

        // 모든 알림 읽음 표시 기능
        function markAllAsRead() {
            $notificationList.find('.notification-item').addClass('read');
            updateNotificationCount();
        }

        // 모든 알림 삭제 기능
        function deleteAllNotifications() {
            $notificationList.empty();
            updateNotificationCount();
        }

        // 웹소켓 연결
        function connectWebSocket() {
            const url = "ws://localhost:80/blb/noty.blb";
            socket = new WebSocket(url);

            socket.onopen = function() {
                console.log("웹소켓 연결 완료!");
            };

            socket.onclose = function() {
                console.log("웹소켓 연결 종료!");
            };

            socket.onerror = function() {
                console.log("웹소켓 에러 발생!");
            };

            socket.onmessage = function(e) {
                const obj = JSON.parse(e.data);
                addNotification(obj.msg);
            };
        }
    });

        
    </script>

</body>
</html>