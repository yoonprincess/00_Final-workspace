package com.mig.blb.helpdesk.model.service.InquiryService;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mig.blb.common.model.vo.PageInfo;
import com.mig.blb.helpdesk.model.dao.InquiryDao;
import com.mig.blb.helpdesk.model.vo.Inquiry;
import com.mig.blb.helpdesk.model.vo.InquiryReply;
import com.mig.blb.member.model.vo.Member;

@Service
public class InquiryServiceImpl implements InquiryService {

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Autowired
	private InquiryDao inquiryDao;
	
	@Override
	public int selectInquiryListCount(String memberId) {
		return inquiryDao.selectInquiryListCount(sqlSession, memberId);
	}

	@Override
	public ArrayList<Inquiry> selectInquiryList(PageInfo pi, String memberId) {
		return inquiryDao.selectInquiryList(sqlSession, pi, memberId);
	}

	// 문의 등록
	@Override
	public int insertInquiry(Inquiry i) {

		return inquiryDao.insertInquiry(sqlSession, i);
	}

	@Override
	public Inquiry selectInquiry(int ino) {
		return inquiryDao.selectInquiry(sqlSession, ino);
	}

	@Override
	public int insertInquiryReply(InquiryReply ir) {
		return inquiryDao.insertInquiryReply(sqlSession, ir);
	}

	@Override
	public ArrayList<InquiryReply> selectInquiryReplyList(int ino) {
		return inquiryDao.selectInquiryReplyList(sqlSession, ino);
	}

	@Override
	public int deleteInquiry(int ino) {
		return inquiryDao.deleteInquiry(sqlSession, ino);
	}

	@Override
	public int updateInquiry(Inquiry i) {
		return inquiryDao.updateInquiry(sqlSession, i);
	}
}
