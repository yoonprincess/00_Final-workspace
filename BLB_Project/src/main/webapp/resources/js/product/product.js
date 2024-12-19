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
    $('#product-option').change(function () {
        const optionId = $(this).val(); // 옵션 ID
        const optionName = $(this).find('option:selected').data('name'); // 옵션 이름
        const optionPrice = parseInt($(this).find('option:selected').data('price')) || 0; // 옵션 가격
        const optionStock = parseInt($(this).find('option:selected').data('stock')) || 0; // 옵션 재고

        if (optionId) {
            let existingOption = selectedOptions.find(opt => opt.id == optionId); // `==`으로 비교
            if (existingOption) {
                existingOption.quantity++;
            } else {
                selectedOptions.push({ id: optionId, name: optionName, price: optionPrice, stock: optionStock, quantity: 1 });
            }
            updateSelectedOptions();
            // 선택 값을 초기화하여 "선택하세요"로 변경
            $(this).val("");
        }
    });

    // 선택된 옵션 업데이트
    function updateSelectedOptions() {
        let html = '';
        selectedOptions.forEach(option => {
            html += `
                <div class="selected-option mb-2 p-2 border rounded">
                    <div class="d-flex justify-content-between align-items-center">
                        <!-- 옵션 내용 (좌측 정렬) -->
                        <span style="flex: 1; text-align: left;">${option.name}</span>
                        <!-- 옵션 재고 (우측 정렬, 조건부 스타일) -->
                        <span style="flex: 1; text-align: right; color: ${option.stock < 10 ? 'red' : 'inherit'};">
                            재고: ${option.stock}개
                        </span>
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
        const optionStock = parseInt($(this).find('option:selected').data('stock')) || 0; // 옵션 재고
        const option = selectedOptions.find(opt => opt.id == id); // `==`으로 비교
        if (option && option.quantity < option.stock) {
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
        const basePrice = parseInt($("#base-price").val()) || 0; // 기본 가격
        const total = selectedOptions.reduce((sum, opt) => sum + (basePrice + opt.price) * opt.quantity, 0);
        $('#totalPrice').html(total.toLocaleString() + '<small>원</small>');
    }
    
    // 장바구니 추가
    $('#addToCart').click(function() {
        alert('장바구니에 추가되었습니다.');
    });

    // 바로 구매
    $('#buyNow').click(function() {
        alert('구매 페이지로 이동합니다.');
    });

    $('.top-review').on('click', function (e) {

        let tabsOffset = $('.origin-tab-location').offset().top || 0; // 탭 메뉴의 위치
        // 부드러운 스크롤 이동
        $('html, body').animate(
            {
                scrollTop: tabsOffset,
            },
            300 // 스크롤 이동 속도 (밀리초)
        );
        
        // 탭 활성화 처리
        $('#reviews-tab').tab('show');
        
    });

    
    // 탭 클릭 시 스크롤 이동
    $('#productTabs a').on('click', function (e) {
        e.preventDefault();
        let tabsOffset = $('.origin-tab-location').offset().top || 0; // 탭 메뉴의 위치
        // 부드러운 스크롤 이동
        $('html, body').animate(
            {
                scrollTop: tabsOffset,
            },
            300 // 스크롤 이동 속도 (밀리초)
        );

        // 탭 활성화 처리
        $(this).tab('show');
    });

    // 리뷰 페이지 이동 시 데이터 교체
    $(document).on('click', '#rev-pagination a', function (e) {
        e.preventDefault();
    
        const revUrl = $(this).data('url'); // data-url 속성에서 URL 가져오기
        
        // AJAX로 데이터 로드
        $.ajax({
            url: revUrl,
            method: 'GET',
            success: function (response) {
                // 요청받은 리스트 및 페이지네이션 변수에 저장
                const newReviewList = $(response).find('#reviewList').html();
                const newRevPagination = $(response).find('#rev-pagination').html();

                // 새로운 데이터로 대체
                $('#reviewList').html(newReviewList);
                $('#rev-pagination').html(newRevPagination);

                // 페이지네이션 클릭된 버튼 활성화 처리
                $(`#rev-pagination a[data-url="${revUrl}"]`).addClass('active');
            },
            error: function () {
                console.error('리뷰 데이터를 불러오는 중 오류 발생');
            },
        });
    });

    // QnA 페이지 이동 시 데이터 교체
    $(document).on('click', '#qna-pagination a', function (e) {
        e.preventDefault();

        const qnaUrl = $(this).data('url'); // data-url 속성 가져오기

        // AJAX로 데이터 로드
        $.ajax({
            url: qnaUrl,
            type: 'GET',
            success: function (response) {
                // 요청받은 리스트 및 페이지네이션 변수에 저장
                const newQnaList = $(response).find('#qnaList').html();
                const newQnaPagination = $(response).find('#qna-pagination').html();

                // 새로운 데이터로 대체
                $('#qnaList').html(newQnaList);
                $('#qna-pagination').html(newQnaPagination);

                // 페이지네이션 클릭된 버튼 활성화 처리
                $(`#qna-pagination a[data-url="${qnaUrl}"]`).addClass('active');
            },
            error: function () {
                console.error('QnA 데이터를 불러오는데 실패했습니다.');
            }
        });
    });
});
