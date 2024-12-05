package com.mig.blb.helpdesk.model.vo;

public class Faq {

	private int FaqNo;
	private String FaqTitle;
	private String FaqContent;
	private String FaqType;
	private String FaqStatus;
	
	public Faq() { }

	public Faq(int faqNo, String faqTitle, String faqContent, String faqType, String faqStatus) {
		super();
		FaqNo = faqNo;
		FaqTitle = faqTitle;
		FaqContent = faqContent;
		FaqType = faqType;
		FaqStatus = faqStatus;
	}

	public int getFaqNo() {
		return FaqNo;
	}

	public void setFaqNo(int faqNo) {
		FaqNo = faqNo;
	}

	public String getFaqTitle() {
		return FaqTitle;
	}

	public void setFaqTitle(String faqTitle) {
		FaqTitle = faqTitle;
	}

	public String getFaqContent() {
		return FaqContent;
	}

	public void setFaqContent(String faqContent) {
		FaqContent = faqContent;
	}

	public String getFaqType() {
		return FaqType;
	}

	public void setFaqType(String faqType) {
		FaqType = faqType;
	}

	public String getFaqStatus() {
		return FaqStatus;
	}

	public void setFaqStatus(String faqStatus) {
		FaqStatus = faqStatus;
	}

	@Override
	public String toString() {
		return "Faq [FaqNo=" + FaqNo + ", FaqTitle=" + FaqTitle + ", FaqContent=" + FaqContent + ", FaqType=" + FaqType
				+ ", FaqStatus=" + FaqStatus + "]";
	}
	
}
