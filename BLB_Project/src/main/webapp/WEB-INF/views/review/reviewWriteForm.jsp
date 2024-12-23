<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
    <title>리뷰 작성</title>
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
        .review-container {
            width: 100%; /* 부모의 크기를 기준으로 조정 */
            margin: 0 auto; /* 중앙 정렬 */
            border: 1px solid #ddd;
            border-radius: 10px;
            padding: 20px;
            background-color: #fff;
        }

        /* 상품 정보 */
        .product-info {
            display: flex;
            align-items: center;
            margin-bottom: 20px;
        }

        .product-thumbnail {
            width: 80px;
            height: 80px;
            margin-right: 15px;
            border-radius: 8px;
            overflow: hidden;
        }

        .product-thumbnail img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .product-details {
            flex: 1;
        }

        .product-name {
            font-size: 16px;
            font-weight: bold;
            margin-bottom: 5px;
        }

        .product-options {
            font-size: 14px;
            color: #888;
        }

        /* 리뷰 별점 */
        .review-rating {
            display: flex;
            align-items: center;
            margin-bottom: 20px;
        }

        .rating-stars {
            display: flex;
            gap: 5px;
        }

        .rating-stars i {
            font-size: 20px;
            color: #ddd;
            cursor: pointer;
        }

        .rating-stars i.selected {
            color: #f39c12;
        }

        /* 첨부 이미지 */
        .image-preview-container {
            display: flex;
            gap: 10px;
            flex-wrap: wrap;
            margin-bottom: 20px;
        }

        .image-preview {
            position: relative;
            width: 100px;
            height: 100px;
            border: 1px solid #ddd;
            border-radius: 5px;
            overflow: hidden;
            display: flex;
            justify-content: center;
            align-items: center;
            background-color: #f9f9f9;
        }

        .image-preview img {
            display: block !important;
            width: 100% !important;
            height: auto !important;
            object-fit: cover !important;
        }

        .image-preview .remove-btn {
            position: absolute;
            top: 5px;
            right: 5px;
            width: 20px;
            height: 20px;
            background: rgba(0, 0, 0, 0.5);
            color: white;
            border: none;
            border-radius: 50%;
            font-size: 12px;
            cursor: pointer;
        }

        .add-image {
            width: 100px;
            height: 100px;
            border: 1px dashed #ddd;
            border-radius: 5px;
            display: flex;
            justify-content: center;
            align-items: center;
            cursor: pointer;
            background-color: #f9f9f9;
        }

        .add-image:hover {
            background-color: #f1f1f1;
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
    <div class="review-container">
        <!-- 리뷰 작성 폼 -->
        <form id="reviewWriteForm" action="insert.rv" method="post" enctype="multipart/form-data">
            <input type="hidden" id="serialNo" name="serialNo" value="${purchaseOne.serialNo}">
            <input type="hidden" id="memberId" name="memberId" value="${memberId}">
            <input type="hidden" id="prodNo" name="prodNo" value="${prodNo}">
            <!-- 상품 정보 -->
      
            <div class="product-info" onclick="window.open('detail.pr?pno=${prodNo}', '_blank');" style="cursor: pointer;">
                <div class="product-thumbnail">
                    <img src="${ pageContext.request.contextPath }${ purchaseOne.thumbOne }" alt="상품 썸네일">
                </div>
                <div class="product-details">
                    <div class="product-name">${purchaseOne.prodName}</div>
                    <div class="product-options">${purchaseOne.optName} ${purchaseOne.optValue}</div>
                    <div class="product-options text-muted">구매 일자: <fmt:formatDate value="${purchaseOne.orderDate}" pattern="yyyy-MM-dd hh:mm" /></div>
                </div>
            </div>
    
            <!-- 리뷰 별점 -->
            <div class="review-rating">
                <label for="revRating" style="margin-right: 10px;">만족도</label>
                <div class="rating-stars" id="ratingStars">
                    <i class="fas fa-star selected" data-value="1"></i>
                    <i class="fas fa-star selected" data-value="2"></i>
                    <i class="fas fa-star selected" data-value="3"></i>
                    <i class="fas fa-star selected" data-value="4"></i>
                    <i class="fas fa-star selected" data-value="5"></i>
                </div>
            </div>
            <input type="hidden" id="revRating" name="revRating" value="5">
    
            <!-- 리뷰 작성 -->
            <div class="form-group">
                <label for="revContent">리뷰 작성란</label>
                <textarea 
                    class="form-control" 
                    id="revContent" 
                    name="revContent" 
                    rows="5" 
                    placeholder="리뷰 내용을 입력하세요 (최소 10자, 최대 500자)" 
                    required
                    style="resize: none;"
                ></textarea>
                <small id="charCount" class="form-text text-muted">0 / 500자</small>
            </div>
    
            <!-- 첨부 이미지 -->
            <div class="form-group">
                <label>포토 첨부</label>
                <div class="image-preview-container" id="imagePreviewContainer">
                    <div class="add-image" id="addImageButton">+</div>
                </div>
            </div>
    
            <!-- 작성 버튼 -->
            <button type="submit" class="btn-submit">리뷰 작성하고 적립금 받기</button>
        </form>
    </div>

    <script>
        $(document).ready(function () {
            const maxChar = 500;
            const minChar = 10;
            const maxFiles = 4;

            const imagePreviewContainer = $('#imagePreviewContainer');

            // 글자 수 실시간 체크
            $('#revContent').on('input', function () {
                const textLength = $(this).val().length;
                $('#charCount').text(`\${textLength} / \${maxChar}자`);
                // 글자 수 초과 경고
                if (textLength > maxChar) {
                    $('#charCount').addClass('text-danger');
                } else {
                    $('#charCount').removeClass('text-danger');
                }
            });

            // 별점 기본 5점
            // $('#ratingStars i').addClass('selected');

            // 별점 선택
            $('#ratingStars i').on('click', function () {
                const rating = $(this).data('value');
                $('#revRating').val(rating);
                $('#ratingStars i').removeClass('selected');
                $('#ratingStars i').each(function () {
                    if ($(this).data('value') <= rating) {
                        $(this).addClass('selected');
                    }
                });
            });

            // 이미지 추가
            $('#addImageButton').click(function () {
                if ($('.image-preview').length >= maxFiles) {
                    alert('최대 4개의 이미지만 첨부할 수 있습니다.');
                    return;
                }

                const fileInput = $('<input type="file" accept="image/*" class="d-none" name="reviewImages">');
                fileInput.click();
                fileInput.change(function () {
                    const file = this.files[0];
                    if (file) {
                        const reader = new FileReader();
                        reader.onload = function (event) {
                            // 미리보기 요소 생성
                            const preview = $('<div class="image-preview"></div>');
                            const img = $('<img alt="첨부 이미지">').attr('src', event.target.result); // src 설정
                            const removeBtn = $('<button type="button" class="remove-btn">&times;</button>');

                            // Remove 버튼 동작 설정
                            removeBtn.click(function () {
                                preview.remove();
                                fileInput.remove();
                                $('#addImageButton').show();
                            });

                            // 미리보기 요소에 이미지와 버튼 추가
                            preview.append(img).append(removeBtn);

                            $('#addImageButton').before(preview);

                            if ($('.image-preview').length >= maxFiles) {
                                $('#addImageButton').hide();
                            }
                        };
                        reader.readAsDataURL(file); // 파일 읽기 시작
                    }
                });
                
                imagePreviewContainer.append(fileInput);
            });

            // 글자수 제한 처리 및 ajax 처리 후 창 닫기
            $('#reviewWriteForm').on('submit', function (e) {
                e.preventDefault(); // 기본 폼 제출 방지

                const textLength = $('#revContent').val().length;
                if (textLength < minChar || textLength > maxChar) {
                    alertify.error(`리뷰는 최소 \${minChar}자, 최대 \${maxChar}자까지 작성 가능합니다.`);
                    return false; // AJAX 요청 중단
                }

                const formData = new FormData(this);

                $.ajax({
                    url: 'insert.rv',
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
