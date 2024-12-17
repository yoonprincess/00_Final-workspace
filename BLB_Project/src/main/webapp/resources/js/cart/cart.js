$(function() {

    // 페이지 로드 시 총 상품 가격 계산
    updateTotalPrice();

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
        let currentQty = parseInt($input.val(), 10); // 10진법으로 현재 값 가져오기
        let prodPrice = parseInt($(this).data("prod-price"));   /// 상품 단가
        let cartNo = parseInt($(this).data("cart-no")); // 장바구니 번호
        
        // 수량 증가 시 총 가격 계산
        let updatedQty = currentQty + 1;  // 수량 1 증가
        let updatedPrice = updatedQty * prodPrice;   // 총 가격 계산

        // ajax로 장바구니 테이블에 적용
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

                   // 업데이트된 수량, 가격 담기
                   $input.val(updatedQty); // 업데이트된 수량 input 요소에 담기
                   $(".product-quantity-"  + cartNo).text(`수량: ${updatedQty.toLocaleString()}`); // 업데이트된 수량 출력하기
                   $("#updated-price-" + cartNo).text(`${updatedPrice.toLocaleString()}원`); // 수량에 따른 총 가격

                   updateTotalPrice(); // 총 가격 업데이트 호출

                } else {
                    alert(response.message || "수량 변경에 실패하였습니다.");
                }
            },
            error: function() {
                alert("서버 오류가 발생했습니다. 다시 시도해 주세요.");
            }
        });

    });

    // 수량 감소 버튼 클릭 이벤트
    $('.quantity-decrease').on('click', function() {

        let $input = $(this).siblings('.quantity-input'); // input 요소 선택
        let currentQty = parseInt($input.val(), 10); // 10진법으로 현재 값 가져오기
        let prodPrice = parseInt($(this).data("prod-price"));   /// 상품 단가
        let cartNo = parseInt($(this).data("cart-no")); // 장바구니 번호

        if (currentQty < 2) {	// 1 이하로 내려가지 않게

            alert("수량은 1개 이상이어야 합니다.");
            return;
        }

        // 수량 감소 시 총 가격 계산
        let updatedQty = currentQty - 1;  // 수량 1 감소
        let updatedPrice = updatedQty * prodPrice;   // 총 가격 계산
        
        // ajax로 장바구니 테이블에 적용
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
                    
                    // 업데이트된 수량, 가격 담기
                    $input.val(updatedQty); // 업데이트된 수량 input 요소에 담기
                    $(".product-quantity-"  + cartNo).text(`수량: ${updatedQty.toLocaleString()}`); // 업데이트된 수량 출력하기
                    $("#updated-price-" + cartNo).text(`${updatedPrice.toLocaleString()}원`); // 수량에 따른 총 가격

                    updateTotalPrice(); // 총 가격 업데이트 호출
                    
                } else {
                    alert(response.message || "수량 변경에 실패하였습니다.");
                }
            },
            error: function() {
                alert("서버 오류가 발생했습니다. 다시 시도해 주세요.");
            }
        });
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



function updateTotalPrice() {

    let totalPrice = 0;

    // 모든 상품의 가격 합산
    $(".product-price span").each(function () { // 수량에 따라 업데이트된 상품 가격
        const priceText = $(this).text().replace(/,/g, "").replace("원", ""); // 쉼표 및 '원' 제거
        const price = parseInt(priceText, 10);

        if (!isNaN(price)) {
            totalPrice += price;
        }
    });

    // 총 상품 가격 업데이트
    $("#total-prod-price").text(`${totalPrice.toLocaleString()}원`);

    // 배송비
    let dlvrFee = totalPrice <= 50000 ? 3000 : 0;
    $("#dlvr-fee").text(`${dlvrFee.toLocaleString()}원`);

    console.log(dlvrFee);
    console.log(totalPrice);


    // 결제 예상 금액
    let finalTotal = totalPrice + dlvrFee;
    console.log(finalTotal);

    $('#final-total').text(`${finalTotal.toLocaleString()}원`);

}