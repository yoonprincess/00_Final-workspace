package com.mig.blb.product.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.mig.blb.common.model.vo.PageInfo;
import com.mig.blb.common.template.Pagination;
import com.mig.blb.helpdesk.model.service.InquiryService.InquiryService;
import com.mig.blb.helpdesk.model.vo.Inquiry;
import com.mig.blb.member.model.vo.Member;
import com.mig.blb.option.model.service.OptionService;
import com.mig.blb.option.model.vo.Option;
import com.mig.blb.product.model.service.ProductService;
import com.mig.blb.product.model.vo.Product;
import com.mig.blb.product.model.vo.ProductAtt;
import com.mig.blb.review.model.service.ReviewService;
import com.mig.blb.review.model.vo.Review;
import com.mig.blb.review.model.vo.ReviewAtt;

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
	public String selectProductList(@RequestParam(value="ppage", defaultValue="1") int currentPage,
									@RequestParam(value="category", defaultValue="전체제품") String category,
									@RequestParam(value="subcategories", required=false) List<String> subcategories,
									@RequestParam(value="keyword", required=false) String keyword,
									@RequestParam(value="sortBy", defaultValue="recent") String sortBy,
							        @RequestParam(value="boardLimit", defaultValue="12") int boardLimit,
									Model model) {
		// params를 생성하여 전달
        Map<String, Object> params = new HashMap<>();
        params.put("category", category);
        params.put("subcategories", subcategories);
        params.put("keyword", keyword);
		
		int listCount = productService.selectProductCount(params);
		
		int pageLimit = 2;
		
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, 
											 pageLimit, boardLimit);
		
		ArrayList<Product> pList = productService.selectProductList(pi, params);
		
		model.addAttribute("pList", pList);
		model.addAttribute("pi", pi);
		model.addAttribute("category", category);
		model.addAttribute("subcategories", subcategories);
		model.addAttribute("keyword", keyword);
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
			int revPageLimit = 3;
			int revBoardLimit = 10;
			PageInfo revPi = Pagination.getPageInfo(revListCount, revPage, 
												 revPageLimit, revBoardLimit);
			ArrayList<Review> revList = reviewService.selectReviewList(revPi, prodNo);
			List<ReviewAtt> allRevAttList = reviewService.getAllReviewAtt(prodNo);
			
			// 상품문의 목록(상세, 댓글포함)조회
			int qnaListCount = productService.selectProdInquiryCount(prodNo);
			int qnaPageLimit = 5;
			int qnaBoardLimit = 5;
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
			model.addAttribute("allRevAttList", allRevAttList);
			model.addAttribute("qnaList", qnaList);
		    model.addAttribute("qnaPi", qnaPi);
			
			return "product/productDetailView";
		} else {
			
			model.addAttribute("errorMsg", "게시글 조회 실패");
			
			return "common/errorPage";
		}
	}
	
	@ResponseBody
	@PostMapping("checkPurchase.pr")
    public Map<String, Object> checkReviewAvailability(@RequestParam int prodNo,
													   @RequestParam String memberId) {
		
		Map<String, Object> result = new HashMap<>();

	    // Step 1: 구매 여부 확인 및 정보 추출
	    List<Map<String, Object>> purchaseInfo = productService.getPurchaseInfo(memberId, prodNo);
	    // serialNo, orderDate, optName, optValue, prodName
	    if (purchaseInfo.isEmpty()) {
	        result.put("status", "no_purchase");
	        return result; // 구매하지 않은 상태
	    }

	    // Step 2: 리뷰 작성 여부 확인
	    // 리뷰되지 않은 SERIAL_NO 찾기
	    for (Map<String, Object> purchaseOne : purchaseInfo) {
	        int serialNo = Integer.parseInt((String) purchaseOne.get("serialNo"));

	        // 리뷰 작성 여부 확인
	        boolean isReviewWritten = reviewService.isReviewWritten(serialNo);

	        if (!isReviewWritten) {
	        	result.put("status", "ok");
	        	result.put("purchaseOne", purchaseOne);
	        	// serialNo, orderDate, optName, optValue, prodName
	            return result;
	        }
	    }
	    result.put("status", "review_exists");
        return result; // 이미 리뷰 작성된 상태
    }
	
	@GetMapping("enrollForm.pqa")
    public String writeProductInquiryForm(@RequestParam int prodNo, 
	    							  	  @RequestParam String memberId, 
	    							  	  Model model, 
	    							  	  HttpSession session) {
		
		if(session.getAttribute("loginUser") == null) {
        	session.setAttribute("errorMsg", "로그인 후 문의를 작성할 수 있습니다.");
			return "redirect:/loginForm.me";
		}
		
        // 현재 로그인된 사용자와 요청된 memberId 비교
		String loginMemberId = ((Member)session.getAttribute("loginUser")).getMemberId();
        
        if(loginMemberId == null || !loginMemberId.equals(memberId)) {
            model.addAttribute("errorMsg", "잘못된 접근입니다.");
            return "common/errorPage"; // 접근 거부 페이지로 이동
        }

	    // 상품 및 사용자 정보 추가
	    model.addAttribute("prodNo", prodNo);
	    model.addAttribute("memberId", memberId);
	    
	    return "product/qnaWriteForm"; // 리뷰 작성 JSP 페이지
    }
	
	@ResponseBody
	@PostMapping("insert.pqa")
    public Map<String, Object> insertProdInquiry(Inquiry inquiry,
    						   					 HttpSession session) {
		
		Map<String, Object> resultMap = new HashMap<>();
		
	    // 문의 저장
	    int result = productService.insertProdInquiry(inquiry);;
			
		if(result > 0) {
        	resultMap.put("success", true);
            resultMap.put("message", "문의가 성공적으로 등록되었습니다.");
            
        } else {
        	resultMap.put("success", false);
            resultMap.put("message", "문의 등록에 실패했습니다.");
        }

        return resultMap;
    }
	
	@GetMapping("delete.pqa")
    public String deleteProdInquiry(Inquiry inquiry, 
							   		Model model, 
							   		HttpSession session,
							   		@RequestHeader(value = "Referer", required = false) String referer) {
		
		if(session.getAttribute("loginUser") == null) {
        	session.setAttribute("errorMsg", "로그인 후 문의를 삭제할 수 있습니다.");
			return "redirect:/loginForm.me";
		}
		
        // 현재 로그인된 사용자와 요청된 memberId 비교
		String loginMemberId = ((Member)session.getAttribute("loginUser")).getMemberId();
        
        if(loginMemberId == null || !loginMemberId.equals(inquiry.getMemberId())) {
            model.addAttribute("errorMsg", "잘못된 접근입니다.");
            return "common/errorPage"; // 접근 거부 페이지로 이동
        }
        
        int result = productService.deleteProdInquiry(inquiry.getInquiryNo());
		
		if (referer != null) {
			session.setAttribute("successMsg", "게시글을 삭제했습니다.");
            return "redirect:" + referer;
        }
		session.setAttribute("successMsg", "게시글을 삭제했습니다.");
        // Referer가 없으면 루트 페이지로 리다이렉트
        return "redirect:/";
	}
	
	@GetMapping("updateForm.pqa")
    public String editReviewForm(Inquiry inquiry, 
    							 Model model, 
    							 HttpSession session) {
		
		if(session.getAttribute("loginUser") == null) {
        	session.setAttribute("errorMsg", "로그인 후 리뷰를 수정할 수 있습니다.");
			return "redirect:/loginForm.me";
		}
		
        // 현재 로그인된 사용자와 요청된 memberId 비교
		String loginMemberId = ((Member)session.getAttribute("loginUser")).getMemberId();
        
        if(loginMemberId == null || !loginMemberId.equals(inquiry.getMemberId())) {
            model.addAttribute("errorMsg", "잘못된 접근입니다.");
            return "common/errorPage"; // 접근 거부 페이지로 이동
        }
        
        // 문의정보 가져오기
        Inquiry i = productService.selectProdInquiry(inquiry.getInquiryNo());
        
        model.addAttribute("i", i);
        
        return "product/qnaEditForm"; // 리뷰 작성 JSP 페이지
       
    }
	
	@ResponseBody
	@PostMapping("update.pqa")
    public Map<String, Object> updateReview(Inquiry inquiry,
    						   HttpSession session) {
		
		Map<String, Object> resultMap = new HashMap<>();
		
	    // 리뷰 저장
	    int result = productService.updateProdInquiry(inquiry);
	    
	    if(result > 0) {
        	resultMap.put("success", true);
            resultMap.put("message", "리뷰가 성공적으로 수정되었습니다.");
            
        } else {
        	resultMap.put("success", false);
            resultMap.put("message", "리뷰 수정에 실패했습니다.");
        }

        return resultMap;
    }
}
