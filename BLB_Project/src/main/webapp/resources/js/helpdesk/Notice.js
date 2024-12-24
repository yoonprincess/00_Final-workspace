$(function() {
	
	$("#noticeList>tbody>tr").click(function() {
		
		let nno = $(this).children(".nno").text();
		location.href = "notice/" + nno;
	});
});

// 관리자 확인 및 버튼 표시 로직
        const isAdmin = localStorage.getItem('userId') === 'admin';
        const adminControls = document.getElementById('adminControls');
        if (isAdmin) {
            adminControls.style.display = 'flex';
        }
        
        function goList(){
            location.href="../list.no";
        }

const fileInput = document.getElementById('files');
        const fileList = document.getElementById('fileList');
        let files = [];

        fileInput.addEventListener('change', function(e) {
            const newFiles = Array.from(e.target.files);
            
            if (files.length + newFiles.length > 5) {
                alert('최대 5개의 파일만 첨부할 수 있습니다.');
                return;
            }

            files = [...files, ...newFiles];
            updateFileList();
        });

        function updateFileList() {
            fileList.innerHTML = '';
            files.forEach((file, index) => {
                const fileItem = document.createElement('div');
                fileItem.className = 'file-item';
                fileItem.innerHTML = `
                    <span>${file.name}</span>
                    <button type="button" onclick="removeFile(${index})">삭제</button>
                `;
                fileList.appendChild(fileItem);
            });
        }

        function removeFile(index) {
            files = files.filter((_, i) => i !== index);
            updateFileList();
        }

        document.getElementById('noticeForm').addEventListener('submit', function(e) {
            e.preventDefault();
            // 여기에 폼 제출 로직 추가
            console.log('제목:', document.getElementById('title').value);
            console.log('내용:', document.getElementById('content').value);
            console.log('첨부파일:', files);
        });