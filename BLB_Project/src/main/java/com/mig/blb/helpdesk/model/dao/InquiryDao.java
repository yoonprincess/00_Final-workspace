package com.mig.blb.helpdesk.model.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.mig.blb.common.model.vo.PageInfo;
import com.mig.blb.helpdesk.model.vo.Inquiry;

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
		return sqlSession.insert("helpdeskMapper.insertInquiry", i);
	}

	
}
