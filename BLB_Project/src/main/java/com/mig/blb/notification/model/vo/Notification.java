package com.mig.blb.notification.model.vo;

/**
 * @author douke
 *
 */
public class Notification {

	private int NotificationNo;
	private String NotificationContent;
	private String NotificationType;
	private String readYn;
	private String deleteYn;
	private String createAt;
	
	public Notification() { }

	public Notification(int notificationNo, String notificationContent, String notificationType, String readYn,
			String deleteYn, String createAt) {
		super();
		NotificationNo = notificationNo;
		NotificationContent = notificationContent;
		NotificationType = notificationType;
		this.readYn = readYn;
		this.deleteYn = deleteYn;
		this.createAt = createAt;
	}

	public int getNotificationNo() {
		return NotificationNo;
	}

	public void setNotificationNo(int notificationNo) {
		NotificationNo = notificationNo;
	}

	public String getNotificationContent() {
		return NotificationContent;
	}

	public void setNotificationContent(String notificationContent) {
		NotificationContent = notificationContent;
	}

	public String getNotificationType() {
		return NotificationType;
	}

	public void setNotificationType(String notificationType) {
		NotificationType = notificationType;
	}

	public String getReadYn() {
		return readYn;
	}

	public void setReadYn(String readYn) {
		this.readYn = readYn;
	}

	public String getDeleteYn() {
		return deleteYn;
	}

	public void setDeleteYn(String deleteYn) {
		this.deleteYn = deleteYn;
	}

	public String getCreateAt() {
		return createAt;
	}

	public void setCreateAt(String createAt) {
		this.createAt = createAt;
	}

	@Override
	public String toString() {
		return "Notification [NotificationNo=" + NotificationNo + ", NotificationContent=" + NotificationContent
				+ ", NotificationType=" + NotificationType + ", readYn=" + readYn + ", deleteYn=" + deleteYn
				+ ", createAt=" + createAt + "]";
	}
	
}
