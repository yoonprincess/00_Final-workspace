package com.mig.blb.review.model.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.mig.blb.common.model.vo.PageInfo;
import com.mig.blb.review.model.vo.Review;
import com.mig.blb.review.model.vo.ReviewAtt;

public interface ReviewService {
	
	// 리뷰 총 갯수 조회
	int selectReviewCount(int prodNo);
	// 리뷰 목록조회
	ArrayList<Review> selectReviewList(PageInfo revPi, int prodNo);
	// 리뷰 평균별점 처리
	Map<String, Object> selectReviewStats(int prodNo);
	// 마이페이지용 내 리뷰 갯수조회
	int myReviewListCount(String memberId);
	// 마이페이지용 내 리뷰 목록조회
	ArrayList<Review> selectMyReviewList(String memberId, PageInfo pi);
	// 리뷰 작성여부 확인
	boolean isReviewWritten(String serialNo);
	// 리뷰 글작성
	int insertReview(Review review);
	// 리뷰 첨부파일 등록
	int insertReviewAtt(ReviewAtt ra);
	// 상품에 포함된 전체 리뷰 이미지
	List<ReviewAtt> getAllReviewAtt(int prodNo);
	// 리뷰 1개 조회
	Review selectReview(int revNo);
	// 리뷰 글수정
	int updateReview(Review review);
	// 리뷰 첨부파일 삭제
	int deleteReviewAtt(String saveFileName);
	// 리뷰 수정 시 첨부파일 추가
	int updateReviewAtt(ReviewAtt ra);
	// 리뷰 삭제
	int deleteReview(int revNo);
	ArrayList<Review> selectReviewAll(PageInfo revPi);
	List<ReviewAtt> allReviewAtt();
	int selectReviewAllCount();
}
