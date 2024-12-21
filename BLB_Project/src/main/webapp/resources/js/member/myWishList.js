

	function deleteWish(prodNo){
		
		$.ajax({
				url : "deleteWish.me",
				type : "post",
				data : {
				
					prodNo : prodNo
				},
				
				success : function(result) {
					console.log("AJAX 요청 성공");
    
				    var $overlay = $('#overlay');
				    var $message = $('#message');
				   
				    $message.text('찜 해제되었습니다!');
				    
				    $('#overlay').css('display', 'flex').hide().fadeIn();
				    
				    $('span.material-symbols-outlined').text('heart_minus');
				
				    setTimeout(function() {
				        $overlay.fadeOut();
				        window.location.href = "wishList.me";
				    }, 1000);
				    
				    document.getElementById('overlay').style.display = 'flex';
					document.getElementById('message').textContent = '찜 해제되었습니다!';
					document.querySelector('.material-symbols-outlined').textContent = 'heart_minus';
									},
				
				error : function() {
					console.log("ajax 통신 실패!");
					alert("찜 해제 실패");
				}
			});
	}

	

    

	