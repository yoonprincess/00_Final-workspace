


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

    // 다중 첨부파일 관련
    const upfileInput = document.getElementById('upfile');
    const fileList = document.getElementById('fileList');

    if (upfileInput) {
        upfileInput.addEventListener('change', function (e) {
            const files = e.target.files;
            const maxFiles = 5;
            const maxSize = 10 * 1024 * 1024; // 10MB in bytes

            // 기존 파일 개수 확인
            const existingFiles = fileList.children.length;

            // 선택된 파일을 하나씩 처리
            for (let i = 0; i < files.length && existingFiles + i < maxFiles; i++) {
                const file = files[i];

                // 파일 크기 체크
                if (file.size > maxSize) {
                    alert(`${file.name}의 크기가 10MB를 초과합니다.`);
                    continue;
                }

                // 파일 형식 체크 (이미지 파일만)
                if (!file.type.startsWith('image/')) {
                    alert(`${file.name}은(는) 이미지 파일이 아닙니다.`);
                    continue;
                }

                const fileItem = document.createElement('div');
                fileItem.className = 'file-item';

                // 파일 크기를 MB 또는 KB 단위로 변환
                const fileSize = file.size > 1024 * 1024
                    ? (file.size / (1024 * 1024)).toFixed(2) + 'MB'
                    : (file.size / 1024).toFixed(2) + 'KB';

                // 이미지 미리보기 생성
                const reader = new FileReader();
                reader.onload = function(e) {
                    fileItem.innerHTML = `
                        <img src="${e.target.result}" alt="${file.name}" class="file-preview">
                        <div class="file-info">
                            <div class="file-name">${file.name}</div>
                            <div class="file-size">${fileSize}</div>
                            <button type="button" class="delete-button">삭제</button>
                        </div>
                    `;

                    // 삭제 버튼 이벤트
                    fileItem.querySelector('.delete-button').addEventListener('click', function() {
                        fileItem.remove();
                    });

                    fileList.appendChild(fileItem);
                }

                reader.readAsDataURL(file); // 파일을 읽어 Data URL로 변환하여 미리보기 표시
            }

            // 최대 파일 개수 초과 시 알림
            if (existingFiles + files.length > maxFiles) {
                alert(`첨부파일은 최대 ${maxFiles}개까지 가능합니다.`);
            }

            // 파일 입력 초기화 (동일한 파일 다시 선택 가능하도록)
            e.target.value = '';
        });
    } else {
        console.error('파일 업로드 input 요소를 찾을 수 없습니다.');
    }
    
    
});


