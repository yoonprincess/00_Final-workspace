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
        <title></title>
        <style>
            /* 클릭할 때마다 색상이 변하도록 스타일 추가 */
            tr:hover {
                cursor: pointer;
                background-color: #f1f1f1;
            }
        </style>
    </head>
    <body class="sb-nav-fixed">
        <div id="layoutSidenav">
            <div id="layoutSidenav_content">
                <main>
                    <div class="container-fluid px-4">
                        <h1 class="mt-4">관리페이지</h1>
                        <ol class="breadcrumb mb-4">
                            <li class="breadcrumb-item active"></li>
                        </ol>
                        <div class="card mb-4">
                            <div class="card-header">
                                <i class="fas fa-table me-1"></i>
                                문의글 전체조회
                            </div>
                            <div class="card-body">
                                <table id="datatablesSimple">
                                    <thead>
                                        <tr>
                                            <th>글번호</th>
                                            <th>제목</th>
                                            <th>내용</th>
                                            <th>분류</th>
                                            <th>게시여부</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                       <c:forEach var="f" items="${fList}">
                                            <tr data-faq-no="${f.faqNo}">
                                               <td contenteditable="true">${f.faqNo}</td>
                                               <td contenteditable="true">${f.faqTitle}</td>
                                               <td contenteditable="true">${f.faqContent}</td>
                                               <td contenteditable="true">${f.faqType}</td>
                                               <td contenteditable="true">${f.faqStatus}</td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div> 
                        </div>
                    </div>
                </main>
            </div>
        </div>
        <script>
            // 테이블의 행을 클릭했을 때 디테일 페이지로 이동
            $(document).on("click", "#datatablesSimple tbody tr", function() {
                const faqNo = $(this).data("faq-no"); // 클릭한 행의 faqNo 가져오기
                // 디테일 페이지로 이동
                window.location.href = "list.fo";
            });
        </script>
    </body>
</html>
