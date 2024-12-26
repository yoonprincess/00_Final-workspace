package com.mig.blb.option.model.vo;

import java.util.ArrayList;

import com.mig.blb.order.model.vo.ProductOrder;
import com.mig.blb.product.model.vo.Product;

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
public class Option {

	private int optNo; 			// OPT_NO NUMBER
    private String optName;		// OPT_NAME VARCHAR2(90 BYTE)
    private String optValue;	// OPT_VALUE VARCHAR2(90 BYTE)
    private int optAddPrice; 	// OPT_ADD_PRICE NUMBER
    private int remainQty; 		// REMAIN_QTY NUMBER
    private int prodNo; 		// PROD_NO NUMBER
    private String prodName;	//	PROD_NAME	VARCHAR2(300 BYTE)
    private int prodPrice;		//	PROD_PRICE	NUMBER
    
    // 마이바티스에서 collection 연결용
    private ArrayList<Product> product; 
}
