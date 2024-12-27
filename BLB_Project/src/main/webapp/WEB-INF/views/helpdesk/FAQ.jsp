<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>FAQ</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/helpdesk/FAQ.css">
	<script src="https://cdnjs.cloudflare.com/ajax/libs/gsap/3.10.0/gsap.min.js"></script>
</head>
<body class="body-offset">
	<%@ include file="/WEB-INF/views/common/header.jsp" %>
	<div class="container-fluid">
		<div class="container">
			<br><br><br><br>
			<!-- 네비게이션 메뉴 -->
			<div class="faq-menu">
				<a href="${pageContext.request.contextPath}/list.fo" class="active">FAQ</a>
				<a href="${pageContext.request.contextPath}/list.io">1:1 문의</a>
				<a href="${pageContext.request.contextPath}/list.no">공지사항</a>
			</div>
			<h1>FAQ</h1>
	
			<div class="section-header">
				<h2>많이 찾는 질문</h2>
			</div>

			<p class="description">
				찾으시는 내용이 없다면 1:1문의를 이용해주세요!
			</p>

			<div class="faq-list">
				<c:forEach var="faq" items="${list}">
					<details>
						<!-- 제목 및 내용 수정 영역 -->
						<summary>
							<form class="faq-edit" action="${pageContext.request.contextPath}/FaqUpdate.fo?fno=${faq.faqNo}" method="post" style="display: none;">
								<input type="hidden" name="fno" value="${faq.faqNo}">
								<input type="text" name="faqTitle" value="${faq.faqTitle}" style="width: 100%; margin-bottom: 5px;">
								<textarea name="faqContent" rows="4" style="width: 100%;">${faq.faqContent}</textarea>
								<div class="faq-actions">
									<button type="submit" class="save-button">저장</button>
									<button type="button" class="cancel-button" onclick="cancelEdit(this)">취소</button>
								</div>
							</form>

							<div class="faq-title-display">${faq.faqTitle}</div>
						</summary>

						<div class="content">
							<div class="faq-display">
								<p>${faq.faqContent}</p>
								<c:if test="${sessionScope.loginUser != null && sessionScope.loginUser.memberId == 'admin'}">
									<div class="faq-actions">
										<button type="button" class="update-button" onclick="editFaq(this)">수정</button>
										<form action="${pageContext.request.contextPath}/FaqDelete.fo" method="post" style="display: inline;">
											<input type="hidden" name="fno" value="${faq.faqNo}">
											<button type="submit" class="delete-button">삭제</button>
										</form>
									</div>
								</c:if>
							</div>
						</div>
					</details>
				</c:forEach>
			</div>

			<c:if test="${sessionScope.loginUser != null && sessionScope.loginUser.memberId == 'admin'}">
				<button type="button" class="add-faq-button" onclick="showAddFaqForm()">FAQ 등록</button>
			</c:if>
			
			<!-- FAQ 등록 폼 -->
			<form class="faq-add-form" action="${pageContext.request.contextPath}/insert.fo" method="post" style="display: none;">
				<h3>새 FAQ 등록</h3>
				<input type="text" name="faqTitle" placeholder="제목을 입력하세요" required style="width: 100%; margin-bottom: 10px;">
				<textarea id="faqContent" name="faqContent" placeholder="내용을 입력하세요" rows="4" required style="width: 100%;">                	
				</textarea>
			
				<select name="faqType" required style="width: 100%; margin-bottom: 10px;">
					<option value="">-- 분류를 선택하세요 --</option>
					<option value="order">주문</option>
					<option value="delivery">배송</option>
					<option value="payAndRefund">결제/환불</option>
				</select>
				
				<div class="faq-actions">
					<button type="submit" class="save-button">등록</button>
					<button type="button" class="cancel-button" onclick="cancelAddFaq()">취소</button>
				</div>
			</form>
		</div>
	</div>

	<script>
// 페이지 로딩 시 애니메이션 추가
window.addEventListener('load', function() {
	// FAQ 메뉴 및 섹션 애니메이션
	gsap.from('.faq-menu', { opacity: 0, y: -20, duration: 0.6, ease: "power2.out" });
	gsap.from('.section-header', { opacity: 0, y: -20, duration: 0.6, ease: "power2.out", delay: 0.3 });
	gsap.from('.faq-list', { opacity: 0, y: 20, duration: 0.6, ease: "power2.out", delay: 0.6 });

	// FAQ 등록 폼 애니메이션
	const addFaqButton = document.querySelector('.add-faq-button');
	const addFaqForm = document.querySelector('.faq-add-form');

	addFaqButton.addEventListener('click', function() {
		gsap.from(addFaqForm, { opacity: 0, y: 10, duration: 0.5, ease: "power2.out" });
		addFaqForm.style.display = 'block';
	});

	// FAQ가 하나씩만 열리도록 처리
	const faqDetails = document.querySelectorAll('.faq-list details');
	faqDetails.forEach(function(detail) {
		detail.addEventListener('click', function() {
			faqDetails.forEach(function(otherDetail) {
				if (otherDetail !== detail) {
					otherDetail.removeAttribute('open');
				}
			});
		});
	});
});

// 수정 버튼 클릭 시 수정 모드 활성화
function editFaq(button) {
	const contentDiv = button.closest('.content');
	const displayDiv = contentDiv.querySelector('.faq-display');
	const editForm = contentDiv.closest('details').querySelector('.faq-edit');
	const titleDiv = contentDiv.closest('details').querySelector('.faq-title-display');
	const summary = contentDiv.closest('details').querySelector('summary');

	const titleInput = editForm.querySelector('input[name="faqTitle"]');
	const contentTextarea = editForm.querySelector('textarea[name="faqContent"]');
	titleInput.dataset.originalValue = titleInput.value;
	contentTextarea.dataset.originalValue = contentTextarea.value;

	// 제목, 내용 수정 폼을 표시하고 기존 제목 숨기기
	titleDiv.style.display = 'none';
	displayDiv.style.display = 'none';
	editForm.style.display = 'block';

	// 수정 중에는 summary의 텍스트를 숨기고 토글 기능 비활성화
	summary.querySelector('.faq-title-display').style.display = 'none';
}

// 수정 취소 버튼
function cancelEdit(button) {
	const contentDiv = button.closest('.content');
	const displayDiv = contentDiv.querySelector('.faq-display');
	const editForm = contentDiv.closest('details').querySelector('.faq-edit');
	const titleDiv = contentDiv.closest('details').querySelector('.faq-title-display');
	const summary = contentDiv.closest('details').querySelector('summary');

	const titleInput = editForm.querySelector('input[name="faqTitle"]');
	const contentTextarea = editForm.querySelector('textarea[name="faqContent"]');
	titleInput.value = titleInput.dataset.originalValue;
	contentTextarea.value = contentTextarea.dataset.originalValue;

	// 수정 취소 시 내용과 제목을 되돌리고 원래 상태로 표시
	titleDiv.style.display = 'block';
	displayDiv.style.display = 'block';
	editForm.style.display = 'none';

	// 취소 시 summary 텍스트 표시
	summary.querySelector('.faq-title-display').style.display = 'block';
}

// 등록 폼 표시
function showAddFaqForm() {
	const addForm = document.querySelector('.faq-add-form');

	// 폼이 이미 보이고 있을 경우 애니메이션을 다시 적용하여 부드럽게 나타나도록
	if (addForm.style.display === 'none' || addForm.style.display === '') {
		addForm.style.display = 'block'; // display를 block으로 설정

		// 애니메이션: FAQ 등록 폼 부드럽게 나타나도록 설정
		gsap.from(addForm, { opacity: 10, y: 10, duration: 0.5, ease: "power2.out" });

		// opacity를 1로 설정하여 투명도가 없게 만듦
		addForm.style.opacity = 1;
	}
}

// 등록 취소
function cancelAddFaq() {
	const addForm = document.querySelector('.faq-add-form');

	// 입력값 초기화
	addForm.reset();

	// 폼 숨기기
	addForm.style.display = 'none';

	// opacity를 다시 1로 설정하여 투명하지 않게 함
	addForm.style.opacity = 1;
}
</script>

	<%@ include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>