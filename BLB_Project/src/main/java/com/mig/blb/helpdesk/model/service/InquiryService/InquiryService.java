package com.mig.blb.helpdesk.model.service.InquiryService;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.mig.blb.common.model.vo.PageInfo;
import com.mig.blb.helpdesk.model.vo.Inquiry;
import com.mig.blb.helpdesk.model.vo.InquiryAtt;
import com.mig.blb.helpdesk.model.vo.InquiryReply;

public interface InquiryService {

	int selectInquiryListCount(String memberId);

	ArrayList<Inquiry> selectInquiryList(PageInfo pi, String memberId);
	
	int insertInquiry(Inquiry i, ArrayList<InquiryAtt> inquiryAtt);

	Inquiry selectInquiry(int ino);
	
	ArrayList<InquiryAtt> selectInquiryAtt(int ino);

	int insertInquiryReply(InquiryReply ir);

	ArrayList<InquiryReply> selectInquiryReplyList(int ino);

	int deleteInquiry(int ino);

	int updateInquiry(Inquiry i);

	ArrayList<Inquiry> selectInquiryListTop4(String memberId);
	
	ArrayList<Inquiry> selectProdQnaTop4(String memberId);
	
	int myProdQnaListCount(String memberId);

	List<Map<String, Object>> selectMyProdQnaList(String memberId, PageInfo pi);

	ArrayList<Inquiry> selectAdminInquiryList();

	int deleteAtt(String deleteFileName);

	int updateAtt(InquiryAtt ia);

	
}
