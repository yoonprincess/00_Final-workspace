package com.mig.blb.helpdesk.model.vo;

import java.util.List;

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
public class Inquiry {

	private int inquiryNo;
	private String inquiryTitle;
	private String inquiryContent;
	private String inquiryType;
	private String inquiryCreateDate;
	private String inquiryAnsweredYn;
	private String inquiryStatus;
	private String memberId;
	private Integer prodNo;
	private String prodName;
	
	// 답변 리스트
    private List<InquiryReply> replyList;
	
}
