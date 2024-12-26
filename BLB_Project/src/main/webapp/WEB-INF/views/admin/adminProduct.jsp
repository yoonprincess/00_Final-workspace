<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/admin/adminSide.jsp" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>Beauty Life Balance</title>
        <style>
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
        </style>
    </head>
    <body class="sb-nav-fixed">
        <div id="layoutSidenav">
            <div id="layoutSidenav_content">
                <main>
                    <div class="container-fluid px-4">
                        <h1 class="mt-4">상품 관리</h1>
                        <ol class="breadcrumb mb-4">
                            <li class="breadcrumb-item active"></li>
                        </ol>
                        <div class="card mb-4">
                            <div class="card-header d-flex justify-content-between align-items-center">
                                <div>
                                    <i class="fas fa-table me-1"></i>
                                    전체조회
                                </div>
                                <button id="addProductBtn" class="btn btn-primary btn-sm">
                                    <i class="fas fa-plus me-1"></i> 상품 추가
                                </button>
                            </div>
                            
                            
                            <div class="card-body">
                                <div class="table-responsive">
                                <table class="table table-bordered" id="productTable" width="100%" cellspacing="0">
                                    <thead>
                                        <tr>
                                            <th>번호</th>
                                            <th>카테고리</th>
                                            <th>서브카테고리</th>
                                            <th>상품명</th>
                                            <th>상품설명</th>
                                            <th>상품가격</th>
                                            <th>주요성분</th>
                                            <th>주의사항</th>
                                            <th>재고수량</th>
                                            <th>등록일</th>
                                            <th>상태</th>
                                            <th>썸네일</th>
                                            <th>평점</th>
                                            <th>리뷰수</th>
                                            <th>총판매량</th>
                                            <th>메인배너</th>
                                            <th>MD배너</th>
                                            <th>상세확인</th>
                                            <th>수정</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="p" items="${pList}">
                                            <tr>
                                                <td>${p.prodNo}</td>
                                                <td contenteditable="true">${p.categoryName}</td>
                                                <td contenteditable="true">${p.subcategoryName}</td>
                                                <td contenteditable="true">${p.prodName}</td>
                                                <td contenteditable="true">${p.prodContent}</td>
                                                <td contenteditable="true">${p.prodPrice}</td>
                                                <td contenteditable="true">${p.prodOrigin}</td>
                                                <td contenteditable="true">${p.prodCaution}</td>
                                                <td contenteditable="true">${p.prodCount}</td>
                                                <td><fmt:formatDate value="${p.prodEnrollDate}" pattern="yyyy-MM-dd hh:mm" /></td>
                                                <td contenteditable="true">${p.prodStatus}</td>
                                                <td><img src="${ pageContext.request.contextPath }${p.thumbImg}" alt="thumbImg" style="width: 50px; height: auto;"></td>
                                                <td>${p.avgRating}</td>
                                                <td>${p.reviewCount}</td>
                                                <td>${p.totalSales}</td>
                                                <td><img src="${ pageContext.request.contextPath }${p.bannerImg}" alt="thumbImg" style="width: 50px; height: auto;"></td>
                                                <td><img src="${ pageContext.request.contextPath }${p.mdImg}" alt="thumbImg" style="width: 50px; height: auto;"></td>
                                                <td><button class="detail-btn btn btn-primary btn-sm">상세수정</button></td>
                                                <td><button class="save-btn btn btn-primary btn-sm">저장</button></td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                            </div>
                            
                            
                        </div>
                    </div>
                </main>
            </div>
        </div>

        <!-- 상품 추가 모달 -->
        <div class="modal fade" id="addProductModal" tabindex="-1" aria-labelledby="addProductModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="addProductModalLabel">상품 추가</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <form id="addProductForm" enctype="multipart/form-data">
                        <div class="modal-body">
                            <!-- 상품 정보 입력 -->
                            <div class="mb-3">
                                <label for="categoryName" class="form-label">카테고리</label>
                                <select class="form-control" id="categoryName" name="categoryName" required>
                                    <option value="">카테고리를 선택하세요</option>
                                    <option value="스킨케어">스킨케어</option>
                                    <option value="메이크업">메이크업</option>
                                    <option value="맨즈">맨즈</option>
                                    <option value="헤어/바디">헤어/바디</option>
                                </select>
                            </div>
                            <div class="mb-3">
                                <label for="subcategoryName" class="form-label">서브카테고리</label>
                                <select class="form-control" id="subcategoryName" name="subcategoryName" required>
                                    <option value="">서브카테고리를 선택하세요</option>
                                </select>
                            </div>
                            <div class="mb-3">
                                <label for="prodName" class="form-label">상품명</label>
                                <input type="text" class="form-control" id="prodName" name="prodName" required>
                            </div>
                            <div class="mb-3">
                                <label for="prodContent" class="form-label">상품설명</label>
                                <textarea class="form-control" id="prodContent" 
                                          name="prodContent" rows="3"
                                          style="resize: none;"></textarea>
                            </div>
                            <div class="mb-3">
                                <label for="prodPrice" class="form-label">상품 가격</label>
                                <input type="number" class="form-control" id="prodPrice" name="prodPrice" required>
                            </div>
                            <div class="mb-3">
                                <label for="prodOrigin" class="form-label">원산지</label>
                                <textarea class="form-control" id="prodOrigin" 
                                          name="prodOrigin" rows="3"
                                          style="resize: none;"></textarea>
                            </div>
                            <div class="mb-3">
                                <label for="prodCaution" class="form-label">주의사항</label>
                                <textarea class="form-control" id="prodCaution" 
                                          name="prodCaution" rows="3"
                                          style="resize: none;"></textarea>
                            </div>
                            <!-- 옵션명과 옵션값 -->
                            <div class="mb-3">
                                <label for="options" class="form-label">옵션</label>
                                <div id="optionsContainer">
                                    <div class="d-flex align-items-center mb-2 option-pair">
                                        <input type="text" class="form-control me-2" name="optionNames[]" placeholder="옵션명" required>
                                        <input type="text" class="form-control me-2" name="optionValues[]" placeholder="옵션값" required>
                                        <input type="number" class="form-control me-2" name="optionAddPrices[]" placeholder="옵션추가금액" required>
                                        <button type="button" class="btn btn-outline-primary btn-sm add-option-btn">+</button>
                                    </div>
                                </div>
                            </div>
                            
                            <!-- 첨부파일 -->
                            <div class="mb-3">
                                <label for="prodThumb" class="form-label">썸네일</label>
                                <div class="image-preview-container" id="thumbPreviewContainer">
                                    <div class="add-image" id="addThumbButton">+</div>
                                </div>
                            </div>

                            <!-- 첨부파일 -->
                            <div class="mb-3">
                                <label for="prodImages" class="form-label">상세이미지</label>
                                <div class="image-preview-container" id="imagePreviewContainer">
                                    <div class="add-image" id="addImageButton">+</div>
                                </div>
                            </div>



                        </div>
                        <div class="modal-footer">
                            <button type="submit" class="btn btn-primary">추가</button>
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <!-- 상세보기 모달 -->
        <div class="modal fade" id="viewProductModal" tabindex="-1" aria-labelledby="viewProductModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="viewProductModalLabel">상품 상세 수정</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <form id="viewProductForm" enctype="multipart/form-data">
                        <div class="modal-body">
                            <!-- 상품 정보 수정 -->
                            <div class="mb-3">
                                <label for="viewProdName" class="form-label">상품명</label>
                                <input type="text" class="form-control" id="viewProdName" name="prodName" required>
                            </div>
                            <div class="mb-3">
                                <label for="viewProdPrice" class="form-label">상품 가격</label>
                                <input type="number" class="form-control" id="viewProdPrice" name="prodPrice" required>
                            </div>
                            <div class="mb-3">
                                <label for="viewProdCategory" class="form-label">카테고리</label>
                                <input type="text" class="form-control" id="viewProdCategory" name="prodCategory" required>
                            </div>
                            <!-- 기존 이미지 및 첨부파일 -->
                            <div class="mb-3">
                                <label class="form-label">기존 이미지</label>
                                <div id="existingProdImage"></div>
                            </div>
                            <div class="mb-3">
                                <label for="viewProdFile" class="form-label">새로운 이미지 업로드</label>
                                <input type="file" class="form-control" id="viewProdFile" name="prodFile">
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="submit" class="btn btn-primary">수정</button>
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <script>
            $(document).ready( function () {
                var productTable = $('#productTable').DataTable({
                    order: [[0, 'desc']], // 첫 번째 컬럼(0-indexed)을 내림차순(desc)으로 정렬
                    pageLength: 25, // 기본값: 10
                    lengthMenu: [10, 25, 50, 100],

                });

                // 카테고리와 서브카테고리 데이터
                const categories = {
                    "스킨케어": ["스킨/에센스", "크림/로션", "클렌징", "선케어"],
                    "메이크업": ["립", "베이스", "아이"],
                    "맨즈": ["스킨", "메이크업", "헤어"],
                    "헤어/바디": ["샴푸", "린스", "바디로션"]
                };

                const imagePreviewContainer = $('#imagePreviewContainer');
                const thumbPreviewContainer = $('#thumbPreviewContainer');

                // 카테고리 선택 시 서브카테고리 옵션 업데이트
                $('#categoryName').change(function () {
                    const selectedCategory = $(this).val();
                    const $subcategory = $('#subcategoryName');

                    $subcategory.empty(); // 기존 옵션 제거
                    $subcategory.append('<option value="">서브카테고리를 선택하세요</option>'); // 기본 옵션 추가

                    if (categories[selectedCategory]) {
                        categories[selectedCategory].forEach(function (subcat) {
                            $subcategory.append(`<option value="\${subcat}">\${subcat}</option>`);
                        });
                    }
                });

                // 저장 버튼 클릭 이벤트
                $('#productTable').on('click', '.save-btn', function () {
                    const row = $(this).closest('tr'); // 해당 행 선택
                    const prodData = {
                        prodNo: row.find('td').eq(0).text(),
                        categoryName: row.find('td').eq(1).text(),
                        subcategoryName: row.find('td').eq(2).text(),
                        prodName: row.find('td').eq(3).text(),
                        prodContent: row.find('td').eq(4).text(),
                        prodPrice: parseInt(row.find('td').eq(5).text().trim(), 10) || 0, // 숫자 변환
                        prodOrigin: row.find('td').eq(6).text(),
                        prodCaution: row.find('td').eq(7).text(),
                        prodCount: parseInt(row.find('td').eq(8).text().trim(), 10) || 0, // 숫자 변환
                        prodStatus: row.find('td').eq(10).text()
                    };

                    // AJAX 요청으로 수정된 데이터 전송
                    $.ajax({
                        url: 'update.pr',
                        type: 'POST',
                        contentType: 'application/json',
                        data: JSON.stringify(prodData),
                        success: function (response) {
                            if (response.success) {
                                alert('저장 성공!');
                            } else {
                                alert('저장 실패: ' + response.message);
                            }
                        },
                        error: function () {
                            alert('서버 오류 발생. 다시 시도해주세요.');
                        }
                    });
                });

                // 상품 추가 모달 열기
                $('#addProductBtn').on('click', function () {
                    $('#addProductModal').modal('show');
                });

                // 상품 추가 폼 제출
                $('#addProductForm').on('submit', function (e) {
                    e.preventDefault();
                    const formData = new FormData(this);

                    $.ajax({
                        url: 'insert.pr',
                        type: 'POST',
                        data: formData,
                        processData: false,
                        contentType: false,
                        success: function (response) {
                            if (response.success) {
                                // 성공 메시지
                                alertify.success(response.message);
                                // 일정 시간 후 창 닫기
                                setTimeout(function () {
                                    location.reload(); // 부모 페이지 새로고침
                                }, 1000); // 1초 후 창 닫기
                            } else {
                                // 실패 메시지
                                alertify.error(response.message);
                                // 일정 시간 후 창 닫기
                                setTimeout(function () {
                                    location.reload(); // 부모 페이지 새로고침
                                }, 1000); // 1초 후 창 닫기
                            }
                        },
                        error: function () {
                            alert('서버 오류가 발생했습니다.');
                        }
                    });
                });

                // 상세보기 모달 열기
                $('.viewProductBtn').on('click', function () {
                    const prodNo = $(this).data('prodno');

                    $.ajax({
                        url: `/admin/getProductDetail?prodNo=${prodNo}`,
                        type: 'GET',
                        success: function (response) {
                            if (response.success) {
                                const product = response.data;
                                $('#viewProdName').val(product.prodName);
                                $('#viewProdPrice').val(product.prodPrice);
                                $('#viewProdCategory').val(product.prodCategory);
                                $('#existingProdImage').html(`<img src="${product.thumbImg}" alt="상품 이미지" style="max-width: 100%; height: auto;">`);
                                $('#viewProductModal').modal('show');
                            } else {
                                alert('상품 정보를 불러오지 못했습니다.');
                            }
                        },
                        error: function () {
                            alert('서버 오류가 발생했습니다.');
                        }
                    });
                });

                // 상품 수정 폼 제출
                $('#viewProductForm').on('submit', function (e) {
                    e.preventDefault();
                    const formData = new FormData(this);

                    $.ajax({
                        url: '/admin/updateProduct',
                        type: 'POST',
                        data: formData,
                        processData: false,
                        contentType: false,
                        success: function (response) {
                            if (response.success) {
                                alert('상품이 수정되었습니다.');
                                location.reload();
                            } else {
                                alert('상품 수정 실패: ' + response.message);
                            }
                        },
                        error: function () {
                            alert('서버 오류가 발생했습니다.');
                        }
                    });
                });

                // 썸네일 추가
                $('#addThumbButton').click(function () {
                    const fileInput = $('<input type="file" accept="image/*" class="d-none" name="thumbImages">');
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
                                    $('#addThumbButton').show();
                                });

                                // 미리보기 요소에 이미지와 버튼 추가
                                preview.append(img).append(removeBtn);

                                $('#addThumbButton').before(preview);

                            };
                            reader.readAsDataURL(file); // 파일 읽기 시작
                        }
                    });
                    
                    thumbPreviewContainer.append(fileInput);
                });

                // 이미지 추가
                $('#addImageButton').click(function () {
                    const fileInput = $('<input type="file" accept="image/*" class="d-none" name="detailImages">');
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

                            };
                            reader.readAsDataURL(file); // 파일 읽기 시작
                        }
                    });
                    
                    imagePreviewContainer.append(fileInput);
                });

                // 옵션 추가 버튼 클릭 시 새로운 옵션 입력 필드 추가
                $('#optionsContainer').on('click', '.add-option-btn', function () {
                    const optionHtml = `
                        <div class="d-flex align-items-center mb-2 option-pair">
                            <input type="text" class="form-control me-2" name="optionNames[]" placeholder="옵션명" required>
                            <input type="text" class="form-control me-2" name="optionValues[]" placeholder="옵션값" required>
                            <input type="text" class="form-control me-2" name="optionAddPrices[]" placeholder="옵션추가금액" required>
                            <button type="button" class="btn btn-outline-danger btn-sm remove-option-btn">-</button>
                        </div>`;
                    $('#optionsContainer').append(optionHtml);
                });

                // 옵션 삭제 버튼 클릭 시 해당 옵션 입력 필드 제거
                $('#optionsContainer').on('click', '.remove-option-btn', function () {
                    $(this).closest('.option-pair').remove();
                });

            } );


        </script>
    </body>
</html>
