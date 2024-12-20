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
	private String createYn;
}
