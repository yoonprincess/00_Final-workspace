$(function() {

    // 페이지 로드 시
    // 체크된 상품의 총 가격 계산
    checkedTotalPrice();
    // 체크된 상품의 수량 결제하기 버튼에 출력
    cartByeButton();

    // 모든 select 요소에 대해 처리
    $(".prod-opt").each(function() {

        const $select = $(this); // 현재 select 요소
        const cartOptNo = parseInt($select.data("cart-optno")); // select에 저장된 cart-optno 값
    
        // select 내부의 모든 option 요소 탐색
        $select.find("option").each(function() {

            const $option = $(this); // 현재 option 요소
            const optionValue = parseInt($option.val()); // option의 value 값
    
            // cart-optno와 option의 value가 같으면 selected 속성 추가
            if (cartOptNo === optionValue) {

                $option.prop("selected", true); // 선택 처리
                $option.css("background-color", "#e0e0e0")
            }
        });
    });

    // 체크박스 클릭 이벤트
    // 전체 선택 체크/해제
    $("#check-all").on("change", function() {

        const isChecked = $(this).is(":checked");   // 전체선택 체크박스 선택 여부

        $(".check-one").prop("checked", isChecked); // 선택 여부에 따른 요소의 속성을 가져옴

        // 체크박스 동작 시에도 총 가격 업데이트
        checkedTotalPrice();

        // 체크된 상품의 수량 결제하기 버튼에 출력
        cartByeButton();
    });

    // 개별 상품 체크
    $(".check-one").on("change", function() {

        const total = $(".check-one").length;   // 전체 상품 개수
        const checked = $(".check-one:checked").length; // 체크된 상품 개수

        $("#check-all").prop("checked", total === checked);
        // 모든 상품이 체크되면 '전체 선택' 체크/해제

        // 체크된 상품 결제하기 버튼에 출력
        $("#checkedCartQty").text(`${checked.toLocaleString()}`);

        // 체크박스 동작 시에도 총 가격 업데이트
        checkedTotalPrice();

        // 체크된 상품의 수량 결제하기 버튼에 출력
        cartByeButton();
    });

    // 수량 증가 버튼 클릭 이벤트
    $('.quantity-increase').on("click", function() {

        let $input = $(this).siblings('.quantity-input'); // 형제인 input 요소 선택
        let currentQty = parseInt($input.val(), 10); // 10진법으로 현재 값 가져오기
        let prodPrice = parseInt($(this).data("prod-price"));   /// 상품 단가
        let cartNo = parseInt($(this).data("cart-no")); // 장바구니 번호
        
        // 옵션 재고 수량
        var remainQty = parseInt($('#prod-opt-' + cartNo).find("option:selected").data('remainqty'), 10);

        if((currentQty + 1) > remainQty) {
            // 재고 수량이 넘지 않게

            alert('최대 ' + remainQty + '개 주문 가능합니다. (재고: ' + remainQty + ')');
            return;
        }

        // 수량 증가 시 총 가격 계산
        let updatedQty = currentQty + 1;  // 수량 1 증가

        const optPrice = parseInt($("#prod-opt-" + cartNo).find("option:selected").data("price")) || 0;

        const updatedPrice = (prodPrice + optPrice) * updatedQty;   // 총 가격 계산

        // ajax로 장바구니 테이블에 적용
        $.ajax({
            url: "updateQty.ct",
            method: "POST",
            data: {
                cartNo : cartNo,
                updatedQty: updatedQty,
                updatedPrice: updatedPrice
            },
            success: function(response) {
                if(response.success) {

                   // 업데이트된 수량, 가격 담기
                   $input.val(updatedQty); // 업데이트된 수량 input 요소에 담기
                   $(".product-quantity-"  + cartNo).text(`수량: ${updatedQty.toLocaleString()}`); // 업데이트된 수량 출력하기
                   $("#updated-price-" + cartNo).text(`${updatedPrice.toLocaleString()}원`); // 수량에 따른 총 가격

                   // 수량 변경 시에도 총 가격 업데이트
                    checkedTotalPrice();

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
    $('.quantity-decrease').on("click", function() {

        const $input = $(this).siblings('.quantity-input'); // input 요소 선택
        const currentQty = parseInt($input.val(), 10); // 10진법으로 현재 값 가져오기
        const prodPrice = parseInt($(this).data("prod-price"));   /// 상품 단가
        const cartNo = parseInt($(this).data("cart-no")); // 장바구니 번호

        console.log("현재 수량 : " + currentQty);

        if ((currentQty - 1) < 1) {
            // 1 이하로 내려가지 않게

            alert("수량은 1개 이상이어야 합니다.");
            return;
        }

        // 수량 감소 시 총 가격 계산
        const updatedQty = currentQty - 1;  // 수량 1 감소
        const optPrice = parseInt($("#prod-opt-" + cartNo).find("option:selected").data("price")) || 0;

        const updatedPrice = (prodPrice + optPrice) * updatedQty;   // 총 가격 계산
        
        // ajax로 장바구니 테이블에 적용
        $.ajax({
            url: "updateQty.ct",
            method: "POST",
            data: {
                cartNo : cartNo,
                updatedQty: updatedQty,
                updatedPrice: updatedPrice
            },
            success: function(response) {
                if(response.success) {
                    
                    // 업데이트된 수량, 가격 담기
                    $input.val(updatedQty); // 업데이트된 수량 input 요소에 담기
                    $(".product-quantity-"  + cartNo).text(`수량: ${updatedQty.toLocaleString()}`); // 업데이트된 수량 출력하기
                    $("#updated-price-" + cartNo).text(`${updatedPrice.toLocaleString()}원`); // 수량에 따른 총 가격

                    // 수량 변경 시에도 총 가격 업데이트
                    checkedTotalPrice();
                    
                } else {
                    alert(response.message || "수량 변경에 실패하였습니다.");
                }
            },
            error: function() {
                alert("서버 오류가 발생했습니다. 다시 시도해 주세요.");
            }
        });
    });

    // 옵션 선택 시 옵션 목록에 추가
    $(".prod-opt").on("change", function() {

        const updatedOptNo = parseInt($(this).val());    // 선택된 옵션 번호

        const $selectedOption = $(this).find("option:selected");    // 선택된 옵션 요소

        // 옵션 선택용 변수
        const optName =  $selectedOption.data("name");
        const optValue = $selectedOption.data("opt-value");
        const optPrice = parseInt($selectedOption.data("price")) || 0;
        const remainQty = parseInt($selectedOption.data("remainqty")) || 0;
        const cartNo = parseInt($selectedOption.data("cart-no"));

        // 가격 계산용 변수
        const prodPrice = parseInt($selectedOption.closest("tr").find(".quantity-increase").data("prod-price"));
        const quantity = parseInt($selectedOption.closest("tr").find(".quantity-input").val(), 10);

        const updatedPrice = (prodPrice + optPrice) * quantity;

        // 유효성 검사: -1 또는 잘못된 값 선택 시 경고 후 종료
        if (updatedOptNo === -1 || isNaN(updatedOptNo)) {
            alert("옵션을 선택해 주세요.");
            return;
        }

        // 모든 옵션의 배경색 초기화
        $(this).find("option").css("background-color", "");

        $.ajax({
            url: "updateOption.ct",
            method: "POST",
            data: {
                cartNo: cartNo,
                updatedOptNo: updatedOptNo
            },
            success: function(response) {
                if(response.success) {

                    $(".product-option-"  + cartNo).text(`[옵션: ${optName.toLocaleString()} ${optValue.toLocaleString()} (+ ${optPrice.toLocaleString()}원)]`);
                    
                    // 선택된 항목에 배경색, selected 속성 부여
                    $selectedOption.css("background-color", "#e0e0e0")
                                   .prop("selected", true);

                    // 상품 총 가격 업데이트
                    $("#updated-price-" + cartNo).text(`${updatedPrice.toLocaleString()}원`);

                    // 옵션 변경 시에도 총 가격 업데이트
                    checkedTotalPrice();

                } else {

                    alert(response.message || "옵션 변경에 실패하였습니다.");
                }
            },
            error: function() {
                alert("서버 오류가 발생했습니다. 다시 시도해 주세요.");
            }
        });
    });

    // 결제하기 버튼 클릭 이벤트
    $("#cartBuy").on("click", function() {

        const $checkedProds = $(".check-one:checked");   // 체크된 상품

        if($checkedProds.length === 0) { // 체크된 항목이 없을 때

            alert("선택한 상품이 없습니다. 결제할 상품을 선택해 주세요.");
            return;
        }

        const checkedCartNos = [];    // 체크된 장바구니 번호를 담을 배열

        $checkedProds.each(function() {

            checkedCartNos.push($(this).val());
        });

        // 결제 예상 금액 계산
        const totalPriceText = $("#total-prod-price").text().replace(/,/g, "").replace("원", "");
        const orderTotalAmt = parseInt(totalPriceText, 10); // 결제 예상 금액

        // 결제하기 페이지로 form 전송

        // 체크된 장바구니 번호와 결제 예상 금액을 hidden input에 설정
        $("#checkedCartNos").val(checkedCartNos.join(",")); // 장바구니 번호
        $("#orderTotalAmt").val(orderTotalAmt); // 총 상품 가격(== 배송비 제외 가격)

        // 폼 전송
        $("#cartBuyForm").submit();
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

    $("#delCartNos").val(cartNos);

    $checkDeleteForm.submit();
}

// 체크박스로 선택한 항목의 총 가격
function checkedTotalPrice() {

    let totalCheckedPrice = 0;
    // 재할당을 위해 let 으로 선언

    $(".check-one:checked").each(function() {

        const cartNo = $(this).val();
        const priceText = $(`#updated-price-${cartNo}`).text().replace(/,/g, "").replace("원", ""); // ',' 및 '원' 제거
        const price = parseInt(priceText, 10);  // 10진수로

        if(!isNaN(price)) {

            totalCheckedPrice += price;
        }
    });

    // 총 가격 DOM 업데이트
    $("#total-prod-price").text(`${totalCheckedPrice.toLocaleString()}원`);

    // 배송비
    let dlvrFee = totalCheckedPrice === 0 
                    ? 0 
                    : (totalCheckedPrice <= 50000 ? 3000 : 0);

    $("#dlvr-fee").text(`${dlvrFee.toLocaleString()}원`);

    // 결제 예상 금액
    let finalTotal = totalCheckedPrice + dlvrFee;

    $('#final-total').text(`${finalTotal.toLocaleString()}원`);
}

// 결제하기 버튼에 결제할 상품 수량 담기
function cartByeButton() {

    const checked = $(".check-one:checked").length; // 체크된 상품 개수

    // 체크된 상품 결제하기 버튼에 출력
    $("#checkedCartQty").text(`${checked.toLocaleString()}`);
}