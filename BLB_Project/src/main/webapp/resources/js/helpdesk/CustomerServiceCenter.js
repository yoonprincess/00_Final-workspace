const receiveEmailCheckbox = document.getElementById('receive-email');
const emailInput = document.getElementById('email');

receiveEmailCheckbox.addEventListener('change', () => {
emailInput.disabled = !receiveEmailCheckbox.checked; // 이메일 입력 필드 활성화/비활성화

if (!emailInput.disabled) {
    emailInput.style.borderColor = '#ddd'; // 기본 테두리로 복원
    const errorMsg = emailInput.nextElementSibling;
    if (errorMsg && errorMsg.classList.contains('error-message')) {
        errorMsg.remove();
    }
} else {
    emailInput.value = ''; // 체크박스를 해제하면 이메일 입력값을 초기화
    emailInput.style.borderColor = '#ddd'; // 이메일 테두리 색상 초기화
    const errorMsg = emailInput.nextElementSibling;
    if (errorMsg && errorMsg.classList.contains('error-message')) {
        errorMsg.remove(); // 오류 메시지도 제거
    }
}
});


// 입력 필드 수정 시 테두리 색상 및 오류 메시지 제거
document.querySelectorAll('input, textarea, select').forEach(field => {
    field.addEventListener('input', () => {
        field.style.borderColor = '#ddd'; // 기본 테두리로 복원
        const errorMsg = field.nextElementSibling;
        if (errorMsg && errorMsg.classList.contains('error-message')) {
            errorMsg.remove();
        }
    });
});

function validateForm() {
    const category = document.getElementById('category');
    const content = document.getElementById('content');
    let isValid = true;

    // 필드 초기화
    const resetField = (field) => {
        field.style.borderColor = '#ddd';
        const errorMsg = field.nextElementSibling;
        if (errorMsg && errorMsg.classList.contains('error-message')) {
            errorMsg.remove();
        }
    };

    const showError = (field, message) => {
        field.style.borderColor = 'red';
        if (!field.nextElementSibling || !field.nextElementSibling.classList.contains('error-message')) {
            const errorMsg = document.createElement('p');
            errorMsg.className = 'error-message';
            errorMsg.style.color = 'red';
            errorMsg.style.fontSize = '12px';
            errorMsg.textContent = message;
            field.parentElement.appendChild(errorMsg);
        }
    };

    // 문의유형
    resetField(category);
    if (category.value === '카테고리를 선택해주세요') {
        showError(category, '문의유형을 선택해주세요.');
        isValid = false;
    }

    // 문의내용
    resetField(content);
    if (content.value.trim() === '') {
        showError(content, '문의내용을 입력해주세요.');
        isValid = false;
    }

    // 이메일
    if (receiveEmailCheckbox.checked) {
        resetField(emailInput);
        const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        if (emailInput.value.trim() === '' || !emailRegex.test(emailInput.value.trim())) {
            showError(emailInput, '유효한 이메일 주소를 입력해주세요.');
            isValid = false;
        }
    }

    return isValid;
}

function submitForm() {
    if (validateForm()) {
        alert('문의가 접수되었습니다.');
        // 추가적인 서버 전송 로직 여기에 작성
    }
}

function resetForm() {
    document.getElementById('category').value = '카테고리를 선택해주세요';
    document.getElementById('content').value = '';
    document.getElementById('email').value = '';
    document.getElementById('file-list').innerHTML = '';
    document.getElementById('file-count').textContent = '0/3';
    document.getElementById('receive-email').checked = false;
    emailInput.disabled = true;
    const errorMessages = document.querySelectorAll('.error-message');
    errorMessages.forEach(msg => msg.remove());
}

const fileUploadBtn = document.getElementById('file-upload-btn');
const fileCountSpan = document.getElementById('file-count');
const maxFiles = 3;
const fileInput = document.createElement('input');
fileInput.type = 'file';
fileInput.accept = 'image/*';
fileInput.multiple = false; // 한 번에 하나의 파일만 선택
fileInput.style.display = 'none'; // 파일 입력 숨김 처리
document.body.appendChild(fileInput); // body에 추가하여 사용

const fileList = document.getElementById('file-list');
let uploadedFiles = []; // 업로드된 파일 목록
let selectedFileIndex = -1; // 교체할 파일 인덱스

// + 버튼을 클릭하면 파일 입력창을 열기
fileUploadBtn.addEventListener('click', () => {
    fileInput.click(); // 파일 선택창 열기
});

fileInput.addEventListener('change', () => {
    const file = fileInput.files[0]; // 선택한 파일

    if (!file) return; // 파일이 선택되지 않으면 종료

    // 파일 갯수 제한
    if (uploadedFiles.length >= maxFiles && selectedFileIndex === -1) {
        alert(`최대 ${maxFiles}개의 파일만 업로드할 수 있습니다.`);
        fileInput.value = ''; // 파일 선택 초기화
        return;
    }

    // 이미지 파일만 업로드 가능
    if (!file.type.startsWith('image/')) {
        alert('이미지 파일만 업로드할 수 있습니다.');
        fileInput.value = ''; // 파일 선택 초기화
        return;
    }

    // 교체할 파일이 선택되었으면 기존 파일을 교체
    if (selectedFileIndex !== -1) {
        uploadedFiles[selectedFileIndex] = file; // 기존 파일 교체
        selectedFileIndex = -1; // 교체 모드 초기화
    } else {
        uploadedFiles.push(file); // 새 파일 추가
    }

    updateFileList(); // 파일 목록 업데이트
    fileInput.value = ''; // 파일 입력 초기화
});

// 파일 목록 업데이트
function updateFileList() {
    fileList.innerHTML = ''; // 기존 목록 초기화
    uploadedFiles.forEach((file, index) => {
        const fileItem = document.createElement('div');
        fileItem.className = 'file-item';
        fileItem.innerHTML = `
            <img src="${URL.createObjectURL(file)}" alt="썸네일" />
            <span>${file.name}</span>
            <button type="button">X</button>
        `;

        // 파일 클릭 시 해당 파일을 교체
        fileItem.addEventListener('click', () => {
            selectedFileIndex = index; // 교체할 파일 인덱스 저장
            fileInput.click(); // 새 파일 선택 창 열기
        });

        // "X" 버튼을 눌러 파일 삭제
        fileItem.querySelector('button').addEventListener('click', (e) => {
            e.stopPropagation(); // 이벤트 전파 막기
            uploadedFiles.splice(index, 1); // 파일 배열에서 삭제
            updateFileList(); // 화면에서 삭제된 파일 목록 업데이트
            updateFileCount(); // 파일 갯수 업데이트
        });

        fileList.appendChild(fileItem);
    });
    updateFileCount(); // 파일 갯수 업데이트
}

// 파일 갯수 업데이트 함수
function updateFileCount() {
    const currentFileCount = uploadedFiles.length;
    fileCountSpan.textContent = `${currentFileCount}/${maxFiles}`;
}

document.addEventListener('DOMContentLoaded', function() {
const tabButtons = document.querySelectorAll('.tab-button');
const tabContents = document.querySelectorAll('.tab-content');
const faqSubTabs = document.querySelectorAll('#faq .sub-tab-button');
const noticeSubTabs = document.querySelectorAll('#notice .sub-tab-button');
const faqList = document.querySelector('.faq-list');
const noticeTable = document.querySelector('#notice-table tbody');
const loginMessage = document.querySelector('#login-message');
const inquiryList = document.querySelector('#inquiry-list');
const loginButton = document.querySelector('#login-button');
const myInquiries = document.querySelector('#my-inquiries');
const pagination = document.querySelector('.pagination');

let isLoggedIn = false; // 로그인 상태를 추적합니다.

// 메인 탭 전환
tabButtons.forEach(button => {
button.addEventListener('click', () => {
    tabButtons.forEach(btn => btn.classList.remove('active'));
    tabContents.forEach(content => content.classList.remove('active'));
    button.classList.add('active');
    document.querySelector(`#${button.dataset.tab}`).classList.add('active');

    if (button.dataset.tab === 'inquiry') {
        if (isLoggedIn) {
            loginMessage.style.display = 'none';
            inquiryList.style.display = 'block';
            loadMyInquiries();
        } else {
            loginMessage.style.display = 'block';
            inquiryList.style.display = 'none';
        }
    }
});
});

// FAQ 서브탭 전환 및 토글
faqSubTabs.forEach(button => {
button.addEventListener('click', () => {
    faqSubTabs.forEach(btn => btn.classList.remove('active'));
    button.classList.add('active');
    loadFAQs(button.dataset.category);
});
});

// 공지사항 서브탭 전환
noticeSubTabs.forEach(button => {
button.addEventListener('click', () => {
    noticeSubTabs.forEach(btn => btn.classList.remove('active'));
    button.classList.add('active');
    loadNotices(button.dataset.category);
});
});

// FAQ 로드 및 토글 기능
function loadFAQs(category) {
const faqs = [
    { question: '배송은 얼마나 걸리나요?', answer: '일반적으로 2-3일 소요됩니다.', category: 'delivery' },
    { question: '반품 절차는 어떻게 되나요?', answer: '고객센터로 연락 주시면 안내해 드리겠습니다.', category: 'order' },
    { question: '결제 방법은 어떤 것이 있나요?', answer: '신용카드, 무통장입금, 간편결제 등이 가능합니다.', category: 'payment' },
];

faqList.innerHTML = '';

faqs.filter(faq => category === 'all' || faq.category === category).forEach(faq => {
    const faqItem = document.createElement('div');
    faqItem.classList.add('faq-item');
    faqItem.innerHTML = `
        <div class="faq-question">${faq.question}</div>
        <div class="faq-answer">${faq.answer}</div>
    `;
    faqItem.querySelector('.faq-question').addEventListener('click', () => {
        // 열려있는 답변을 모두 닫기
        const allAnswers = document.querySelectorAll('.faq-answer');
        allAnswers.forEach(answer => {
            if (answer !== faqItem.querySelector('.faq-answer')) {
                answer.style.display = 'none';
            }
        });
        // 현재 클릭한 답변만 토글
        const answer = faqItem.querySelector('.faq-answer');
        answer.style.display = answer.style.display === 'block' ? 'none' : 'block';
    });
    faqList.appendChild(faqItem);
});
}


// 공지사항 로드
function loadNotices(category) {
const notices = [
    { id: 1, category: 'general', content: '공지사항 내용 1', date: '2024-11-01' },
    { id: 2, category: 'store', content: '매장 공지사항 내용 1', date: '2024-11-02' },
    { id: 3, category: 'event', content: '이벤트 공지사항 내용 1', date: '2024-11-03' },
];

noticeTable.innerHTML = '';

notices.filter(notice => category === 'all' || notice.category === category).forEach(notice => {
    const row = document.createElement('tr');
    row.innerHTML = `
        <td>${notice.id}</td>
        <td>${notice.category}</td>
        <td>${notice.content}</td>
        <td>${notice.date}</td>
    `;
    noticeTable.appendChild(row);
});
}

// 로그인 후 문의내역 로드
function loadMyInquiries() {
const inquiries = [
    { id: 1, subject: '상품 문의', date: '2024-11-01' },
    { id: 2, subject: '배송 문의', date: '2024-11-02' },
];

myInquiries.innerHTML = '';
inquiries.forEach(inquiry => {
    const listItem = document.createElement('li');
    listItem.textContent = `${inquiry.subject} - ${inquiry.date}`;
    myInquiries.appendChild(listItem);
});
}

// 초기 로드
loadFAQs('all');
loadNotices('all');
});