package com.mig.blb.order.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;

import com.mig.blb.order.model.service.OrderService;

@Controller
public class OrderController {
	
	@Autowired
	private OrderService orderService;
	
	/**
	 * 주문서 작성/결제 - 예원_12/09
	 * @return
	 */
	@PostMapping("orderEnrollForm.or")
	public String orderEnrollForm() {
		
		return "order/orderEnrollForm";
	}

}
