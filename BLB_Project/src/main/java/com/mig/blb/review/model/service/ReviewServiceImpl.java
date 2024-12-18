package com.mig.blb.review.model.service;

import java.util.ArrayList;
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
}
