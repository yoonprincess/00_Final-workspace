
// 라디오버튼 변경 시  
$(document).ready(function () {
    
    $('input[name="checkType"]').on('change', function () {
      
		 if ($('input[name="checkType"]:checked').val() === "email") {
           
            $('#checkPhone').hide();
            $('#phone-label').hide();
            $('#checkEmail').show();
            $('#email-label').show();
        } else {
        	 $('#email-label').hide();
            $('#checkEmail').hide();
            $('#checkPhone').show();
            $('#phone-label').show();
        }
    });
});