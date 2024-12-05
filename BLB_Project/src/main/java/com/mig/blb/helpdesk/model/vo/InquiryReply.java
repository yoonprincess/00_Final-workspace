package com.mig.blb.helpdesk.model.vo;

public class InquiryReply {

	private int inquiryReplyNo;
	private String inquiryReplyContent;
	private String inquiryReplyCreateDate;
	private String inquiryReplyYn;
	private String inquiryReplyStatus;
	
	public InquiryReply() { }

	public InquiryReply(int inquiryReplyNo, String inquiryReplyContent, String inquiryReplyCreateDate,
			String inquiryReplyYn, String inquiryReplyStatus) {
		super();
		this.inquiryReplyNo = inquiryReplyNo;
		this.inquiryReplyContent = inquiryReplyContent;
		this.inquiryReplyCreateDate = inquiryReplyCreateDate;
		this.inquiryReplyYn = inquiryReplyYn;
		this.inquiryReplyStatus = inquiryReplyStatus;
	}

	public int getInquiryReplyNo() {
		return inquiryReplyNo;
	}

	public void setInquiryReplyNo(int inquiryReplyNo) {
		this.inquiryReplyNo = inquiryReplyNo;
	}

	public String getInquiryReplyContent() {
		return inquiryReplyContent;
	}

	public void setInquiryReplyContent(String inquiryReplyContent) {
		this.inquiryReplyContent = inquiryReplyContent;
	}

	public String getInquiryReplyCreateDate() {
		return inquiryReplyCreateDate;
	}

	public void setInquiryReplyCreateDate(String inquiryReplyCreateDate) {
		this.inquiryReplyCreateDate = inquiryReplyCreateDate;
	}

	public String getInquiryReplyYn() {
		return inquiryReplyYn;
	}

	public void setInquiryReplyYn(String inquiryReplyYn) {
		this.inquiryReplyYn = inquiryReplyYn;
	}

	public String getInquiryReplyStatus() {
		return inquiryReplyStatus;
	}

	public void setInquiryReplyStatus(String inquiryReplyStatus) {
		this.inquiryReplyStatus = inquiryReplyStatus;
	}

	@Override
	public String toString() {
		return "InquiryReply [inquiryReplyNo=" + inquiryReplyNo + ", inquiryReplyContent=" + inquiryReplyContent
				+ ", inquiryReplyCreateDate=" + inquiryReplyCreateDate + ", inquiryReplyYn=" + inquiryReplyYn
				+ ", inquiryReplyStatus=" + inquiryReplyStatus + "]";
	}
	
}
