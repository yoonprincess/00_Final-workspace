package com.mig.blb.helpdesk.model.service.InquiryService;

import java.util.ArrayList;

import com.mig.blb.common.model.vo.PageInfo;
import com.mig.blb.helpdesk.model.vo.Inquiry;

public interface InquiryService {

	int selectInquiryListCount();

	ArrayList<Inquiry> selectInquiryList(PageInfo pi);
	
	int insertInquiry(Inquiry i);
}
