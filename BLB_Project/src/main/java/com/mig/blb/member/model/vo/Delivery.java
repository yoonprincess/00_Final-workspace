package com.mig.blb.member.model.vo;

public class Delivery {
	private int deliCode;	//	DELI_CODE	NUMBER
	private String deliName;//	DELI_NAME	VARCHAR2(20 BYTE)
	private String deliPhone;	//	DELI_PHONE	CHAR(11 BYTE)
	private String deliAddress;	//	DELI_ADDRESS	VARCHAR2(300 BYTE)
	private String deliDefault;	//	DELI_DEFAULT	CHAR(1 BYTE)
	private String deliComment;	//	DELI_COMMENT	VARCHAR2(300 BYTE)
	private String memberId;	//	MEMBER_ID	VARCHAR2(20 BYTE)
	private String postcode;
	private String detailAddress;
	
	public Delivery() { }

	public Delivery(int deliCode, String deliName, String deliPhone, String deliAddress, String deliDefault,
			String deliComment, String memberId, String postcode, String detailAddress) {
		super();
		this.deliCode = deliCode;
		this.deliName = deliName;
		this.deliPhone = deliPhone;
		this.deliAddress = deliAddress;
		this.deliDefault = deliDefault;
		this.deliComment = deliComment;
		this.memberId = memberId;
		this.postcode = postcode;
		this.detailAddress = detailAddress;
	}



	public String getPostcode() {
		return postcode;
	}

	public void setPostcode(String postcode) {
		this.postcode = postcode;
	}

	public String getDetailAddress() {
		return detailAddress;
	}

	public void setDetailAddress(String detailAddress) {
		this.detailAddress = detailAddress;
	}

	public int getDeliCode() {
		return deliCode;
	}

	public void setDeliCode(int deliCode) {
		this.deliCode = deliCode;
	}

	public String getDeliName() {
		return deliName;
	}

	public void setDeliName(String deliName) {
		this.deliName = deliName;
	}

	public String getDeliPhone() {
		return deliPhone;
	}

	public void setDeliPhone(String deliPhone) {
		this.deliPhone = deliPhone;
	}

	public String getDeliAddress() {
		return deliAddress;
	}

	public void setDeliAddress(String deliAddress) {
		this.deliAddress = deliAddress;
	}

	public String getDeliDefault() {
		return deliDefault;
	}

	public void setDeliDefault(String deliDefault) {
		this.deliDefault = deliDefault;
	}

	public String getDeliComment() {
		return deliComment;
	}

	public void setDeliComment(String deliComment) {
		this.deliComment = deliComment;
	}

	public String getMemberId() {
		return memberId;
	}

	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}

	@Override
	public String toString() {
		return "Delivery [deliCode=" + deliCode + ", deliName=" + deliName + ", deliPhone=" + deliPhone
				+ ", deliAddress=" + deliAddress + ", deliDefault=" + deliDefault + ", deliComment=" + deliComment
				+ ", memberId=" + memberId + ", postcode=" + postcode + ", detailAddress=" + detailAddress + "]";
	}

	
}

