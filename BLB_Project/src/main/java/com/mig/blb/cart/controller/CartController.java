package com.mig.blb.cart.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mig.blb.cart.model.service.CartService;
import com.mig.blb.cart.model.vo.Cart;
import com.mig.blb.member.model.vo.Member;
import com.mig.blb.option.model.service.OptionService;
import com.mig.blb.option.model.vo.Option;

@Controller
public class CartController {
	
	@Autowired
	public CartService cartService;
	
	@Autowired
	public OptionService optionService;
	
	/**
	 * 장바구니 목록 조회
	 * - 예원 24.12.06
	 * @param model
	 * @return
	 */
	@GetMapping("list.ct")
	public String selectCartList(Model model,
								 HttpSession session) {
		
	    if (session.getAttribute("loginUser") == null) {	// 로그인 전
	    	
	    	session.setAttribute("alertMsg", "로그인 후 이용 가능한 서비스입니다.");
	    	
	        return "redirect:/loginForm.me";
	        
	    } else {
	    	
	    	// 로그인된 회원아이디 가져오기
		    String memberId = ((Member)session.getAttribute("loginUser")).getMemberId();
	    	
	    	// 회원아이디로 장바구니 목록 조회
	    	ArrayList<Cart> cartList = cartService.selectCartList(memberId);
	    	
	    	for(Cart cart : cartList) {
	    		
	    		int prodNo = cart.getProdNo();
	    		
	    		// 옵션 리스트
	    		ArrayList<Option> optionList = optionService.selectCartOption(prodNo);
	    		cart.setOptionList(optionList);
	    	}
	    	
	    	// 장바구니 목록 조회 페이지를 포워딩
	    	model.addAttribute("list", cartList);
	    	
	    	return "cart/cartListView";
	    }

	}
	
	/**
	 * 장바구니 X버튼으로 1개의 상품 삭제
	 * - 예원 24.12.11
	 * @param cartNo
	 * @param model
	 * @param session
	 * @return
	 */
	@PostMapping("delete.ct")
	public String deleteCartOne(int cartNo,
							 	Model model,
							 	HttpSession session) {
		
		int result = cartService.deleteCartOne(cartNo);

		if(result > 0) {
			
			session.setAttribute("alertMsg", "장바구니 삭제 성공");

		} else {
			
			session.setAttribute("errorMsg", "해당 상품 삭제를 실패했습니다.");
		}
		
		return "redirect:/list.ct";
	}
	
	/**
	 * 장바구니 체크박스 선택 삭제
	 * - 예원 24.12.13
	 * @param cartNos
	 * @param ct
	 * @return
	 */
	@PostMapping("deleteCheck.ct")
	public String deleteCheckItems(@RequestParam("cartNos") String cartNos,
								   HttpSession session) {
		
		int result = cartService.deleteCheckItems(cartNos);
		
		if(result > 0) {
			session.setAttribute("alertMsg", "선택한 상품이 삭제되었습니다.");
		} else {
			session.setAttribute("errorMsg", "선택한 상품 삭제를 실패했습니다.");
		}
		
		return "redirect:/list.ct";
	}
	
	/**
	 * 장바구니 수량 변경
	 * - 예원 24.12.14
	 * @param cartNo
	 * @param updatedQty
	 * @return
	 */
	@PostMapping("updateQty.ct")
	@ResponseBody
	public Map<String, Object> updateCartQty(@RequestParam("cartNo") int cartNo,
											 @RequestParam("updatedQty") int updatedQty) {
		
		Map<String, Object> response = new HashMap<>();
		
		int result = cartService.updateCartQty(cartNo, updatedQty);

		if(result > 0) {
			
			response.put("success", true);
			response.put("updateQty", updatedQty);
		}

		return response;
	}
	
	/**
	 * 장바구니 상품 옵션 변경
	 * - 예원 24.12.18
	 * @param cartNo
	 * @param updatedOptNo
	 * @return
	 */
	@PostMapping("updateOption.ct")
	@ResponseBody
	public Map<String, Object> updateCartOption(@RequestParam("cartNo") int cartNo,
								   				@RequestParam("updatedOptNo") int updatedOptNo) {
		
		Map<String, Object> response = new HashMap<>();
		
		int result = cartService.updateCartOption(cartNo, updatedOptNo);
		
		if(result > 0) {
			
			response.put("success", true);
			response.put("updateOptNo", updatedOptNo);
		}
		
		return response;
	}
	
}
