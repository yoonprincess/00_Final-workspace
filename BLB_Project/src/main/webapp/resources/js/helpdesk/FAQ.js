document.addEventListener('DOMContentLoaded', function () {
    const faqList = document.querySelector('.faq-list');
    const subTabButtons = document.querySelectorAll('.sub-tab-button');
    const tabButtons = document.querySelectorAll('.tab-button');
    
    // 클릭 이벤트 리스너 추가 (메인 탭 버튼)
    tabButtons.forEach(button => {
        button.addEventListener('click', function() {
            // 클릭한 버튼에 active 클래스 추가
            tabButtons.forEach(btn => btn.classList.remove('active')); // 모든 버튼에서 active 제거
            this.classList.add('active'); // 클릭한 버튼에 active 클래스 추가
        });
    });

    // 클릭 이벤트 리스너 추가 (서브 탭 버튼)
    subTabButtons.forEach(button => {
        button.addEventListener('click', () => {
            subTabButtons.forEach(btn => btn.classList.remove('active')); // 모든 서브탭 버튼에서 active 제거
            button.classList.add('active'); // 클릭한 서브탭 버튼에 active 클래스 추가
            loadFAQs(button.dataset.category); // 해당 카테고리의 FAQ 로드
        });
    });

    const faqData = [
    { question: "회원 가입은 어떻게 하나요?", answer: "상단 메뉴에서 '회원가입' 버튼을 클릭하여 필수 정보를 입력하면 회원 가입이 완료됩니다." },
    { question: "비밀번호를 잊어버렸습니다. 어떻게 해야 하나요?", answer: "로그인 화면에서 '비밀번호 찾기'를 클릭하여 이메일 인증 후 비밀번호를 재설정할 수 있습니다." },
    { question: "배송 기간은 얼마나 걸리나요?", answer: "보통 주문 후 2~3일 이내에 상품을 받아보실 수 있습니다. 지역에 따라 차이가 있을 수 있습니다." },
    { question: "구매한 상품을 반품하고 싶어요.", answer: "고객센터로 연락하시거나 반품 신청 페이지를 통해 접수하시면 됩니다. 자세한 안내는 고객센터에서 확인하세요." },
    { question: "환불은 얼마나 걸리나요?", answer: "환불 처리는 반품 확인 후 3~5일 이내에 완료됩니다. 결제 수단에 따라 차이가 있을 수 있습니다." },
    { question: "포인트 사용은 어떻게 하나요?", answer: "결제 페이지에서 포인트 사용 옵션을 선택하여 보유 포인트를 사용할 수 있습니다." },
    { question: "문의사항이 있습니다. 어떻게 연락하나요?", answer: "상단 'CONTACT' 메뉴에서 전화 문의 또는 이메일로 문의하실 수 있습니다." },
    { question: "상품 품절 시 재입고 알림을 받을 수 있나요?", answer: "상품 페이지에서 '재입고 알림 신청' 버튼을 클릭하면 알림을 받을 수 있습니다." },
    { question: "회원 탈퇴는 어떻게 하나요?", answer: "마이페이지에서 '회원 탈퇴'를 클릭하여 절차를 진행할 수 있습니다. 탈퇴 후에는 계정 복구가 불가능합니다." },
    { question: "배송 주소를 변경하고 싶어요.", answer: "주문 완료 후 배송 주소 변경은 고객센터로 문의해 주시기 바랍니다." }
];

const faqGrid = document.getElementById('faqGrid');

faqData.forEach(item => {
    const faqItem = document.createElement('div');
    faqItem.classList.add('faq-item');

    faqItem.innerHTML = `
        <h4 class="faq-question">Q. ${item.question}</h4>
        <p class="faq-answer">${item.answer}</p>
    `;

    faqGrid.appendChild(faqItem);
});
    

        // FAQ 리스트 초기화
        faqList.innerHTML = '';
        faqs[category].forEach(faq => {
            const faqItem = document.createElement('div');
            faqItem.classList.add('faq-item');
            faqItem.innerHTML = `
                <div class="faq-question">${faq.question}</div>
                <div class="faq-answer">${faq.answer}</div>
            `;
            // 질문 클릭 시 답변 토글
            faqItem.querySelector('.faq-question').addEventListener('click', () => {
                const answer = faqItem.querySelector('.faq-answer');
                const allAnswers = document.querySelectorAll('.faq-answer');
                
                // 모든 답변을 숨김
                allAnswers.forEach(ans => {
                    if (ans !== answer) ans.style.display = 'none';
                });

                // 클릭한 질문의 답변만 토글
                answer.style.display = answer.style.display === 'block' ? 'none' : 'block';
            });
            faqList.appendChild(faqItem);
        });
    }

    // 서브탭 클릭 시 '상품' 카테고리 FAQ 로드
    loadFAQs('product');
});