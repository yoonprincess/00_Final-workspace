	
	// 취소버튼
	function goBack() {
	   window.history.back();
	}
	
	
	
	// 메인버튼
	function goMain() {
   		 window.location.href = "/blb";
	}
	
			// 모달 창 띄우기
		function showDeleteConfirmModal() {
		    document.getElementById("deleteConfirmModal").style.display = "flex";
		}
		
		// 모달 창 닫기
		function closeDeleteConfirmModal() {
		    document.getElementById("deleteConfirmModal").style.display = "none";
		}
		
		// 탈퇴 버튼 클릭 시
		document.getElementById("confirmDeleteBtn").addEventListener("click", function() {
		    // 카카오 탈퇴 API 호출
		    $.ajax({
				        url: 'deleteKakao.me', 
				        method: 'POST',
				        data : {
				        	
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
		    closeDeleteConfirmModal(); // 모달 닫기
		});
		
		// 취소 버튼 클릭 시
		document.getElementById("cancelDeleteBtn").addEventListener("click", function() {
		    closeDeleteConfirmModal(); // 모달 닫기
		});
		
		// 탈퇴 요청 버튼 클릭 시 모달 띄우기
		document.getElementById("deleteAccountBtn").addEventListener("click", function() {
		    showDeleteConfirmModal(); // 확인 모달 띄우기
		});