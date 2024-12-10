package com.mig.blb.helpdesk.model.service.InquiryService;

import java.util.ArrayList;

import com.mig.blb.common.model.vo.PageInfo;
import com.mig.blb.helpdesk.model.vo.Inquiry;
import com.mig.blb.helpdesk.model.vo.InquiryReply;
import com.mig.blb.member.model.vo.Member;

public interface InquiryService {

	int selectInquiryListCount(String memberId);

	ArrayList<Inquiry> selectInquiryList(PageInfo pi, String memberId);
	
	int insertInquiry(Inquiry i);

	Inquiry selectInquiry(int ino);

	int insertInquiryReply(InquiryReply ir);

	ArrayList<InquiryReply> selectInquiryReplyList(int ino);

	int deleteInquiry(int ino);

	int updateInquiry(Inquiry i);
}
