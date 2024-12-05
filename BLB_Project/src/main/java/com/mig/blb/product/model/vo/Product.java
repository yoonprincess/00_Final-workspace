package com.mig.blb.product.model.vo;

import java.sql.Timestamp;

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
	
	public Product() { }

	public Product(int prodNo, String categoryName, String prodName, String prodContent, int prodPrice,
			String prodOrigin, String prodCaution, int prodCount, Timestamp prodEnrollDate, String prodStatus) {
		super();
		this.prodNo = prodNo;
		this.categoryName = categoryName;
		this.prodName = prodName;
		this.prodContent = prodContent;
		this.prodPrice = prodPrice;
		this.prodOrigin = prodOrigin;
		this.prodCaution = prodCaution;
		this.prodCount = prodCount;
		this.prodEnrollDate = prodEnrollDate;
		this.prodStatus = prodStatus;
	}

	public int getProdNo() {
		return prodNo;
	}

	public void setProdNo(int prodNo) {
		this.prodNo = prodNo;
	}

	public String getCategoryName() {
		return categoryName;
	}

	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
	}

	public String getProdName() {
		return prodName;
	}

	public void setProdName(String prodName) {
		this.prodName = prodName;
	}

	public String getProdContent() {
		return prodContent;
	}

	public void setProdContent(String prodContent) {
		this.prodContent = prodContent;
	}

	public int getProdPrice() {
		return prodPrice;
	}

	public void setProdPrice(int prodPrice) {
		this.prodPrice = prodPrice;
	}

	public String getProdOrigin() {
		return prodOrigin;
	}

	public void setProdOrigin(String prodOrigin) {
		this.prodOrigin = prodOrigin;
	}

	public String getProdCaution() {
		return prodCaution;
	}

	public void setProdCaution(String prodCaution) {
		this.prodCaution = prodCaution;
	}

	public int getProdCount() {
		return prodCount;
	}

	public void setProdCount(int prodCount) {
		this.prodCount = prodCount;
	}

	public Timestamp getProdEnrollDate() {
		return prodEnrollDate;
	}

	public void setProdEnrollDate(Timestamp prodEnrollDate) {
		this.prodEnrollDate = prodEnrollDate;
	}

	public String getProdStatus() {
		return prodStatus;
	}

	public void setProdStatus(String prodStatus) {
		this.prodStatus = prodStatus;
	}

	@Override
	public String toString() {
		return "Product [prodNo=" + prodNo + ", categoryName=" + categoryName + ", prodName=" + prodName
				+ ", prodContent=" + prodContent + ", prodPrice=" + prodPrice + ", prodOrigin=" + prodOrigin
				+ ", prodCaution=" + prodCaution + ", prodCount=" + prodCount + ", prodEnrollDate=" + prodEnrollDate
				+ ", prodStatus=" + prodStatus + "]";
	}
	
}
