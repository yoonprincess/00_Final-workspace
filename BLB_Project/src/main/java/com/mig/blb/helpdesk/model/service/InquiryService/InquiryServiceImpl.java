package com.mig.blb.helpdesk.model.service.InquiryService;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.mig.blb.common.model.vo.PageInfo;
import com.mig.blb.helpdesk.model.dao.InquiryDao;
import com.mig.blb.helpdesk.model.vo.Inquiry;
import com.mig.blb.helpdesk.model.vo.InquiryAtt;
import com.mig.blb.helpdesk.model.vo.InquiryReply;

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
	@Transactional
	public int insertInquiry(Inquiry i, ArrayList<InquiryAtt> inquiryAtt) {

		int result1 = inquiryDao.insertInquiry(sqlSession, i);
		int result2 = inquiryDao.insertInquiryAtt(sqlSession, inquiryAtt);
		
		return result1 + result2;
	}

	@Override
	public Inquiry selectInquiry(int ino) {
		return inquiryDao.selectInquiry(sqlSession, ino);
	}

	@Override
	public ArrayList<InquiryAtt> selectInquiryAtt(int ino){ 
		return inquiryDao.selectInquiryAtt(sqlSession, ino);
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

	@Override
	public ArrayList<Inquiry> selectInquiryListTop4(String memberId) {
		return inquiryDao.selectInquiryListTop4(sqlSession, memberId);
	}
	
	@Override
	public ArrayList<Inquiry> selectProdQnaTop4(String memberId) {
		return inquiryDao.selectProdQnaTop4(sqlSession, memberId);
	}
	
	@Override
	public int myProdQnaListCount(String memberId) {
		
		return inquiryDao.myProdQnaListCount(sqlSession,memberId);
	}

	@Override
	public List<Map<String, Object>> selectMyProdQnaList(String memberId, PageInfo pi) {
		
		return inquiryDao.selectMyProdQnaList(sqlSession,memberId,pi);
	}

	@Override
	public ArrayList<Inquiry> selectAdminInquiryList() {
		return inquiryDao.selectAdminInquiryList(sqlSession);
	}

	@Override
	public int deleteAtt(String deleteFileName) {
		return inquiryDao.deleteAtt(sqlSession, deleteFileName);
	}

	@Override
	public int updateAtt(InquiryAtt ia) {
		return inquiryDao.updateAtt(sqlSession, ia);
	}


}
