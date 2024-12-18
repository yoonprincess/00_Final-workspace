package com.mig.blb.common.notification.server;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;
import org.springframework.util.StringUtils;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

@Repository
public class NotificationHandler extends TextWebSocketHandler {

    List<WebSocketSession> sessions = new ArrayList<>();
    Map<String, WebSocketSession> memberSessions = new HashMap<>();

    @Override
    public void afterConnectionEstablished(WebSocketSession session) throws Exception {
        sessions.add(session);
        String senderId = getId(session);
        memberSessions.put(senderId,  session);
    }

    @Override
    protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
        String senderId = getId(session);
        for (WebSocketSession sess : sessions) {
            sess.sendMessage(new TextMessage("보낸 사람 " + senderId + " : " + message.getPayload()));
            
            // protocol: cmd, 댓글작성자, 게시글작성, bno (reply, user2, user1, 글번호)
            String msg = message.getPayload();
            if(!StringUtils.isEmpty(msg)) {
            String[] strs = message.getPayload().split(",");
            if(strs !=null && strs.length == 4) {
            	String cmd = strs[0];
            	String admin = strs[1];
            	String inquiryWriter = strs[2];
            	String ino = strs[3];
            	
            	WebSocketSession adminSession =  memberSessions.get(admin);
            	if("reply".equals(cmd) && adminSession != null) {
            		TextMessage tmpMsg = new TextMessage(ino + "번 문의글에 " + admin + "가 답변을 남겼습니다.");
            		adminSession.sendMessage(tmpMsg);
            	}
            	}
            } 
        }
    }

    @Override
    public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
    	sessions.remove(session);
        
    }

    private String getId(WebSocketSession session) {
        // WebSocketSession의 attributes에서 사용자 정보를 가져옴
        Map<String, Object> attributes = session.getAttributes();
        String loginUserId = (String) attributes.get("loginUserId"); // "loginUserId"는 세션에 저장된 키 이름
        return loginUserId != null ? loginUserId : session.getId(); // 값이 없으면 WebSocketSession의 id 반환
    }
}
