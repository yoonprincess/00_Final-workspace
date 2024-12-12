
// 오늘 날짜로 option 태그 선택되게 설정하기 
$(document).ready(function() {
	
	const today = new Date();
	const year = today.getFullYear();
	const month = today.getMonth() + 1;
	const day = today.getDate();
	
	$('select[name="year1"]').val(year);
    $('select[name="month1"]' ).val(month);
    $('select[name="day1"]').val(day);
	
	
	function beforeDate(monthAgo){
		const beforeDate = new Date();
		beforeDate.setMonth(today.getMonth() - monthAgo);

		const beforeYear = beforeDate.getFullYear();
		const beforeMonth = beforeDate.getMonth()+1;
		const beforeDay = beforeDate.getDate();

		$('select[name="year"]').val(beforeYear);
   		$('select[name="month"]' ).val(beforeMonth);
    	$('select[name="day"]').val(beforeDay);
	}
	
	beforeDate(1);	
	
	// 기간설정 버튼 효과 + 기간설정
	var $one = $('#one');
	var $three = $('#three')
	var $six = $('#six');
	var $twelve = $('#twelve');
	 
	function handleActiveClass(element){
		
		$(element).addClass('active').siblings()
				 .removeClass('active');
	}	
	
	
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



	 
	
 	 	
	
