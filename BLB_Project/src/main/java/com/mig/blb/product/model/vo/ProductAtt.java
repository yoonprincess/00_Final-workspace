package com.mig.blb.product.model.vo;

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
public class ProductAtt {

	private int prodAttNo;			//	PROD_ATT_NO	NUMBER
	private String origFileName;	//	ORIG_FILE_NAME	VARCHAR2(255 BYTE)
	private String saveFileName;	//	SAVE_FILE_NAME	VARCHAR2(255 BYTE)
	private String savePath;		//	SAVE_PATH	VARCHAR2(60 BYTE)
	private String thumbPath;		//	THUMB_PATH	VARCHAR2(60 BYTE)
	private String prodAttStatus;	//	PROD_ATT_STATUS	CHAR(1 BYTE)
	private int prodNo;				//	PROD_NO	NUMBER
}
