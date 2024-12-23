
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

	