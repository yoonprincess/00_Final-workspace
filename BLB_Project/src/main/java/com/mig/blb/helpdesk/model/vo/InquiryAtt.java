package com.mig.blb.helpdesk.model.vo;

public class InquiryAtt {

	private int InquiryAttNo;
	private String origFileName;
	private String saveFileName;
	private String savePath;
	private String InquiryAttStatus;
	
	public InquiryAtt() {}

	public InquiryAtt(int inquiryAttNo, String origFileName, String saveFileName, String savePath,
			String inquiryAttStatus) {
		super();
		InquiryAttNo = inquiryAttNo;
		this.origFileName = origFileName;
		this.saveFileName = saveFileName;
		this.savePath = savePath;
		InquiryAttStatus = inquiryAttStatus;
	}

	public int getInquiryAttNo() {
		return InquiryAttNo;
	}

	public void setInquiryAttNo(int inquiryAttNo) {
		InquiryAttNo = inquiryAttNo;
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

	public String getInquiryAttStatus() {
		return InquiryAttStatus;
	}

	public void setInquiryAttStatus(String inquiryAttStatus) {
		InquiryAttStatus = inquiryAttStatus;
	}

	@Override
	public String toString() {
		return "InquiryAtt [InquiryAttNo=" + InquiryAttNo + ", origFileName=" + origFileName + ", saveFileName="
				+ saveFileName + ", savePath=" + savePath + ", InquiryAttStatus=" + InquiryAttStatus + "]";
	}
	
	}
	

