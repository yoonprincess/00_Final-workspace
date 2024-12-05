package com.mig.blb.member.model.vo;

import java.sql.Date;

public class Member {
	
	// 필드부
	private String memberId;		//	MEMBER_ID	VARCHAR2(20 BYTE)
	private String memberName;		//	MEMBER_NAME	VARCHAR2(20 BYTE)
	private String memberPwd;		//	MEMBER_PWD	VARCHAR2(150 BYTE)
	private String phone;			//	PHONE	CHAR(11 BYTE)
	private String email;			//	EMAIL	VARCHAR2(30 BYTE)
	private String birthdate;		//	BIRTHDATE	DATE
	private Date createDate;		//	CREATE_DATE	DATE
	private Date deleteDate;		//	DELETE_DATE	DATE
	private String status;			//	STATUS	CHAR(1 BYTE)
	private String totalPoints;		//	TOTAL_POINTS	NUMBER
	private String currentPoints;	//	CURRENT_POINTS	NUMBER
	private String gradeName;		//	GRADE_NAME	VARCHAR2(20 BYTE)
			
	public Member() { }

	public Member(String memberId, String memberName, String memberPwd, String phone, String email, String birthdate,
			Date createDate, Date deleteDate, String status, String totalPoints, String currentPoints,
			String gradeName) {
		super();
		this.memberId = memberId;
		this.memberName = memberName;
		this.memberPwd = memberPwd;
		this.phone = phone;
		this.email = email;
		this.birthdate = birthdate;
		this.createDate = createDate;
		this.deleteDate = deleteDate;
		this.status = status;
		this.totalPoints = totalPoints;
		this.currentPoints = currentPoints;
		this.gradeName = gradeName;
	}

	public String getMemberId() {
		return memberId;
	}

	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}

	public String getMemberName() {
		return memberName;
	}

	public void setMemberName(String memberName) {
		this.memberName = memberName;
	}

	public String getMemberPwd() {
		return memberPwd;
	}

	public void setMemberPwd(String memberPwd) {
		this.memberPwd = memberPwd;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getBirthdate() {
		return birthdate;
	}

	public void setBirthdate(String birthdate) {
		this.birthdate = birthdate;
	}

	public Date getCreateDate() {
		return createDate;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}

	public Date getDeleteDate() {
		return deleteDate;
	}

	public void setDeleteDate(Date deleteDate) {
		this.deleteDate = deleteDate;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getTotalPoints() {
		return totalPoints;
	}

	public void setTotalPoints(String totalPoints) {
		this.totalPoints = totalPoints;
	}

	public String getCurrentPoints() {
		return currentPoints;
	}

	public void setCurrentPoints(String currentPoints) {
		this.currentPoints = currentPoints;
	}

	public String getGradeName() {
		return gradeName;
	}

	public void setGradeName(String gradeName) {
		this.gradeName = gradeName;
	}

	@Override
	public String toString() {
		return "Member [memberId=" + memberId + ", memberName=" + memberName + ", memberPwd=" + memberPwd + ", phone="
				+ phone + ", email=" + email + ", birthdate=" + birthdate + ", createDate=" + createDate
				+ ", deleteDate=" + deleteDate + ", status=" + status + ", totalPoints=" + totalPoints
				+ ", currentPoints=" + currentPoints + ", gradeName=" + gradeName + "]";
	}
	
}
