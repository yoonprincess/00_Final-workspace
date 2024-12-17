
// 전달받은 값들 option 태그 선택되게 설정하기 
$(document).ready(function() {
	
	  
    
	  function updateSelectOptionsFromQueryString() {
        var urlParams = new URLSearchParams(window.location.search);
        
        var year = urlParams.get('year');
        var month = parseInt(urlParams.get('month'), 10);
        var day = urlParams.get('day');
        var year1 = urlParams.get('year1');
        var month1 = parseInt(urlParams.get('month1'), 10);
        var day1 = urlParams.get('day1');
	  
	 	 var period = month1-month;
	  
		  if (period < 0) {
		   
		    period += 12; 
		  
		  }
		
	$('select[name="year1"]').val(year1);
    $('select[name="month1"]').val(month1);
    $('select[name="day1"]').val(day1);
    $('select[name="year"]').val(year);
    $('select[name="month"]').val(month);
    $('select[name="day"]').val(day);
	
	  handleActiveClassBasedOnPeriod(period);
	}
	
	 function handleActiveClassBasedOnPeriod(period) {
    var $one = $('#one');
    var $three = $('#three');
    var $six = $('#six');
    var $twelve = $('#twelve');

    function handleActiveClass(element) {
      $(element).addClass('active').siblings().removeClass('active');
    }

    if (period <= 1) {
      handleActiveClass('#one');
    } else if (period <= 3) {
      handleActiveClass('#three');
    } else if (period <= 6) {
      handleActiveClass('#six');
    } else {
      handleActiveClass('#twelve');
    }

    // 버튼 클릭 이벤트 설정
    $one.on('click', function() { handleActiveClass(this); beforeDate(1); });
    $three.on('click', function() { handleActiveClass(this); beforeDate(3); });
    $six.on('click', function() { handleActiveClass(this); beforeDate(6); });
    $twelve.on('click', function() { handleActiveClass(this); beforeDate(12); });
  }
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
    	
	}
	
	updateSelectOptionsFromQueryString();
	
	});



	 
	
 	 	
	
