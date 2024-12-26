<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>공지사항 수정</title>
    <link rel="stylesheet" href="${ pageContext.request.contextPath }/resources/css/helpdesk/NoticeUpdateForm.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body class="body-offset">
<%@ include file="/WEB-INF/views/common/header.jsp" %>
    <div class="container-fluied">
        <div class="container">
            <h2 class="page-title">공지사항 수정</h2>
            
            <form class="edit-form" id="noticeUpdate" name="noticeUpdate" action="NoticeUpdate.no" method="post" enctype="multipart/form-data">
                <div class="form-group">
                    <label for="title">제목</label>
                    <input type="text" id="noticeTitle" name="noticeTitle" class="input-field" value="${ requestScope.n.noticeTitle }">
                </div>

                <div class="form-group">
                    <label for="content">내용</label>
                    <textarea id="content" name="noticeContent" class="input-field textarea">${requestScope.n.noticeContent }</textarea>
                </div>

                <div class="form-group">
                    <label>첨부파일</label>
                    <div class="file-upload-container">
                        <div class="file-preview-grid" id="filePreviewGrid">
                            <c:choose>
                                <c:when test="${ empty requestScope.na }">
                                    <!-- 첨부파일 없음 -->
                                </c:when>
                                <c:otherwise>
                                    <c:forEach var="a" items="${ requestScope.na }">
                                        <div class="file-preview" data-id="${a.saveFileName}">
                                            <img src="${pageContext.request.contextPath }/${ a.savePath }${a.saveFileName}" width="400px" height="400px">
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
                <input type="hidden" name="nno" value="${requestScope.n.noticeNo }">
                <input type="hidden" name="deleteFiles" id="deleteFiles">
                <input type="hidden" name="newFiles" id="newFiles">
                <button type="submit" class="btn btn-primary">수정하기</button>
                <button type="button" class="btn btn-danger" onclick="goBack();">이전으로</button>
            </form>
        </div>
    </div>

    <script>
    $(document).ready(function() {
        // 기존 삭제 요청 파일 저장소
        const deleteFiles = [];
        // 새로 업로드된 파일 저장소
        const newFiles = [];

     // X 버튼 클릭 시 삭제 처리 (이벤트 위임 방식)
        $(document).on("click", ".delete-btn", function () {
            const fileId = $(this).data("file");
            
            // 삭제된 파일 정보를 hidden input에 저장
            deleteFiles.push(fileId);
            $('#deleteFiles').val(deleteFiles.join(","));  // 값 갱신

            // 해당 파일 미리보기 삭제
            $(this).closest(".file-preview").remove();
            
            // 기존 이미지 삭제 로직 추가
            const parent = $(this).closest('.file-preview');
            const fileName = parent.data('file');
            
            // 삭제 대상 파일 추가
            const removeInput = $('<input>')
                .attr('type', 'hidden')
                .attr('name', 'removeFiles')
                .val(fileName);
            $('#noticeUpdate').append(removeInput);

            // 삭제된 파일 추가 후, 버튼 상태 확인
            checkAddButtonVisibility();
        });

        // 추가된 파일이 5개를 넘지 않도록 버튼 상태 업데이트
        function checkAddButtonVisibility() {
            const fileCount = $('#filePreviewGrid .file-preview').length;
            if (fileCount >= 5) {
                $('.file-upload-box').hide();  // 최대 5개 업로드된 경우 버튼 숨김
            } else {
                $('.file-upload-box').show();  // 추가로 파일을 업로드할 수 있는 경우 버튼 보이기
            }
        }


        // 파일 업로드 처리
        $('#upfile').on('change', function() {
            const files = this.files;
            if (files.length > 5) {
                alert("최대 5개의 파일만 업로드할 수 있습니다.");
                return;
            }

            $.each(files, function(index, file) {
                const reader = new FileReader();
                reader.onload = function(e) {
                    const previewDiv = $('<div class="file-preview"></div>');
                    const img = $('<img />').attr('src', e.target.result).attr('width', '400px').attr('height', '400px');
                    const deleteBtn = $('<button type="button" class="delete-btn">×</button>');

                    // 삭제 버튼 클릭 시 동작
                    deleteBtn.on('click', function() {
                        console.log("삭제 버튼 클릭됨");  // 버튼 클릭 여부 확인
                        previewDiv.remove();
                    });

                    previewDiv.append(img).append(deleteBtn);
                    $('#filePreviewGrid').append(previewDiv);
                };
                reader.readAsDataURL(file);

                // 새로 추가된 파일 정보 저장
                newFiles.push(file);
                $('#newFiles').val(newFiles.join(","));
            });
        });

        $('#noticeUpdate').on('submit', function(e) {
            e.preventDefault();

            // 파일 정보 추가
            const formData = new FormData(this);

            // deleteFiles 값을 확인 후 추가
            const deleteFilesValue = $('#deleteFiles').val();
            
            console.log("삭제된 파일들:", deleteFilesValue);  // AJAX 요청 전 삭제 파일 정보 확인
            
            if (deleteFilesValue) {
                formData.append('deleteFiles', deleteFilesValue);  // deleteFiles 추가
            }

            // AJAX 요청으로 폼 데이터 전송
            $.ajax({
                url: 'NoticeUpdate.no',
                type: 'POST',
                data: formData,
                contentType: false,
                processData: false,
                success: function(response) {
                    if (response.success) {
                        alert("공지사항이 수정되었습니다.");
                        window.location.href = "../list.no";  // 수정 완료 후 공지사항 목록으로 이동
                    } else {
                    	window.location.href = "../blb/list.no";
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
        window.history.back();
    }
    </script>
</body>
</html>
