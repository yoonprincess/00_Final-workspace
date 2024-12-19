package com.mig.blb.product.model.service;

import java.util.ArrayList;
import java.util.Map;

import com.mig.blb.common.model.vo.PageInfo;
import com.mig.blb.helpdesk.model.vo.Inquiry;
import com.mig.blb.product.model.vo.Product;
import com.mig.blb.product.model.vo.ProductAtt;

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
	
	// 상품 구매여부 체크 서비스
	boolean checkPurchase(int prodNo, String memberId);
}
