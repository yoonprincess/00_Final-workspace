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
public class InquiryReply {

	private int inquiryReplyNo;
	private String inquiryReplyContent;
	private String inquiryReplyCreateDate;
	private String inquiryReplyYn;
	private String inquiryReplyStatus;
	private int inquiryNo;
	private String memberId;
	
}
