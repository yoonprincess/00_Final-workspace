package com.mig.blb.product.model.vo;

import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@AllArgsConstructor
@Setter
@Getter
@ToString
public class Product {

	private int prodNo;					//	PROD_NO	NUMBER
	private String categoryName;		//	CATEGORY_NAME	VARCHAR2(60 BYTE)
	private String prodName;			//	PROD_NAME	VARCHAR2(300 BYTE)
	private String prodContent;			//	PROD_CONTENT	VARCHAR2(3900 BYTE)
	private int prodPrice;				//	PROD_PRICE	NUMBER
	private String prodOrigin;			//	PROD_ORIGIN	VARCHAR2(1500 BYTE)
	private String prodCaution;			//	PROD_CAUTION	VARCHAR2(1500 BYTE)
	private int prodCount;				//	PROD_COUNT	NUMBER
	private Timestamp prodEnrollDate;	//	PROD_ENROLL_DATE	DATE
	private String prodStatus;			//	PROD_STATUS	CHAR(1 BYTE)
}
