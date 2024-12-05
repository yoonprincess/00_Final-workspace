package com.mig.blb.helpdesk.model.vo;

public class Notice {

	private int noticeNo;
	private String noticeTitle;
	private String noticeContent;
	private String originName;
	private String changeName;
	private String noticeRegDate;
	private String noticePinnedYn;
	private String noticeStatus;
	
	public Notice() { }

	public Notice(int noticeNo, String noticeTitle, String noticeContent, String originName, String changeName,
			String noticeRegDate, String noticePinnedYn, String noticeStatus) {
		super();
		this.noticeNo = noticeNo;
		this.noticeTitle = noticeTitle;
		this.noticeContent = noticeContent;
		this.originName = originName;
		this.changeName = changeName;
		this.noticeRegDate = noticeRegDate;
		this.noticePinnedYn = noticePinnedYn;
		this.noticeStatus = noticeStatus;
	}

	public int getNoticeNo() {
		return noticeNo;
	}

	public void setNoticeNo(int noticeNo) {
		this.noticeNo = noticeNo;
	}

	public String getNoticeTitle() {
		return noticeTitle;
	}

	public void setNoticeTitle(String noticeTitle) {
		this.noticeTitle = noticeTitle;
	}

	public String getNoticeContent() {
		return noticeContent;
	}

	public void setNoticeContent(String noticeContent) {
		this.noticeContent = noticeContent;
	}

	public String getOriginName() {
		return originName;
	}

	public void setOriginName(String originName) {
		this.originName = originName;
	}

	public String getChangeName() {
		return changeName;
	}

	public void setChangeName(String changeName) {
		this.changeName = changeName;
	}

	public String getNoticeRegDate() {
		return noticeRegDate;
	}

	public void setNoticeRegDate(String noticeRegDate) {
		this.noticeRegDate = noticeRegDate;
	}

	public String getNoticePinnedYn() {
		return noticePinnedYn;
	}

	public void setNoticePinnedYn(String noticePinnedYn) {
		this.noticePinnedYn = noticePinnedYn;
	}

	public String getNoticeStatus() {
		return noticeStatus;
	}

	public void setNoticeStatus(String noticeStatus) {
		this.noticeStatus = noticeStatus;
	}

	@Override
	public String toString() {
		return "Notice [noticeNo=" + noticeNo + ", noticeTitle=" + noticeTitle + ", noticeContent=" + noticeContent
				+ ", originName=" + originName + ", changeName=" + changeName + ", noticeRegDate=" + noticeRegDate
				+ ", noticePinnedYn=" + noticePinnedYn + ", noticeStatus=" + noticeStatus + "]";
	}
	
}
