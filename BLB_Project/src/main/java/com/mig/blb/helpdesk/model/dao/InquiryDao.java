package com.mig.blb.helpdesk.model.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.mig.blb.common.model.vo.PageInfo;
import com.mig.blb.helpdesk.model.vo.Inquiry;
import com.mig.blb.helpdesk.model.vo.InquiryReply;
import com.mig.blb.member.model.vo.Member;

@Repository
public class InquiryDao {
	
	public int selectInquiryListCount(SqlSessionTemplate sqlSession, String memberId) {
		return sqlSession.selectOne("helpdeskMapper.selectInquiryListCount",memberId);
	}
	
	public ArrayList<Inquiry> selectInquiryList(SqlSessionTemplate sqlSession, PageInfo pi, String memberId){
		
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		int limit = pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, limit);
		return (ArrayList)sqlSession.selectList("helpdeskMapper.selectInquiryList", memberId , rowBounds);
		
	}

	public int insertInquiry(SqlSessionTemplate sqlSession, Inquiry i) {
		//System.out.println("dao단에서 : " + i);
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

	public int deleteInquiry(SqlSessionTemplate sqlSession, int ino) {
		return sqlSession.update("helpdeskMapper.deleteInquiry", ino);
	}

	public int updateInquiry(SqlSessionTemplate sqlSession, Inquiry i) {
		return sqlSession.update("helpdeskMapper.updateInquiry", i);
	}

	
}
