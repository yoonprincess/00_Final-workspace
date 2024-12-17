<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
            <h2 class="page-title">공지사항</h2>
            
            <form class="edit-form" id="noticeUpdate" name="noticeUpdate" action="NoticeUpdate.no" method="post" enctype="multipart/form-data">
                <div class="form-group">
                    <label for="title">제목</label>
                    <input type="text" id="title" name="title" class="input-field" value="${ requestScope.n.noticeTitle }">
                </div>

                <div class="form-group">
                    <label for="content">내용</label>
                    <textarea id="content" name="content" class="input-field textarea">${requestScope.n.noticeContent }</textarea>
                </div>

                <div class="form-group">
                    <label>첨부파일</label>
                    <div class="file-upload-container">
                        <div class="file-preview-grid" id="filePreviewGrid">
                            <c:choose>
                                <c:when test="${ empty requestScope.na }">
                                    첨부파일이 없습니다.
                                </c:when>
                                <c:otherwise>
                                    <c:forEach var="a" items="${ requestScope.na }">
                                        <div class="file-preview" data-id="${a.saveFileName}">
                                            <img src="${pageContext.request.contextPath }/${ a.savePath }${a.saveFileName}" width="400px" height="400px">
                                            <button type="button" class="delete-btn" data-saveFileName="${a.saveFileName}">×</button>
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
                 <button type="submit" class="btn btn-primary">수정하기</button>
                    <button type="button" class="btn btn-danger" onclick="goBack();">이전으로</button>
            </form>
        </div>
    </div>

    <script>
 // 임시 삭제 저장소 배열 (기존 파일)
    const tempDeleteStorage = [];

    // 새로 업로드된 파일 저장소
    const newFileStorage = [];

    // X 버튼 클릭 시 파일 삭제 처리
    $(document).on("click", ".delete-btn", function () {
        const fileId = $(this).data("saveFileName"); // 파일의 식별자 (saveFileName 사용)

        // 삭제 대상이 기존 파일인지 새로 업로드된 파일인지 확인
        if (newFileStorage.includes(fileId)) {
            // 새로 업로드된 파일일 경우
            newFileStorage.splice(newFileStorage.indexOf(fileId), 1); // 새 파일 저장소에서 제거
        } else {
            // 기존 파일일 경우
            if (!tempDeleteStorage.includes(fileId)) {
                tempDeleteStorage.push(fileId); // 임시 삭제 저장소에 추가
            }
        }

        // 화면에서 미리보기 삭제
        $(this).closest(".file-preview").remove();

        console.log("삭제 예정 파일 리스트:", tempDeleteStorage); // 디버깅용
        console.log("새 파일 저장소:", newFileStorage); // 디버깅용
    });

    // 새 파일 업로드 처리
    $(document).on("change", ".file-input", function () {
        const fileInput = this;
        const files = fileInput.files;

        if (files.length > 0) {
            for (let i = 0; i < files.length; i++) {
                const file = files[i];
                const fileId = Date.now() + "_" + file.name; // 유니크한 식별자 생성

                // 새 파일 미리보기 추가
                const reader = new FileReader();
                reader.onload = function (e) {
                    const previewHtml = `
                        <div class="file-preview" data-id="${fileId}">
                            <img src="${e.target.result}" width="400px" height="400px">
                            <button type="button" class="delete-btn" data-id="${fileId}">×</button>
                        </div>`;
                    $("#filePreviewGrid").append(previewHtml);
                };
                reader.readAsDataURL(file);

                // 새 파일 저장소에 추가
                newFileStorage.push(fileId);
            }

            // 파일 input 초기화
            $(fileInput).val("");
        }

        console.log("새 파일 저장소:", newFileStorage); // 디버깅용
    });

    // 폼 제출 시 삭제 파일 리스트와 새 파일 리스트를 숨겨진 input에 추가
    $("#noticeUpdate").on("submit", function () {
        // 기존 파일 삭제 목록 추가
        if (tempDeleteStorage.length > 0) {
            const hiddenDeleteInput = $("<input>")
                .attr("type", "hidden")
                .attr("name", "deleteFiles")
                .val(tempDeleteStorage.join(",")); // 배열을 콤마로 연결
            $(this).append(hiddenDeleteInput);
        }

        // 새로 추가된 파일 목록 추가
        if (newFileStorage.length > 0) {
            const hiddenNewInput = $("<input>")
                .attr("type", "hidden")
                .attr("name", "newFiles")
                .val(newFileStorage.join(",")); // 배열을 콤마로 연결
            $(this).append(hiddenNewInput);
        }
    });


    // 목록으로 돌아가기
    function goBack() {
        window.history.back();
    }
</script>

<script src="${ pageContext.request.contextPath }/resources/js/helpdesk/NoticeUpdateForm.js"></script>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>
