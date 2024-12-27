$(document).ready(function () {

    // 옵션 번호(반복문 기준 번호로 사용)
    const optNo = $('.order-product').data('opt-no');

    // 상품 총 금액
    const totalAmt = $(`.product-total-amt-${optNo}`).data('total-amt');
    $('#refundAmount').text(`${totalAmt.toLocaleString()}원`);
    // 상품 수량
    const orderQty = $(`.product-quantity-${optNo}`).data('order-qty');
    // 할인 금액 차감
    const discount = totalAmt * 0.05; // 총 판매가의 5%
    $('#refundDiscount').text(`-${discount.toLocaleString()}원`);
    // 포인트 반환
    let pointAmt = totalAmt * 0.01;
    $('#refuntPoint').text(`-${pointAmt.toLocaleString()}원`);
    // 환불 예상 금액 계산
    const finalRefund = totalAmt - discount;
    $('#finalRefund').text(`${finalRefund.toLocaleString()}원`);

    // '취소 신청' 버튼 클릭 이벤트
    $("#submitCancel").click(function () {
        
        const orderNo = $('#orderNo').val(); // JSP에서 넘겨받은 주문 번호

        console.log(orderNo);
        
        // 선택된 취소 사유 가져오기
        const refundReason = $("#reasonSelect").val();

        console.log(refundReason);

        if (refundReason === null) {
            alert("취소 사유를 선택해주세요.");
            return;
        }

        if (confirm("정말로 취소하시겠습니까?")) {

            // 서버로 데이터 전송
            $.ajax({
                url: "cancelForm.or", // 취소 요청 URL
                type: "POST",
                contentType: "application/json",
                data: JSON.stringify({
                    orderNo: orderNo,
                    refundReason: refundReason,
                }),
                success: function (response) {
                    if (response.success) {
                        alert("취소 요청이 완료되었습니다.");
                        location.href = 'cancelComplete.or';
                        console.log("성공:", response);
                    } else {
                        alert("취소 요청에 실패했습니다. 다시 시도해주세요.");
                    }
                },
                error: function (xhr, status, error) {
                    console.error("취소 요청 중 오류 발생:", error);
                    alert("오류가 발생했습니다. 다시 시도해주세요.");
                },
            });

        }
    });
    
});