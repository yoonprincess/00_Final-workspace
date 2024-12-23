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

function openModal(prodNo) {
        // 아이프레임을 선택하고, src 속성을 동적으로 설정
        var iframe = document.getElementById('optModal').querySelector('iframe');
        iframe.src = "selectCartOption.me";
        
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



// 장바구니 추가 
function insertCart(){
	  
	  const dropdown = document.getElementById("dropdown");
      const selectedOption = dropdown.value; // 선택된 옵션 번호
  	if (selectedOption) {
        const optionData = dropdown.options[dropdown.selectedIndex].dataset;
        const optName = optionData.name;
        const optPrice = optionData.price;
        const optStock = optionData.stock;
   		const prodNo = optionData.prodNo;
   		
		$.ajax({
		        url: "insertCart.me",
		        type: "post",
		        data: {
		           
					prodNo: prodNo,
		            optNo : selectedOption, 
		            optName: optName,  // 옵션 이름
               		optPrice: optPrice, // 옵션 가격
                	optStock: optStock  // 옵션 재고
		        },
		        success: function(result) {
		         	alert("장바구니에 추가되었습니다.");
		              console.log("성공");
		           
		        },
		        error: function() {
		            console.log("ajax 통신 실패!");
		            alert("장바구니 추가 실패");
		        }
		    });
	 
	    } else {
        	alert("옵션을 선택하세요!");
    	}
}

document.getElementById("insertCartBtn").addEventListener("click", insertCart);




