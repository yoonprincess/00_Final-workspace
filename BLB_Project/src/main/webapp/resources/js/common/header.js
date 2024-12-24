$(function() {

    const navbar = $('.navbar');
    const productTabs = $('#productTabs'); // 상품 상세보기 페이지 탭 메뉴
    const isProductPage = productTabs.length > 0; // 상품 상세보기 페이지 여부 확인
    let lastScrollTop = 0; // 이전 스크롤 위치 저장
    
    window.iframe = $('#reviewIframeContainer iframe'); // iframe

    // 토글버튼 효과 처리
    var $blbToggler = $('.overlay.blb-toggler');
    var $TogglerMessage = $blbToggler.find('#toggler-message');
    var $TogglerIcon = $blbToggler.find('span');

    window.togglerEvent = {
        active: function(icon, style, text) {
            $TogglerIcon.text(icon);
            $TogglerIcon.attr('id', style);
            $TogglerIcon.addClass('active');
            $TogglerMessage.text(text);

            $blbToggler.css({
                'display': 'flex',
                'opacity': '0'
            }).animate({opacity: 1}, 300);
            setTimeout(function() {
                $blbToggler.animate({opacity: 0}, 300, function() {
                    $(this).css('display', 'none');
                    // window.location.reload();
                });
            }, 1000);
        },
        disable: function(icon, style, text) {
            $TogglerIcon.text(icon);
            $TogglerIcon.attr('id', style);
            $TogglerIcon.removeClass('active');
            $TogglerMessage.text(text);

            $blbToggler.css({
                'display': 'flex',
                'opacity': '0'
            }).animate({opacity: 1}, 300);
            setTimeout(function() {
                $blbToggler.animate({opacity: 0}, 300, function() {
                    $(this).css('display', 'none');
                    // window.location.reload();
                });
            }, 1000);
        }
    }

    // iframe 크기 조정 함수
    function adjustIframeSize(iframe) {
        if (iframe) {
            const iframeContent = iframe.contentWindow.document || iframe.contentDocument;
            if (iframeContent) {
                const iframeHeight = iframeContent.body.scrollHeight || iframeContent.documentElement.scrollHeight;
                const iframeWidth = iframeContent.body.scrollWidth || iframeContent.documentElement.scrollWidth;

                $(iframe).css({
                    width: `${Math.min(iframeWidth, window.innerWidth * 0.9)}px`, // 최대 너비 제한
                    height: `${Math.min(iframeHeight, window.innerHeight * 0.9)}px`, // 최대 높이 제한
                });
            }
        }
    }
    window.adjustIframeSize = adjustIframeSize;
    function showSuccessMessage() {
        const reviewIframeUrl = `${contextPath}/successForm.ct`;
        $(iframe).attr('src', reviewIframeUrl);

        // iframe 크기 조정
        iframe.on('load', function () {
            adjustIframeSize(this); // 크기 조정 함수 호출
        });

        // 모달 표시
        $('#reviewIframeContainer').fadeIn();
    }
    window.showSuccessMessage = showSuccessMessage;
    // * 상품 상세보기 페이지: 헤더 숨김 및 상품 메뉴 탭 고정
    if (isProductPage) {

        let tabsOffsetTop = productTabs.offset().top; // 탭의 초기 위치 저장

        // 스크롤 이벤트 최적화: throttle
        const throttle = (func, limit) => {
            let lastFunc;
            let lastRan;
            return function () {
                const context = this;
                const args = arguments;
                if (!lastRan) {
                    func.apply(context, args);
                    lastRan = Date.now();
                } else {
                    clearTimeout(lastFunc);
                    lastFunc = setTimeout(function () {
                        if (Date.now() - lastRan >= limit) {
                            func.apply(context, args);
                            lastRan = Date.now();
                        }
                    }, limit - (Date.now() - lastRan));
                }
            };
        };

        // 스크롤 이벤트 처리
        const handleScroll = () => {
            const scrollTop = $(window).scrollTop();

            // 탭 고정 및 헤더 숨김 처리
            if (scrollTop > tabsOffsetTop) {
                productTabs.addClass('sticky');
                if (scrollTop > lastScrollTop) {
                    navbar.addClass('hide-header'); // 아래로 스크롤: 헤더 숨김
                    productTabs.removeClass('body-offset');
                } else {
                    navbar.removeClass('hide-header'); // 위로 스크롤: 헤더 표시
                    productTabs.addClass('body-offset');
                }
            } else {
                productTabs.removeClass('sticky');
                navbar.removeClass('hide-header');
            }

            lastScrollTop = scrollTop; // 현재 스크롤 위치 저장

            if ($(this).scrollTop() > 50) {
                navbar.removeClass('transparent-navbar').addClass('scrolled-navbar');
            } else {
                navbar.removeClass('scrolled-navbar').addClass('transparent-navbar');
            }

            
        };

        // 이벤트 바인딩
        $(window).on('scroll', throttle(handleScroll, 50));

        // 윈도우 크기 조정 시 탭 위치 재계산
        $(window).on('resize', () => {
            tabsOffsetTop = productTabs.offset().top;
        });
              
    } else {
        // * 상품 상세보기 외 페이지: 기존 배경색 효과 유지
        $(window).scroll(function () {
            if ($(this).scrollTop() > 50) {
                navbar.removeClass('transparent-navbar').addClass('scrolled-navbar');
            } else {
                navbar.removeClass('scrolled-navbar').addClass('transparent-navbar');
            }
        });
    }

	// * 반응형 드롭다운 메뉴 스크립트
    // 데스크톱: 마우스 오버로 드롭다운 메뉴 표시
    $(".custom-dropdown").on("mouseenter", function () {
        if (window.innerWidth >= 768) {
            $(this).find(".custom-dropdown-menu").css({ opacity: 1, transform: "translateY(0)" });
        }
    });
    $(".custom-dropdown").on("mouseleave", function () {
        if (window.innerWidth >= 768) {
            $(this).find(".custom-dropdown-menu").css({ opacity: 0, transform: "translateY(5px)" });
        }
    });
    // 모바일: 클릭 시 드롭다운 메뉴 열기/닫기
    $(".custom-dropdown > .nav-link").on("click", function (e) {

        // 데스크톱에서는 작동하지 않도록 조건 추가
        if (window.innerWidth < 768) {
            // 기본 동작 방지
            e.preventDefault();
            var menu = $(this).siblings(".custom-dropdown-menu");
            // 다른 메뉴 닫기
            $(".custom-dropdown-menu").not(menu).slideUp();
            // 현재 메뉴 열기/닫기
            menu.stop(true, true).slideToggle();
        }
    });
    // 메뉴 외부 클릭 시 닫기
    $(document).on("click", function (e) {
        // 모바일 화면 크기에서만 적용 (768px 이하)
        if (window.innerWidth < 768) {
            if (!$(e.target).closest(".custom-dropdown").length) {
                $(".custom-dropdown-menu").slideUp();
            }
        }
    });

    // * 토글 버튼 클릭 시 active 클래스 추가/제거
    $('.navbar-toggler').click(function () {
        $(this).toggleClass('active');
        $('.navbar').toggleClass('bg-white');
    });

    // * search 버튼 스크립트
    // 검색창 초기 상태 설정: searchBox 값이 있으면 열기
    if ($("#searchBox").val() !== "") {
        $("#searchBox").addClass("show"); // 검색창 열기
    }
    $("#searchIcon").click(function () {
        const searchBox = $("#searchBox");
        searchBox.toggleClass("show"); // 검색창 확장/축소
        if (searchBox.hasClass("show")) {
            searchBox.focus(); // 입력창에 포커스
        } else {
            searchBox.blur(); // 포커스 해제
        }
    });
    // search 인풋창 키워드 입력 스크립트
    $("#searchBox").keypress(function (e) {
        if (e.which === 13) { // Enter 키
            const keyword = $(this).val().trim();
            if (keyword) {
                window.location.href = `${contextPath}/list.pr?keyword=${encodeURIComponent(keyword)}`;
            } else {
                alert("검색어를 입력하세요.");
            }
        }
    });

    // * 위로가기 버튼 스크립트
    // 초기 로딩 시 스크롤 위치에 따라 버튼 표시 여부 결정
    if ($(window).scrollTop() > 250) {
        $('#backToTop').css('opacity', '0.5'); // 초기 로딩 시 버튼이 노출될 높이에 있을 경우
    }
    // 스크롤 이벤트로 버튼 표시/숨김
    $(window).scroll(function () {
        if ($(this).scrollTop() > 250) {
            $('#backToTop').css('opacity', '0.5');
        } else {
            $('#backToTop').css('opacity', '0');
        }
    });
    // 위로가기 버튼 클릭 시 맨 위로 스크롤
    $('#backToTop').click(function () {
        $('html, body').animate({ scrollTop: 0 }, 300);
        return false;
    });

    // * 리뷰 작성/수정/삭제하기
    // iframe 크기 조정 함수
    $('#reviewIframeContainer').hide(); // 초기에는 숨김
    // 리뷰 작성하기
    $(document).on('click', '#writeReviewBtn', function () {
        const prodNo = $(this).data('prodno'); // 상품 번호 가져오기
        const memberId = $(this).data('memberid'); // 회원 ID 가져오기
        const serialNo = $(this).data('serialno');

        if (!memberId) {
            alertify.error("로그인 후 리뷰를 작성할 수 있습니다.");
            // 페이지 이동
            setTimeout(function() {
                window.location.href = `${contextPath}/loginForm.me`;
            }, 1500); // 2초 후 이동
            return; // 실행 중단
        }

        // 구매 여부 확인 AJAX 요청
        $.ajax({
            url: `${contextPath}/checkPurchase.pr`, // 구매 여부 확인 API URL
            type: 'POST',
            data: {
                prodNo: prodNo,
                memberId: memberId,
                serialNo: serialNo
            },
            success: function (response) {
                if(response.status == "no_purchase") {
                    alertify.warning("해당 상품을 구매한 고객만 리뷰를 작성할 수 있습니다.");
                }
                if(response.status == "review_exists") {
                    alertify.warning("이미 리뷰를 작성하셨습니다.");
                }
                if(response.status == "serial_error") {
                    alertify.error("잘못된 주문번호 입니다.");
                }
                if (response.status == "ok") {
                    const reviewIframeUrl = `${contextPath}/enrollForm.rv?prodNo=${prodNo}&memberId=${memberId}&serialNo=${response.serialNo}`;
                    // 서버 검증 후 iframe URL을 서버에서 제공
                    $(iframe).attr('src', reviewIframeUrl);

                    // iframe 로드 후 크기 조정
                    iframe.on('load', function () {
                        adjustIframeSize(this); // 크기 조정 함수 호출
                    });
                    

                    // 모달 표시
                    $('#reviewIframeContainer').fadeIn();
                }
            },
            error: function () {
                alertify.error("구매 여부를 확인하는 중 오류가 발생했습니다. 잠시 후 다시 시도해주세요.");
            }
        });
    });
    // 리뷰 수정하기
    $(document).on('click', '#editReviewBtn', function () {
        const prodNo = $(this).data('prodno'); // 상품 번호 가져오기
        const memberId = $(this).data('memberid'); // 회원 ID 가져오기
        const revNo = $(this).data('revno'); // 리뷰 번호 가져오기기
        
        const iframe = $('#reviewIframeContainer iframe');

        const reviewIframeUrl = `${contextPath}/updateForm.rv?prodNo=${prodNo}&memberId=${memberId}&revNo=${revNo}`;
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
    // 리뷰 삭제하기
    $(document).on('click', '#deleteReviewBtn', function () {
        const prodNo = $(this).data('prodno'); // 상품 번호 가져오기
        const memberId = $(this).data('memberid'); // 회원 ID 가져오기
        const revNo = $(this).data('revno'); // 리뷰 번호 가져오기기
        // 확인 팝업 표시
        if (confirm("작성한 리뷰가 완전히 삭제됩니다. 진행하시겠습니까?")) {
            // 확인 클릭 시 URL로 이동
            const url = `${contextPath}/delete.rv?prodNo=${prodNo}&memberId=${memberId}&revNo=${revNo}`;
            window.location.href = url;
        }
    });

    // 장바구니 추가 버튼
    $('.add-cart').click(function (e) {
        e.stopPropagation();
        e.preventDefault(); // 기본 동작 차단
        const button = $(this);
        const prodNo = button.data('prodno');
        const memberId = button.data('memberid'); // 회원 ID 가져오기

        if (!memberId) {
            alertify.error("로그인 후 이용가능합니다.");
            // 페이지 이동
            setTimeout(function() {
                window.location.href = `${contextPath}/loginForm.me`;
            }, 1500); // 2초 후 이동
            return; // 실행 중단
        }
    
        const reviewIframeUrl = `${contextPath}/enrollForm.ct?prodNo=${prodNo}&memberId=${memberId}`;
        $(iframe).attr('src', reviewIframeUrl);

        // iframe 크기 조정
        iframe.on('load', function () {
            adjustIframeSize(this); // 크기 조정 함수 호출
        });

        // 모달 표시
        $('#reviewIframeContainer').fadeIn();
    });


    // 닫기 버튼 클릭 시
    $('.close-btn.review-enroll').on('click', function () {
        $('#reviewIframeContainer').hide();
        $('#reviewIframeContainer iframe').attr('src', ''); // iframe 초기화
        window.location.reload();
    });
   
});