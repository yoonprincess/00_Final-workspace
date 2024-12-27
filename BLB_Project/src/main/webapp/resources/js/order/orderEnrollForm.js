$(function() {

    // 모든 select 요소에 대해 처리
    $("#deliSelect").each(function() {
        
        // 선택된 배송지 배송코드
        const deliCode = parseInt($(this).val());

        // select 내부의 모든 option 요소 탐색
        $(this).find("option").each(function() {

            const $option = $(this); // 현재 option 요소
            const optionValue = parseInt($option.val()); // option의 value 값
    
            // cart-optno와 option의 value가 같으면 selected 속성 추가
            if (deliCode === optionValue) {

                $option.prop("selected", true); // 선택 처리
                $option.css("background-color", "#e0e0e0")
            }
        });

        // deliCode가 비어있으면 경고 메시지
        if (!deliCode) {
            alert('배송지를 선택해주세요.');
            return;
        }

        // 드롭다운 변경 시 이벤트 처리
        $('#deliSelect').on('change', function () {
            const deliCode = $(this).val();

            $.ajax({
                url: 'selectDelivery.or', // 컨트롤러 매핑 주소
                type: 'POST',
                data: { deliCode: deliCode },
                success: function (response) {
                    if (response) {
                        // 값 업데이트
                        $('#deliNickname').val(response.deliNickname);
                        $('#rcvrName').val(response.deliName);
                        $('#postCode').val(response.postcode);
                        $('#deliAddress').val(response.deliAddress);
                        $('#detailAddress').val(response.detailAddress);
    
                        const phone = response.deliPhone;
                        if (phone) {
                            $('#phone-prefix').val(phone.substring(0, 3));
                            $('#phone-middle').val(phone.substring(3, 7));
                            $('#phone-last').val(phone.substring(7));
                        }
    
                        $('#additionalInfo').val(response.deliComment);
                    } else {
                        alert('배송지 정보를 가져오는 데 실패했습니다.');
                    }
                },
                error: function () {
                    alert('배송지 정보를 가져오는 중 오류가 발생했습니다.');
                }
            });
        });
    });

    // 배송 상세 요청 시 textarea
    // 새로고침 시 기본 상태에서도 숨겨지게 설정
    if ($("#delivery-message").val() !== "custom") {
        $("#custom-comment").hide(); // 기본 옵션 또는 다른 옵션 선택 시 textarea 숨김
    }
    
    // select 요소의 change 이벤트 처리
    $("#delivery-message").on("change", function () {

        // 선택된 값이 "custom"인지 확인
        if ($(this).val() === "custom") {
            $("#custom-comment").show(); // 직접 입력 시 textarea 표시
        } else {
            $("#custom-comment").hide(); // 다른 옵션 선택 시 숨김
        }
    });

    // 결제 수단 전역 변수로 쓰기 위함함
    let payOption;

    // 결제 옵션 선택 이벤트
    $(".payment-option").on("click", function () {
        
        $(".payment-option").removeClass("selected");   // 모든 옵션에서 selected 제거
        $(this).addClass("selected");   // 클릭된 옵션에 seleceted 클래스 추가가

        payOption = $(this).data("value");  // 클릭된 옵션의 value
    
        // 결제수단 선택 시 나오는 안내 문구 세팅
        const payComment = {
            "무통장입금": "현금 영수증 발생 여부를 선택해 주세요.",
            "신용카드": "소액 결제의 경우 PG사 정책에 따라 결제 금액 제한이 있을 수 있습니다.",
            "카카오페이": "카카오톡 앱을 설치한 후, 최초 1회 카드정보를 등록하셔야 사용 가능합니다. <br> 인터넷 익스플로러는 8 이상에서만 결제 가능합니다. <br> 카카오머니로 결제 시, 현금영수증 발급은 ㈜카카오페이에서 발급 가능합니다."
        };
    
        $("#payment-comment").html(payComment[payOption] || "결제 수단을 선택해주세요.");
            
        if (payOption === "무통장입금") {
            $("#bank-info").show(); // 무통장입금 입력 필드 표시
        } else {
            $("#bank-info").hide(); // 무통장입금 입력 필드 숨기기
        }
    });

    // 약관 동의 체크박스
    // 모든 약관 동의
    $("#check-all").on("change", function () {

        const isChecked = $(this).is(":checked");
        $(".check-term").prop("checked", isChecked); // 모든 개별 체크박스 체크/해제
    });

    // 개별 약관 체크박스 클릭 이벤트
    $(".check-term").on("change", function () {
        
        const total = $(".check-term").length; // 전체 약관 개수
        const checked = $(".check-term:checked").length; // 체크된 약관 개수

        // 모든 약관이 체크되면 "모든 약관 동의"도 체크, 아니면 해제
        $("#check-all").prop("checked", total === checked);
    });

    // 전화번호 분리해서 출력하기
    // > 숨겨진 전체 전화번호에서 값 가져오기
    const phoneNumber = $("#hidden-phone-number").val(); // 숨겨진 input에서 값 가져오기

    if (phoneNumber) {
        // 전화번호를 직접 분리
        const phonePrefix = phoneNumber.substring(0, 3); // 앞자리
        const middle = phoneNumber.substring(3, 7); // 중간 4자리
        const last = phoneNumber.substring(7); // 마지막 4자리

        // select 및 input 요소에 값 설정
        $("#phone-prefix").val(phonePrefix); // 앞자리 설정
        $("#phone-middle").val(middle); // 중간자리 설정
        $("#phone-last").val(last); // 마지막자리 설정
    }


    // 최종 총합 가격 계산
    function calculateTotalPrice() {
        let totalPrice = 0; // 모든 상품 가격의 총합을 저장할 변수

        // 판매가 계산을 위한 상품 가격
        $('.order-product').each(function () {
            // 장바구니 번호
            const cartNo = $(this).data('cart-no');

            // 상품 가격 텍스트에서 숫자만 추출
            let prodPriceText = $(`.product-price-${cartNo}`).text().replace(/[^0-9]/g, ""); // 숫자가 아닌 모든 문자를 제거
            let prodPrice = parseInt(prodPriceText, 10); // 숫자로 변환

            // 수량 가져오기
            let cartQtyText = $(`.product-quantity-${cartNo}`).text().replace(/[^0-9]/g, "");
            let cartQty = parseInt(cartQtyText, 10);

            // 구매가 계산
            let prodOrderPrice = prodPrice * cartQty;

            // 구매가 DOM 업데이트
            $(`.product-order-price-${cartNo}`)
                .text(`구매가: ${prodOrderPrice.toLocaleString()}원`)
                .css({
                    "font-size": "16px",  // 텍스트 크기
                    "font-weight": "bold" // 텍스트 굵기
                });

            // 총 가격에 추가
            totalPrice += prodOrderPrice;
        });

       // 총 판매가
        $('#total-amt').text(`${totalPrice.toLocaleString()}원`);

        // 총 할인가 (5% 할인)
        let discount = totalPrice * 0.05; // 총 판매가의 5%
        $('.discount').text(`${discount.toLocaleString()}원`);

        // 배송비
        let dlvrFee = totalPrice <= 50000 ? 3000 : 0;
        $("#dlvr-fee").text(`${dlvrFee.toLocaleString()}원`);

        // 총 결제 예상 금액 최소 ('총 판매가 - 총 할인가 + 배송비')
        let finalPrice = totalPrice - discount + dlvrFee;
        $('.final-price').text(`${finalPrice.toLocaleString()}원`);

        // 최종 총합 가격 DOM 업데이트
        $('.final-order-price').text(`${finalPrice.toLocaleString()}원`);
    }

    // 초기 계산 수행
    calculateTotalPrice();

    // 이벤트로 다시 계산 (예: 삭제 버튼 클릭 시)
    $('.delete-button').on('click', function () {
        
        // 다음 hr 요소 삭제
        $(this).closest('.order-product').next('hr').remove(); // 다음 hr 요소 삭제
        // 해당 상품 삭제 처리
        $(this).closest('.order-product').remove();

        // 총합 다시 계산
        calculateTotalPrice();
    });


    // 배송지 요청 사항
    $('input[name="entry"]').on('change', function() {

        var selectedValue = $(this).val();
        
        switch (selectedValue) {

            case '비밀번호':
                placeholderText = "공동현관 비밀번호를 입력하세요";
                break;
            case '경비실호출':
                placeholderText = "경비실 호출 방법을 입력하세요";
                break;
            case '자유출입가능':
                placeholderText = "추가 요청사항을 입력하세요";
                break;
            case '기타사항':
                placeholderText = "기타 상세 내용을 입력하세요";
                break;
        }

        $('#additionalInfo').attr('placeholder', placeholderText);
    });

    // 아임포트 SDK 초기화
    if (typeof IMP !== "undefined") {
        IMP.init("imp28486016"); // 본인의 아임포트 가맹점 코드
        console.log("IMP SDK 초기화 완료");
    } else {
        console.error("IMP SDK 로드 실패");
    }


    // 결제하기 버튼 클릭 이벤트
    $('.payment-button').on('click', function(event) {

        event.preventDefault(); // 폼 기본 제출 동작 방지

        const orderNo = $("#orderNo").val(); // 주문 No
        console.log("주문번호 : " + orderNo);

        
        const orderTotalAmt = parseInt($(".final-price").text().replace(/[^0-9]/g, "")); // 결제 금액

        console.log("결제금액: " + orderTotalAmt);
        
        
        // 각 상품의 데이터를 배열에 저장
        var productData = [];

        $('.order-product').each(function() {
            // 장바구니 번호
            const cartNo = $(this).data('cart-no');

            // 각 상품 데이터 추출
            const orderQty = $(`.product-option-` + cartNo).data('cart-qty'); // 수량
            const productPrice = $(`.product-price-` + cartNo).text().replace(/[^0-9]/g, ""); // 가격
            const totalAmt = productPrice * orderQty;
            const optNo = $(`.product-option-` + cartNo).data('opt-no'); // cartNo를 optNo로 사용

            // 상품 데이터를 객체로 저장
            productData.push({
                orderQty: parseInt(orderQty, 10),
                totalAmt: parseInt(totalAmt, 10),
                optNo: parseInt(optNo, 10),
                cartNo: parseInt(cartNo, 10)
            });
        });

        const memberId = $('#memberId').val();
        const rcvrName = $('#rcvrName').val().trim();
        const rcvrAddress = "(" + $('#postCode').val() + ") " + $('#deliAddress').val() + $('#detailAddress').val();
        const rcvrPhone = $('#phone-prefix').find('option:selected').val().trim() + $('#phone-middle').val() + $('#phone-last').val();

        // 라디오 버튼 값과 추가 요청사항 값 합치기
        var entryMethod = $('input[name="entry"]:checked').val();   // 라디오 버튼 값
        var additionalInfo = $('#additionalInfo').val();    // 추가 요청 사항
        const dlvrReqMessage = entryMethod + ' / ' + (additionalInfo || '');
        
        const paymentMethod = payOption;
        const totalAmt = $('#total-amt').text().replace(/[^0-9]/g, "");
        const discount = parseInt($('.discount').text().replace(/[^0-9]/g, "")); // 총 판매가의 5%
        const dlvrFee = parseInt($('#dlvr-fee').text().replace(/[^0-9]/g, ""));

        if (!rcvrName || !rcvrPhone || !rcvrAddress) { 
            alert("배송 정보를 모두 입력해주세요.");
            event.preventDefault();
            return;
        }
    
        if (!paymentMethod) {
            alert("결제 수단을 선택해주세요.");
            event.preventDefault();
            return;
        }


        if (payOption === '카카오페이') {

            try {
                // 나이스페이 요청
                IMP.request_pay({
                    pg: "kakaopay",
                    paymethod: "card",
                    amount: totalAmt - discount + dlvrFee,
                    name: "뷰라밸",
                    merchant_uid: "616" + new Date().getTime(), // 고유 주문 ID
                }, async function (rsp) {
                    if (rsp.success) {
                        // 결제가 성공하면 서버로 결제 정보 전송
                        const response = await fetch('payment.or', {
                            method: 'POST',
                            headers: {
                                'Content-Type': 'application/json',
                            },
                            body: JSON.stringify({
                                imp_uid: rsp.imp_uid, // 결제 고유 번호
                                merchant_uid: rsp.merchant_uid, // 주문 번호
                                paid_amount: rsp.paid_amount, // 결제 금액
                                rcvrName : rcvrName,
                                rcvrPhone : rcvrPhone,
                                rcvrAddress : rcvrAddress,
                                dlvrReqMessage : dlvrReqMessage,
                                paymentMethod : paymentMethod,
                                orderTotalAmt : orderTotalAmt,
                                dlvrFee: dlvrFee,
                                products: productData, // productData 배열 추가
                                memberId : memberId,
                                totalAmt: totalAmt
                            }),
                        });
                        
                        const result = await response.json();
                        if (result.status === "success") {

                            alert("결제가 완료되었습니다!");

                            // 결제 완료 정보를 URL로 전달
                            // 배열에서 cartNo만 추출
                            const cartNos = productData.map(product => product.cartNo);

                            // URL 생성
                            const url = `orderComplete.or?paymentCode=${encodeURIComponent(rsp.merchant_uid)}&orderCartNos=${cartNos.join(',')}`;
                            window.location.href = url; // GET 요청으로 이동
                        } else {
                            alert("결제 확인에 실패했습니다.");
                        }
                    } else {
                        alert("결제가 취소되었습니다. " + rsp.error_msg);
                    }
                });
            } catch (error) {
                console.error("결제 요청 중 오류 발생:", error);
                alert("결제 처리 중 문제가 발생했습니다.");
            }

        } else if(payOption === '신용카드') {

            try {
                // 나이스페이 요청
                IMP.request_pay({
                    pg: "nice",
                    paymethod: "card",
                    amount: totalAmt - discount + dlvrFee,
                    name: "뷰라밸",
                    merchant_uid: "616" + new Date().getTime(), // 고유 주문 ID
                }, async function (rsp) {
                    if (rsp.success) {
                        // 결제가 성공하면 서버로 결제 정보 전송
                        const response = await fetch('payment.or', {
                            method: 'POST',
                            headers: {
                                'Content-Type': 'application/json',
                            },
                            body: JSON.stringify({
                                imp_uid: rsp.imp_uid, // 결제 고유 번호
                                merchant_uid: rsp.merchant_uid, // 주문 번호
                                paid_amount: rsp.paid_amount, // 결제 금액
                                rcvrName : rcvrName,
                                rcvrPhone : rcvrPhone,
                                rcvrAddress : rcvrAddress,
                                dlvrReqMessage : dlvrReqMessage,
                                paymentMethod : paymentMethod,
                                orderTotalAmt : orderTotalAmt,
                                dlvrFee: dlvrFee,
                                products: productData, // productData 배열 추가
                                memberId : memberId,
                                totalAmt: totalAmt
                            }),
                        });
                        
                        const result = await response.json();
                        if (result.status === "success") {

                            alert("결제가 완료되었습니다!");

                            // 결제 완료 정보를 URL로 전달
                            // 배열에서 cartNo만 추출
                            const cartNos = productData.map(product => product.cartNo);

                            // URL 생성
                            const url = `orderComplete.or?paymentCode=${encodeURIComponent(rsp.merchant_uid)}&orderCartNos=${cartNos.join(',')}`;
                            window.location.href = url; // GET 요청으로 이동
                        } else {
                            alert("결제 확인에 실패했습니다.");
                        }
                    } else {
                        alert("결제가 취소되었습니다. " + rsp.error_msg);
                    }
                });
            } catch (error) {
                console.error("결제 요청 중 오류 발생:", error);
                alert("결제 처리 중 문제가 발생했습니다.");
            }

        } else if(payOption === '무통장입금') {
            alert("[우리은행 1002-848-470984]로 입금해 주세요.");
        } else if (payOption) {
            alert(`${payOption} 결제는 아직 구현되지 않았습니다.`);
        } else {
            alert('결제 수단을 선택해주세요.');
        }
    });

    // 페이지 로딩 시에도 결제하기 버튼 비활성화
    const allChecked = $('.check-term').length === $('.check-term:checked').length;
    $('.payment-button').prop('disabled', !allChecked);

    // 약관 동의 체크박스 관련 이벤트
    $('#check-all, .check-term').on('change', function () {
        const allChecked = $('.check-term').length === $('.check-term:checked').length;
        const isCheckAll = $('#check-all').prop('checked', allChecked);

        // "결제하기" 버튼 활성화/비활성화
        $('.payment-button').prop('disabled', !allChecked);
    });

    // "결제하기" 버튼 클릭 시 조건 확인
    $('.payment-button').on('click', function (event) {
        const allChecked = $('.check-term').length === $('.check-term:checked').length;

        if (!allChecked) {
            event.preventDefault(); // 기본 제출 동작 방지
            alert('모든 약관에 동의해야 결제가 가능합니다.');
        }
    });



});

// 우편번호 검색 버튼 클릭 이벤트
function sample4_execDaumPostcode() {

    console.log("클릭?");

    new daum.Postcode({
        oncomplete: function(data) {

            // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
            var roadAddr = data.roadAddress; // 도로명 주소 변수
            var extraRoadAddr = ''; // 참고 항목 변수

            // 법정동명이 있을 경우 추가한다. (법정리는 제외)
            // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
            if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                extraRoadAddr += data.bname;
            }
            // 건물명이 있고, 공동주택일 경우 추가한다.
            if(data.buildingName !== '' && data.apartment === 'Y'){
               extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
            }
            // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
            if(extraRoadAddr !== ''){
                extraRoadAddr = ' (' + extraRoadAddr + ')';
            }
            
            var fullAddress = '도로명 : ' + roadAddr + extraRoadAddr + ' | 지번 : '+ data.jibunAddress ;
            
            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            document.getElementById('postCode').value = data.zonecode;
           
            document.getElementById("deliAddress").value = fullAddress;
            
            if(data.autoRoadAddress) {
                var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
              
            } else if(data.autoJibunAddress) {
                var expJibunAddr = data.autoJibunAddress;
                document.getElementById("deliAddress").value = '도로명 : ' + roadAddr + extraRoadAddr + ' | 지번 : ' + expJibunAddr;
                
            } 
            
            document.getElementById("detailAddress").focus();
        }
        
    }).open();

}
