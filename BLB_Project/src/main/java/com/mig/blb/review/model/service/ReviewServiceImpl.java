package com.mig.blb.review.model.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mig.blb.common.model.vo.PageInfo;
import com.mig.blb.review.model.dao.ReviewDao;
import com.mig.blb.review.model.vo.Review;

@Service
public class ReviewServiceImpl implements ReviewService {

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Autowired
	private ReviewDao reviewDao;
	
	@Override
	public int selectReviewCount(int prodNo) {
		return reviewDao.selectReviewCount(sqlSession, prodNo);
	}

	@Override
	public ArrayList<Review> selectReviewList(PageInfo revPi, int prodNo) {
		return reviewDao.selectReviewList(sqlSession, revPi, prodNo);
	}

	@Override
	public Map<String, Object> selectReviewStats(int prodNo) {
		return reviewDao.selectReviewStats(sqlSession, prodNo);
	}

	@Override
	public int myReviewListCount(String memberId) {
		
		return reviewDao.myReviewListCount(sqlSession,memberId);
	}

	@Override
	public List<Map<String, Object>> selectMyReviewList(String memberId, PageInfo pi) {

		return reviewDao.selectMyReviewList(sqlSession,memberId,pi);
	}
	
	@Override
	public boolean isReviewWritten(int serialNo) {
		return reviewDao.isReviewWritten(sqlSession, serialNo);
	}
	
	@Override
	public int insertReview(Review review) {
		return reviewDao.insertReview(sqlSession, review);
	}

}
