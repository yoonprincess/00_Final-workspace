package com.mig.blb.order.model.service;

import com.mig.blb.order.model.vo.Order;

public interface OrderService {

	// 주문서 작성/결제
	int insertOrder(Order o);
}
