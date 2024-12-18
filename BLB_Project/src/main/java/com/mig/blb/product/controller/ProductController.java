package com.mig.blb.product.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.mig.blb.common.model.vo.PageInfo;
import com.mig.blb.common.template.Pagination;
import com.mig.blb.helpdesk.model.vo.Inquiry;
import com.mig.blb.option.model.service.OptionService;
import com.mig.blb.option.model.vo.Option;
import com.mig.blb.product.model.service.ProductService;
import com.mig.blb.product.model.vo.Product;
import com.mig.blb.product.model.vo.ProductAtt;
import com.mig.blb.review.model.service.ReviewService;
import com.mig.blb.review.model.vo.Review;

@Controller
public class ProductController {
	
	@Autowired
	private ProductService productService;
	
	@Autowired
	private ReviewService reviewService;
	
	@Autowired
	private OptionService optionService;

	// 상품 목록보기 요청
	@GetMapping("list.pr")
	public String selectProductList(@RequestParam(value="ppage", defaultValue="1")int currentPage,
									@RequestParam(value="category", defaultValue="전체제품")String category,
									@RequestParam(value="subcategories", required=false) List<String> subcategories,
									@RequestParam(value="sortBy", defaultValue="recent") String sortBy,
							        @RequestParam(value="boardLimit", defaultValue="12") int boardLimit,
									Model model) {
		// params를 생성하여 전달
        Map<String, Object> params = new HashMap<>();
        params.put("category", category);
        params.put("subcategories", subcategories);
		
		int listCount = productService.selectProductCount(params);
		
		int pageLimit = 2;
		
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, 
											 pageLimit, boardLimit);
		
		ArrayList<Product> pList = productService.selectProductList(pi, params);
		
		model.addAttribute("pList", pList);
		model.addAttribute("pi", pi);
		model.addAttribute("category", category);
		model.addAttribute("subcategories", subcategories);
	    model.addAttribute("sortBy", sortBy);
	    model.addAttribute("boardLimit", boardLimit);
		
		return "product/productListView";
	}
	
	// 상품 상세보기 요청
	@GetMapping("detail.pr")
	public String selectProduct(@RequestParam(value="pno", defaultValue="1")int prodNo,
								@RequestParam(value="rpage", defaultValue="1")int revPage,
								@RequestParam(value="qpage", defaultValue="1")int qnaPage,
								Model model) {
		
		int count = productService.increaseViewCount(prodNo);
		
		if(count > 0) {
			
			// 상품정보 상세조회
			Product p = productService.selectProduct(prodNo);
			
			// 상품 첨부이미지 조회
			ArrayList<ProductAtt> paList = productService.selectProductAtt(prodNo);
			// 상품 옵션 조회
			ArrayList<Option> optList = optionService.selectCartOption(prodNo);
			
			// 리뷰 통계 데이터 가져오기
		    Map<String, Object> reviewStats = reviewService.selectReviewStats(prodNo);
			
			// 리뷰 목록조회
			int revListCount = reviewService.selectReviewCount(prodNo);
			int revPageLimit = 5;
			int revBoardLimit = 10;
			PageInfo revPi = Pagination.getPageInfo(revListCount, revPage, 
												 revPageLimit, revBoardLimit);
			ArrayList<Review> revList = reviewService.selectReviewList(revPi, prodNo);
			
			// 상품문의 목록(상세, 댓글포함)조회
			int qnaListCount = productService.selectProdInquiryCount(prodNo);
			int qnaPageLimit = 5;
			int qnaBoardLimit = 10;
			PageInfo qnaPi = Pagination.getPageInfo(qnaListCount, qnaPage, 
												 qnaPageLimit, qnaBoardLimit);
			ArrayList<Inquiry> qnaList = productService.selectProdInquiryList(qnaPi, prodNo);
			
			
			// requestScope에 객체 전달
			model.addAttribute("p", p);
			model.addAttribute("paList", paList);
			model.addAttribute("optList", optList);
			model.addAttribute("reviewStats", reviewStats);
			model.addAttribute("revList", revList);
			model.addAttribute("revPi", revPi);
			model.addAttribute("qnaList", qnaList);
		    model.addAttribute("qnaPi", qnaPi);
			
			return "product/productDetailView";
		} else {
			
			model.addAttribute("errorMsg", "게시글 조회 실패");
			
			return "common/errorPage";
		}
	}
}
