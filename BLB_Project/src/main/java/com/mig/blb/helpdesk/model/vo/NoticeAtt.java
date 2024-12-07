package com.mig.blb.helpdesk.model.vo;

public class NoticeAtt {

	private int noticeAttNo;
	private String origFileName;
	private String saveFileName;
	private String savePath;
	private String noticeAttStatus;
	
	public NoticeAtt() {}

	public NoticeAtt(int noticeAttNo, String origFileName, String saveFileName, String savePath,
			String noticeAttStatus) {
		super();
		this.noticeAttNo = noticeAttNo;
		this.origFileName = origFileName;
		this.saveFileName = saveFileName;
		this.savePath = savePath;
		this.noticeAttStatus = noticeAttStatus;
	}

	public int getNoticeAttNo() {
		return noticeAttNo;
	}

	public void setNoticeAttNo(int noticeAttNo) {
		this.noticeAttNo = noticeAttNo;
	}

	public String getOrigFileName() {
		return origFileName;
	}

	public void setOrigFileName(String origFileName) {
		this.origFileName = origFileName;
	}

	public String getSaveFileName() {
		return saveFileName;
	}

	public void setSaveFileName(String saveFileName) {
		this.saveFileName = saveFileName;
	}

	public String getSavePath() {
		return savePath;
	}

	public void setSavePath(String savePath) {
		this.savePath = savePath;
	}

	public String getNoticeAttStatus() {
		return noticeAttStatus;
	}

	public void setNoticeAttStatus(String noticeAttStatus) {
		this.noticeAttStatus = noticeAttStatus;
	}

	@Override
	public String toString() {
		return "NoticeAtt [noticeAttNo=" + noticeAttNo + ", origFileName=" + origFileName + ", saveFileName="
				+ saveFileName + ", savePath=" + savePath + ", noticeAttStatus=" + noticeAttStatus + "]";
	}
	
}
