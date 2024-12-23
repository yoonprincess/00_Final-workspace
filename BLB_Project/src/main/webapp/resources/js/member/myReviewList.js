

	// 버튼 관련
	function goEnrollForm() {
	    window.location.href = "/blb/enrollDeliveryForm.me";
	}

	function deleteDelivery(deliCode){
		
		$.ajax({
				url : "deleteDelivery.me",
				type : "post",
				data : {
					deliCode : deliCode
				},
				
				success : function(result) {
					
					alert("배송지 삭제 성공");
					window.location.href = "deliveryList.me";
				},
				error : function() {
					console.log("ajax 통신 실패!");
					alert("배송지 삭제 실패");
				}
			});
	}

	function updateDelivery(deliCode) {
	    window.location.href = "/blb/updateDeliveryForm.me?deliCode="+deliCode;
	}
	
	function setDefaultDelivery(deliCode){
		
		$.ajax({
			url : "updateDeliDefault.me",
			type : "post",
			data : {
				deliCode : deliCode
			},
			
			success : function(result) {
				
				alert("기본 배송지 변경");
				
				window.location.href = "deliveryList.me";
			},
			error : function() {
				console.log("ajax 통신 실패!");
				  console.log("Error details:", error);
            console.log("Response Text:", xhr.responseText);  // 서버에서 보낸 오류 메시지 확인
				alert("기본 배송지 변경 실패");
			}
		});
	}
// 이미지 모달 열기
function openThumbModal(imageSrc) {
    $('#fullImage').attr('src', imageSrc);
    $('#thumbModal').fadeIn();
}
// 이미지 모달 닫기
function closeThumbModal() {
    $('#thumbModal').fadeOut();
}
// 모달 외부 클릭 시 닫기
$(document).on('click', '#imageModal', function (e) {
    if ($(e.target).is('#imageModal')) {
        closeImageModal();
    }
});

// * 리뷰 썸네일 기능
// 더보기/접기 버튼 동작
$(document).on('click', '.show-more-thumbnails-btn', function () {
    const thumbnailsContainer = $(this).siblings('.thumbnail-container');
    
    if (thumbnailsContainer.hasClass('short-thumbnails')) {
        thumbnailsContainer.removeClass('short-thumbnails').addClass('full-thumbnails');
        $(this).text('접기');
    } else {
        thumbnailsContainer.removeClass('full-thumbnails').addClass('short-thumbnails');
        $(this).text('더보기');
    }
});
	