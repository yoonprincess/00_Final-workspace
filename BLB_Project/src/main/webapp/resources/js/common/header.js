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

    // 토글 버튼 클릭 시 active 클래스 추가/제거
    $('.navbar-toggler').click(function () {
        $(this).toggleClass('active');
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