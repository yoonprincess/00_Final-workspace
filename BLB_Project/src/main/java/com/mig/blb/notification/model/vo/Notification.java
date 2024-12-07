package com.mig.blb.notification.model.vo;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@ToString
public class Notification {

	private int NotificationNo;
	private String NotificationContent;
	private String NotificationType;
	private String readYn;
	private String deleteYn;
	private String createAt;
		
}
