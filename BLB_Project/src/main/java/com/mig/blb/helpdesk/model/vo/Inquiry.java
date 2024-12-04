package com.mig.blb.helpdesk.model.vo;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@Setter
@Getter
@ToString
public class Inquiry {

	private int inquiryNo;
	private String inquiryTitle;
	private String inquiryContent;
	private String inquiryType;
	private String inquiryCreateDate;
	private String inquiryAnsweredYn;
	private String inquiryStatus;
}
