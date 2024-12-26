$(document).ready(function () {
    const cancelQuantity = $("#cancelQuantity");
    const reasonSelect = $("#reasonSelect");
    const refundAmount = $("#refundAmount");
    const submitCancel = $("#submitCancel");

    // 환불 금액 계산
    const quantity = parseInt(cancelQuantity.val(), 10);
    const pricePerItem = 7900;
    const deliveryFee = 2500;
    const totalRefund = pricePerItem * quantity + deliveryFee;
    refundAmount.text(`${totalRefund.toLocaleString()}원`);

    // 취소 신청 버튼 클릭
    $('#reasonSelect').change(function () {
        const selectedReason = $(this).val();

        if (selectedReason !== "") {
            // Ajax 요청
            $.ajax({
                url: 'orderCancelComplete.or', // 서버의 요청 URL
                type: 'POST',
                contentType: 'application/json',
                data: JSON.stringify({
                    orderNo: $('#orderNo').val(), // 예: 주문 번호 (필요시 추가)
                    refundReason: selectedReason // 선택한 취소 사유
                }),
                success: function (response) {
                    alert("취소 사유가 저장되었습니다.");
                },
                error: function (xhr, status, error) {
                    console.error("취소 사유 저장 중 오류 발생:", error);
                    alert("취소 사유 저장 중 문제가 발생했습니다. 다시 시도해주세요.");
                }
            });
        }
    });
    
});
