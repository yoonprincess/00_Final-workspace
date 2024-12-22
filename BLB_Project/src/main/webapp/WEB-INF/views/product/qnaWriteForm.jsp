<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
    <title>상품문의 등록</title>
    <!-- jQuery 3.7.1 -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <!-- header CSS -->
    <link rel="stylesheet" href="${ pageContext.request.contextPath }/resources/css/common/header.css">
    <!-- Bootstrap 4.6.2 CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
    <!-- Google Fonts NotoSansKR -->
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&family=Oregano&display=swap" />
    <!-- Google Fonts Icon -->
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
    <!-- awesome Icon -->
	<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" rel="stylesheet">

    <!--  Alertify 라이브러리 연동구문 (CDN) -->
	<!-- JavaScript -->
	<script src="//cdn.jsdelivr.net/npm/alertifyjs@1.14.0/build/alertify.min.js"></script>
	<!-- CSS -->
	<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/alertifyjs@1.14.0/build/css/alertify.min.css"/>
	<!-- Default theme -->
	<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/alertifyjs@1.14.0/build/css/themes/default.min.css"/>
	<!-- Semantic UI theme -->
	<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/alertifyjs@1.14.0/build/css/themes/semantic.min.css"/>

    <style>
        body {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            width: 100%;
            height: 100%;
        }
        /* 컨테이너 스타일 */
        .qna-container {
            width: 100%; /* 부모의 크기를 기준으로 조정 */
            margin: 0 auto; /* 중앙 정렬 */
            border: 1px solid #ddd;
            border-radius: 10px;
            padding: 20px;
            background-color: #fff;
        }

        /* 버튼 스타일 */
        .btn-submit {
            width: 100%;
            background-color: #4A628A;
            color: white;
            border: none;
            padding: 10px 15px;
            font-size: 16px;
            font-weight: bold;
            border-radius: 5px;
            cursor: pointer;
        }
    </style>
</head>
<body>
    <div class="qna-container">
        <!-- 문의 작성 폼 -->
        <form id="qnaWriteForm" action="insert.pqa" method="post" enctype="multipart/form-data">
            <input type="hidden" id="memberId" name="memberId" value="${memberId}">
            <input type="hidden" id="prodNo" name="prodNo" value="${prodNo}">
            <input type="hidden" id="inquiryType" name="inquiryType" value="상품">
            <!-- 문의 작성 -->
            <div class="form-group">
                <label for="inquiryContent">문의 작성란</label>
                <textarea 
                    class="form-control" 
                    id="inquiryContent" 
                    name="inquiryContent" 
                    rows="5" 
                    placeholder="문의 내용을 입력하세요 (최소 10자, 최대 1000자)" 
                    required
                    style="resize: none;"
                ></textarea>
                <small id="charCount" class="form-text text-muted">0 / 1000자</small>
            </div>
    
            <!-- 작성 버튼 -->
            <button type="submit" class="btn-submit">문의 작성하기</button>
        </form>
    </div>

    <script>
        $(document).ready(function () {
            const maxChar = 1000;
            const minChar = 10;

            const imagePreviewContainer = $('#imagePreviewContainer');

            // 글자 수 실시간 체크
            $('#inquiryContent').on('input', function () {
                const textLength = $(this).val().length;
                $('#charCount').text(`\${textLength} / \${maxChar}자`);
                // 글자 수 초과 경고
                if (textLength > maxChar) {
                    $('#charCount').addClass('text-danger');
                } else {
                    $('#charCount').removeClass('text-danger');
                }
            });

            // 글자수 제한 처리 및 ajax 처리 후 창 닫기
            $('#qnaWriteForm').on('submit', function (e) {
                e.preventDefault(); // 기본 폼 제출 방지

                const textLength = $('#inquiryContent').val().length;
                if (textLength < minChar || textLength > maxChar) {
                    alertify.error(`문의는 최소 \${minChar}자, 최대 \${maxChar}자까지 작성 가능합니다.`);
                    return false; // AJAX 요청 중단
                }

                const formData = new FormData(this);

                $.ajax({
                    url: 'insert.pqa',
                    type: 'POST',
                    data: formData,
                    contentType: false,
                    processData: false,
                    success: function (response) {
                        if (response.success) {
                            // 성공 메시지
                            alertify.success(response.message);
                            // 일정 시간 후 창 닫기
                            setTimeout(function () {
                                parent.$('#reviewIframeContainer').hide();
                                parent.location.reload(); // 부모 페이지 새로고침
                            }, 1000); // 1초 후 창 닫기
                        } else {
                            // 실패 메시지
                            alertify.error(response.message);
                            // 일정 시간 후 창 닫기
                            setTimeout(function () {
                                parent.$('#reviewIframeContainer').hide();
                                parent.location.reload(); // 부모 페이지 새로고침
                            }, 1000); // 1초 후 창 닫기
                        }
                    },
                    error: function () {
                        alertify.error("서버 오류가 발생했습니다. 다시 시도해주세요.");
                        // 일정 시간 후 창 닫기
                        setTimeout(function () {
                                parent.$('#reviewIframeContainer').hide();
                                parent.location.reload(); // 부모 페이지 새로고침
                            }, 1000); // 1초 후 창 닫기
                    }
                });
            });
        });
    </script>

    
    <!-- Popper JS -->
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>

    <!-- Bootstrap 4.6.2 JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
    
    <!-- header Javascript -->
    <script src="${ pageContext.request.contextPath }/resources/js/common/header.js"></script>
</body>
</html>
