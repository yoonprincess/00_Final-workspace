<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>WebSocket Notification</title>
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
    <style>
        .alert-qna {
            display: none;
            position: fixed;
            top: 10px;
            right: 10px;
            z-index: 1000;
            background: #ffeb3b;
            padding: 10px 20px;
            border-radius: 5px;
            box-shadow: 0px 2px 10px rgba(0, 0, 0, 0.2);
        }
    </style>
</head>
<body>
    <!-- 알림 메시지 표시 -->
    <div id="websocketQna" class="alert-qna">
        <h4>새로운 Q&A가 등록되었습니다.</h4>
    </div>

    <script>
        
    </script>
</body>
</html>
