package com.mig.blb.review.model.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.mig.blb.common.model.vo.PageInfo;
import com.mig.blb.review.model.vo.Review;

@Repository
public class ReviewDao {

	public int selectReviewCount(SqlSessionTemplate sqlSession, int prodNo) {
		return sqlSession.selectOne("reviewMapper.selectReviewCount", prodNo);
	}

	public ArrayList<Review> selectReviewList(SqlSessionTemplate sqlSession, PageInfo revPi, int prodNo) {

		int offset = (revPi.getCurrentPage() - 1) * revPi.getBoardLimit();
		int limit = revPi.getBoardLimit();
		
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		return (ArrayList)sqlSession.selectList("reviewMapper.selectReviewList", prodNo, rowBounds);
	}

	public Map<String, Object> selectReviewStats(SqlSessionTemplate sqlSession, int prodNo) {
		return sqlSession.selectOne("reviewMapper.selectReviewStats", prodNo);
	}
	
	public boolean isReviewWritten(SqlSessionTemplate sqlSession, int serialNo) {
		return (int)sqlSession.selectOne("reviewMapper.isReviewWritten", serialNo) > 0;
	}

	public int myReviewListCount(SqlSessionTemplate sqlSession, String memberId) {
		
		return sqlSession.selectOne("memberMapper.myReviewListCount", memberId);
	}

	public List<Map<String, Object>> selectMyReviewList(SqlSessionTemplate sqlSession, String memberId, PageInfo pi) {
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		int limit = pi.getBoardLimit();
		
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		return (ArrayList)sqlSession.selectList("memberMapper.selectMyReviewList", memberId, rowBounds);
	}

	public int insertReview(SqlSessionTemplate sqlSession, Review review) {
		int result = sqlSession.insert("reviewMapper.insertReview", review);
        
        return result;
	}
}
