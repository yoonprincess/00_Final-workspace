package com.mig.blb.helpdesk.model.service.InquiryReplyService;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.mig.blb.helpdesk.model.dao.InquiryReplyDao;
import com.mig.blb.helpdesk.model.vo.InquiryReply;

@Service
public class InquiryReplyServiceImpl implements InquiryReplyService {

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Autowired
	private InquiryReplyDao inquiryReplyDao;
	
	@Override
	public ArrayList<InquiryReply> selectInquiryReplyList(int ino) {
		return inquiryReplyDao.selectInquiryReplyList(sqlSession, ino);
	}

	@Override
	@Transactional
	public int insertInquiryReply(InquiryReply r) {
		return inquiryReplyDao.insertInquiryReply(sqlSession, r);
	}

	@Override
	public int deleteInquiryReply(int ino) {
		return inquiryReplyDao.deleteInquiryReply(sqlSession, ino);
	}

	@Override
	public int updateInquiryReply(InquiryReply ir) {
		return inquiryReplyDao.updateInquiryReply(sqlSession, ir);
	}
	
}
