package com.mig.blb.review.model.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.mig.blb.common.model.vo.PageInfo;
import com.mig.blb.review.model.dao.ReviewDao;
import com.mig.blb.review.model.vo.Review;
import com.mig.blb.review.model.vo.ReviewAtt;

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
	public ArrayList<Review> selectMyReviewList(String memberId, PageInfo pi) {

		return reviewDao.selectMyReviewList(sqlSession,memberId,pi);
	}
	
	@Override
	public boolean isReviewWritten(String serialNo) {
		return reviewDao.isReviewWritten(sqlSession, serialNo);
	}
	
	@Override
	@Transactional
	public int insertReview(Review review) {
		return reviewDao.insertReview(sqlSession, review);
	}

	@Override
	@Transactional
	public int insertReviewAtt(ReviewAtt ra) {
		return reviewDao.insertReviewAtt(sqlSession, ra);
	}

	@Override
	public List<ReviewAtt> getAllReviewAtt(int prodNo) {
		return reviewDao.getAllReviewAtt(sqlSession, prodNo);
	}

	@Override
	public Review selectReview(int revNo) {
		return reviewDao.selectReview(sqlSession, revNo);
	}

	@Override
	@Transactional
	public int updateReview(Review review) {
		return reviewDao.updateReview(sqlSession, review);
	}

	@Override
	@Transactional
	public int deleteReviewAtt(String saveFileName) {
		return reviewDao.deleteReviewAtt(sqlSession, saveFileName);
	}

	@Override
	@Transactional
	public int updateReviewAtt(ReviewAtt ra) {
		return reviewDao.updateReviewAtt(sqlSession, ra);
	}

	@Override
	@Transactional
	public int deleteReview(int revNo) {
		return reviewDao.deleteReview(sqlSession, revNo);
	}

	@Override
	public ArrayList<Review> selectReviewAll(PageInfo revPi) {
		return reviewDao.selectReviewAll(sqlSession, revPi);
	}

	@Override
	public List<ReviewAtt> allReviewAtt() {
		return reviewDao.allReviewAtt(sqlSession);
	}

	@Override
	public int selectReviewAllCount() {
		return reviewDao.selectReviewAllCount(sqlSession);
	}

}
