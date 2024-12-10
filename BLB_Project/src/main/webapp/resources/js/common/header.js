$(function() {

    // * 헤더 스크롤 효과 스크립트
    $(window).scroll(function () {
        if ($(this).scrollTop() > 50) {
            // 스크롤 위치가 50px 이상일 때
            $('.navbar').removeClass('transparent-navbar').addClass('scrolled-navbar');
        } else {
            // 스크롤 위치가 50px 이하일 때
            $('.navbar').removeClass('scrolled-navbar').addClass('transparent-navbar');
        }
    });

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