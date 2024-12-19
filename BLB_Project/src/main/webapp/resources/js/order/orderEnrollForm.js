$(function() {

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

    // 결제 옵션 클릭 이벤트
    $(".payment-option").on("click", function () {
        
        $(".payment-option").removeClass("selected");   // 모든 옵션에서 selected 제거
        $(this).addClass("selected");   // 클릭된 옵션에 seleceted 클래스 추가가
        
        const payOption = $(this).data("value");  // 클릭된 옵션의 value
    
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

});
