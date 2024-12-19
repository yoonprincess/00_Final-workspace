package com.mig.blb.order.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.mig.blb.cart.model.vo.Cart;
import com.mig.blb.order.model.service.OrderService;
import com.mig.blb.order.model.vo.ProductOrder;

@Controller
public class OrderController {
	
	@Autowired
	private OrderService orderService;
	
	/**
	 * 주문서 작성/결제 - 예원_12/09
	 * @return
	 */
	@PostMapping("orderEnrollForm.or")
	public String orderEnrollForm(@RequestParam("checkedCartNos") List<Integer> checkedCartNos) {
		
		System.out.println(checkedCartNos);
		
//		List<Cart> cartList = cart
//		
//		for(Cart cart : checkedCartNos) {
//			
//			ProductOrder order = new ProductOrder();
//			
//			
//		}
		return "order/orderEnrollForm";
	}

}
