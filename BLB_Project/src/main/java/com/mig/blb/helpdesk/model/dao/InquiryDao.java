package com.mig.blb.helpdesk.model.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.mig.blb.common.model.vo.PageInfo;
import com.mig.blb.helpdesk.model.vo.Inquiry;
import com.mig.blb.helpdesk.model.vo.InquiryReply;

@Repository
public class InquiryDao {
	
	public int selectInquiryListCount(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("helpdeskMapper.selectInquiryListCount");
	}
	
	public ArrayList<Inquiry> selectInquiryList(SqlSessionTemplate sqlSession, PageInfo pi){
		
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		int limit = pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, limit);
		return (ArrayList)sqlSession.selectList("helpdeskMapper.selectInquiryList", null, rowBounds);
		
	}

	public int insertInquiry(SqlSessionTemplate sqlSession, Inquiry i) {
		System.out.println("dao단에서 : " + i);
		return sqlSession.insert("helpdeskMapper.insertInquiry", i);
	}

	public Inquiry selectInquiry(SqlSessionTemplate sqlSession, int ino) {
		return sqlSession.selectOne("helpdeskMapper.selectInquiry", ino);
	}

	public int insertInquiryReply(SqlSessionTemplate sqlSession, InquiryReply ir) {
		return sqlSession.insert("helpdeskMapper.insertInquiryReply",ir);
	}

	public ArrayList<InquiryReply> selectInquiryReplyList(SqlSessionTemplate sqlSession, int ino) {
		return (ArrayList)sqlSession.selectList("helpdeskMapper.selectInquiryReplyList", ino);
	}

	
}
