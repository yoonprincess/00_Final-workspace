function goBack() {
    history.back();
}

$(function () {
    $("#inquiryList>tbody>tr").click(function () {
        let ino = $(this).children(".ino").text();
        location.href = "inquiry/" + ino;
    });
});

// 문서가 로드된 후 실행
document.addEventListener('DOMContentLoaded', () => {
    // 문의 리스트 클릭 이벤트
    $("#inquiryList>tbody>tr").click(function () {
        const ino = $(this).children(".ino").text();
        if (ino) {
            location.href = "inquiry/" + ino;
        }
    });

    // FAQ 토글 기능
    document.querySelectorAll('.faq-question').forEach(question => {
        question.addEventListener('click', () => {
            const answer = question.nextElementSibling;
            const arrow = question.querySelector('span');

            if (answer.style.display === 'block') {
                answer.style.display = 'none';
                arrow.textContent = '▼';
            } else {
                answer.style.display = 'block';
                arrow.textContent = '▲';
            }
        });
    });
});
