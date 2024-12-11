	
	// 취소버튼
	function goBack() {
	   window.history.back();
	}
	
	// 탈퇴버튼 
	$(document).ready(function() {
	    $('#deleteForm').submit(function(event) {
	       event.preventDefault();
	       
	        var checkPwd = $('#checkPwd').val();
	        
		    $.ajax({
		        url: 'delete.me', 
		        method: 'POST',
		        data : {
		        	checkPwd : checkPwd
		        },
		        success: function(response) {
		        	
		        	console.log("response : "  + response);
		        	
		           if(response.result === "탈퇴완료"){
		           	
		           	$('#check-page').hide();
		            $('#result-page').show();
		               
		           }else{
		           	
		           		console.log(response.result);
		           }
		        },
		        error: function() {
		            console.log('ajax 통신오류');
		        }
		    });
	    });
	});
