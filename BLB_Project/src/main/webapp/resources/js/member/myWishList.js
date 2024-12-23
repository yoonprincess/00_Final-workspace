// 찜해제 관련 
function deleteWish(prodNo){
    $.ajax({
        url: "deleteWish.me",
        type: "post",
        data: {
            prodNo: prodNo
        },
        success: function(result) {
            
            
            var $overlay = $('#overlay');
            var $message = $('#message');
            
           	togglerEvent.disable('favorite', 'orangered', '찜 해제!');
  
             setTimeout(function() {
                window.location.reload(); // 새로고침
            }, 500); // 500ms 후에 새로고침 (애니메이션이 있을 경우 시간 설정)
           
        },
        error: function() {
            console.log("ajax 통신 실패!");
        }
    });
}

// 전체 삭제 
function confirmDelete() {
  if (confirm("찜 상품을 모두 삭제하시겠습니까?")) {
 	 alert("삭제가 성공되었습니다.");
  } else {
    alert("삭제가 취소되었습니다.");
  }
}

function openModal(prodNo) {
    // 아이프레임을 선택하고, src 속성을 동적으로 설정
    console.log(prodNo);
    var iframe = document.getElementById('optModal').querySelector('iframe');
 	 iframe.src = "selectCartOption.me?prodNo=" + prodNo;
    
    // 모달을 띄움
    document.getElementById('optModal').style.display = 'block';
}








