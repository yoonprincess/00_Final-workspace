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
import com.mig.blb.review.model.vo.ReviewAtt;

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
	
	public boolean isReviewWritten(SqlSessionTemplate sqlSession, String serialNo) {
		return (int)sqlSession.selectOne("reviewMapper.isReviewWritten", serialNo) > 0;
	}

	public int myReviewListCount(SqlSessionTemplate sqlSession, String memberId) {
		
		return sqlSession.selectOne("memberMapper.myReviewListCount", memberId);
	}

	public ArrayList<Review> selectMyReviewList(SqlSessionTemplate sqlSession, String memberId, PageInfo pi) {
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		int limit = pi.getBoardLimit();
		
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		return (ArrayList)sqlSession.selectList("memberMapper.selectMyReviewList", memberId, rowBounds);
	}

	public int insertReview(SqlSessionTemplate sqlSession, Review review) {
        
        return sqlSession.insert("reviewMapper.insertReview", review);
	}

	public int insertReviewAtt(SqlSessionTemplate sqlSession, ReviewAtt ra) {
		
		return sqlSession.insert("reviewMapper.insertReviewAtt", ra);
	}

	public List<ReviewAtt> getAllReviewAtt(SqlSessionTemplate sqlSession, int prodNo) {
		return (List)sqlSession.selectList("reviewMapper.getAllReviewAtt", prodNo);
	}

	public Review selectReview(SqlSessionTemplate sqlSession, int revNo) {
		return sqlSession.selectOne("reviewMapper.selectReview", revNo);
	}

	public int updateReview(SqlSessionTemplate sqlSession, Review review) {
		return sqlSession.update("reviewMapper.updateReview", review);
	}

	public int deleteReviewAtt(SqlSessionTemplate sqlSession, String saveFileName) {
		return sqlSession.delete("reviewMapper.deleteReviewAtt", saveFileName);
	}

	public int updateReviewAtt(SqlSessionTemplate sqlSession, ReviewAtt ra) {
		return sqlSession.insert("reviewMapper.updateReviewAtt", ra);
	}

	public int deleteReview(SqlSessionTemplate sqlSession, int revNo) {
		return sqlSession.update("reviewMapper.deleteReview", revNo);
	}

	public ArrayList<Review> selectReviewAll(SqlSessionTemplate sqlSession, PageInfo revPi) {
		int offset = (revPi.getCurrentPage() - 1) * revPi.getBoardLimit();
		int limit = revPi.getBoardLimit();
		
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		return (ArrayList)sqlSession.selectList("reviewMapper.selectReviewAll", null, rowBounds);
	}

	public List<ReviewAtt> allReviewAtt(SqlSessionTemplate sqlSession) {
		return (List)sqlSession.selectList("reviewMapper.allReviewAtt");
	}

	public int selectReviewAllCount(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("reviewMapper.selectReviewAllCount");
	}
}
