package com.mig.blb.notification.model.vo;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@Setter
@Getter
@ToString
public class Notification {

	private int NotificationNo;
	private String NotificationContent;
	private String NotificationType;
	private String readYn;
	private String deleteYn;
	private String createAt;
}
