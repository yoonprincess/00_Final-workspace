
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
          
            $overlay.css({
                'display': 'flex',
                'opacity': '0'
            }).animate({opacity: 1}, 300);
            
            setTimeout(function() {
                $overlay.animate({opacity: 0}, 300, function() {
                    $(this).css('display', 'none');
                    window.location.href = "myPage.me";
                });
            }, 1000);
        },
        error: function() {
            console.log("ajax 통신 실패!");
            alert("찜 해제 실패");
        }
    });
}
