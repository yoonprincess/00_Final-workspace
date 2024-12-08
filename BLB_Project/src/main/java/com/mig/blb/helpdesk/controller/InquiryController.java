package com.mig.blb.helpdesk.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.mig.blb.common.model.vo.PageInfo;
import com.mig.blb.common.template.Pagination;
import com.mig.blb.helpdesk.model.service.InquiryService.InquiryService;
import com.mig.blb.helpdesk.model.vo.Inquiry;
import com.mig.blb.helpdesk.model.vo.InquiryAtt;

@Controller
public class InquiryController {

	// InquiryService 객체 생성
	@Autowired
	private InquiryService inquiryService;
	
	// 문의 목록 조회 요청
	@GetMapping("list.io")
	public String selectInquiryList(@RequestParam(value="cpage", defaultValue="1")int currentPage,
									Model model) {
		int listCount = inquiryService.selectInquiryListCount();
		
		int pageLimit = 5;
		int boardLmit = 5;
		
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, pageLimit, boardLmit);
		ArrayList<Inquiry> list = inquiryService.selectInquiryList(pi);
		
		model.addAttribute("list", list);
		model.addAttribute("pi", pi);
		
		//System.out.println(list);
		// > 상품 정보가 잘 넘어온다.
		
		return "helpdesk/InquiryListView";
	}
	
	
	@GetMapping("Inquiry.blb")
	public ModelAndView Inquiry(ModelAndView mv) {
		
		mv.setViewName("helpdesk/Inquiry");
		
		return mv;
	}
	
	@PostMapping("insert.io")
	public ModelAndView insertInquiry(Inquiry i,
									  InquiryAtt ia,
									  RedirectAttributes ar,
									  MultipartFile upfile,
									  HttpSession session,
									  ModelAndView mv){
		
		if(!upfile.getOriginalFilename().equals("")) {
			
			String changeName = saveFile(upfile, session);
			
			ia.setOrigFileName(upfile.getOriginalFilename());
			ia.setSaveFileName("resources/uploadFiles/" + changeName);
		}
		
		int result = inquiryService.insertInquiry(i);
		if(result > 0) {
			mv.setViewName("redirect:/Inquiry.blb");
		} else {
			ar.addFlashAttribute("alertMsg", "공지사항이 성공적으로 등록되었습니다.");
			mv.setViewName("redirect:/Inquiry.blb");
		}
		
		
		return mv;
	}
	
	// 첨부파일을 위한 메소드
			public String saveFile(MultipartFile upfile,
								   HttpSession session) {
				
				String originName = upfile.getOriginalFilename();
				
				String currentTime = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());
				
				int ranNum = (int)(Math.random() * 90000 + 10000);
				String ext = originName.substring(originName.lastIndexOf("."));
				
				String changeName = currentTime + ranNum + ext;
				
				String savePath = session.getServletContext().getRealPath("/resources/uploadFiles/");
				
				try {
					upfile.transferTo(new File(savePath + changeName));
				} catch (IllegalStateException | IOException e) {
					e.printStackTrace();
				}
				
				return changeName;
			}
}
