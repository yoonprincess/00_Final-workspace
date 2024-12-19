package com.mig.blb.review.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.mig.blb.member.model.vo.Member;
import com.mig.blb.option.model.service.OptionService;
import com.mig.blb.product.model.service.ProductService;
import com.mig.blb.review.model.service.ReviewService;

@Controller
public class ReviewController {

	@Autowired
	private ProductService productService;
	
	@Autowired
	private ReviewService reviewService;
	
	@Autowired
	private OptionService optionService;
	
	@GetMapping("enrollForm.rv")
    public String writeReviewForm(@RequestParam int prodNo, 
    							  @RequestParam String memberId, 
    							  Model model, 
    							  HttpSession session) {
		
        // 현재 로그인된 사용자와 요청된 memberId 비교
		String loginMemberId = ((Member)session.getAttribute("loginUser")).getMemberId();
        
        if (loginMemberId == null || !loginMemberId.equals(memberId)) {
            model.addAttribute("errorMsg", "잘못된 접근입니다.");
            return "common/errorPage"; // 접근 거부 페이지로 이동
        }

        // 구매 여부 확인
        boolean isPurchased = productService.checkPurchase(prodNo, memberId);
        if (!isPurchased) {
            model.addAttribute("alertMsg", "구매한 상품에만 리뷰를 작성할 수 있습니다.");
            return "redirect:/detail.pr?pno=" + prodNo; // 상품페이지로 리다이렉트
        }

        // 상품 및 사용자 정보 추가
        model.addAttribute("prodNo", prodNo);
        model.addAttribute("memberId", memberId);

        return "review/reviewWriteForm"; // 리뷰 작성 JSP 페이지
    }
	
}
