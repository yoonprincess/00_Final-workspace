document.addEventListener('DOMContentLoaded', function () {
    const tabButtons = document.querySelectorAll('.tab-button');
    const receiveEmailCheckbox = document.getElementById('receive-email');
    const emailInput = document.getElementById('email');

    // 탭 전환 처리
    tabButtons.forEach(button => {
        button.addEventListener('click', (event) => {
            // event.preventDefault(); // 페이지 이동을 원하시면 이 줄을 제거하세요.
            
            // 모든 탭에서 active 클래스를 제거
            tabButtons.forEach(btn => btn.classList.remove('active'));
            
            // 클릭한 탭에 active 클래스 추가
            button.classList.add('active');

            // 해당 탭에 맞는 콘텐츠를 표시하도록 처리 (필요에 따라)
            // 예: 
            // document.getElementById('faq-content').style.display = 'block';
            // document.getElementById('inquiry-content').style.display = 'none';
            // document.getElementById('notice-content').style.display = 'none';
        });
    });

    // 이메일 수신 여부 체크박스 처리
    receiveEmailCheckbox.addEventListener('change', () => {
        emailInput.disabled = !receiveEmailCheckbox.checked;

        if (!emailInput.disabled) {
            emailInput.style.borderColor = '#ddd';
            const errorMsg = emailInput.nextElementSibling;
            if (errorMsg && errorMsg.classList.contains('error-message')) {
                errorMsg.remove();
            }
        } else {
            emailInput.value = '';
            emailInput.style.borderColor = '#ddd';
            const errorMsg = emailInput.nextElementSibling;
            if (errorMsg && errorMsg.classList.contains('error-message')) {
                errorMsg.remove();
            }
        }
    });

    // 입력 필드 수정 시 테두리 색상 및 오류 메시지 제거
    document.querySelectorAll('input, textarea, select').forEach(field => {
        field.addEventListener('input', () => {
            field.style.borderColor = '#ddd';
            const errorMsg = field.nextElementSibling;
            if (errorMsg && errorMsg.classList.contains('error-message')) {
                errorMsg.remove();
            }
        });
    });

    // 양식 검증
    function validateForm() {
        const category = document.getElementById('category');
        const content = document.getElementById('content');
        let isValid = true;

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

        // 문의유형 검증
        resetField(category);
        if (category.value === '카테고리를 선택해주세요') {
            showError(category, '문의유형을 선택해주세요.');
            isValid = false;
        }

        // 문의내용 검증
        resetField(content);
        if (content.value.trim() === '') {
            showError(content, '문의내용을 입력해주세요.');
            isValid = false;
        }

        // 이메일 검증
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

    // 양식 제출 처리
    document.querySelector('.submit').addEventListener('click', () => {
        if (validateForm()) {
            alert('문의가 접수되었습니다.');
            // 서버 전송 로직 추가
        }
    });

    // 파일 업로드 처리
    const fileUploadBtn = document.getElementById('file-upload-btn');
    const fileCountSpan = document.getElementById('file-count');
    const maxFiles = 3;
    const fileInput = document.createElement('input');
    fileInput.type = 'file';
    fileInput.accept = 'image/*';
    fileInput.multiple = false;
    fileInput.style.display = 'none';
    document.body.appendChild(fileInput);

    const fileList = document.getElementById('file-list');
    let uploadedFiles = [];
    let selectedFileIndex = -1;

    fileUploadBtn.addEventListener('click', () => {
        fileInput.click();
    });

    fileInput.addEventListener('change', () => {
        const file = fileInput.files[0];
        if (!file) return;

        if (uploadedFiles.length >= maxFiles && selectedFileIndex === -1) {
            alert(`최대 ${maxFiles}개의 파일만 업로드할 수 있습니다.`);
            fileInput.value = '';
            return;
        }

        if (!file.type.startsWith('image/')) {
            alert('이미지 파일만 업로드할 수 있습니다.');
            fileInput.value = '';
            return;
        }

        if (selectedFileIndex !== -1) {
            uploadedFiles[selectedFileIndex] = file;
            selectedFileIndex = -1;
        } else {
            uploadedFiles.push(file);
        }

        updateFileList();
        fileInput.value = '';
    });

    function updateFileList() {
        fileList.innerHTML = '';
        uploadedFiles.forEach((file, index) => {
            const fileItem = document.createElement('div');
            fileItem.className = 'file-item';
            fileItem.innerHTML = `
                <img src="${URL.createObjectURL(file)}" alt="썸네일" />
                <span>${file.name}</span>
                <button type="button">X</button>
            `;

            fileItem.addEventListener('click', () => {
                selectedFileIndex = index;
                fileInput.click();
            });

            fileItem.querySelector('button').addEventListener('click', (e) => {
                e.stopPropagation();
                uploadedFiles.splice(index, 1);
                updateFileList();
                updateFileCount();
            });

            fileList.appendChild(fileItem);
        });
        updateFileCount();
    }

    function updateFileCount() {
        const currentFileCount = uploadedFiles.length;
        fileCountSpan.textContent = `${currentFileCount}/${maxFiles}`;
    }
});
