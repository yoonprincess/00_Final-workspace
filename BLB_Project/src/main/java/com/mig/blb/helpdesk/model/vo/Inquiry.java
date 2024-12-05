package com.mig.blb.helpdesk.model.vo;

public class Inquiry {

	private int inquiryNo;
	private String inquiryTitle;
	private String inquiryContent;
	private String inquiryType;
	private String inquiryCreateDate;
	private String inquiryAnsweredYn;
	private String inquiryStatus;
	
	public Inquiry() { }

	public Inquiry(int inquiryNo, String inquiryTitle, String inquiryContent, String inquiryType,
			String inquiryCreateDate, String inquiryAnsweredYn, String inquiryStatus) {
		super();
		this.inquiryNo = inquiryNo;
		this.inquiryTitle = inquiryTitle;
		this.inquiryContent = inquiryContent;
		this.inquiryType = inquiryType;
		this.inquiryCreateDate = inquiryCreateDate;
		this.inquiryAnsweredYn = inquiryAnsweredYn;
		this.inquiryStatus = inquiryStatus;
	}

	public int getInquiryNo() {
		return inquiryNo;
	}

	public void setInquiryNo(int inquiryNo) {
		this.inquiryNo = inquiryNo;
	}

	public String getInquiryTitle() {
		return inquiryTitle;
	}

	public void setInquiryTitle(String inquiryTitle) {
		this.inquiryTitle = inquiryTitle;
	}

	public String getInquiryContent() {
		return inquiryContent;
	}

	public void setInquiryContent(String inquiryContent) {
		this.inquiryContent = inquiryContent;
	}

	public String getInquiryType() {
		return inquiryType;
	}

	public void setInquiryType(String inquiryType) {
		this.inquiryType = inquiryType;
	}

	public String getInquiryCreateDate() {
		return inquiryCreateDate;
	}

	public void setInquiryCreateDate(String inquiryCreateDate) {
		this.inquiryCreateDate = inquiryCreateDate;
	}

	public String getInquiryAnsweredYn() {
		return inquiryAnsweredYn;
	}

	public void setInquiryAnsweredYn(String inquiryAnsweredYn) {
		this.inquiryAnsweredYn = inquiryAnsweredYn;
	}

	public String getInquiryStatus() {
		return inquiryStatus;
	}

	public void setInquiryStatus(String inquiryStatus) {
		this.inquiryStatus = inquiryStatus;
	}

	@Override
	public String toString() {
		return "Inquiry [inquiryNo=" + inquiryNo + ", inquiryTitle=" + inquiryTitle + ", inquiryContent="
				+ inquiryContent + ", inquiryType=" + inquiryType + ", inquiryCreateDate=" + inquiryCreateDate
				+ ", inquiryAnsweredYn=" + inquiryAnsweredYn + ", inquiryStatus=" + inquiryStatus + "]";
	}
	
}
