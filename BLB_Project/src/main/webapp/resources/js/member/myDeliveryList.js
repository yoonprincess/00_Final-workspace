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