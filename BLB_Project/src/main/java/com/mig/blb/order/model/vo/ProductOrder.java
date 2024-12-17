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
	private String orderNo;
	private int optNo;

	// 마이바티스에서 collection 연결용
    private ArrayList<Option> option; 
}
