package com.mig.blb.review.model.dao;

import java.util.ArrayList;

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

}
