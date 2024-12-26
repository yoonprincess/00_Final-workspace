package com.mig.blb.helpdesk.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.mig.blb.common.model.vo.PageInfo;
import com.mig.blb.common.template.Pagination;
import com.mig.blb.helpdesk.model.service.FaqService.FaqService;
import com.mig.blb.helpdesk.model.vo.Faq;

@Controller
public class FaqController {

	// NoticeService 객체 생성
	@Autowired
	private FaqService faqService;
	
	// FAQ 목록 조회 요청
		@GetMapping("list.fo")
		public String selectFaqList(@RequestParam(value="cpage", defaultValue="1")int currentPage,
								 Model model) {
			
			int listCount = faqService.selectFaqListCount();
			
			int pageLimit = 5;
			int boardLimit = 5;
			
			PageInfo pi = Pagination.getPageInfo(listCount, currentPage, pageLimit, boardLimit);
			ArrayList<Faq> list = faqService.selectFaqList(pi);
			
			model.addAttribute("list",list);
			model.addAttribute("pi",pi);
			
			
			return "helpdesk/FAQ";
			
		}
		
		// FAQ 작성 요청
		@PostMapping("insert.fo")
		public ModelAndView insertFaq(Faq f,
									/*@RequestParam(value="faqType") String faqType,*/
		                                 RedirectAttributes ar,
		                                 HttpSession session,
		                                 ModelAndView mv) {
				//f.setFaqType(faqType);
				
			
				// Faq 객체를 서비스에 전달
				int result = faqService.insertFaq(f);
				
				if(result > 0) {
					mv.setViewName("redirect:/list.fo");
				} else {
					mv.setViewName("common/errorPage");
				}
			
			return mv;
		}
		
		// FAQ 삭제 요청
		@PostMapping("FaqDelete.fo")
		public String deleteFaq(int fno,
								   Model model,
								   HttpSession session,
								   RedirectAttributes ar) {
			int result = faqService.deleteFaq(fno);
			if(result > 0) {
				session.setAttribute("aletMsg", "FAQ가 성공적으로 삭제되었습니다.");
				
				return "redirect:/list.fo";
			} else {
				ar.addFlashAttribute("alertMsg", "FAQ 삭제에 실패했습니다.");
				return "redirect:/list.fo";
			}
		}
		
		// FAQ 수정 요청
		@PostMapping("FaqUpdate.fo")
		public ModelAndView updateFaq(@RequestParam("fno") int fno, // FAQ 번호
									  @RequestParam("faqTitle") String faqTitle, // FAQ 제목
									  @RequestParam("faqContent") String faqContent, // FAQ 내용
									  
		                              Faq f,
		                              RedirectAttributes ar,
		                              HttpSession session,
		                              ModelAndView mv) {
			

		    // FAQ 본문 및 제목 수정
		    f.setFaqNo(fno); // 공지사항 번호 설정
		    f.setFaqTitle(faqTitle); // 공지사항 제목 설정
		    f.setFaqContent(faqContent); // 공지사항 내용 설정
		    
		    //System.out.println(f);
		    
		    int result = faqService.updateFaq(f);
		    
		    

		    if (result > 0) {
		        ar.addFlashAttribute("message", "FAQ가 성공적으로 수정되었습니다.");
		        mv.setViewName("redirect:/list.fo"); // 상세 페이지로 이동
		    } else {
		        ar.addFlashAttribute("message", "FAQ 수정에 실패했습니다.");
		        mv.setViewName("redirect:/errorPage");
			    }

			    return mv;
			}
}
