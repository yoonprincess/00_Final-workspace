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
public class ProductBanner {
	
	private int prodBannerNo;		//	PROD_BANNER_NO	NUMBER
	private String origFileName;	//	ORIG_FILE_NAME	VARCHAR2(255 BYTE)
	private String saveFileName;	//	SAVE_FILE_NAME	VARCHAR2(255 BYTE)
	private String bannerPath;		//	BANNER_PATH	VARCHAR2(60 BYTE)
	private String mdPath;			//	MD_PATH	VARCHAR2(60 BYTE)
	private String bannerStatus;	//	BANNER_STATUS	CHAR(1 BYTE)
	private int prodNo;				//	PROD_NO	NUMBER

}
