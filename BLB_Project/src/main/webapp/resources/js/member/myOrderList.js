
// 오늘 날짜로 option 태그 선택되게 설정하기 
$(document).ready(function() {
	
	// 기본날짜
	const today = new Date();
	const year = today.getFullYear();
	const month = today.getMonth() + 1;
	const day = today.getDate();
	
	$('select[name="year1"]').val(year);
    $('select[name="month1"]').val(month);
    $('select[name="day1"]').val(day);
	
	
	// 선택된 날짜 기준으로 계산 	
	function beforeDate(monthAgo){
	
		const selectedYear = parseInt($('select[name="year1"]').val(), 10);
		const selectedMonth = parseInt($('select[name="month1"]').val(), 10) - 1;
		const selectedDay = parseInt($('select[name="day1"]').val(), 10);
		 
		const selectDate = new Date(selectedYear, selectedMonth, selectedDay);
		selectDate.setMonth(selectDate.getMonth() - monthAgo);

		const beforeYear = selectDate.getFullYear();
		const beforeMonth = selectDate.getMonth()+1;
		const beforeDay = selectDate.getDate();

		$('select[name="year"]').val(beforeYear);
   		$('select[name="month"]' ).val(beforeMonth);
    	$('select[name="day"]').val(beforeDay);
    	
    	 return {
            beforeYear: beforeYear,
            beforeMonth: beforeMonth,
            beforeDay: beforeDay,
            year: year,
            month: month,
            day: day
        };
	}
	
	function date(){
		
		const dates = beforeDate(1); 

        $.ajax({
            url: 'orderList.me', 
            type: 'GET',
            data: {
                year: dates.beforeYear,
                month: dates.beforeMonth,
                Day: dates.beforeDay,
                year1: dates.year,
                month1: dates.month,
                day1: dates.day
            },
            success: function(response) {
                // 서버에서 받은 데이터 처리
                console.log(response);
            },
            error: function(error) {
                console.error(error);
            }
        });
	
	}
	
	
	
	// 기간설정 버튼 효과 + 기간설정
	var $one = $('#one');
	var $three = $('#three')
	var $six = $('#six');
	var $twelve = $('#twelve');
	 
	function handleActiveClass(element){
		
		$(element).addClass('active').siblings()
				 .removeClass('active');
	}	
	
	beforeDate(1);
	handleActiveClass($one);
	
	$one.on('click', function(){
	 	
 		handleActiveClass(this);
 		beforeDate(1);		
	 });
	 
	 $three.on('click', function(){
	 	
 		handleActiveClass(this);
		 beforeDate(3);	
		
	 });
	 
	 $six.on('click', function(){
		handleActiveClass(this);
		beforeDate(6);		 		
	 });
	 
	 $twelve.on('click', function(){
		handleActiveClass(this);
		beforeDate(12);		 		
	 });
});



	 
	
 	 	
	
