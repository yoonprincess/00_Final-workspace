package com.mig.blb.order.controller;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.mig.blb.cart.model.service.CartService;
import com.mig.blb.cart.model.vo.Cart;
import com.mig.blb.member.model.service.MemberService;
import com.mig.blb.member.model.vo.Delivery;
import com.mig.blb.member.model.vo.Member;
import com.mig.blb.order.model.service.OrderService;
import com.mig.blb.order.model.vo.Order;
import com.mig.blb.order.model.vo.ProductOrder;

@Controller
public class OrderController {
	
	@Autowired
	private OrderService orderService;
	
	@Autowired
	private CartService cartService;
	
	@Autowired
	private MemberService memberService;
	
	/**
	 * 주문서 폼 화면 조회
	 * - 예원 24.12.20
	 * @param checkedCartNos
	 * @param session
	 * @param model
	 * @return
	 */
	@PostMapping("orderEnrollForm.or")
	public String orderForm(@RequestParam("checkedCartNos") List<Integer> checkedCartNos,
							HttpSession session,
							Model model) {
		
	    String memberId = ((Member)session.getAttribute("loginUser")).getMemberId();
	    
	    if (session.getAttribute("loginUser") == null) {	// 로그인 전
	    	
	    	session.setAttribute("alertMsg", "로그인 후 이용 가능한 서비스입니다.");
	        return "redirect:/loginForm.me";
	    }
	    
	    // 장바구니에서 선택된 상품 정보 조회
	    List<Cart> selectedCartList = cartService.getSelectedCartItems(memberId, checkedCartNos);

	    // 저장된 배송 정보 조회
	    List<Delivery> deliveryList = memberService.selectDeliveryList(memberId);
	    
	    Delivery selectedDelivery = null;
	    
	    for (Delivery d : deliveryList) {
	    	
	        if (d.getDeliDefault().equals("Y")) {
	        	
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
	
	/**
	 * 주문서 배송지 선택
	 * - 예원_24.12.20
	 * @param deliCode
	 * @param session
	 * @return
	 */
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
	 * - 예원_24.12.25
	 * @return
	 */
	@ResponseBody
	@PostMapping("payment.or")
	public Map<String, String> orderEnrollForm(@RequestBody Map<String, Object> paymentData,
								  			   HttpSession session) {
		
		// 로그인된 회원아이디 가져오기
		String memberId = ((Member)session.getAttribute("loginUser")).getMemberId();
			
		Map<String, String> response = new HashMap<>();
		
	    if (session.getAttribute("loginUser") == null) {	// 로그인 전
	    	
	    	response.put("status", "fail");
	        response.put("message", "로그인 후 이용 가능한 서비스입니다.");
	        return response;
	        
	    }
		
		// 0. 총 상품 가격은 따로 세션에 저장
		session.setAttribute("totalAmt", (String) paymentData.get("totalAmt"));
		session.setAttribute("merchantUid",(String) paymentData.get("merchant_uid"));
		
		// 1. ORDER 테이블에 데이터 넣기
		Order order = new Order();
	    order.setRcvrName((String) paymentData.get("rcvrName"));
	    order.setRcvrPhone((String) paymentData.get("rcvrPhone"));
	    order.setRcvrAddress((String) paymentData.get("rcvrAddress"));
	    order.setDlvrFee((Integer) paymentData.get("dlvrFee"));
	    order.setDlvrReqMessage((String) paymentData.get("dlvrReqMessage"));
	    order.setPaymentMethod((String) paymentData.get("paymentMethod"));
	    order.setOrderTotalAmt((Integer) paymentData.get("orderTotalAmt"));
	    order.setMemberId(memberId);
	    
		int result1 = orderService.insertOrder(order);
		
		if(result1 < 1) {
			
			response.put("message", "주문 실패.");
		}
		
		// 2. TB_ORDER 테이블에서 채번한 ORDER_NO 가져오기
		int orderNo = orderService.selectOrderNo();
		order.setOrderNo(String.valueOf(orderNo));  // String으로 변환 후 Order 객체에 설정
		
		// 3. PRODUCT_ORDER에 데이터 넣기
	    List<Map<String, Object>> productList = (List<Map<String, Object>>) paymentData.get("products");
	    // > products 데이터 추출
	    List<ProductOrder> productOrders = new ArrayList<>();

	    List<Cart> checkedCartNos = new ArrayList<>();
	    
	    for (Map<String, Object> product : productList) {
	        
	        ProductOrder productOrder = new ProductOrder();
	        productOrder.setOrderQty((Integer)product.get("orderQty"));
	        productOrder.setTotalAmt((Integer)product.get("totalAmt"));
	        productOrder.setOptNo((Integer)product.get("optNo"));
	        productOrder.setOrderNo(orderNo); // String 타입
	        
	        // 장바구니 번호가 존재하면 Cart 객체 생성 및 추가
	        if (product.get("cartNo") != null) {
	            Cart cart = new Cart();
	            cart.setCartNo((Integer) product.get("cartNo")); // cartNo 설정
	            checkedCartNos.add(cart); // 리스트에 추가
	        }
	        
	        // productOrder 추가
	        productOrders.add(productOrder);
	    }
	    
	    int result2 = orderService.insertProductOrder(productOrders);
	        
        if (result2 < productOrders.size()) {	// 삽입된 행 수와 리스트 크기 비교
        	
            response.put("message", "상품 데이터 삽입 실패.");
            return response;
        }
        
	    response.put("status", "success");
	    return response;
	}
	
	/**
	 * 장바구니에서 넘어온 상품 결제 완료
	 * - 예원_24.12.26
	 * @param merchantUid
	 * @param orderCartNos
	 * @param session
	 * @param model
	 * @param order
	 * @return
	 */
	@GetMapping("orderComplete.or")
	public String updateOrderSuccess(@RequestParam("paymentCode") String merchantUid,
            						 @RequestParam("orderCartNos") String orderCartNos,
									 HttpSession session,
									 Model model,
									 Order order) {
		
		// 1. TB_ORDER 테이블에서 채번한 ORDER_NO 가져오기
	    int orderNoInt = orderService.selectOrderNo(); // selectOrderNo()는 int 반환
	    String orderNo = String.valueOf(orderNoInt);  // int를 String으로 변환
		
	    // 2. 결제 코드 업데이트
	    int result1 = orderService.updateOrderStatus(merchantUid, orderNo);
	    
	    if(result1 < 1) {
	    	
	    	model.addAttribute("errorMsg", "주문 상태 업데이트 실패");
	    	model.addAttribute("merchantUid", merchantUid);
	        return "common/errorPage";
	    }

	    // 3. 장바구니에서 결제된 상품 삭제
	    List<Integer> checkedCartNos = Arrays.stream(orderCartNos.split(","))
				 .map(Integer::parseInt)
				 .collect(Collectors.toList()); // 장바구니 번호 리스트
	    
	    int result2 = cartService.deleteSelectedCarts(checkedCartNos);
	    
	    if(result2 < 1) {
	    	
	    	model.addAttribute("errorMsg", "장바구니 삭제 실패");
	        return "common/errorPage";
	    }

	    // 마지막. order 객체에 담아서 조회
	    Order o = orderService.selectOrderComplete(orderNo);
	    
	    model.addAttribute("order", o);
	    
	    return "order/orderCompleteView";
	}
	
	/**
	 * 주문 환불/취소 요청 화면
	 * - 예원_24.12.26
	 * @param orderNo
	 * @param session
	 * @param model
	 * @return
	 */
	@GetMapping("cancelForm.or")
	public String orderCancelForm(@RequestParam("orderNo") String orderNo,
	                              HttpSession session,
	                              Model model) {

	    // 로그인된 사용자 확인
	    if (session.getAttribute("loginUser") == null) {
	        session.setAttribute("alertMsg", "로그인이 필요합니다.");
	        return "redirect:/loginForm.me";
	    }

	    // 1. 주문 정보(TB_ORDER) 가져오기
	    Order order = orderService.selectOrderComplete(orderNo);
	    model.addAttribute("order", order);
	    
	    // 2. 상품 정보 가져오기
	    List<ProductOrder> productList = orderService.selectProductOrderList(orderNo);
	    model.addAttribute("productList", productList);

	    return "order/orderCancelForm";
	}
	
	/**
	 * 취소 요청 시 환불일, 환불사유 업데이트
	 * - 예원
	 * @param requestData
	 * @param session
	 * @param model
	 * @return
	 */
	@ResponseBody
	@PostMapping("cancelForm.or")
	public Map<String, Object> updateOrderCancel(@RequestBody Map<String, Object> requestData,
												 HttpSession session,
												 Model model) {
		
	    Map<String, Object> response = new HashMap<>();
	    
	    if (session.getAttribute("loginUser") == null) {
	    	response.put("success", true);
	        response.put("message", "로그인 후 이용 가능한 서비스입니다.");
	        return response;
	    }
	    
	    String orderNo = (String) requestData.get("orderNo");
	    String refundReason = (String) requestData.get("refundReason");

	    int result = orderService.updateOrderCancel(orderNo, refundReason);
	    
	    if(result > 0) {
	    	response.put("success", true);
	    	response.put("message", "주문 취소가 성공적으로 처리되었습니다.");
        } else {
        	response.put("success", false);
        	response.put("message", "주문 취소에 실패되었습니다.");
        }
	    
        return response;
	}
	
	/**
	 * 취소 완료 화면
	 * - 예원
	 * @param session
	 * @return
	 */
	@GetMapping("cancelComplete.or")
	public String selectCancelComplete(HttpSession session) {
		
		return "order/orderCancelCompleteView";
	}
	
	/**
	 * 바로 구매 주문서 조회
	 * - 예원 25.01.17
	 * @param orderDataJson
	 * @param model
	 * @param session
	 * @return
	 */
	@PostMapping("directOrderForm.or")
	public String directOrderForm(@RequestParam("orderData") String orderDataJson,
	                              Model model,
	                              HttpSession session) {

	    // 1. JSON 데이터를 파싱
	    ObjectMapper mapper = new ObjectMapper();
	    List<Map<String, Object>> orderData;
	    try {
	        orderData = mapper.readValue(orderDataJson, new TypeReference<List<Map<String, Object>>>() {});
	    } catch (JsonProcessingException e) {
	        e.printStackTrace();
	        return "common/errorPage"; // 에러 페이지로 이동
	    }

	    // 2. 옵션 번호 리스트를 추출 후 상품 정보 조회
	    List<Integer> optNos = orderData.stream()
	            .map(data -> (Integer) data.get("optNo"))
	            .collect(Collectors.toList());
	    List<ProductOrder> productList = orderService.selectProductOptions(optNos);
	    
	    // 1. optNo와 orderQty 매핑
	    Map<Integer, Integer> optNoToOrderQty = orderData.stream()
	        .collect(Collectors.toMap(
	            data -> (Integer) data.get("optNo"), // 키: optNo
	            data -> (Integer) data.get("orderQty") // 값: orderQty
	        ));
	    
	    // 상품 정보에 수량 추가
	    if (productList != null) {
	        for (ProductOrder productOrder : productList) {
	            Integer orderQty = optNoToOrderQty.get(productOrder.getOptNo());
	            if (orderQty != null) {
	                productOrder.setOrderQty(orderQty); // 상품 객체에 수량 설정
	            }
	        }
	    }
	    
	    // 4. 회원 아이디로 배송 정보 조회
	    String memberId = ((Member)session.getAttribute("loginUser")).getMemberId();
	    List<Delivery> deliveryList = memberService.selectDeliveryList(memberId);
	    
	    Delivery selectedDelivery = null;
	    for (Delivery d : deliveryList) {
	    	
	        if (d.getDeliDefault().equals("Y")) {
	        	
	            selectedDelivery = d; // 기본배송지를 저장
	        } else {
	        	
	            d.setDeliDefault("");
	        }
	    }
	    
	    // 5. 모델에 데이터 추가
	    model.addAttribute("productList", productList); // 상품 정보 리스트
	    model.addAttribute("deliveryList", deliveryList); // 배송 정보 리스트
	    model.addAttribute("selectedDelivery", selectedDelivery); // 선택된 배송 정보

	    return "order/directOrderEnrollForm"; // JSP 경로 반환
	}
	
	/**
	 * 바로 구매 결제 완료
	 * - 예원_25.01.17
	 * @param merchantUid
	 * @param orderCartNos
	 * @param session
	 * @param model
	 * @param order
	 * @return
	 */
	@GetMapping("directOrderComplete.or")
	public String updateDirectOrderSuccess(@RequestParam("paymentCode") String merchantUid,
									 HttpSession session,
									 Model model,
									 Order order) {
		
		// 1. TB_ORDER 테이블에서 채번한 ORDER_NO 가져오기
	    int orderNoInt = orderService.selectOrderNo(); // selectOrderNo()는 int 반환
	    String orderNo = String.valueOf(orderNoInt);  // int를 String으로 변환
		
	    // 2. 결제 코드 업데이트
	    int result1 = orderService.updateOrderStatus(merchantUid, orderNo);
	    
	    if(result1 < 1) {
	    	
	    	model.addAttribute("errorMsg", "주문 상태 업데이트 실패");
	    	model.addAttribute("merchantUid", merchantUid);
	        return "common/errorPage";
	    }

	    // 마지막. order 객체에 담아서 조회
	    Order o = orderService.selectOrderComplete(orderNo);
	    
	    model.addAttribute("order", o);
	    
	    return "order/orderCompleteView";
	}



	
}
