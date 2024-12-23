package com.mig.blb.review.model.vo;

import java.sql.Timestamp;
import java.sql.Date;
import java.util.List;

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
public class Review {
	
	private int revNo;					//	REV_NO	NUMBER
	private String revTitle;			//	REV_TITLE	VARCHAR2(300 BYTE)
	private String revContent;			//	REV_CONTENT	VARCHAR2(1500 BYTE)
	private Timestamp revEnrollDate;	//	REV_ENROLL_DATE	DATE
	private float revRating; 				//	REV_RATING	NUMBER
	private String revStatus;			//	REV_STATUS	CHAR(1 BYTE)
	private String serialNo;			//	SERIAL_NO	VARCHAR2(30 BYTE)
	private String memberId;			//	MEMBER_ID	VARCHAR2(20 BYTE)
	private int optNo;					//	OPT_NO	NUMBER
	private String optName;				//	OPT_NAME	VARCHAR2(90 BYTE)
	private String optValue;			//	OPT_VALUE	VARCHAR2(90 BYTE)
	
	private String prodName;
	private int prodNo;
	private String orderDate;
	private String thumbImg;
	
	
	
	// 리뷰 첨부파일 리스트
	private List<ReviewAtt> reviewAttList;
		
}
