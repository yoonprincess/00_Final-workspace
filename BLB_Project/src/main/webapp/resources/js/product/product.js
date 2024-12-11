$(document).ready(function () {
    // * 상품 목록보기 script
    // 정렬 및 보기 설정
	$('#sortBy, #boardLimit').change(function () {
	    const sortBy = $('#sortBy').val();
	    const boardLimit = $('#boardLimit').val();
	
	    // 현재 URL을 기반으로 파라미터 추가
	    const currentUrl = new URL(window.location.href);
	    currentUrl.searchParams.set('sortBy', sortBy);
	    currentUrl.searchParams.set('boardLimit', boardLimit);
	    
	    // 페이지 초기화
	    currentUrl.searchParams.set('ppage', 1);
	
	    // 새 URL로 이동
	    window.location.href = currentUrl.toString();
	});

    // 장바구니 추가 버튼
    $('.add-cart').click(function (e) {
        e.stopPropagation();
        const productId = $(this).data('id');
        alert(`장바구니에 상품 ${productId} 추가!`);
    });

    // 찜하기 버튼
    $('.add-wishlist').click(function (e) {
        e.stopPropagation();
        const productId = $(this).data('id');
        alert(`찜 목록에 상품 ${productId} 추가!`);
    });


    // * 상품 상세보기 script
    // 이미지 썸네일 클릭 이벤트
    $('.thumbnail').click(function() {
        $('.thumbnail').removeClass('active-thumbnail');
        $(this).addClass('active-thumbnail');
    });

    // 옵션 선택 및 수량 변경
    let selectedOptions = [];

    // 옵션 선택 시 옵션 목록에 추가
    $('#option').change(function() {
        const optionId = $(this).val(); // 옵션 ID
        const optionName = $(this).find('option:selected').text(); // 옵션 이름
        const optionPrice = parseInt($(this).find('option:selected').data('price')) || 0; // 옵션 가격

        if (optionId) {
            let existingOption = selectedOptions.find(opt => opt.id == optionId); // `==`으로 비교
            if (existingOption) {
                existingOption.quantity++;
            } else {
                selectedOptions.push({ id: optionId, name: optionName, price: optionPrice, quantity: 1 });
            }
            updateSelectedOptions();
        }
    });

    // 선택된 옵션 업데이트
    function updateSelectedOptions() {
        let html = '';
        selectedOptions.forEach(option => {
            html += `
                <div class="selected-option mb-2 p-2 border rounded">
                    <div class="d-flex justify-content-between align-items-center">
                        <span>${option.name}</span>
                        <div>
                            <button type="button" class="btn btn-sm btn-outline-secondary decrease-quantity" data-id="${option.id}">-</button>
                            <span class="mx-2 option-quantity">${option.quantity}</span>
                            <button type="button" class="btn btn-sm btn-outline-secondary increase-quantity" data-id="${option.id}">+</button>
                        </div>
                    </div>
                </div>
            `;
        });
        $('#selectedOptions').html(html);
        updateTotalPrice();
    }

    // 수량 증가
    $(document).on('click', '.increase-quantity', function(e) {
        e.preventDefault(); // 기본 동작 방지
        const id = $(this).data('id'); // data-id 가져오기
        const option = selectedOptions.find(opt => opt.id == id); // `==`으로 비교
        if (option) {
            option.quantity++; // 수량 증가
            updateSelectedOptions();
        }
    });

    // 수량 감소
    $(document).on('click', '.decrease-quantity', function(e) {
        e.preventDefault(); // 기본 동작 방지
        const id = $(this).data('id'); // data-id 가져오기
        const option = selectedOptions.find(opt => opt.id == id); // `==`으로 비교
        if (option) {
            if (option.quantity > 1) {
                option.quantity--; // 수량 감소
            } else {
                selectedOptions = selectedOptions.filter(opt => opt.id != id); // 옵션 제거
            }
            updateSelectedOptions();
        }
    });

    // 총 금액 계산
    function updateTotalPrice() {
        const basePrice = 29800; // 기본 가격
        const total = selectedOptions.reduce((sum, opt) => sum + (basePrice + opt.price) * opt.quantity, 0);
        $('#totalPrice').text(total.toLocaleString() + '원');
    }

    // 리뷰 데이터 (실제로는 서버에서 가져와야 함)
    const reviews = [
        { id: 1, author: 'user1', rating: 5, content: '제품이 너무 좋아요! 재구매 의사 있습니다.', date: '2024-01-10' },
        { id: 2, author: 'user2', rating: 4, content: '전반적으로 만족스럽습니다.', date: '2024-01-09' },
        { id: 3, author: 'user3', rating: 5, content: '피부에 잘 맞아요. 추천합니다!', date: '2024-01-08' },
        { id: 4, author: 'user4', rating: 3, content: '보통이에요. 큰 기대는 하지 마세요.', date: '2024-01-07' },
        { id: 5, author: 'user5', rating: 5, content: '가격 대비 품질이 훌륭해요.', date: '2024-01-06' },
    ];

    // 상품문의 데이터 (실제로는 서버에서 가져와야 함)
    const qnas = [
        { id: 1, title: '배송 관련 문의', author: 'user1', content: '언제쯤 배송될까요?', date: '2024-01-10', answer: '주문 후 1-2일 내에 발송됩니다.' },
        { id: 2, title: '제품 사용 문의', author: 'user2', content: '사용 방법을 자세히 알고 싶어요.', date: '2024-01-09', answer: '제품 설명서를 참고해 주세요. 추가 문의 사항은 고객센터로 연락 주시기 바랍니다.' },
        { id: 3, title: '환불 정책', author: 'user3', content: '개봉 후 환불이 가능한가요?', date: '2024-01-08', answer: '개봉 후에는 환불이 어렵습니다. 자세한 내용은 환불 정책을 확인해 주세요.' },
        { id: 4, title: '할인 쿠폰', author: 'user4', content: '첫 구매 할인 쿠폰은 어떻게 받나요?', date: '2024-01-07', answer: '회원가입 시 자동으로 지급됩니다. 마이페이지에서 확인 가능합니다.' },
        { id: 5, title: '품절 문의', author: 'user5', content: '언제 재입고 되나요?', date: '2024-01-06', answer: '현재 생산 중이며, 이번 주 내로 재입고 예정입니다.' },
    ];

    function renderReviews(page) {
        const itemsPerPage = 3;
        const start = (page - 1) * itemsPerPage;
        const end = start + itemsPerPage;
        const paginatedReviews = reviews.slice(start, end);

        let html = '';
        paginatedReviews.forEach(review => {
            html += `
                <div class="card mb-3">
                    <div class="card-body">
                        <div class="d-flex justify-content-between align-items-center mb-2">
                            <div>
                                <span class="review-stars">
                                    ${'<i class="fas fa-star"></i>'.repeat(review.rating)}
                                    ${'<i class="far fa-star"></i>'.repeat(5 - review.rating)}
                                </span>
                                <span class="ml-2">${review.author}</span>
                            </div>
                            <small class="text-muted">${review.date}</small>
                        </div>
                        <p class="card-text">${review.content}</p>
                    </div>
                </div>
            `;
        });
        $('#reviewList').html(html);

        renderPagination(reviews.length, itemsPerPage, page, 'reviewPagination', renderReviews);
    }

    function renderQna(page) {
        const itemsPerPage = 3;
        const start = (page - 1) * itemsPerPage;
        const end = start + itemsPerPage;
        const paginatedQna = qnas.slice(start, end);

        let html = '';
        paginatedQna.forEach(qna => {
            html += `
                <div class="card mb-3">
                    <div class="card-body">
                        <h5 class="card-title">${qna.title}</h5>
                        <p class="card-text">${qna.content}</p>
                        <p class="card-text">
                            <small class="text-muted">작성자: ${qna.author} | 작성일: ${qna.date}</small>
                        </p>
                        ${qna.answer ? `
                            <div class="mt-3 p-3 bg-light">
                                <p class="mb-0"><strong>답변:</strong> ${qna.answer}</p>
                            </div>
                        ` : ''}
                    </div>
                </div>
            `;
        });
        $('#qnaList').html(html);

        renderPagination(qnas.length, itemsPerPage, page, 'qnaPagination', renderQna);
    }

    function renderPagination(totalItems, itemsPerPage, currentPage, paginationId, renderFunction) {
        const totalPages = Math.ceil(totalItems / itemsPerPage);
        let html = '';
        for (let i = 1; i <= totalPages; i++) {
            html += `
                <li class="page-item ${i === currentPage ? 'active' : ''}">
                    <a class="page-link" href="#" data-page="${i}">${i}</a>
                </li>
            `;
        }
        $(`#${paginationId}`).html(html);

        $(`#${paginationId} .page-link`).click(function(e) {
            e.preventDefault();
            const page = $(this).data('page');
            renderFunction(page);
        });
    }

    // 초기 렌더링
    renderReviews(1);
    renderQna(1);

    // 탭 전환 시 해당 컨텐츠 렌더링
    $('#productTabs a').on('shown.bs.tab', function (e) {
        const target = $(e.target).attr("href");
        if (target === '#reviews') {
            renderReviews(1);
        } else if (target === '#qna') {
            renderQna(1);
        }
    });

    // 장바구니 추가
    $('#addToCart').click(function() {
        alert('장바구니에 추가되었습니다.');
    });

    // 바로 구매
    $('#buyNow').click(function() {
        alert('구매 페이지로 이동합니다.');
    });

    // 스크롤 이벤트 처리
    $(window).scroll(function() {
        var windowTop = $(window).scrollTop();
        var imageBottom = $('.col-lg-6:first-child').offset().top + $('.col-lg-6:first-child').outerHeight();

        if (windowTop > imageBottom) {
            $('.sticky-wrapper').addClass('is-sticky');
        } else {
            $('.sticky-wrapper').removeClass('is-sticky');
        }
    });

});
