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
            /* contenteditable 속성을 가진 셀 스타일 */
            td[contenteditable="true"] {
                background-color: #f9f9f9; /* 연한 배경색 */
                border: 1px solid #ccc; /* 테두리 */
                outline: none; /* 포커스 시 기본 외곽선 제거 */
                padding: 5px; /* 내부 여백 */
                cursor: text; /* 텍스트 편집 커서 */
            }

            /* contenteditable 셀이 포커스를 받을 때 스타일 */
            td[contenteditable="true"]:focus {
                background-color: #fffbe6; /* 포커스 시 배경색 */
                border: 1px solid #f1c40f; /* 포커스 시 테두리 */
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
        </style>
    </head>
    <body class="sb-nav-fixed">
        <div id="layoutSidenav">
            <div id="layoutSidenav_content">
                <main>
                    <div class="container-fluid px-4">
                        <h1 class="mt-4">옵션 및 재고관리</h1>
                        <ol class="breadcrumb mb-4">
                            <li class="breadcrumb-item active"></li>
                        </ol>
                        <div class="card mb-4">
                            <div class="card-header d-flex justify-content-between align-items-center">
                                <div>
                                    <i class="fas fa-table me-1"></i>
                                    전체조회
                                </div>
                                <!-- <button id="addProductBtn" class="btn btn-primary btn-sm">
                                    <i class="fas fa-plus me-1"></i> 상품 추가
                                </button> -->
                            </div>
                            
                            
                            <div class="card-body">
                                <div class="table-responsive">
                                <table class="table table-bordered" id="productTable" width="100%" cellspacing="0">
                                    <thead>
                                        <tr>
                                            <th>상품번호</th>
                                            <th>상품명</th>
                                            <th>상품원가</th>
                                            <th>옵션번호</th>
                                            <th>옵션명</th>
                                            <th>옵션값</th>
                                            <th>옵션추가금액</th>
                                            <th>옵션수량</th>
                                            <th>수정</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="o" items="${oList}">
                                            <tr>
                                                <td>${o.prodNo}</td>
                                                <td>${o.prodName}</td>
                                                <td>${o.prodPrice}</td>
                                                <td>${o.optNo}</td>
                                                <td contenteditable="true">${o.optName}</td>
                                                <td contenteditable="true">${o.optValue}</td>
                                                <td contenteditable="true">${o.optAddPrice}</td>
                                                <td contenteditable="true">${o.remainQty}</td>
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

        
        <script>
            $(document).ready( function () {
                var productTable = $('#productTable').DataTable({
                    order: [[0, 'desc']], // 첫 번째 컬럼(0-indexed)을 내림차순(desc)으로 정렬
                    pageLength: 25, // 기본값: 10
                    lengthMenu: [10, 25, 50, 100]
                });

                // 저장 버튼 클릭 이벤트
                $('#productTable').on('click', '.save-btn', function () {
                    const row = $(this).closest('tr'); // 해당 행 선택
                    const prodData = {
                        optNo: parseInt(row.find('td').eq(3).text().trim(), 10) || 0, // 숫자 변환
                        optName: row.find('td').eq(4).text(),
                        optValue: row.find('td').eq(5).text(),
                        optAddPrice: parseInt(row.find('td').eq(6).text().trim(), 10) || 0, // 숫자 변환
                        remainQty: parseInt(row.find('td').eq(7).text().trim(), 10) || 0 // 숫자 변환
                    };

                    // AJAX 요청으로 수정된 데이터 전송
                    $.ajax({
                        url: 'update.opt',
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

            } );


        </script>
    </body>
</html>
