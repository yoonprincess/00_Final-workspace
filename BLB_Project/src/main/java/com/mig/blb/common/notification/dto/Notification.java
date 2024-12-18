package com.mig.blb.common.notification.dto;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class Notification {	
	
	
	private int notificationNo;
	private String notificationContent;
	private String notificationType;
	private String readYn;
	private String deleteYn;
	private String createAt;
	private String memberId;
	
	public Notification(String memberId, String notificationContent, String createAt) {
		
		this.memberId = memberId;
		this.notificationContent = notificationContent;
		this.createAt = createAt;
	}
}
