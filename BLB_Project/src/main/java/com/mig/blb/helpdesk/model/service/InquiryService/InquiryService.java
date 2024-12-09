package com.mig.blb.helpdesk.model.service.InquiryService;

import java.util.ArrayList;

import com.mig.blb.common.model.vo.PageInfo;
import com.mig.blb.helpdesk.model.vo.Inquiry;
import com.mig.blb.helpdesk.model.vo.InquiryReply;

public interface InquiryService {

	int selectInquiryListCount();

	ArrayList<Inquiry> selectInquiryList(PageInfo pi);
	
	int insertInquiry(Inquiry i);

	Inquiry selectInquiry(int ino);

	int insertInquiryReply(InquiryReply ir);

	ArrayList<InquiryReply> selectInquiryReplyList(int ino);
}
