package com.mig.blb.order.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.mig.blb.member.model.vo.Member;
import com.mig.blb.order.model.service.OrderService;
import com.mig.blb.order.model.vo.Order;
import com.mig.blb.order.model.vo.ProductOrder;

@Controller
public class OrderController {
	
	@Autowired
	private OrderService orderService;
	
	/**
	 * 주문서 작성/결제 - 예원_12/09
	 * @return
	 */
	@PostMapping("insert.or")
	public String orderEnrollForm(@RequestParam("checkedCartNos") List<Integer> checkedCartNos,
								  @RequestParam("orderTotalAmt") int orderTotalAmt,
								  HttpSession session,
								  Order order,
								  Model model) {
		
		// 로그인된 회원아이디 가져오기
		String memberId = ((Member)session.getAttribute("loginUser")).getMemberId();
		
		// 1. ORDER 테이블에 데이터 넣기
		order.setMemberId(memberId);	// ORDER 테이블에 로그인한 회원아이디 데이터 넣기
		order.setOrderTotalAmt(orderTotalAmt);
		
		int result1 = orderService.insertOrder(order);
		
		if(result1 < 0) {
			
			model.addAttribute("errorMsg", "주문이 정상적으로 완료되지 않았습니다.");
	        return "common/errorPage";
		}
		
		// 2. TB_ORDER 테이블에서 채번한 ORDER_NO 가져오기
		int orderNo = orderService.selectOrderNo();
		
		System.out.println(orderNo);
		
		order.setOrderNo(String.valueOf(orderNo));  // String으로 변환 후 Order 객체에 설정
		
		
		// 3. PRODUCT_ORDER에 데이터 넣기
		int result2 = orderService.insertProductOrder(orderNo, checkedCartNos);
		
		
		if(result2 < 0) {
			
			model.addAttribute("errorMsg", "주문이 정상적으로 완료되지 않았습니다.");
			return "common/errorPage";
		}
		
		// 4. ORDER, PRODUCT_ORDER에서 주문 정보 가져오기
		order = orderService.selectOrder(orderNo);
		
		if(order == null) {
			
			model.addAttribute("errorMsg", "주문 정보를 찾을 수 없습니다.");
			return "common/errorPage";
		}
		
		List<ProductOrder> productOrderList = orderService.selectProductOrderList(orderNo);
		
		System.out.println(productOrderList);
		
		// 4. 조회된 정보를 뷰로 전달
        model.addAttribute("order", order);
        model.addAttribute("productOrderList", productOrderList);
        model.addAttribute("orderTotalAmt", orderTotalAmt);
		
		return "order/orderEnrollForm";
	}

}
