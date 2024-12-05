package com.mig.blb.helpdesk.model.vo;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@Setter
@Getter
@ToString
public class Faq {

	private int FaqNo;
	private String FaqTitle;
	private String FaqContent;
	private String FaqType;
	private String FaqStatus;
}
