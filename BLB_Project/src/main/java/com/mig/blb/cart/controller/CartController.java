package com.mig.blb.cart.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.mig.blb.cart.model.service.CartService;
import com.mig.blb.cart.model.vo.Cart;
import com.mig.blb.member.model.vo.Member;

@Controller
public class CartController {
	
	@Autowired
	public CartService cartService;
	
	/**
	 * 장바구니 목록 조회
	 * - 예원 12/06
	 * @param model
	 * @return
	 */
	@GetMapping("list.ct")
	public String selectCartList(Model model,
								 HttpSession session) {
		
//	    System.out.println(memberId);
	    
	    if (session.getAttribute("loginUser") == null) {	// 로그인 전
	    	
	    	session.setAttribute("alertMsg", "로그인 후 이용 가능한 서비스입니다.");
	    	
	        return "redirect:/loginForm.me";
	        
	    } else {
	    	// 로그인된 회원아이디 가져오기
		    String memberId = ((Member)session.getAttribute("loginUser")).getMemberId();
	    	
	    	// 회원아이디로 장바구니 목록 조회
	    	ArrayList<Cart> list = cartService.selectCartList(memberId);
	    	
	    	System.out.println(list);
	    	
	    	// 장바구니 목록 조회 페이지를 포워딩
	    	model.addAttribute("list", list);
	    	
	    	return "cart/cartListView";
	    }

	}
	
	/**
	 * 장바구니 X버튼으로 1개의 상품 삭제
	 * - 예원 12/11
	 * @param cartNo
	 * @param model
	 * @param session
	 * @return
	 */
	@PostMapping("delete.ct")
	public String deleteCartOne(int cartNo,
							 	Model model,
							 	HttpSession session) {
		System.out.println("장바구니 번호 :" + cartNo);
		
		int result = cartService.deleteCartOne(cartNo);
		
		
		if(result > 0) {
			
			session.setAttribute("alertMsg", "장바구니 삭제 성공");
			// 구현 후 지우기
		} else {
			
			session.setAttribute("errorMsg", "해당 상품 삭제를 실패했습니다.");
		}
		
		return "redirect:/list.ct";
	}
	
	/*
	@GetMapping("list.ct")
	public String selectCartOption(@RequestParam("prodNo")int prodNo,
								   Model model,
								   HttpSession session) {
		
		prodNo = 105;
		// 나중에 상품 번호 Session에 담아서 불러오기?
		
		model.addAttribute(prodNo);
		
		return "cart/cartListView";
	}
	*/
	
	/**
	 * 장바구니 상품 옵션 변경
	 * - 예원 12/11
	 * @param ct
	 * @param session
	 * @param model
	 * @return
	 */
	/*
	@PostMapping("updateOption.ct")
	public String updateCartOption(Cart ct,
								   HttpSession session,
								   Model model) {
		
		int result = cartService.updateCartOption(ct);
		
		if(result > 0) {
			
			session.setAttribute("alertMsg", "옵션이 성공적으로 변경되었습니다.");
			return "redirect:/cart/list.ct";
		} else {
			
			session.setAttribute("errorMssg", "옵션 변경에 실패하였습니다.");
			return "redirect:/cart/list.ct";
		}
	}
	*/
	

	
}
