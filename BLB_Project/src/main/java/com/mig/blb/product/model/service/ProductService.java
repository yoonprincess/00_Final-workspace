package com.mig.blb.product.model.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.mig.blb.cart.model.vo.Cart;
import com.mig.blb.common.model.vo.PageInfo;
import com.mig.blb.helpdesk.model.vo.Inquiry;
import com.mig.blb.product.model.vo.Product;
import com.mig.blb.product.model.vo.ProductAtt;
import com.mig.blb.product.model.vo.ProductBanner;
import com.mig.blb.wish.model.vo.Wish;

public interface ProductService {
	
	// 상품 목록조회 서비스 + 페이징
	// 상품 총 갯수 조회
	int selectProductCount(Map<String, Object> params);
	// 상품 목록조회
	ArrayList<Product> selectProductList(PageInfo pi, Map<String, Object> params);
	
	// 상품 상세조회 서비스
	// 상품 조회수 증가
	int increaseViewCount(int prodNo);
	// 상품 상세 조회
	Product selectProduct(int prodNo);
	// 상품 이미지 조회
	ArrayList<ProductAtt> selectProductAtt(int prodNo);
	
	// 상품문의 목록조회 서비스
	// 문의 총 갯수 조회
	int selectProdInquiryCount(int prodNo);
	// 문의 목록(상세, 댓글포함)조회
	ArrayList<Inquiry> selectProdInquiryList(PageInfo qnaPi, int prodNo);
	// 문의 등록
	int insertProdInquiry(Inquiry inquiry);
	// 문의 삭제
	int deleteProdInquiry(int inquiryNo);
	// 문의 조회
	Inquiry selectProdInquiry(int inquiryNo);
	// 문의 수정
	int updateProdInquiry(Inquiry inquiry);
	
	// 상품 구매 여부 확인 및 정보 추출
	List<Map<String, Object>> getPurchaseInfo(String memberId, int prodNo);
	
	// 리뷰 수정용 상품 정보 추출
	Map<String, Object> getInfoByRevNo(int revNo);
	
	// 찜(wish) 관련
	// 찜 여부 확인
	int isWished(Wish wish);
	// 찜하기
	int addWish(Wish wish);
	// 찜취소
	int removeWish(Wish wish);
	
	// 장바구니(cart) 관련
	// 상품 1건 추출
	Product getInfoByProdNo(int prodNo);
	// 회원과 옵션에 해당하는 장바구니 정보 조회
	Cart getCartByMemberAndOption(String memberId, int optNo);
	// 장바구니 수정
	int updateCart(Cart cart);
	// 장바구니 등록
	int insertCart(Cart cart);
	
	// 상품정보 등록/수정/삭제 관련
	// 상품정보 수정
	int updateProduct(Product product);
	// 상품정보 등록
	int insertProduct(Product product);
	// 첨부파일 등록
	int insertProductAtt(ProductAtt pa);
	// 커발로 최근 prodNo 가져오기
	int getProdNoCurrval();
	// 썸네일만 가져오기
	List<ProductAtt> selectProductThumb(int prodNo);
	// 상세이미지만 가져오기
	List<ProductAtt> selectProductImg(int prodNo);
	// 파일 데이터 삭제
	int deleteProductAtt(String deleteFileName);
	// 배너 등록
	int insertBanner(ProductBanner pb);
	// MD배너 등록
	int insertMdBanner(ProductBanner pb);
	// 배너 삭제
	int deleteBanner(String saveFileName);
	// MD배너 삭제
	int deleteMdBanner(String saveFileName);
	// 배너 전체 검색
	List<ProductBanner> selectBannerList();
	ArrayList<Product> selectProductAdmin();
	
	
}
