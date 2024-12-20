package com.mig.blb.common.notification.dto;

public class Message {

	private String userId;
	private String msg;
	private String sendTime;
	
	public Message() { }
	
	public Message(String userId, String msg, String sendTime) {
		this.userId = userId;
		this.msg = msg;
		this.sendTime = sendTime;
	}
	
	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}

	public String getSendTime() {
		return sendTime;
	}

	public void setSendTime(String sendTime) {
		this.sendTime = sendTime;
	}

	@Override
	public String toString() {
		return "Message [userId=" + userId + ", msg=" + msg + ", sendTime=" + sendTime + "]";
	}
}
