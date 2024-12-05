<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
	
        
                <div id="faq" class="tab-content active">
                    <div class="sub-tabs">
                        <button class="sub-tab-button active" data-category="all">전체</button>
                        <button class="sub-tab-button" data-category="product">상품</button>
                        <button class="sub-tab-button" data-category="delivery">배송</button>
                        <button class="sub-tab-button" data-category="order">주문</button>
                        <button class="sub-tab-button" data-category="payment">결제/환불</button>
                    </div>
                    <div class="faq-list">
                        <!-- FAQ 항목들이 여기에 동적으로 추가됩니다 -->
                    </div>
                </div>
        
                <div id="inquiry" class="tab-content">
                    <div class="header">
                        BLB 고객센터입니다!
                        <br />
                        무엇을 도와드릴까요?
                    </div>
                    <div class="form-container">
                        <div class="form-group">
                            <label for="category">문의유형</label>
                            <select id="category">
                                <option>카테고리를 선택해주세요</option>
                                <option>상품</option>
                                <option>배송</option>
                                <option>주문</option>
                                <option>결제/환불</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="content">내용</label>
                            <textarea id="content" placeholder="문의내용을 입력해주세요. (2000자 이내)"></textarea>
                        </div>
                        <div class="form-group">
                            <label for="file-upload">첨부파일</label>
                            <button type="button" id="file-upload-btn" class="file-upload-btn">+</button>
                            <span id="file-count">0/3</span>
                            <p id="file-info" style="font-size: 12px; color: #7AB2D3;">10MB 이하 이미지 파일 (JPG, PNG, GIF) 3개를 첨부할 수 있습니다.</p>
                            <div class="file-list" id="file-list"></div>
                        </div>
                
                        <div class="form-group">
                            <label for="receive-email">
                                <input type="checkbox" id="receive-email"> 답변 완료 시 이메일로 알림 받기
                            </label>
                        </div>
                
                        <div class="form-group" id="email-group">
                            <label for="email">답변 받을 이메일</label>
                            <div>
                                <input type="text" id="email" placeholder="답변 받을 이메일을 입력하세요." style="width: 55%;" disabled/>
                            </div>
                        </div>
                
                        <div class="form-buttons">
                            <button type="button" class="cancel" onclick="resetForm()">취소</button>
                            <button type="button" class="submit" onclick="submitForm()">등록</button>
                        </div>
                    </div>
            </div>
    
            <div id="notice" class="tab-content">
                <div class="sub-tabs">
                    <button class="sub-tab-button active" data-category="all">전체</button>
                    <button class="sub-tab-button" data-category="general">일반</button>
                    <button class="sub-tab-button" data-category="store">매장</button>
                    <button class="sub-tab-button" data-category="event">이벤트</button>
                </div>
                
                <!-- 검색 기능 추가 -->
                <div class="notice-search">
                    <input type="text" id="notice-search-input" placeholder="검색어를 입력하세요.">
                    <button type="button" id="notice-search-btn">검색</button>
                </div>
                
                <table id="notice-table">
                    <colgroup>
                        <col style="width: 10%;"> <!-- 글번호 -->
                        <col style="width: 20%;"> <!-- 분류 -->
                        <col style="width: 50%;"> <!-- 내용 -->
                        <col style="width: 20%;"> <!-- 작성일 -->
                    </colgroup>
                    <thead>
                        <tr>
                            <th>글번호</th>
                            <th></th>
                            <th>내용</th>
                            <th>작성일</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="n" items="${requestScope.list }">
                        	<tr>
                        		<td class="nno">${n.noticeNo }</td>
                        		<td>${ n.noticeTitle }</td>
                        		<td>${ n.noticeContent }</td>
                        		<td>${ n.noticeRegDate }</td>
                        	</tr>
                        </c:forEach>
                    </tbody>
                </table>
                <div id="pagingArea">
                <ul class="pagination">	          
	                <c:choose>
	                	<c:when test="${ requestScope.pi.currentPage eq 1 }">
		                    <li class="page-item disabled">
		                    	<a class="page-link" href="#">
		                    		이전
		                    	</a>
		                    </li>
		                </c:when>
		                <c:otherwise>
		                	<li class="page-item">
		                    	<a class="page-link" href="list.no?cpage=${ requestScope.pi.currentPage - 1 }">
		                    		이전
		                    	</a>
		                    </li>
		                </c:otherwise>
	                </c:choose>
                    
                    <c:forEach var="p" begin="${ requestScope.pi.startPage }"
                    				   end="${ requestScope.pi.endPage }" 
                    				   step="1">
                    	<c:choose>
                    		<c:when test="${ p ne requestScope.pi.currentPage }">			   
			                    <li class="page-item">
			                    	<a class="page-link" href="list.no?cpage=${ p }">
			                    		${ p }
			                    	</a>
			                    </li>
		                    </c:when>
		                    <c:otherwise>
		                    	<li class="page-item disabled">
			                    	<a class="page-link" href="list.no?cpage=${ p }">
			                    		${ p }
			                    	</a>
			                    </li>
	                    	</c:otherwise>
	                    </c:choose>
                    </c:forEach>
                    
                    <c:choose>
                    	<c:when test="${ requestScope.pi.currentPage ne requestScope.pi.maxPage }">
                   			<li class="page-item">
                   				<a class="page-link" href="list.no?cpage=${ requestScope.pi.currentPage + 1 }">
                   					다음
                   				</a>
                   			</li>
                   		</c:when>
                   		<c:otherwise>
                   			<li class="page-item disabled">
                   				<a class="page-link" href="#">
                   					다음
                   				</a>
                   			</li>
                   		</c:otherwise>
                   	</c:choose>
                </ul>
            </div>
            </div>
            
        </div>
    </div>
</body>
</html>