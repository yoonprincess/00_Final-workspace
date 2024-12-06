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

    // FAQ 항목 로드 함수
    function loadFAQs(category) {
        const faqs = {
           product: [
                { question: '상품의 색상은 어떻게 선택하나요?', answer: '상품 상세 페이지에서 색상 옵션을 선택할 수 있습니다.', category: 'product' },
                { question: '상품의 사이즈는 어떻게 확인하나요?', answer: '사이즈 가이드를 참고하여 적절한 사이즈를 선택할 수 있습니다.', category: 'product' },
                { question: '상품이 품절이면 어떻게 되나요?', answer: '품절된 상품은 재입고 알림을 신청하면 재입고 시 알림을 받으실 수 있습니다.', category: 'product' },
                { question: '상품의 가격은 언제 변경되나요?', answer: '가격은 프로모션이나 할인에 따라 변동될 수 있습니다. 항상 상품 페이지에서 최신 가격을 확인해주세요.', category: 'product' },
                { question: '상품을 교환할 수 있나요?', answer: '상품 수령 후 7일 이내에 교환이 가능합니다. 자세한 사항은 교환 정책을 참조해주세요.', category: 'product' }
            ],
            delivery: [
                { question: '배송은 얼마나 걸리나요?', answer: '2-3일 소요됩니다.', category: 'delivery' },
                { question: '배송 상태는 어떻게 확인하나요?', answer: '배송 추적 페이지에서 확인 가능합니다.', category: 'delivery' },
                { question: '배송비는 얼마인가요?', answer: '주문 금액에 따라 달라집니다.', category: 'delivery' },
                { question: '배송 중 주소 변경이 가능한가요?', answer: '배송 전까지 주소 변경이 가능합니다.', category: 'delivery' },
                { question: '해외 배송이 가능한가요?', answer: '현재는 국내 배송만 가능합니다.', category: 'delivery' }
            ],
            order: [
                { question: '반품 절차는 어떻게 되나요?', answer: '고객센터로 연락 주시면 안내 드립니다.', category: 'order' },
                { question: '주문 상태는 어떻게 확인하나요?', answer: '주문 내역에서 확인 가능합니다.', category: 'order' },
                { question: '주문을 취소하고 싶은데 어떻게 해야 하나요?', answer: '주문 후 30분 이내에 취소 가능합니다.', category: 'order' },
                { question: '주문이 정상적으로 처리되지 않았습니다. 어떻게 해야 하나요?', answer: '고객센터로 문의 바랍니다.', category: 'order' },
                { question: '배송 전 주소 변경이 가능한가요?', answer: '배송 전까지 주소 변경이 가능합니다.', category: 'order' }
            ],
            payment: [
                { question: '결제 방법은 어떤 것이 있나요?', answer: '신용카드, 무통장입금, 간편결제 등이 가능합니다.', category: 'payment' },
                { question: '결제 오류가 발생했습니다. 어떻게 해야 하나요?', answer: '결제 오류 발생 시 고객센터로 문의해주세요.', category: 'payment' },
                { question: '결제 금액이 잘못되었습니다. 수정이 가능한가요?', answer: '고객센터로 문의주시면 확인 후 수정해드립니다.', category: 'payment' },
                { question: '간편 결제 방법은 무엇인가요?', answer: '카카오페이, 네이버페이 등의 간편 결제 수단을 이용할 수 있습니다.', category: 'payment' },
                { question: '결제 완료 후 영수증을 받을 수 있나요?', answer: '결제 후 영수증은 이메일로 발송됩니다.', category: 'payment' }
            ]
        };

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
