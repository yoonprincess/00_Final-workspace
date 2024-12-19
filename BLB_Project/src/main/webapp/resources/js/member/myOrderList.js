$(document).ready(function() {
    // URL에서 쿼리 파라미터 가져오기
    function getUrlParams() {
        var urlParams = new URLSearchParams(window.location.search);
        return {
            year: urlParams.get('year'),
            month: urlParams.get('month'),
            day: urlParams.get('day'),
            year1: urlParams.get('year1'),
            month1: urlParams.get('month1'),
            day1: urlParams.get('day1')
        };
    }

    // URL 파라미터로 기본 날짜 설정
    function setDefaultDate() {
        const params = getUrlParams();
        
        // 쿼리스트링이 없을 경우 기본값을 1개월 전으로 설정
        if (!params.year && !params.month && !params.day) {
            const today = new Date();
            const oneMonthAgo = new Date(today.getFullYear(), today.getMonth() - 1, today.getDate());
            
            $('select[name="year"]').val(oneMonthAgo.getFullYear());
            $('select[name="month"]').val(oneMonthAgo.getMonth() + 1);
            $('select[name="day"]').val(oneMonthAgo.getDate());
            
            $('select[name="year1"]').val(today.getFullYear());
            $('select[name="month1"]').val(today.getMonth() + 1);
            $('select[name="day1"]').val(today.getDate());
            
            // 1개월 버튼 활성화
            $('#one').addClass('active').siblings().removeClass('active');
        } else {
            // 쿼리스트링에서 날짜 값을 추출하여 셀렉트 태그에 적용
            if (params.year && params.month && params.day) {
                $('select[name="year"]').val(params.year);
                $('select[name="month"]').val(params.month);
                $('select[name="day"]').val(params.day);
            }
            if (params.year1 && params.month1 && params.day1) {
                $('select[name="year1"]').val(params.year1);
                $('select[name="month1"]').val(params.month1);
                $('select[name="day1"]').val(params.day1);
            }
        }
    }

    // 기간 설정 버튼 클릭 시, 쿼리 파라미터에 맞는 날짜로 업데이트
    function beforeDate(monthAgo) {
        const selectedYear = parseInt($('select[name="year1"]').val(), 10);
        const selectedMonth = parseInt($('select[name="month1"]').val(), 10) - 1; // 월은 0부터 시작
        const selectedDay = parseInt($('select[name="day1"]').val(), 10);

        const selectDate = new Date(selectedYear, selectedMonth, selectedDay);
        selectDate.setMonth(selectDate.getMonth() - monthAgo);

        const beforeYear = selectDate.getFullYear();
        const beforeMonth = selectDate.getMonth() + 1; // 1부터 시작
        const beforeDay = selectDate.getDate();

        // 계산된 날짜를 날짜 선택 영역에 적용
        $('select[name="year"]').val(beforeYear);
        $('select[name="month"]').val(beforeMonth);
        $('select[name="day"]').val(beforeDay);

        return { beforeYear, beforeMonth, beforeDay, year: selectedYear, month: selectedMonth + 1, day: selectedDay };
    }

    // AJAX 요청 (변경하지 않음)
    function date() {
        const dates = beforeDate(1); // 1개월 전 날짜로 설정

        $.ajax({
            url: 'orderList.me',
            type: 'GET',
            data: {
                year: dates.beforeYear,
                month: dates.beforeMonth,
                day: dates.beforeDay,
                year1: dates.year,
                month1: dates.month,
                day1: dates.day
            },
            success: function(response) {
                console.log(response); // 서버에서 받은 데이터 처리
            },
            error: function(error) {
                console.error(error);
            }
        });
    }

    // 버튼 클릭 이벤트 핸들러
    function handleButtonClick(months) {
        return function(e) {
            handleActiveClass(this);
            const dates = beforeDate(months);
            
            // 폼의 input 값들을 업데이트합니다.
            $('select[name="year"]').val(dates.beforeYear);
            $('select[name="month"]').val(dates.beforeMonth);
            $('select[name="day"]').val(dates.beforeDay);
            $('select[name="year1"]').val(dates.year);
            $('select[name="month1"]').val(dates.month);
            $('select[name="day1"]').val(dates.day);
            
            // 폼을 제출합니다.
            $('#searchForm').submit();
        };
    }

    // 기간설정 버튼 효과 + 기간설정
    var $one = $('#one');
    var $three = $('#three');
    var $six = $('#six');
    var $twelve = $('#twelve');

    function handleActiveClass(element) {
        $(element).addClass('active').siblings().removeClass('active');
    }

    // 페이지 로드 시 기본 날짜 설정
    setDefaultDate();

    // 버튼 클릭 이벤트 설정
    $one.on('click', handleButtonClick(1));
    $three.on('click', handleButtonClick(3));
    $six.on('click', handleButtonClick(6));
    $twelve.on('click', handleButtonClick(12));
});

