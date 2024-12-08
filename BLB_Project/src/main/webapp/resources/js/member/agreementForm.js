
// 버튼 관련
function goBack() {
    history.back();
}

// 체크박스 관련
$('#all-agreement').change(function() {
    if ($(this).prop('checked')) {
        // all-agreement가 체크되면 나머지 체크박스들도 체크
        $('.checkbox').prop('checked', true);
    } else {
        // all-agreement가 체크 해제되면 나머지 체크박스들도 체크 해제
        $('.checkbox').prop('checked', false);
    }
});

// 나머지 체크박스가 변경되면 상태를 동기화
$('.checkbox').change(function() {
    if ($('.checkbox:checked').length === $('.checkbox').length) {
        // 모든 체크박스가 체크되었으면 
        $('#all-agreement').prop('checked', true);
    } else {
        // 하나라도 체크 해제되었으면 
        $('#all-agreement').prop('checked', false);
    }
});

// 필수 체크요건 검사
document.getElementById("agreementForm").addEventListener("submit", function(event) {
   
    var checkbox1 = document.getElementById("checkbox1").checked;
    var checkbox2 = document.getElementById("checkbox2").checked;

    // 체크박스 1과 체크박스 2가 모두 체크되지 않았을 경우
    if (!checkbox1 || !checkbox2) {
       
        if (!checkbox1 && !checkbox2) {
            alert("이용약관에 동의해주세요");

        } else {

            if (!checkbox1) {
                alert("이용약관에 동의해주세요");
            }
            if (!checkbox2) {
                alert("개인정보 수집 및 이용 방침에 동의하세요");
            }
        }
        event.preventDefault();  //  폼 submit 막기
    }
});