package com.mig.blb.cart.model.vo;

import java.util.ArrayList;

import com.mig.blb.option.model.vo.Option;

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
public class Cart {
	
	private int cartNo;			//	CART_NO	NUMBER
	private String memberId;	//	MEMBER_ID	VARCHAR2(20 BYTE)
	private int prodNo;			//	PROD_NO	NUMBER
	private int optNo;			//	OPT_NO	NUMBER
	private int cartQty;		//	CART_QTY	NUMBER
	
	private String prodName;
	private String optName;
	private int optAddPrice;
	private int remainQty;
	private int prodPrice;
	private String thumbImg;
	
    private ArrayList<Option> optionList;
	
}
