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


// 옵션선택 
const modal = document.getElementById("optModal");
const openModalBtn = document.getElementById("openModal");
const closeModalBtn = document.querySelector(".close");
const selectOptionBtn = document.getElementById("selectOption");
const dropdown = document.getElementById("dropdown");



// Close modal
closeModalBtn.addEventListener("click", () => {
    modal.style.display = "none";
});








