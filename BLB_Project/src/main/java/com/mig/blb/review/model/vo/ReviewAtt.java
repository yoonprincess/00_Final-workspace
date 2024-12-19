package com.mig.blb.review.model.vo;

import java.sql.Timestamp;

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
public class ReviewAtt {

	private int revAttNo;			//	REV_ATT_NO	NUMBER
	private String origFileName;	//	ORIG_FILE_NAME	VARCHAR2(255 BYTE)
	private String saveFileName;	//	SAVE_FILE_NAME	VARCHAR2(255 BYTE)
	private String savePath;		//	SAVE_PATH	VARCHAR2(60 BYTE)
	private String thumbPath;		//	THUMB_PATH	VARCHAR2(60 BYTE)
	private String revAttStatus;	//	REV_ATT_STATUS	CHAR(1 BYTE)
	private int revNo;				//	REV_NO	NUMBER
}
