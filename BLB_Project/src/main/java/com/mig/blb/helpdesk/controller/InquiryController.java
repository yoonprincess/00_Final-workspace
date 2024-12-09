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
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.gson.Gson;
import com.mig.blb.common.model.vo.PageInfo;
import com.mig.blb.common.template.Pagination;
import com.mig.blb.helpdesk.model.service.InquiryService.InquiryService;
import com.mig.blb.helpdesk.model.vo.Inquiry;
import com.mig.blb.helpdesk.model.vo.InquiryAtt;
import com.mig.blb.helpdesk.model.vo.InquiryReply;

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
	
	// 문의 작성 페이지 요청
	@GetMapping("Inquiry.blb")
	public ModelAndView Inquiry(ModelAndView mv) {
		
		mv.setViewName("helpdesk/Inquiry");
		
		return mv;
	}
	
	// 문의 등록 요청
	@PostMapping("insert.io")
	public ModelAndView insertInquiry(Inquiry i,
									  /*InquiryAtt ia,*/
									  RedirectAttributes ar,
									  /*MultipartFile upfile,*/
									  HttpSession session,
									  ModelAndView mv){
		
		/*
		if(!upfile.getOriginalFilename().equals("")) {
			
			String changeName = saveFile(upfile, session);
			
			ia.setOrigFileName(upfile.getOriginalFilename());
			ia.setSaveFileName("resources/uploadFiles/" + changeName);
		}
		*/
		
		int result = inquiryService.insertInquiry(i);
		
		
		System.out.println("controller단에서 : " + i);
		
		if(result > 0) {
			mv.setViewName("redirect:/Inquiry.blb");
		} else {
			ar.addFlashAttribute("alertMsg", "문의가 성공적으로 접수되었습니다.");
			mv.setViewName("redirect:/Inquiry.blb");
		}
		
		
		return mv;
	}
	
	// 문의 상세조회 요청
		@GetMapping("inquiry/{inquiryNo}")
		public ModelAndView selectInquiry(@PathVariable(value = "inquiryNo") int ino,
		                                 ModelAndView mv,
		                                 RedirectAttributes ra) {
		        Inquiry i = inquiryService.selectInquiry(ino);
		        mv.addObject("i", i).setViewName("helpdesk/InquiryDetailView");
		        
		        //System.out.println(i);
		        // > 데이터는 잘 넘어온다.
		        
		    return mv;
		}
		
	// 댓글 목록 조회 요청 (ajax)
	@ResponseBody
	@GetMapping(value="rlist.io",
				produces="application/json; charset=UTF-8")
	public String SelectInquiryReplyList(int ino) {
		
		ArrayList<InquiryReply> list = inquiryService.selectInquiryReplyList(ino);
		
		return new Gson().toJson(list);
	}	
		
	// 댓글 작성용 요청
	@ResponseBody
	@PostMapping(value="rinsert.io",
				 produces="text/html; charset=UTF-8")
	public String InsertInquiryReply(InquiryReply ir) {
		
		int result = inquiryService.insertInquiryReply(ir);
		
		System.out.println(result);
		
		return (result > 0) ? "success" : "fail";
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
