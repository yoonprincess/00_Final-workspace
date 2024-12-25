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
                                <div class="button-group" style="float:right;">
                                    <button  class="btn btn-outline-info"type="button" onclick="updateMember();">수정</button>
                                    <button class=" btn btn-outline-danger" type="button" onclick="deleteMember();">탈퇴</button>
                                </div>
                            </div>
                            <div class="card-body">
                                <div class="table-responsive">
                                    <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                                        <thead>
                                            <tr>
                                                <th>
                                                 <input type="checkbox" value="Y" onclick="toggleAllCheckboxes(this)" style="width:20px; height:20px;">
                                                </th>
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
                                        <tbody>
                                            <tr>
                                               <td>
                                                  <input type="checkbox" value="Y" class="memberCheckbox" style="width:20px; height:20px;"> 
                                               </td>
                                               <td>${m.memberId}</td>
                                               <td>${m.memberName}</td>
                                               <td>${m.phone}</td>
                                               <td>${d.d }
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
                                               <td>
                                                <form action="${pageContext.request.contextPath}/adminDetailMember.me" method="POST" id="detailForm">
												    <input type="hidden" name="memberId" value="${m.memberId}">
												    <button type="submit">상세조회</button>
												</form>
                                               </td>
                                            </tr>
                                        </tbody>
                                        <thead>
                                            <tr>
                                             	<th>배송지명</th>
                                                <th colspan="2">우편번호</th>
                                                <th colspan="3">주소</th>
                                                <th colspan="2">상세주소</th>
                                                <th colspan="3">배송시 요청사항</th>
                                                <th>기본주소지여부</th>
                                               
                                                <th></th>
                                                
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr>
                                               <td>
                                                 ${d.deliCode}
                                               </td>
                                               <td>${m.memberId}</td>
                                               <td>${m.memberName}</td>
                                               <td>${m.phone}</td>
                                               <td>${d.d }
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
                                               <td>
                                                <form action="${pageContext.request.contextPath}/adminDetailMember.me" method="POST" id="detailForm">
												    <input type="hidden" name="memberId" value="${m.memberId}">
												    <button type="submit">상세조회</button>
												</form>
                                               </td>
                                            </tr>
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
        function toggleAllCheckboxes(source) {
            const checkboxes = document.querySelectorAll('.memberCheckbox');
            checkboxes.forEach(checkbox => {
                checkbox.checked = source.checked;
            });
        }     
        
        </script>
        
        
    </body>
</html>
