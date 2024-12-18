package com.mig.blb.member.model.vo;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@ToString
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
	private String deliNickname;
	private String homeAddressYN;
	
}

