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
                            <div class="card-header">
                                <i class="fas fa-table me-1"></i>
                                전체조회
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
                                            <th>원산지</th>
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
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="p" items="${pList}">
                                            <tr>
                                                <td>${p.prodNo}</td>
                                                <td>${p.categoryName}</td>
                                                <td>${p.subcategoryName}</td>
                                                <td>${p.prodName}</td>
                                                <td>${p.prodContent}</td>
                                                <td>${p.prodPrice}</td>
                                                <td>${p.prodOrigin}</td>
                                                <td>${p.prodCaution}</td>
                                                <td>${p.prodCount}</td>
                                                <td>${p.prodEnrollDate}</td>
                                                <td>${p.prodStatus}</td>
                                                <td>${p.thumbImg}</td>
                                                <td>${p.avgRating}</td>
                                                <td>${p.reviewCount}</td>
                                                <td>${p.totalSales}</td>
                                                <td>${p.bannerImg}</td>
                                                <td>${p.mdImg}</td>
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
                $('#productTable').DataTable();
            } );
        </script>
    </body>
</html>
