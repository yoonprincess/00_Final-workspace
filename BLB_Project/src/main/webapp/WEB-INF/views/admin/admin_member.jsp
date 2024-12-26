<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/admin/adminSide.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
                        <p class="mb-4">회원관리테이블입니다</p>
    
                        <!-- DataTales Example -->
                        <div class="card shadow mb-4">
                            <div class="card-header py-3">
                                <span class="m-0 font-weight-bold text-primary">뷰라밸 회원목록</span>
                                <div class="button-group" style="float:right;">
                                    <button  class="btn btn-outline-info"type="button" onclick="detailMember();">상세조회</button>
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
                                                <th style="color:#7AB2D3;">*총 적립금</th>
                                                <th style="color:#7AB2D3;" >*회원등급</th>
                                                <th>SNS 아이디</th>
                                                <th>가입 종류</th>
                                                <th style="color:#7AB2D3;">*탈퇴여부</th>
                                                <th>설정</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        
                                           <c:forEach var="m" items="${mList}">
                                                <tr>
                                                   <td>
                                                      <input type="checkbox" value="Y" class="memberCheckbox" style="width:20px; height:20px;"> 
                                                   	  <input type="hidden" name="memberId" value="${m.memberId}">
                                                   </td>
                                                   <td >${m.memberId}</td>
                                                   <td >${m.memberName}</td>
                                                   <td >${m.phone}</td>
                                                   <td>
                                                     ${addressMap[m.memberId] != null ? addressMap[m.memberId] : '-'}
                                                    </td>
                                                   <td>
                                                  	<c:set var="dateParts" value="${fn:split(m.birthdate, ' ')}" />
													${dateParts[0]}
                                                   </td>
                                                   <td>${m.createDate}</td>
                                                   <td>${m.deleteDate}</td>
                                                   <td contenteditable="true">${m.totalPoints}</td>
                                                   <td contenteditable="true">${m.gradeName}</td>
                                                   <td>${m.snsId}</td>
                                                   <td>${m.loginType}</td>
                                                   <td contenteditable="true">${m.status}</td>
                                                   <td>
												   	 <button type="button"  class="btn btn-primary btn-sm" id="saveBtn">저장</button>
                                                   </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                      </div>
                      
                      <br><br>
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
        
        $(document).ready( function () {

            // 저장 버튼 클릭 이벤트
            $('#dataTable').on('click', '#saveBtn', function () {
            
                const row = $(this).closest('tr'); // 해당 행 선택
            	
                const prodData = {
                	memberId : row.find('td').eq(1).text(),
                	totalPoints: row.find('td').eq(8).text(),
                    gradeName: row.find('td').eq(9).text(),
                    status: row.find('td').eq(12).text()
                };
                
                
                // AJAX 요청으로 수정된 데이터 전송
                $.ajax({
                    url: 'updateAdmin.me',
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
        
     	//상세조회 버튼 관련
        function detailMember() {
        
     		const checkedbox = document.querySelector('.memberCheckbox:checked');
          
     		if(checkedbox){
        	
     			const memberId = checkedbox.closest('tr').querySelector('input[name="memberId"]').value;
           		console.log(memberId)
           		
           		$.ajax({
                    url: '${pageContext.request.contextPath}/adminDetailMember.me', // 서버 URL
                    type: 'GET', // 요청 방식
                    data: { memberId: memberId }, // 전송할 데이터
                    success: function(response) {
                    	  window.location.href = '${pageContext.request.contextPath}/adminDetailMember.me?memberId=' + memberId;
                    },
                    error: function(xhr, status, error) {
                        console.error("AJAX request failed: ", error);
                    }
                });	
           		
     	}else{
     		alert("선택된 회원이 없습니다.");
     	}
     }
        
        </script>
        
    </body>
    
    
</html>
