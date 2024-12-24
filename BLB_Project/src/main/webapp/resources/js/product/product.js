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

    // 찜하기 기능
    $('.wishlist-btn').click(function (e) {
        e.stopPropagation();
        e.preventDefault(); // 기본 동작 차단
        const button = $(this);
        const prodNo = button.data('prodno');
        const isWished = button.data('iswished'); // 현재 찜 상태
        const memberId = button.data('memberid'); // 회원 ID 가져오기
        
        if (!memberId) {
            alertify.error("로그인 후 이용 할 수 있습니다.");
            // 페이지 이동
            setTimeout(function() {
                window.location.href = `${contextPath}/loginForm.me`;
            }, 1500); // 2초 후 이동
            return; // 실행 중단
        }
    
        $.ajax({
            url: 'toggle.wl',
            type: 'POST',
            data: {
                prodNo: prodNo,
                memberId: memberId,
                action: isWished > 0 ? 'remove' : 'add' // 상태에 따라 추가 또는 삭제
            },
            success: function (response) {
                if (response === 'added') {
                    button.data('iswished', 1);
                    button.find('span').addClass('active'); // 하트 아이콘 활성화
                    togglerEvent.active('favorite', 'orangered', '찜 성공!');
                    // alertify.success('해당 상품을 찜하였습니다.');
                } else if (response === 'removed') {
                    button.data('iswished', 0);
                    button.find('span').removeClass('active'); // 하트 아이콘 비활성화
                    togglerEvent.disable('favorite', 'orangered', '찜 해제!');
                    // alertify.success('해당 상품의 찜을 해제하였습니다.');
                }
            },
            error: function () {
                alertify.error('찜 상태를 업데이트하는 데 실패했습니다.');
            }
        });
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
                        <span style="flex: 1; text-align: right; color: ${option.stock < 10 ? 'red' : 'inherit'}; margin-right: 5px;">
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

    // 데이터 제출
    $('#cartAddForm').click(function (e) {
        e.preventDefault(); // 기본 폼 제출 방지

        const prodNo = $(this).data('prodno'); // 상품 번호 가져오기
        const memberId = $(this).data('memberid'); // 회원 ID 가져오기

        if (!memberId) {
            alertify.error("로그인 후 이용 할 수 있습니다.");
            // 페이지 이동
            setTimeout(function() {
                window.location.href = `${contextPath}/loginForm.me`;
            }, 1500); // 2초 후 이동
            return; // 실행 중단
        }

        console.log(selectedOptions);
        
        const cartData = selectedOptions.map(option => ({
            memberId: memberId,
            prodNo: prodNo,
            optNo: option.id,
            cartQty: option.quantity
        }));

        if (cartData.every(data => !data.optNo)) {
            alertify.error("옵션을 선택해야 합니다.");
            return; // 실행 중단
        }

        $.ajax({
            url: 'insert.ct',
            type: 'POST',
            contentType: 'application/json',
            data: JSON.stringify(cartData),
            success: function (response) {
                
                if (response.success) {
                    // 성공 메시지
                    // togglerEvent.active('shopping_bag', '', '장바구니 등록 성공!');
                    // alertify.success(response.message);
                    showSuccessMessage();
                } else {
                    // 실패 메시지
                    alertify.error(response.message);
                }
            },
            error: function () {
                alertify.error("서버 오류가 발생했습니다. 다시 시도해주세요.");
            }
        });
    });

    // function showSuccessMessage() {
    //     const reviewIframeUrl = `${contextPath}/successForm.ct`;
    //     $(iframe).attr('src', reviewIframeUrl);

    //     // iframe 크기 조정
    //     iframe.on('load', function () {
    //         adjustIframeSize(this); // 크기 조정 함수 호출
    //     });

    //     // 모달 표시
    //     $('#reviewIframeContainer').fadeIn();
    // }
    
    // 바로 구매
    $('#buyNow').click(function() {
        alert('구매 페이지로 이동합니다.');
    });

    // 상품정보 별점 클릭 시 이동동
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

                // 전문보기 버튼 체크 및 활성화
                processReviewContent();
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

                // 전문보기 버튼 체크 및 활성화
                processReviewContent();
            },
            error: function () {
                console.error('QnA 데이터를 불러오는데 실패했습니다.');
            }
        });
    });


    // 상품문의 작성하기
    $(document).on('click', '#writeQnaBtn', function () {
        const prodNo = $(this).data('prodno'); // 상품 번호 가져오기
        const memberId = $(this).data('memberid'); // 회원 ID 가져오기
        
        const iframe = $('#reviewIframeContainer iframe');
        
        if (!memberId) {
            alertify.error("로그인 후 이용 할 수 있습니다.");
            // 페이지 이동
            setTimeout(function() {
                window.location.href = `${contextPath}/loginForm.me`;
            }, 1500); // 2초 후 이동
            return; // 실행 중단
        }

        const reviewIframeUrl = `${contextPath}/enrollForm.pqa?prodNo=${prodNo}&memberId=${memberId}`;
        $(iframe).attr('src', reviewIframeUrl);

        // iframe 로드 후 크기 조정
        iframe.on('load', function () {
            const iframeContent = this.contentWindow.document || this.contentDocument;
            if (iframeContent) {
                const iframeHeight = iframeContent.body.scrollHeight || iframeContent.documentElement.scrollHeight;
                const iframeWidth = iframeContent.body.scrollWidth || iframeContent.documentElement.scrollWidth;

                $(this).css({
                    width: iframeWidth + 'px',
                    height: iframeHeight + 'px',
                });
            }
        });

        // 모달 표시
        $('#reviewIframeContainer').fadeIn();
    });

    // 상품문의 수정하기
    $(document).on('click', '#editQnaBtn', function () {
        const memberId = $(this).data('memberid'); // 회원 ID 가져오기
        const inquiryNo = $(this).data('inquiryno'); // 리뷰 번호 가져오기기
        
        const iframe = $('#reviewIframeContainer iframe');

        const reviewIframeUrl = `${contextPath}/updateForm.pqa?memberId=${memberId}&inquiryNo=${inquiryNo}`;
        $(iframe).attr('src', reviewIframeUrl);

        // iframe 로드 후 크기 조정
        iframe.on('load', function () {
            const iframeContent = this.contentWindow.document || this.contentDocument;
            if (iframeContent) {
                const iframeHeight = iframeContent.body.scrollHeight || iframeContent.documentElement.scrollHeight;
                const iframeWidth = iframeContent.body.scrollWidth || iframeContent.documentElement.scrollWidth;

                $(this).css({
                    width: iframeWidth + 'px',
                    height: iframeHeight + 'px',
                });
            }
        });

        // 모달 표시
        $('#reviewIframeContainer').fadeIn();
    });
    // 상품문의 삭제하기
    $(document).on('click', '#deleteQnaBtn', function () {
        const memberId = $(this).data('memberid'); // 회원 ID 가져오기
        const inquiryNo = $(this).data('inquiryno'); // 리뷰 번호 가져오기기
        // 확인 팝업 표시
        if (confirm("작성한 문의가 완전히 삭제됩니다. 진행하시겠습니까?")) {
            // 확인 클릭 시 URL로 이동
            const url = `${contextPath}/delete.pqa?memberId=${memberId}&inquiryNo=${inquiryNo}`;
            window.location.href = url;
        }
    });



    // 리뷰 전체 썸네일 더보기 버튼 썸네일 5개 이하일 경우 숨김
    $('.thumbnail-container').each(function () {
        if ($(this).find('.review-thumbnail').length <= 6) {
            $(this).siblings('.show-more-thumbnails-btn').hide();
        }
    });

    // 탭 활성화 이벤트
    $('a[data-toggle="tab"]').on('shown.bs.tab', function (e) {
        const targetTab = $(e.target).attr('href');

        if (targetTab === '#reviews') {
            processReviewContent();
        }
        if (targetTab === '#qna') {
            processReviewContent();
        }
    });

    // 리뷰 내용 처리 함수
    function processReviewContent() {
        $('.review-content-container').each(function () {
            const reviewText = $(this).find('.review-text');
            const moreButton = $(this).find('.show-more-btn');
            const lineHeight = parseInt(reviewText.css('line-height')) || 24;
            const maxHeight = lineHeight * 3;
    
            const scrollHeight = getScrollHeightHiddenElement(reviewText);
    
            if (scrollHeight > maxHeight) {
                reviewText.css({
                    'max-height': `${maxHeight}px`,
                    'overflow': 'hidden',
                });
                moreButton.text('더보기'); // 기본 버튼 텍스트 설정
                moreButton.show();
            } else {
                moreButton.hide();
            }
    
            // "더보기" 버튼 클릭 시 전체 보기
            moreButton.off('click').on('click', function () {
                if (reviewText.hasClass('expanded')) {
                    // 접기 동작
                    reviewText.removeClass('expanded');
                    reviewText.css({
                        'max-height': `${maxHeight}px`,
                        'overflow': 'hidden',
                    });
                    $(this).text('더보기');
                } else {
                    // 더보기 동작
                    reviewText.addClass('expanded');
                    reviewText.css({
                        'max-height': 'none',
                        'overflow': 'visible',
                    });
                    $(this).text('접기');
                }
            });
        });
    }
    // 숨겨진 요소 높이 계산 함수
    function getScrollHeightHiddenElement(element) {
        const clone = $(element).clone();
        clone.css({
            display: 'block',
            visibility: 'hidden',
            position: 'absolute',
            height: 'auto', // 높이 제한 해제
        });
        $('body').append(clone);
        const scrollHeight = clone[0].scrollHeight;
        clone.remove();
        return scrollHeight;
    }

});

// * 리뷰 썸네일 기능
// 더보기/접기 버튼 동작
$(document).on('click', '.show-more-thumbnails-btn', function () {
    const thumbnailsContainer = $(this).siblings('.thumbnail-container');
    
    if (thumbnailsContainer.hasClass('short-thumbnails')) {
        thumbnailsContainer.removeClass('short-thumbnails').addClass('full-thumbnails');
        $(this).text('접기');
    } else {
        thumbnailsContainer.removeClass('full-thumbnails').addClass('short-thumbnails');
        $(this).text('더보기');
    }
});

// 이미지 모달 열기
function openThumbModal(imageSrc) {
    $('#fullImage').attr('src', imageSrc);
    $('#thumbModal').fadeIn();
}
// 이미지 모달 닫기
function closeThumbModal() {
    $('#thumbModal').fadeOut();
}
// 모달 외부 클릭 시 닫기
$(document).on('click', '#imageModal', function (e) {
    if ($(e.target).is('#imageModal')) {
        closeImageModal();
    }
});