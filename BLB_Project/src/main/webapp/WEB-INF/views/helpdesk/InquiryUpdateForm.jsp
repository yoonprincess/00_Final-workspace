<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>문의 수정</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/helpdesk/InquiryUpdateForm.css"> <!-- 스타일 시트 링크 -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body class="body-offset">
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<div class="container-fluid">
    <div class="container">
        <h2>문의사항 수정</h2>

        <!-- 상단 내비게이션 -->
        <nav>
            <ul>
                <li><a href="../list.io">목록</a></li>
            </ul>
        </nav>

        <!-- 수정 폼 -->
        <form id="editInquiryForm" name="editInquiryForm" action="InquiryUpdate.io" method="post" enctype="multipart/form-data">
            <input type="hidden" name="inquiryNo" value="${requestScope.i.inquiryNo}" readonly>

            <div class="form-group">
                <label for="prodName">상품명</label>
                <input type="text" id="prodName" name="prodName" value="${requestScope.i.prodName}" readonly>
            </div>

            <div class="form-group">
                <label for="memberId">문의자</label>
                <input type="text" id="memberId" name="memberId" value="${requestScope.i.memberId}" readonly>
            </div>

            <div class="form-group">
                <label for="inquiryCreateDate">문의일</label>
                <input type="text" id="inquiryCreateDate" name="inquiryCreateDate" value="${requestScope.i.inquiryCreateDate}" readonly>
            </div>

            <div class="form-group">
                <label for="inquiryContent">내용</label>
                <textarea id="inquiryContent" name="inquiryContent" rows="5" required>${requestScope.i.inquiryContent}</textarea>
            </div>

            <div class="form-group">
			    <label>첨부파일</label>
			    <div class="file-upload-container">
			        <div class="file-preview-grid" id="filePreviewGrid">
			            <c:choose>
			                <c:when test="${empty requestScope.ia}">
			                    <!-- 첨부파일 없음 -->
			                </c:when>
			                <c:otherwise>
			                    <c:forEach var="a" items="${requestScope.ia}">
			                        <div class="file-preview" data-id="${a.saveFileName}">
			                            <img src="${pageContext.request.contextPath}/${a.savePath}${a.saveFileName}" alt="파일 미리보기" width="400px" height="400px">
			                            <button type="button" class="delete-btn" data-file="${a.saveFileName}">×</button>
			                        </div>
			                    </c:forEach>
			                </c:otherwise>
			            </c:choose>
			        </div>
			        <div class="file-upload-box">
                            <input type="file" id="upfile" name="upfile" accept="image/*" class="file-input">
                            <span class="upload-icon">+</span>
                        </div>
                        <p class="file-info">이미지는 최대 5개까지 업로드 가능합니다.</p>
			    </div>
			</div>
			<input type="hidden" name="ino" value="${requestScope.i.inquiryNo }"/>
            <input type="hidden" name="deleteFiles" id="deleteFiles">
            <input type="hidden" name="removeFiles" id="removeFiles">

            <button type="submit" class="btn btn-primary">수정하기</button>
            <button type="button" class="btn btn-danger" onclick="goBack();">이전으로</button>
        </form>
    </div>
</div>

<script>
$(document).ready(function() {
    // 삭제 및 추가 파일 저장소
    const deleteFiles = [];
    const newFiles = [];

    // 파일 삭제 버튼 클릭 시 처리
    $(document).on("click", ".delete-btn", function () {
        const fileId = $(this).data("file");
        
        deleteFiles.push(fileId);
        $('#deleteFiles').val(deleteFiles.join(","));
        
        $(this).closest(".file-preview").remove();
        
        // 기존 이미지 삭제 로직 추가
        const parent = $(this).closest('.file-preview');
        const fileName = parent.data('file');
        
        // 삭제 대상 파일 추가
        const removeInput = $('<input>')
            .attr('type', 'hidden')
            .attr('name', 'removeFiles')
            .val(fileName);
        $('#editInquiryForm').append(removeInput);
        
        checkAddButtonVisibility();
    });

    // 추가된 파일이 5개를 넘지 않도록 버튼 상태 업데이트
    function checkAddButtonVisibility() {
        const fileCount = $('#filePreviewGrid .file-preview').length;
        if (fileCount >= 5) {
            $('.file-upload-box').hide();
        } else {
            $('.file-upload-box').show();
        }
    }

    // 파일 선택 시 미리보기 추가
    $('#fileInput').on('change', function() {
        const files = this.files;
        const currentFileCount = $('#filePreviewGrid .file-preview').length;

        if (currentFileCount + files.length > 5) {
            alert("최대 5개의 파일만 업로드할 수 있습니다.");
            return;
        }

        $.each(files, function(index, file) {
            const reader = new FileReader();
            reader.onload = function(e) {
                const previewDiv = $('<div class="file-preview"></div>');
                const img = $('<img />').attr('src', e.target.result).attr('width', '400px').attr('height', '400px');
                const deleteBtn = $('<button type="button" class="delete-btn">×</button>');

                previewDiv.append(img).append(deleteBtn);
                $('#filePreviewGrid').append(previewDiv);
            };
            reader.readAsDataURL(file);

            newFiles.push(file);
        });

        checkAddButtonVisibility();
    });

    // 폼 제출 처리
    $('#editInquiryForm').on('submit', function(e) {
        e.preventDefault();

        const formData = new FormData(this);

        // 삭제된 파일 추가
        const deleteFilesValue = $('#deleteFiles').val();
        if (deleteFilesValue) {
            formData.append('deleteFiles', deleteFilesValue);
        }

        // 새로 업로드된 파일 추가
        $.each(newFiles, function(index, file) {
            formData.append('newFiles', file);
        });

        // AJAX 요청으로 폼 데이터 전송
        $.ajax({
            url: 'InquiryUpdate.io',
            type: 'POST',
            data: formData,
            contentType: false,
            processData: false,
            success: function(response) {
                if (response.success) {
                    alert("문의사항이 수정되었습니다.");
                    window.location.href = "../list.io";
                } else {
                    window.location.href = "../blb/list.io";
                }
            },
            error: function() {
                alert("서버 오류가 발생했습니다. 다시 시도해주세요.");
            }
        });
    });
});

// 이전 페이지로 돌아가기
function goBack() {
   history.back();
}

</script>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>
