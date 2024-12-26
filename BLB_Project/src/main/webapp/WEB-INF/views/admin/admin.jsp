<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
                                    
                                    <!-- 데이터 테이블 불러오는 코드를 이 부분에 작성해주시면 됩니다. table의 id명을 "datatablesSimple"로 해주세요 -->
                                    
                                </table>
                            </div>
                            
                             <div class="card shadow mb-4" style="width:60%;">
                              <!-- Card Header - Dropdown -->
                              <div
                                  class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                                  <h6 class="m-0 font-weight-bold text-primary">
                                  	사이트 회원 수 :  
                                  	 <span id="totalMemberCount" style="font-size:20px;">0</span>명 
                                  </h6>
                                  <div class="dropdown no-arrow">
                                      <a class="dropdown-toggle" href="#" role="button" id="dropdownMenuLink"
                                          data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                          <i class="fas fa-ellipsis-v fa-sm fa-fw text-gray-400"></i>
                                      </a>
                                      <div class="dropdown-menu dropdown-menu-right shadow animated--fade-in"
                                          aria-labelledby="dropdownMenuLink">
                                          <div class="dropdown-header">Dropdown Header:</div>
                                          <a class="dropdown-item" href="#">Action</a>
                                          <a class="dropdown-item" href="#">Another action</a>
                                          <div class="dropdown-divider"></div>
                                          <a class="dropdown-item" href="#">Something else here</a>
                                      </div>
                                  </div>
                              </div>
                              <!-- Card Body -->
                              <div class="card-body">
                                  <div class="chart-area">
                                      <canvas id="myAreaChart"></canvas>
                                  </div>
                              </div>
                      </div>
                            
                            
                        </div>
                    </div>
                </main>
            </div>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
                        
        <script>
       
	     // 차트를 그리기 위한 데이터와 옵션 설정
	        var labels = [];
	        var data = []; 
	        var totalMemberCount = 0; // 총 회원 수를 저장할 변수 초기화
	
	        <c:forEach var="item" items="${memberCounts}">
	            labels.push('${item.MONTH}월');
	            data.push('${item.MEMBER_COUNT}');
	            totalMemberCount += parseInt('${item.MEMBER_COUNT}'); // 각 회원 수를 더하여 총합을 구함
	        </c:forEach>
	        
	        document.getElementById('totalMemberCount').innerText = totalMemberCount; 
	        
	        var ctx = document.getElementById('myAreaChart').getContext('2d');
	        var myChart = new Chart(ctx, {
	            type: 'line', 
	            data: {
	                labels: labels,
	                datasets: [{
	                    label: '회원 수',
	                    data: data, // y축 데이터
	                    backgroundColor: 'rgba(78, 115, 223, 0.05)', // 그래프 배경색
	                    borderColor: 'rgba(78, 115, 223, 1)', // 그래프 선 색
	                    fill: false
	                }]
	            },
	            options: {
	                responsive: true, // 화면 크기 변화에 대응
	                scales: {
	                    x: {
	                        reverse: true // x축 방향을 반대로 설정 (최신 날짜가 오른쪽)
	                    },
	                    y: {
	                        beginAtZero: true,
	                        ticks: {
	                            precision: 0, // 소수점 자리를 0으로 설정하여 정수로 표시
	                        }
	                    }
	                }
	              
	            }
	        });
	   </script>
    </body>
</html>
