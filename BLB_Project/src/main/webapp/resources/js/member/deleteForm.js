	
	// 취소버튼
	function goBack() {
	   window.history.back();
	}
	
	// 탈퇴버튼 
	$(document).ready(function() {
	    $('#deleteForm').submit(function(event) {
	        event.preventDefault(); // 폼 제출 기본 동작 방지
	        var checkPwd = $('#checkPwd').val();
	        
		    $.ajax({
		        url: 'delete.me', 
		        method: 'POST',
		        data : {
		        	checkPwd : checkPwd
		        },
		        success: function(response) {
		        			        	
		           if(response.result === "탈퇴완료"){
		           	
		           	$('#check-page').hide();
		            $('#result-page').show();
		               
		           }else{
		           	 alert(response.result);
		           }
		        },
		        error: function() {
		            console.log('ajax 통신오류');
		        }
		    });
	    });
	});
	
	// 메인버튼
	function goMain() {
   		 window.location.href = "/blb";
	}