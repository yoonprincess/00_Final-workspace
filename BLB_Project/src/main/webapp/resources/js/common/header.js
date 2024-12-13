$(function() {

    const navbar = $('.navbar');
    const productTabs = $('#productTabs'); // 상품 상세보기 페이지 탭 메뉴
    const isProductPage = productTabs.length > 0; // 상품 상세보기 페이지 여부 확인
    let lastScrollTop = 0; // 이전 스크롤 위치 저장
    
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
            $(this).find(".custom-dropdown-menu").css({ display: "block", opacity: 1, transform: "translateY(0)" });
        }
    });
    $(".custom-dropdown").on("mouseleave", function () {
        if (window.innerWidth >= 768) {
            $(this).find(".custom-dropdown-menu").css({ display: "none", opacity: 0, transform: "translateY(5px)" });
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
        if (!$(e.target).closest(".custom-dropdown").length) {
            $(".custom-dropdown-menu").slideUp();
        }
    });

    // * 토글 버튼 클릭 시 active 클래스 추가/제거
    $('.navbar-toggler').click(function () {
        $(this).toggleClass('active');
        $('.navbar').toggleClass('bg-white');
    });

    // * 위로가기 버튼 스크립트
    // 초기 로딩 시 스크롤 위치에 따라 버튼 표시 여부 결정
    if ($(window).scrollTop() > 250) {
        $('#backToTop').css('opacity', '0.7'); // 초기 로딩 시 버튼이 노출될 높이에 있을 경우
    }
    // 스크롤 이벤트로 버튼 표시/숨김
    $(window).scroll(function () {
        if ($(this).scrollTop() > 250) {
            $('#backToTop').css('opacity', '0.7');
        } else {
            $('#backToTop').css('opacity', '0');
        }
    });
    // 위로가기 버튼 클릭 시 맨 위로 스크롤
    $('#backToTop').click(function () {
        $('html, body').animate({ scrollTop: 0 }, 300);
        return false;
    });
});