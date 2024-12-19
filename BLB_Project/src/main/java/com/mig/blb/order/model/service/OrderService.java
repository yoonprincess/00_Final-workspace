package com.mig.blb.order.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import com.mig.blb.common.model.vo.PageInfo;
import com.mig.blb.order.model.vo.Order;

public interface OrderService {

	// 주문서 작성/결제
	int insertOrder(Order o);
	
	// 마이페이지용 주문, 배송 게시글 수
	int myOrderListCount(HashMap<String, String> dateMap);
	
	// 마이페이지용 주문,배송 목록 조회
	ArrayList<Order> selectMyOrderList(HashMap<String, String> dateMap, PageInfo pi);
	
	// 마이페이지용 주문,배송 검색 조회
	ArrayList<Order> searchMyOrderList(HashMap<String, String> searchMap);
	
	// 마이페이지용 주문,배송상태 갯수 조회
	HashMap<String, Integer> myOrderCounts(String memberId);
	
	
}
