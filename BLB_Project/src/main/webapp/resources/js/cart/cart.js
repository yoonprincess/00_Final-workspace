$(function() {

    // 체크박스 클릭 이벤트
    // 전체 선택 체크/해제
    $("#check-all").on("change", function() {

        const isChecked = $(this).is(":checked");   // 전체선택 체크박스 선택 여부

        $(".check-one").prop("checked", isChecked); // 선택 여부에 따른 요소의 속성을 가져옴
    });
    // 개별 상품 체크
    $(".check-one").on("change", function() {

        const total = $(".check-one").length;   // 전체 상품 개수
        const checked = $(".check-one:checked").length; // 체크된 상품 개수

        $("#check-all").prop("checked", total === checked);
        // 모든 상품이 체크되면 '전체 선택' 체크/해제
    });

    // 수량 증가 버튼 클릭 이벤트
    $('.quantity-increase').on('click', function() {

        let $input = $(this).siblings('.quantity-input'); // input 요소 선택
        let currentValue = parseInt($input.val(), 10); // 10진법으로 현재 값 가져오기
        
        $input.val(currentValue + 1);
    });

    // 수량 감소 버튼 클릭 이벤트
    $('.quantity-decrease').on('click', function() {

        let $input = $(this).siblings('.quantity-input');
        let currentValue = parseInt($input.val(), 10);

        if (currentValue > 1) {	// 1 이상으로만
            $input.val(currentValue - 1);
        }
    });

});

// X 버튼으로 장바구니 삭제
function deleteCartItem(cartNo) {

    if (confirm("해당 상품을 장바구니에서 삭제하시겠습니까?")) {
        $("#delCartNo").val(cartNo);
        $("#deleteCart").submit();
    }
}

// 선택 삭제 버튼 클릭
function checkDelete() {

    const $checkDeleteForm = $("#checkDeleteForm");
    const $checkItems = $(".check-one:checked");

    if($checkItems.length === 0) {
        alert("선택한 상품이 없습니다.");
        return;
    }

    let cartNos = "";

    $checkItems.each(function() {
        cartNos += $(this).val() + ",";
        // 연이어져 들어오기 때문에 쉼표로 구분
    });

    cartNos = cartNos.slice(0, -1); // 마지막은 쉼표 빼기

    console.log(cartNos);

    $("#delCartNos").val(cartNos);

    $checkDeleteForm.submit();
}

// 옵션 변경 셀렉트박스
// function updateCartOption() {

//     // select box Name로 접근하여 선택된 값 읽기
//     const $selectedForm = ("#sel-opt-form");
//     const $selectedOpt = $(".sel-opt:selected");

//     $selectedOpt.each(function() {

//         console.log("옵션 값:", $(this).val()); // 현재 요소의 값
        
//     })

//     // form에 hidden input으로 값 추가
//     if ($("#hiddenNewOptNo").length === 0) {
//         $("<input>")
//             .attr({
//                 type: "hidden",
//                 id: "hiddenNewOptNo",
//                 name: "newOptNo",
//                 value: newOptNo
//             })
//             .appendTo("#selectNewOpt");
//     } else {
//         $("#hiddenNewOptNo").val(newOptNo);
//     }
//     $("#selectNewOpt").submit();
// }


// 장바구니 수량 변경
function updateQty(cartNo, currentQty, prodPrice, change) {

    // 수정된 수량 계산
    const updatedQty = currentQty + change;

    // 수량이 1개 이하로 내려가지 않게
    if (updatedQty <= 0) {
        alert("수량은 1개 이상이어야 합니다.");
        return;
    }
    
    // 수량에 따른 가격 계산
    const updatedPrice = prodPrice * updatedQty;

    $.ajax({
        url: "updateQty.ct",
        method: "POST",
        data: {
            cartNo : cartNo,
            updatedQty: updatedQty,
            updatedPrice: updatedPrice
            // currentQty: currentQty, // 현재 수량 전달
            // change: change  // -1(감소), 1(증가) 값 전달
        },
        success: function(response) {
            if(response.success) {

                // alert("수량이 변경되었습니다."); // 수량 변경 확인용
                // alert(updatedPrice); // 가격 변경 확인용

                // 수량 및 가격 업데이트
                // DOM 업데이트
                // var index = -1;
                // for(var i = 0; i < response.data.length; i++) {
                //     if(response.data[i] == cartNo) {
                //         index = i;
                //     }
                // }
                $('#update-price-' + cartNo).text(`${updatedPrice.toLocaleString()}원`); // 가격 업데이트
                // $("#update-price-"+cartNo).text(response.data[index].updatedPrice+"원");

                // location.reload();  // 페이지 새로고침
            } else {
                alert(response.message || "수량 변경에 실패하였습니다.");
            }
        },
        error: function() {
            alert("서버 오류가 발생했습니다. 다시 시도해 주세요.");
        }
    });
}


// 전체 장바구니 금액 계산
/*
function updateTotalPrice() {

    let totalPrice = 0;

    $(".product-price #update-price").each(function() {
        const priceText = $(this).text().replace(/,/g, '').replace('원', '');
        const price = parseInt(priceText, 10);

        if (!isNaN(price)) {
            totalPrice += price;
        }
    });

    // 전체 금액 DOM 업데이트
    $("#total-price").text(`${totalPrice.toLocaleString()}원`);
}
*/