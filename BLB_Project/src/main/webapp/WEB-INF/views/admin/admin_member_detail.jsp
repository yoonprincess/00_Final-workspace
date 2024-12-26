<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
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
                    <div class="container-fluid">
                        <!-- Page Heading -->
                        <h1 class="h3 mb-2 text-gray-800">Admin-회원관리</h1>
                        <p class="mb-4">뷰라밸 상세정보</p>
                        <!-- DataTales Example -->
                        <div class="card shadow mb-4">
                            <div class="card-header py-3">
                                <span class="m-0 font-weight-bold text-primary">회원 상세조회</span>
                            </div>
                            <div class="card-body">
                                <div class="table-responsive">
                                    <table class="table table-bordered" id="dataTable1" width="100%" cellspacing="0">
                                        <thead align="center">
                                            <tr>
                                                <th>아이디</th>
                                                <th>이름</th>
                                                <th>전화번호</th>
                                                <th>주소</th>
                                                <th>생일</th>
                                                <th>가입일</th>
                                                <th>탈퇴일</th>
                                                <th>총 적립금</th>
                                                <th>회원등급</th>
                                                <th>SNS 아이디</th>
                                                <th>가입 종류</th>
                                                <th>탈퇴여부</th>
                                            </tr>
                                        </thead>
                                        <tbody align="center">
                                            <tr>
                                               <td>${m.memberId}</td>
                                               <td>${m.memberName}</td>
                                               <td>${m.phone}</td>
                                                <td>
							                		${d.deliAddress}	
							            		</td>
                                              
                                               <td>
                                               	<c:set var="dateParts" value="${fn:split(m.birthdate, ' ')}" />
												${dateParts[0]}
                                               </td>
                                               <td>${m.createDate}</td>
                                               <td>${m.deleteDate}</td>
                                               <td>${m.totalPoints}</td>
                                               <td>${m.gradeName}</td>
                                               <td>${m.snsId}</td>
                                               <td>${m.loginType}</td>
                                               <td>${m.status}</td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                             
                        </div>
                         <div class="card shadow mb-4">
                            <div class="card-header py-3">
                                <span class="m-0 font-weight-bold text-primary">회원 배송지목록 조회</span>
                            </div>
                            <div class="card-body">
                                <div class="table-responsive">
                               
                                    <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                                        <thead align="center">
                                            <tr>
                                             	<th style="color:#7AB2D3;">*배송지명</th>
                                             	<th>받는사람</th>
                                             	<th >연락처</th>
                                                <th >우편번호</th>
                                                <th colspan="2">주소</th>
                                                <th colspan="2">상세주소</th>
                                                <th colspan="2">배송시 요청사항</th>
                                                <th style="color:#7AB2D3;">*기본주소지여부</th>
                                                <th>설정</th>
                                            </tr>
                                        </thead>
                                        <tbody align="center">
                                        <c:forEach var="d" items="${dList}">
                                            <tr>
                                            	<input type="hidden" name="deliCode" value="${d.deliCode}">
                                               <td contenteditable="true">${d.deliNickname}</td>
                                               <td>${d.deliName}</td>
                                               <td>${d.deliPhone}</td>
                                               <td>${d.postcode}</td>
                                               <td colspan="2">${d.deliAddress}</td>
                                               <td colspan="2">${d.detailAddress}</td>
                                               <td colspan="2">${d.deliComment}</td>
                                               <td contenteditable="true">${d.deliDefault}</td>
                                               <td>
                                               <div  style="display: flex; gap: 10px;">
                                                	<button type="button"  class="btn btn-primary btn-sm" id="saveBtn">저장</button>
													 <button type="button"  class="btn btn-outline-primary btn-sm" id="deleteBtn">삭제</button>
                                               </div>
												   
                                               </td>
                                            </tr>
                                        </c:forEach>
                                         <c:if test="${empty dList}">
							                <td colspan="12" align="center">등록된 배송지가 없습니다.</td>
							                
							            </c:if>
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

            // 저장 버튼 클릭 이벤트
            $('#dataTable').on('click', '#saveBtn', function () {
            
                const row = $(this).closest('tr'); // 해당 행 선택
            	
                const prodData = {
                	deliCode : row.find('input[name="deliCode"]').val(),
                	deliNickname: row.find('td').eq(0).text(),
                    deliDefault: row.find('td').eq(7).text()
                };
                console.log(prodData.deliCode);
                
                // AJAX 요청으로 수정된 데이터 전송
                $.ajax({
                    url: 'updateDeliveryAdmin.me',
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
            
            // 저장 버튼 클릭 이벤트
            $('#dataTable').on('click', '#deleteBtn', function () {
            
                const row = $(this).closest('tr'); // 해당 행 선택
            	
                const prodData = {
                	deliCode : row.find('input[name="deliCode"]').val(),
                };
                console.log(prodData.deliCode);
                
                // AJAX 요청으로 수정된 데이터 전송
                $.ajax({
                    url: 'deleteDeliveryAdmin.me',
                    type: 'POST',
                    contentType: 'application/json',
                   
                    data: JSON.stringify(prodData),
                   
                    success: function (response) {
                        if (response.success) {
                            alert('삭제 성공!');
                            location.reload();  // 페이지 리로드
                        } else {
                            alert('삭제 실패: ' + response.message);
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
