package com.mig.blb.helpdesk.model.service.InquiryReplyService;

import java.util.ArrayList;

import com.mig.blb.helpdesk.model.vo.InquiryReply;

public interface InquiryReplyService {

	// 댓글 리스트 조회 서비스 (Ajax)
	ArrayList<InquiryReply> selectInquiryReplyList(int ino);
	
	// 댓글 작성 서비스 (Ajax)
	int insertInquiryReply(InquiryReply r);

	// 댓글 삭제 서비스
	int deleteInquiryReply(int ino);

	int updateInquiryReply(InquiryReply ir);
	
}
