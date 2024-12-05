package com.mig.blb.review.model.vo;

import java.sql.Timestamp;

public class Review {
	
	private int revNo;					//	REV_NO	NUMBER
	private String revTitle;			//	REV_TITLE	VARCHAR2(300 BYTE)
	private String revContent;			//	REV_CONTENT	VARCHAR2(1500 BYTE)
	private Timestamp revEnrollDate;	//	REV_ENROLL_DATE	DATE
	private float revRating; 			//	REV_RATING	NUMBER
	private String revStatus;			//	REV_STATUS	CHAR(1 BYTE)
	private String orderNo;				//	ORDER_NO	VARCHAR2(50 BYTE)
	private String memberId;			//	MEMBER_ID	VARCHAR2(20 BYTE)
	
	public Review() { }

	public Review(int revNo, String revTitle, String revContent, Timestamp revEnrollDate, float revRating,
			String revStatus, String orderNo, String memberId) {
		super();
		this.revNo = revNo;
		this.revTitle = revTitle;
		this.revContent = revContent;
		this.revEnrollDate = revEnrollDate;
		this.revRating = revRating;
		this.revStatus = revStatus;
		this.orderNo = orderNo;
		this.memberId = memberId;
	}

	public int getRevNo() {
		return revNo;
	}

	public void setRevNo(int revNo) {
		this.revNo = revNo;
	}

	public String getRevTitle() {
		return revTitle;
	}

	public void setRevTitle(String revTitle) {
		this.revTitle = revTitle;
	}

	public String getRevContent() {
		return revContent;
	}

	public void setRevContent(String revContent) {
		this.revContent = revContent;
	}

	public Timestamp getRevEnrollDate() {
		return revEnrollDate;
	}

	public void setRevEnrollDate(Timestamp revEnrollDate) {
		this.revEnrollDate = revEnrollDate;
	}

	public float getRevRating() {
		return revRating;
	}

	public void setRevRating(float revRating) {
		this.revRating = revRating;
	}

	public String getRevStatus() {
		return revStatus;
	}

	public void setRevStatus(String revStatus) {
		this.revStatus = revStatus;
	}

	public String getOrderNo() {
		return orderNo;
	}

	public void setOrderNo(String orderNo) {
		this.orderNo = orderNo;
	}

	public String getMemberId() {
		return memberId;
	}

	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}

	@Override
	public String toString() {
		return "Review [revNo=" + revNo + ", revTitle=" + revTitle + ", revContent=" + revContent + ", revEnrollDate="
				+ revEnrollDate + ", revRating=" + revRating + ", revStatus=" + revStatus + ", orderNo=" + orderNo
				+ ", memberId=" + memberId + "]";
	}
	
}
