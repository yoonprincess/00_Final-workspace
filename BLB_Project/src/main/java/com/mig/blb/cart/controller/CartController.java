package com.mig.blb.cart.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

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
	
}
