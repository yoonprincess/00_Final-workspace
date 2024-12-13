$(function() {

    // 체크박스 클릭 이벤트
    // 전체 선택 체크/해제
    $("#check-all").on("change", function() {

        const isChecked = $(this).is(":checked");

        $(".check-one").prop("checked", isChecked);
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