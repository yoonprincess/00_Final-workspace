package com.mig.blb.order.model.vo;

import java.sql.Date;
import java.util.ArrayList;

import com.mig.blb.option.model.vo.Option;
import com.mig.blb.product.model.vo.Product;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@Setter
@Getter
@ToString
public class ProductOrder {
	
//	SERIAL_NO	VARCHAR2(30 BYTE)
//	ORDER_QTY	NUMBER
//	TOTAL_AMT	NUMBER
//	ORDER_NO	VARCHAR2(30 BYTE)
//	OPT_NO	NUMBER
	
	private String serialNo;
	private int orderQty;
	private int totalAmt;
	private int orderNo;
	private int optNo;
	
	private int prodNo;
	private String prodName;
	private String optName;
	private int optAddPrice;
	private int remainQty;
	private int prodPrice;
	private String thumbImg;
	private int cartNo;
	private int isWritten;
	
	// 마이바티스에서 collection 연결용
    private ArrayList<Option> option; 
    
    
}
