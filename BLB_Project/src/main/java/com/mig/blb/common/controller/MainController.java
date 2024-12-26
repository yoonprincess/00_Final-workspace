package com.mig.blb.common.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.mig.blb.common.model.vo.PageInfo;
import com.mig.blb.common.template.Pagination;
import com.mig.blb.member.model.vo.Member;
import com.mig.blb.product.model.service.ProductService;
import com.mig.blb.product.model.vo.Product;
import com.mig.blb.product.model.vo.ProductBanner;

@Controller
public class MainController {
	
	@Autowired
    private ProductService productService;

	@GetMapping("main.blb")
    public String showMainPage(@RequestParam(value="ppage", defaultValue="1") int currentPage,
							   @RequestParam(value="category", defaultValue="전체제품") String category,
							   @RequestParam(value="subcategories", required=false) List<String> subcategories,
							   @RequestParam(value="keyword", required=false) String keyword,
							   @RequestParam(value="sortBy", defaultValue="sales") String sortBy,
						       @RequestParam(value="boardLimit", defaultValue="8") int boardLimit,
						       HttpSession session,
							   Model model) {
    	// 최다판매상품
        Map<String, Object> bestParam = new HashMap<>();
        bestParam.put("category", category);
        bestParam.put("subcategories", subcategories);
        bestParam.put("keyword", keyword);
        bestParam.put("sortBy", sortBy);
		
        // 로그인한 유저라면 로그인 아이디도 전달 
        if(session.getAttribute("loginUser") != null) {
        	String loginMemberId = ((Member)session.getAttribute("loginUser")).getMemberId();
        	bestParam.put("memberId", loginMemberId);
        }
        
		int listCount = 8;
		int pageLimit = 1;
		
		PageInfo bestPi = Pagination.getPageInfo(listCount, currentPage, 
											 pageLimit, boardLimit);
		
		ArrayList<Product> pList = productService.selectProductList(bestPi, bestParam);
		
		// 최신상품
		Map<String, Object> newParams = new HashMap<>();
        newParams.put("category", category);
        newParams.put("subcategories", subcategories);
        newParams.put("keyword", keyword);
        newParams.put("sortBy", "recent");
		
		int newCount = 8;
		int newLimit = 1;
		
		PageInfo newPi = Pagination.getPageInfo(newCount, currentPage, 
											 newLimit, boardLimit);
		
		ArrayList<Product> nList = productService.selectProductList(newPi, newParams);
		
		// 전체 배너
		List<ProductBanner> pbList = productService.selectBannerList();
		
		
		model.addAttribute("pList", pList);
		model.addAttribute("nList", nList);
		model.addAttribute("pbList", pbList);

        // main.jsp로 데이터 전달
        return "main";
    }

}
