package com.mig.blb.order.model.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import com.mig.blb.common.model.vo.PageInfo;
import com.mig.blb.order.model.vo.Order;
import com.mig.blb.order.model.vo.ProductOrder;

public interface OrderService {

	// 주문서 작성/결제
	int insertOrder(Order o);
	
	// 마이페이지용 주문, 배송 게시글 수
	int myOrderListCount(HashMap<String, Object> dateMap);
	
	// 마이페이지용 주문,배송 목록 조회
	ArrayList<Order> selectMyOrderList(HashMap<String, Object> dateMap, PageInfo pi);
	
	// 마이페이지용 주문,배송상태 갯수 조회
	HashMap<String, Integer> myOrderCounts(String memberId);

	// TB_ORDER 테이블에서 채번한 ORDER_NO 조회
	int selectOrderNo();

	// PRODUCT_ORDER 테이블에 데이터 넣기
	int insertProductOrder(int orderNo, List<Integer> checkedCartNos);

	// ORDER, PRODUCT_ORDER에서 주문 정보 가져오기
	// ORDER
	Order selectOrder(int orderNo);
	// PRODUCT_ORDER
	List<ProductOrder> selectProductOrderList(int orderNo);

	// 마이페이지용 목록조회 2 
	ArrayList<Order> selectAllMyOrders(HashMap<String, Object> dateMap);
	
	
}
