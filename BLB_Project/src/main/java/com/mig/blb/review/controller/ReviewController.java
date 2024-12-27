package com.mig.blb.review.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

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
import com.mig.blb.wish.model.vo.Wish;

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
    							  @RequestParam String serialNo,
    							  Model model, 
    							  HttpSession session) {
		
		if(session.getAttribute("loginUser") == null) {
        	session.setAttribute("errorMsg", "로그인 후 리뷰를 작성할 수 있습니다.");
			return "redirect:/loginForm.me";
		}
		
        // 현재 로그인된 사용자와 요청된 memberId 비교
		String loginMemberId = ((Member)session.getAttribute("loginUser")).getMemberId();
        
        if(loginMemberId == null || !loginMemberId.equals(memberId)) {
            model.addAttribute("errorMsg", "잘못된 접근입니다.");
            return "common/errorPage"; // 접근 거부 페이지로 이동
        }

        // Step 1: 구매 여부 확인 및 정보 추출
        List<Map<String, Object>> purchaseInfo = productService.getPurchaseInfo(memberId, prodNo);

        for(Map<String, Object> purchaseOne : purchaseInfo) {

    		String purchaseSerialNo = (String)purchaseOne.get("serialNo");
    		
    		if(purchaseSerialNo.equals(serialNo)) {
    			// 리뷰 작성 여부 확인
    			boolean isReviewWritten = reviewService.isReviewWritten(purchaseSerialNo);
    			

		        if(!isReviewWritten) {
		        	// 상품 및 사용자 정보 추가
		            model.addAttribute("prodNo", prodNo);
		            model.addAttribute("memberId", memberId);
		            model.addAttribute("purchaseOne", purchaseOne);
		            // serialNo, orderDate, optName, optValue, prodName
		            return "review/reviewWriteForm"; // 리뷰 작성 JSP 페이지
		        }
		        
    		}
        }
        model.addAttribute("alertMsg", "이미 리뷰를 작성하셨습니다.");
        return "redirect:/detail.pr?pno=" + prodNo; // 상품페이지로 리다이렉트
    }
	
	@ResponseBody
	@PostMapping("insert.rv")
    public Map<String, Object> insertReview(Review review,
    						   @RequestParam int prodNo,
    						   @RequestParam(value = "reviewImages", required = false) List<MultipartFile> reviewImages,
    						   HttpSession session) {
		
		Map<String, Object> resultMap = new HashMap<>();
		
	    // 리뷰 저장
	    int result = reviewService.insertReview(review);
	    int attResult = 1;
	    
	    // 리뷰 저장 성공 시 첨부파일 처리 
	    if(result > 0 && reviewImages != null) {
			// 첨부파일 데이터 리스트 생성
			for(MultipartFile upfile : reviewImages) {
				if(!upfile.isEmpty()) {
					String origFileName = upfile.getOriginalFilename();
					String saveFileName = saveFile(upfile, session); // 서버에 파일 저장 및 파일명 수정
					
					// 첨부파일 객체 생성
					ReviewAtt ra = new ReviewAtt();
					ra.setOrigFileName(origFileName);
					ra.setSaveFileName(saveFileName);
					ra.setSavePath("/resources/uploadFiles/review/");
					// 첨부파일 데이터 등록
					attResult = attResult * reviewService.insertReviewAtt(ra);
				}
			}
			
			if(attResult <= 0) {
	        	resultMap.put("success", false);
	            resultMap.put("message", "리뷰가 등록되었으나, 첨부파일 등록에 실패했습니다.");
	        } else {
	        	resultMap.put("success", true);
	            resultMap.put("message", "리뷰가 성공적으로 등록되었습니다.");
	        }
			
		} else if(result > 0) {
        	resultMap.put("success", true);
            resultMap.put("message", "리뷰가 성공적으로 등록되었습니다.");
            
        } else {
        	resultMap.put("success", false);
            resultMap.put("message", "리뷰 등록에 실패했습니다.");
        }

        return resultMap;
    }
	
	@GetMapping("updateForm.rv")
    public String editReviewForm(@RequestParam int prodNo, 
    							 Review review, 
    							 Model model, 
    							 HttpSession session) {
		
		if(session.getAttribute("loginUser") == null) {
        	session.setAttribute("errorMsg", "로그인 후 리뷰를 수정할 수 있습니다.");
			return "redirect:/loginForm.me";
		}
		
        // 현재 로그인된 사용자와 요청된 memberId 비교
		String loginMemberId = ((Member)session.getAttribute("loginUser")).getMemberId();
        
        if(loginMemberId == null || !loginMemberId.equals(review.getMemberId())) {
            model.addAttribute("errorMsg", "잘못된 접근입니다.");
            return "common/errorPage"; // 접근 거부 페이지로 이동
        }

        // 구매정보 가져오기
        Map<String, Object> productInfo = productService.getInfoByRevNo(review.getRevNo());
        // 리뷰정보 가져오기
        Review r = reviewService.selectReview(review.getRevNo());
        
        model.addAttribute("productInfo", productInfo);
        model.addAttribute("r", r);
        model.addAttribute("prodNo", prodNo);
        // serialNo, orderDate, optName, optValue, prodName
        return "review/reviewEditForm"; // 리뷰 작성 JSP 페이지
       
    }
	
	@ResponseBody
	@PostMapping("update.rv")
    public Map<String, Object> updateReview(Review review,
    						   @RequestParam(value = "reviewImages", required = false) List<MultipartFile> reviewImages,
    						   @RequestParam(value = "removeFiles", required = false) List<String> removeFiles,
    						   HttpSession session) {
		
		Map<String, Object> resultMap = new HashMap<>();
		
	    // 리뷰 저장
	    int result = reviewService.updateReview(review);
	    int attResult = 1;
	    
	    // 삭제 파일이 있을 경우
	    if(removeFiles != null) {
	    	for(String deleteFileName : removeFiles) {
	    		
	    		// 실제 파일 삭제
	    		deleteFile(deleteFileName, session);
	    		
	    		// DB 삭제
	    		int resultDel = reviewService.deleteReviewAtt(deleteFileName);
	    		
	    		if(resultDel == 0) {
	    			System.out.println("첨부파일 삭제 실패");
	    		}
	    	}
	    }
	    
	    // 리뷰 저장 성공 시 첨부파일 처리 
	    if(result > 0 && reviewImages != null) {
			// 첨부파일 데이터 리스트 생성
			for(MultipartFile upfile : reviewImages) {
				if(!upfile.isEmpty()) {
					String origFileName = upfile.getOriginalFilename();
					String saveFileName = saveFile(upfile, session); // 서버에 파일 저장 및 파일명 수정
					
					// 첨부파일 객체 생성
					ReviewAtt ra = new ReviewAtt();
					ra.setOrigFileName(origFileName);
					ra.setSaveFileName(saveFileName);
					ra.setSavePath("/resources/uploadFiles/review/");
					ra.setRevNo(review.getRevNo());
					// 첨부파일 데이터 등록
					attResult = attResult * reviewService.updateReviewAtt(ra);
				}
			}
			
			if(attResult <= 0) {
	        	resultMap.put("success", false);
	            resultMap.put("message", "리뷰가 수정되었으나, 첨부파일 등록에 실패했습니다.");
	        } else {
	        	resultMap.put("success", true);
	            resultMap.put("message", "리뷰가 성공적으로 수정되었습니다.");
	        }
			
		} else if(result > 0) {
        	resultMap.put("success", true);
            resultMap.put("message", "리뷰가 성공적으로 수정되었습니다.");
            
        } else {
        	resultMap.put("success", false);
            resultMap.put("message", "리뷰 수정에 실패했습니다.");
        }

        return resultMap;
    }
	
	@GetMapping("delete.rv")
    public String deleteReview(Review review, 
							   Model model, 
							   HttpSession session,
							   @RequestHeader(value = "Referer", required = false) String referer) {
		
		if(session.getAttribute("loginUser") == null) {
        	session.setAttribute("errorMsg", "로그인 후 리뷰를 삭제할 수 있습니다.");
			return "redirect:/loginForm.me";
		}
		
        // 현재 로그인된 사용자와 요청된 memberId 비교
		String loginMemberId = ((Member)session.getAttribute("loginUser")).getMemberId();
        
        if(loginMemberId == null || !loginMemberId.equals(review.getMemberId())) {
            model.addAttribute("errorMsg", "잘못된 접근입니다.");
            return "common/errorPage"; // 접근 거부 페이지로 이동
        }
        
        int result = reviewService.deleteReview(review.getRevNo());
		
		if (referer != null) {
			session.setAttribute("successMsg", "게시글을 삭제했습니다.");
            return "redirect:" + referer;
        }
        // Referer가 없으면 루트 페이지로 리다이렉트
		session.setAttribute("successMsg", "게시글을 삭제했습니다.");
        return "redirect:/";
	}
	
	// 상품 상세보기 요청
	@GetMapping("listAll.rv")
	public String selectProduct(@RequestParam(value="rpage", defaultValue="1")int revPage,
								Model model,
								HttpSession session) {
		
			
			// 리뷰 목록조회
			int revListCount = reviewService.selectReviewAllCount();
			int revPageLimit = 5;
			int revBoardLimit = 10;
			PageInfo revPi = Pagination.getPageInfo(revListCount, revPage, 
												 revPageLimit, revBoardLimit);
			ArrayList<Review> revList = reviewService.selectReviewAll(revPi);
			List<ReviewAtt> allRevAttList = reviewService.allReviewAtt();
			
			model.addAttribute("revList", revList);
			model.addAttribute("revPi", revPi);
			model.addAttribute("allRevAttList", allRevAttList);
			
			return "review/reviewListView";
	}
	
	// 첨부파일 저장 메소드
	public String saveFile(MultipartFile upfile, HttpSession session) {
		
	    String originName = upfile.getOriginalFilename();
	    
	    String currentTime = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());
	    String ext = originName.substring(originName.lastIndexOf("."));
	    
	    String changeName = currentTime + "_" + UUID.randomUUID() + ext;
	    
	    String savePath = session.getServletContext().getRealPath("/resources/uploadFiles/review/");
	    
	    try {
			upfile.transferTo(new File(savePath + changeName));
		} catch (IllegalStateException | IOException e) {
			e.printStackTrace();
		}
	    
	    return changeName;
	}
	
	// 첨부파일 삭제 메소드
	public boolean deleteFile(String delfile, HttpSession session) {
		
		String savePath = session.getServletContext().getRealPath("/resources/uploadFiles/review/");
		
		File delFile = new File(savePath + delfile);
		
		try {
			if(delFile.exists() && delFile.delete()) {
				System.out.println("서버파일 삭제성공");
				return true;
			} else {
				System.out.println("서버파일 삭제실패");
				return false;
			}
		} catch(Exception e) {
			e.printStackTrace();
			return false;
		}
	}
	
}
