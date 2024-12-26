package com.mig.blb.helpdesk.model.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.mig.blb.common.model.vo.PageInfo;
import com.mig.blb.helpdesk.model.vo.Faq;

@Repository
public class FaqDao {

	public int selectFaqListCount(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("helpdeskMapper.selectListCount");
	}

	public ArrayList<Faq> selectFaqList(SqlSessionTemplate sqlSession, PageInfo pi) {
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		int limit = pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, limit);
		return (ArrayList)sqlSession.selectList("helpdeskMapper.selectFaqList", null, rowBounds);
	}

	public int insertFaq(SqlSessionTemplate sqlSession, Faq n) {
		return sqlSession.insert("helpdeskMapper.insertFaq", n);
	}
	
	public int deleteFaq(SqlSessionTemplate sqlSession, int nno) {
		return sqlSession.update("helpdeskMapper.deleteFaq", nno);
	}
	
	public int updateFaq(SqlSessionTemplate sqlSession, Faq n) {
        return sqlSession.update("helpdeskMapper.updateFaq", n);
    }

	public ArrayList<Faq> selectFaqList(SqlSessionTemplate sqlSession) {
		return (ArrayList)sqlSession.selectList("helpdeskMapper.selectAdminFaqList");
	}

}
