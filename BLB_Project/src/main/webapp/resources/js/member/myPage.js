
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
                window.location.reload(true); // 새로고침
            }, 500); // 500ms 후에 새로고침 (애니메이션이 있을 경우 시간 설정)
           
        },
        error: function() {
            console.log("ajax 통신 실패!");
        }
    });
}

// 회원등급 모달창 
document.addEventListener("DOMContentLoaded", function () {
    const modal = document.getElementById('modal');
    const openBtn = document.getElementById('openModal');
    const closeBtn = document.querySelector('.close');

    if (!modal || !openBtn || !closeBtn) {
        console.error("Required elements not found. Check your HTML structure and IDs/classes.");
        return;
    }

    openBtn.addEventListener("click", function () {
        modal.style.display = "block";
    });

    closeBtn.addEventListener("click", function () {
        modal.style.display = "none";
    });

    window.addEventListener("click", function (event) {
        if (event.target === modal) {
            modal.style.display = "none";
        }
    });
});
		