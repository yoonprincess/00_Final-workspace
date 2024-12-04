package com.mig.blb.helpdesk.model.vo;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@Setter
@Getter
@ToString
public class InquiryReply {

	private int inquiryReplyNo;
	private String inquiryReplyContent;
	private String inquiryReplyCreateDate;
	private String inquiryReplyYn;
	private String inquiryReplyStatus;
}
