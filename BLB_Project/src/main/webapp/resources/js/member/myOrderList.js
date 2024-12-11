$(document).ready(function() {
	
	const today = new Date();
	const year = today.getFullYear();
	const month = today.getMonth() + 1;
	const day = today.getDate();
	
	$('select[name="year"] option').filter(function() {
        return $(this).text() == year;
    }).attr('selected', true);

    $('select[name="month"] option').filter(function() {
        return $(this).text() == month;
    }).attr('selected', true);

    $('select[name="day"] option').filter(function() {
        return $(this).text() == day;
    }).attr('selected', true);
});

$(document).ready(function() {
	 
	 	$('.tab').on('click', function(){
	 		 if ($(this).hasClass('active')) {
	 		 
           	 $(this).removeClass('active');
        
        } else {
        
        	 $(this).addClass('active');
        }
	 		
	 	});
	});