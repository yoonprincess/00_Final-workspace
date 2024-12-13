
	// 라디오버튼 변경 시  
	$(document).ready(function () {
	    
	    $('input[name="checkType"]').on('change', function () {
	      
			 if ($('input[name="checkType"]:checked').val() === "email") {
	          
	           
	            $('#checkPhone').hide();
	            $('#checkEmail').show();
	         
	        } else {
	         
	            $('#checkEmail').hide();
	            $('#checkPhone').show();
	           
	            
	        }
	    });
	});

	// 취소버튼클릭
	function goMain() {
	    window.location.href = "/blb";
	}