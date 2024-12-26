package com.mig.blb.product.model.vo;

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
public class Product {

	private int prodNo;					//	PROD_NO	NUMBER
	private String categoryName;		//	CATEGORY_NAME	VARCHAR2(60 BYTE)
	private String subcategoryName;		//	SUBCATEGORY_NAME	VARCHAR2(60 BYTE)
	private String prodName;			//	PROD_NAME	VARCHAR2(300 BYTE)
	private String prodContent;			//	PROD_CONTENT	VARCHAR2(3900 BYTE)
	private int prodPrice;				//	PROD_PRICE	NUMBER
	private String prodOrigin;			//	PROD_ORIGIN	VARCHAR2(1500 BYTE)
	private String prodCaution;			//	PROD_CAUTION	VARCHAR2(1500 BYTE)
	private int prodCount;				//	PROD_COUNT	NUMBER
	private Timestamp prodEnrollDate;	//	PROD_ENROLL_DATE	DATE
	private String prodStatus;			//	PROD_STATUS	CHAR(1 BYTE)
	private String thumbImg;			//	PA.THUMB_PATH || PA.SAVE_FILE_NAME AS "THUMB_IMG"
	
	// 추가된 필드
    private float avgRating; 		    // AVG_RATING 평균 별점
    private int reviewCount;     		// REVIEW_COUNT 리뷰 개수
    private int isWished;				// IS_WISHED 찜한 상태
    private int totalSales;				// TOTAL_SALES 전체 판매수
    private int totalQty;				// TOTAL_QTY 전체 재고수
    private String bannerPath;			//	PB.BANNER_PATH || PB.SAVE_FILE_NAME AS "BANNER_IMG"
    private String mdPath;				//	PM.MD_PATH || PM.SAVE_FILE_NAME AS "MD_IMG"
    private String bannerFileName;		//	PB.SAVE_FILE_NAME
    
    
		
}
