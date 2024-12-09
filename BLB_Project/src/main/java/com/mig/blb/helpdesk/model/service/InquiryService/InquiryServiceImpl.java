package com.mig.blb.helpdesk.model.service.InquiryService;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mig.blb.common.model.vo.PageInfo;
import com.mig.blb.helpdesk.model.dao.InquiryDao;
import com.mig.blb.helpdesk.model.vo.Inquiry;
import com.mig.blb.helpdesk.model.vo.InquiryReply;

@Service
public class InquiryServiceImpl implements InquiryService {

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Autowired
	private InquiryDao inquiryDao;
	
	@Override
	public int selectInquiryListCount() {
		return inquiryDao.selectInquiryListCount(sqlSession);
	}

	@Override
	public ArrayList<Inquiry> selectInquiryList(PageInfo pi) {
		return inquiryDao.selectInquiryList(sqlSession, pi);
	}

	// 문의 등록
	@Override
	public int insertInquiry(Inquiry i) {
		System.out.println("service단에서 : " + i);
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
}
