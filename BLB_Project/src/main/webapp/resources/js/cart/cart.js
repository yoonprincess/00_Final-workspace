$(function() {
	        	
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

    // X 버튼으로 장바구니 삭제
    function deleteCartItem(cartNo) {
        if (confirm("해당 상품을 장바구니에서 삭제하시겠습니까?")) {
            $("#delCartNo").val(cartNo);
            $("#deleteCart").submit();
        }
    }
});
