package com.mig.blb.helpdesk.model.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.mig.blb.common.model.vo.PageInfo;
import com.mig.blb.helpdesk.model.vo.Inquiry;
import com.mig.blb.helpdesk.model.vo.InquiryAtt;
import com.mig.blb.helpdesk.model.vo.InquiryReply;

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
	
	public int insertInquiryAtt(SqlSessionTemplate sqlSession, ArrayList<InquiryAtt> inquiryAtt) {
		
		int result = 0;
		
		// InquiryAtt리스트의 길이만큼 반복하여 INSERT 쿼리 실행
		for(InquiryAtt iatt : inquiryAtt) {
			result += sqlSession.insert("helpdeskMapper.insertInquiryAtt", iatt);
		}
		
		return result;
	}

	public Inquiry selectInquiry(SqlSessionTemplate sqlSession, int ino) {
		return sqlSession.selectOne("helpdeskMapper.selectInquiry", ino);
	}
	
	public ArrayList<InquiryAtt> selectInquiryAtt(SqlSessionTemplate sqlSession, int ino) {
		return (ArrayList)sqlSession.selectList("helpdeskMapper.selectInquiryAtt", ino);
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

	public ArrayList<Inquiry> selectInquiryListTop4(SqlSessionTemplate sqlSession, String memberId) {
		return (ArrayList)sqlSession.selectList("memberMapper.selectInquiryListTop4", memberId);
	}

	public int myProdQnaListCount(SqlSessionTemplate sqlSession, String memberId) {
		return sqlSession.selectOne("memberMapper.myProdQnaListCount", memberId);
	}

	public List<Map<String, Object>> selectMyProdQnaList(SqlSessionTemplate sqlSession, String memberId, PageInfo pi) {
		
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		int limit = pi.getBoardLimit();
		
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		return (ArrayList)sqlSession.selectList("memberMapper.selectMyProdQnaList", memberId, rowBounds);
	}

	public ArrayList<Inquiry> selectProdQnaTop4(SqlSessionTemplate sqlSession, String memberId) {
		return (ArrayList)sqlSession.selectList("memberMapper.selectProdQnaTop4", memberId);
	}

	public ArrayList<Inquiry> selectAdminInquiryList(SqlSessionTemplate sqlSession) {
		return (ArrayList)sqlSession.selectList("helpdeskMapper.selectAdminInquiryList");
	}

	public int deleteAtt(SqlSessionTemplate sqlSession, String deleteFileName) {
		return sqlSession.delete("helpdeskMapper.deleteInquiryAtt", deleteFileName);
	}

	public int updateAtt(SqlSessionTemplate sqlSession, InquiryAtt ia) {
		return sqlSession.update("helpdeskMapper.updateInquiryAtt", ia);
	}

	

	
}
