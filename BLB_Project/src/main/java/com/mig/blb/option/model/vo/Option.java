package com.mig.blb.option.model.vo;

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
}
