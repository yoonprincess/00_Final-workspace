package com.mig.blb.helpdesk.model.vo;

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
public class Faq {

	private int faqNo;
	private String faqTitle;
	private String faqContent;
	private String faqType;
	private String faqStatus;
	
}
