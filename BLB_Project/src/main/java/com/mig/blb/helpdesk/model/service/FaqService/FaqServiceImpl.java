package com.mig.blb.helpdesk.model.service.FaqService;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mig.blb.common.model.vo.PageInfo;
import com.mig.blb.helpdesk.model.dao.FaqDao;
import com.mig.blb.helpdesk.model.vo.Faq;

@Service
public class FaqServiceImpl implements FaqService{

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Autowired
	private FaqDao faqDao;
	
	@Override
	public int selectFaqListCount() {
		return faqDao.selectFaqListCount(sqlSession);
	}

	@Override
	public ArrayList<Faq> selectFaqList(PageInfo pi) {
		return faqDao.selectFaqList(sqlSession, pi);
	}

	@Override
	public int insertFaq(Faq f) {
		return faqDao.insertFaq(sqlSession, f);
	}

	@Override
	public int deleteFaq(int fno) {
		return faqDao.deleteFaq(sqlSession, fno);
	}

	@Override
	public int updateFaq(Faq f) {
		return faqDao.updateFaq(sqlSession, f);
	}

	@Override
	public ArrayList<Faq> selectFaqList() {
		return faqDao.selectFaqList(sqlSession);
	}

}
