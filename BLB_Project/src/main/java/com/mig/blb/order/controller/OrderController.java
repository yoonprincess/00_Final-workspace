package com.mig.blb.order.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mig.blb.cart.model.service.CartService;
import com.mig.blb.cart.model.vo.Cart;
import com.mig.blb.member.model.service.MemberService;
import com.mig.blb.member.model.vo.Delivery;
import com.mig.blb.member.model.vo.Member;
import com.mig.blb.order.model.service.OrderService;


@Controller
public class OrderController {
	
	@Autowired
	private OrderService orderService;
	
	@Autowired
	private CartService cartService;
	
	@Autowired
	private MemberService memberService;

	// 주문서 화면 조회
	@PostMapping("orderEnrollForm.or")
	public String orderForm(@RequestParam("checkedCartNos") List<Integer> checkedCartNos,
							HttpSession session,
							Model model) {
		
		Member loginUser = (Member)session.getAttribute("loginUser");

	    // 로그인된 회원 ID 가져오기
	    String memberId = loginUser.getMemberId();

	    // 장바구니에서 선택된 상품 정보 조회
	    List<Cart> selectedCartList = cartService.getSelectedCartItems(memberId, checkedCartNos);

	    // 저장된 배송 정보 조회
	    List<Delivery> deliveryList = memberService.selectDeliveryList(memberId);
	    
	    Delivery selectedDelivery = null;
	    
	    for (Delivery d : deliveryList) {
	    	
	        if (d.getDeliDefault().equals("Y")) {
	        	
	            d.setDeliDefault("기본배송지");
	            selectedDelivery = d; // 기본배송지를 저장
	        } else {
	        	
	            d.setDeliDefault("");
	        }
	    }
	    
	    // 상품 정보와 배송 정보를 모델에 추가
	    model.addAttribute("selectedCartList", selectedCartList);
	    model.addAttribute("deliveryList", deliveryList);
	    model.addAttribute("selectedDelivery", selectedDelivery);

	    return "order/orderEnrollForm"; // 주문서 화면 JSP 경로
	}
	
	// 주문서 배송지 선택
	@PostMapping("selectDelivery.or")
	@ResponseBody
	public Delivery selectDelivery(@RequestParam("deliCode") int deliCode,
								   HttpSession session) {
		
        // 선택된 배송지 정보 조회
        Delivery selectedDelivery = memberService.selectMemberDelivery(deliCode);
        
        return selectedDelivery;
	}
	

	
	/**
	 * 주문서 작성/결제
	 * - 예원_24.12.09
	 * @return
	 */
	/*
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
	*/
	
	
}
