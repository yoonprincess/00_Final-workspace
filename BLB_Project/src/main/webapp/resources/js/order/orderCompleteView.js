$(function() {

    // 총 상품 금액
    const totalAmt = $('#total-amt').data('total-amt');
    $('#order-total-amt').text(`${totalAmt.toLocaleString()}원`);

    // 할인 금액 (5% 할인)
    let discount = totalAmt * 0.05; // 총 판매가의 5%
    $('#discount').text(`-${discount.toLocaleString()}원`);

    let orderTotalAmt = parseInt($('#order-total-amt').text().replace(/[^0-9]/g, ""), 10);
    let dlvrFee = parseInt($('#dlvr-fee').text().replace(/[^0-9]/g, ""), 10);
    orderTotalAmt = totalAmt - discount + dlvrFee;
    console.log(orderTotalAmt);
    //왜이래 고쳐 ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
    
    let pointAmt = orderTotalAmt * 0.01;
    // 소수점 제거 (내림)
    pointAmt = Math.floor(pointAmt);
    $('#order-total-amt').text(`${orderTotalAmt.toLocaleString()}원`);
    $('#point-amt').text(`${pointAmt.toLocaleString()}원`);

    

});