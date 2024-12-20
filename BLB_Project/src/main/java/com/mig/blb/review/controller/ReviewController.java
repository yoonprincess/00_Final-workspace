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

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.mig.blb.member.model.vo.Member;
import com.mig.blb.option.model.service.OptionService;
import com.mig.blb.product.model.service.ProductService;
import com.mig.blb.review.model.service.ReviewService;
import com.mig.blb.review.model.vo.Review;
import com.mig.blb.review.model.vo.ReviewAtt;

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
        // Step 1: 구매 여부 확인 및 정보 추출
        List<Map<String, Object>> purchaseInfo = productService.getPurchaseInfo(memberId, prodNo);
	    if (purchaseInfo.isEmpty()) {
	    	model.addAttribute("alertMsg", "구매한 상품에만 리뷰를 작성할 수 있습니다.");
            return "redirect:/detail.pr?pno=" + prodNo; // 상품페이지로 리다이렉트
	    }

	    // Step 2: 리뷰 작성 여부 확인
	    // 리뷰되지 않은 SERIAL_NO 찾기
	    for (Map<String, Object> purchaseOne : purchaseInfo) {
	        int serialNo = Integer.parseInt((String) purchaseOne.get("serialNo"));

	        // 리뷰 작성 여부 확인
	        boolean isReviewWritten = reviewService.isReviewWritten(serialNo);

	        if (!isReviewWritten) {
	        	// 상품 및 사용자 정보 추가
	            model.addAttribute("prodNo", prodNo);
	            model.addAttribute("memberId", memberId);
	            model.addAttribute("purchaseOne", purchaseOne);
	            // serialNo, orderDate, optName, optValue, prodName
	            return "review/reviewWriteForm"; // 리뷰 작성 JSP 페이지
	        }
	    }
        model.addAttribute("alertMsg", "이미 리뷰를 작성하셨습니다.");
        return "redirect:/detail.pr?pno=" + prodNo; // 상품페이지로 리다이렉트
    }
	
	@ResponseBody
	@PostMapping("insert.rv")
    public Map<String, Object> insertReview(Review review,
    						   @RequestParam("prodNo") int prodNo,
    						   @RequestParam(value = "reviewImages", required = false) List<MultipartFile> reviewImages,
    						   HttpSession session) {
		
		Map<String, Object> resultMap = new HashMap<>();
		
	    // 리뷰 저장
	    int result = reviewService.insertReview(review);
	    int attResult = 1;
	    
	    // 리뷰 저장 성공 시 첨부파일 처리 
	    if(result > 0 && !reviewImages.isEmpty()) {
			// 파일 저장 처리
			List<ReviewAtt> raList = new ArrayList<>();
			
			// 첨부파일 데이터 리스트 생성
			for(MultipartFile upfile : reviewImages) {
				if(!upfile.isEmpty()) {
					String origFileName = upfile.getOriginalFilename();
					String saveFileName = saveFile(upfile, session);
					
					// 첨부파일 객체 생성
					ReviewAtt ra = new ReviewAtt();
					ra.setOrigFileName(origFileName);
					ra.setSaveFileName(saveFileName);
					ra.setSavePath("/resources/uploadFiles/review/");
					
					raList.add(ra);
				}
			}
			
			// 첨부파일 데이터 등록
			for(ReviewAtt ra : raList) {
				attResult = attResult * reviewService.insertReviewAtt(ra);
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
	
	// 첨부파일을 위한 메소드
	public String saveFile(MultipartFile upfile, HttpSession session) {
		
	    String originName = upfile.getOriginalFilename();
	    
	    String currentTime = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());
	    String ext = originName.substring(originName.lastIndexOf("."));
	    
	    String changeName = currentTime + "_" + UUID.randomUUID() + ext;
	    
	    String savePath = session.getServletContext().getRealPath("/resources/uploadFiles/review/");
	    
	    try {
			upfile.transferTo(new File(savePath + changeName));
		} catch (IllegalStateException | IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	    
	    return changeName;
	}
	
}
