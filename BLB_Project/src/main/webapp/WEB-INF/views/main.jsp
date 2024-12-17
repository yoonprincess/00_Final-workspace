<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style>
    /* 배너 스타일 */
    .banner {
        position: relative;
        width: 100%;
        height: 40vh;
        overflow: hidden; /* 이미지가 div 영역을 벗어나지 않도록 */
        z-index: 1;
        background-color: #C4EFF8; /* 배너 배경 색상 */
        display: flex;
        align-items: center; /* 세로 가운데 정렬 */
        justify-content: center; /* 가로 가운데 정렬 */
    }
    .banner img {
        width: 100%; /* 가로 크기를 부모 요소에 맞춤 */
        height: 100%; /* 세로 크기를 부모 요소에 맞춤 */
        object-fit: cover; /* 이미지 비율을 유지하며 배너 크기에 맞춤 */
        object-position: center; /* 이미지 가운데 정렬 */
    }
</style>
<title>뷰라밸 (Beauty Life Balance)</title>
</head>
<body>
<div class="banner">
    <div class="container-fluid">
        <img src="${ pageContext.request.contextPath }/resources/images/product/all_banner.jpg">
    </div>
</div>
<div class="container-fluid">


<pre>
임시 공백

















































































































</pre></div>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>