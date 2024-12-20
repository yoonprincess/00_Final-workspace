package com.mig.blb.common.notification.server;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Set;
import java.util.concurrent.CopyOnWriteArraySet;

import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.google.gson.Gson;
import com.mig.blb.common.notification.dto.Message;


public class NotificationHandler extends TextWebSocketHandler {
	
	// 로그인한 전체 회원을 담을 곳
	private Set<WebSocketSession> sessions = new CopyOnWriteArraySet<>();
	
	// 클라이언트가 웹 소켓 생성
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		
		// 웹소켓이 생성될 때마다 리스트에 넣어줌
		sessions.add(session);
		
//		System.out.println("접속 : " + session);
//		System.out.println("세션의 속성들 : " + session.getAttributes());
//		System.out.println("아이디 : " + session.getAttributes().get("loginUser"));
	}

	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		String userId = (String)session.getAttributes().get("loginUser");
		String msg = message.getPayload();
		String sendTime 
				= new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")
											.format(new Date());
		
		if(userId != null) {
			Message m = new Message(userId, msg, sendTime);
			String result = new Gson().toJson(m);
			TextMessage newMessage = new TextMessage(result);
			
			for(WebSocketSession ws : sessions) {
				
				ws.sendMessage(newMessage);
			}
		}
	}

	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		sessions.remove(session);
	}

   
}
