
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
            
            $message.text('찜 해제!');
          
            $overlay.css({
                'display': 'flex',
                'opacity': '0'
            }).animate({opacity: 1}, 300);
            
            setTimeout(function() {
                $overlay.animate({opacity: 0}, 300, function() {
                    $(this).css('display', 'none');
                    window.location.href = "wishList.me";
                });
            }, 1000);
        },
        error: function() {
            console.log("ajax 통신 실패!");
            alert("찜 해제 실패");
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