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
import com.mig.blb.helpdesk.model.service.InquiryReplyService.InquiryReplyService;
import com.mig.blb.helpdesk.model.service.InquiryService.InquiryService;
import com.mig.blb.helpdesk.model.vo.Inquiry;
import com.mig.blb.helpdesk.model.vo.InquiryAtt;
import com.mig.blb.helpdesk.model.vo.InquiryReply;
import com.mig.blb.member.model.vo.Member;

@Controller
public class InquiryController {

	// InquiryService 객체 생성
	@Autowired
	private InquiryService inquiryService;
	
	// InquiryService 객체 생성
	@Autowired
	private InquiryReplyService inquiryReplyService;
		
	
	// 문의 목록 조회 요청
	@GetMapping("list.io")
	public String selectInquiryList(@RequestParam(value="cpage", defaultValue="1")int currentPage,
									Model model,
									HttpSession session) {
		
		if(session.getAttribute("loginUser") == null) {
			
			
			return "redirect:/loginForm.me";
			
		} else {
		
			String memberId = ((Member)session.getAttribute("loginUser")).getMemberId();
			
			//System.out.println(memberId);
			// > session.loginUser의 memberId가 출력됨
			
			int listCount = inquiryService.selectInquiryListCount(memberId);
			
			int pageLimit = 5;
			int boardLmit = 5;
			
			PageInfo pi = Pagination.getPageInfo(listCount, currentPage, pageLimit, boardLmit);
			ArrayList<Inquiry> list = inquiryService.selectInquiryList(pi, memberId);
			
			//System.out.println(list);
			
			model.addAttribute("list", list);
			model.addAttribute("pi", pi);
			
			return "helpdesk/InquiryListView";
		}
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
									  RedirectAttributes ar,
									  MultipartFile[] upfile,
									  HttpSession session,
									  ModelAndView mv){
		
		// 첨부파일 O
		if(upfile != null && upfile.length >0) {
			ArrayList<InquiryAtt> inquiryAtt = new ArrayList<InquiryAtt>(); // InquiryAtt 객체를 담을 리스트
			
			// 첨부파일 처리
			for(int ia = 0; ia < upfile.length; ia++) {
				MultipartFile upfiles = upfile[ia];
				 
				if(!upfiles.isEmpty()) {
					// 파일저장
					String changeName = saveFile(upfiles, session);
					
					// InquiryAtt 객체 생성 및 첨부파일 정보 설정
					InquiryAtt iatt = new InquiryAtt();
					iatt.setOrigFileName(upfiles.getOriginalFilename()); // 원본 파일명
					iatt.setSaveFileName(changeName); // 저장된 파일명
					
					iatt.setSavePath("resources/uploadFiles/inquiry/");
					
					// InquiryAtt 객체 리스트에 추가
					inquiryAtt.add(iatt);
				}
			}
		
		 // 서비스 호출
	    int result = inquiryService.insertInquiry(i, inquiryAtt);

	    // 결과 처리
	    if (result > 0) {
	        ar.addFlashAttribute("alertMsg", "문의가 성공적으로 접수되었습니다.");
	        mv.setViewName("redirect:/list.io");
	    } else {
	        ar.addFlashAttribute("alertMsg", "문의 접수에 실패했습니다.");
	        mv.setViewName("common/errorPage");
	    }
	}
	    return mv;
	   
	}
	
	// 문의 상세조회 요청
	@GetMapping("inquiry/{inquiryNo}")
	public ModelAndView selectInquiry(@PathVariable(value = "inquiryNo") int ino,
	                                 ModelAndView mv,
	                                 RedirectAttributes ra) {
	        Inquiry i = inquiryService.selectInquiry(ino);
	        ArrayList<InquiryAtt> iatt = inquiryService.selectInquiryAtt(ino);
	        mv.addObject("i", i).setViewName("helpdesk/InquiryDetailView");
	        mv.addObject("iatt", iatt).setViewName("helpdesk/InquiryDetailView");
	    return mv;
	}
		
	// 문의글 삭제 요청
	@PostMapping("InquiryDelete.io")
	public String deleteInquiry(int ino,
							   String filePath,
							   Model model,
							   HttpSession session,
							   RedirectAttributes ar) {
		
		int result = inquiryService.deleteInquiry(ino);
		
		session.setAttribute("aletMsg", "문의글이 성공적으로 삭제되었습니다.");		
		return "redirect:/list.io";
		/*
		if(result > 0) {
			if(!filePath.equals("")) {
				String realPath = session.getServletContext().getRealPath(filePath);
				
				new File(realPath).delete();
			}
			
			System.out.println("문의글 삭제 성공 :" + ino);
			
			session.setAttribute("aletMsg", "문의글이 성공적으로 삭제되었습니다.");
			
			return "redirect:/list.io";
		} else {
			
			System.out.println("문의글 삭제 실패 :" + ino);
			
			ar.addFlashAttribute("alertMsg", "문의글 삭제에 실패했습니다.");
			return "redirect:/list.io";
		}
		*/
	}
		
	// 문의글 수정 페이지 요청
	@PostMapping("InquiryUpdateForm.io")
	public String InquiryUpdateForm(@RequestParam int ino,
								    Model model) {
		Inquiry i = inquiryService.selectInquiry(ino);
		
		model.addAttribute("i",i);
		return "helpdesk/InquiryUpdateForm";
	}
			
	// 문의글 수정 요청
	@PostMapping("InquiryUpdate.io")
	public String updateInquiry(Inquiry i,
							   /*InquiryAtt ia,*/
							   RedirectAttributes ar,
							   MultipartFile reupfile,
							   HttpSession session,
							   Model model) {
		/*
		if(!reupfile.getOriginalFilename().equals("")) {
			if(ia.getOriginName() != null) {
				String realPath = session.getServletContext().getRealPath(ia.getChangeName());
				
				new File(realPath).delete();
			}
			
			String changeName = saveFile(reupfile, session);
			ia.setOriginName(reupfile.getOriginalFilename());
			ia.setChangeName("resources/uploadFiles/" + changeName);
		}
		*/
		
		int result = inquiryService.updateInquiry(i);
		
		if(result > 0) {
			session.setAttribute("alertMsg", "문의글이 성공적으로 수정되었습니다.");
			
			return "redirect:/inquiry/" + i.getInquiryNo();
		} else {
			ar.addFlashAttribute("alertMsg", "문의글 수정에 실패했습니다.");
			return "redirect:/list.io";
		} 
	}		
		
	// 댓글 목록 조회 요청 (ajax)
	@ResponseBody
	@GetMapping(value="rlist.io",
				produces="application/json; charset=UTF-8")
	public String selectInquiryReplyList(int ino) {
		
		ArrayList<InquiryReply> list = inquiryReplyService.selectInquiryReplyList(ino);						
		
		return new Gson().toJson(list);
	}
	
	// 댓글 작성용 요청
	@ResponseBody
	@PostMapping(value="rinsert.io",
				 produces="text/html; charset=UTF-8")
	public String insertInquiryReply(InquiryReply r) {
		
		int result = inquiryReplyService.insertInquiryReply(r);
		
		return (result > 0) ? "success" : "fail";
	}
	
	@PostMapping(value = "rupdate.io")
	@ResponseBody // AJAX 요청에 대한 응답을 JSON 형태로 반환
	public String updateInquiryReply(@RequestParam("ino") int inquiryReplyNo,
	                                 @RequestParam("inquiryReplyContent") String inquiryReplyContent,
	                                 @RequestParam("memberId") String memberId) {
	    // InquiryReply 객체에 데이터 설정
	    InquiryReply ir = new InquiryReply();
	    ir.setInquiryReplyNo(inquiryReplyNo);
	    ir.setInquiryReplyContent(inquiryReplyContent);
	    ir.setMemberId(memberId);

	    // 댓글 수정 로직 호출
	    int result = inquiryReplyService.updateInquiryReply(ir);

	    // 결과 반환
	    return result > 0 ? "success" : "fail";
	}

	
	
	// 댓글 삭제 요청
	@PostMapping(value="rdelete.io")
	public String deleteInquiryReply(int ino,
									 Model model,
								     HttpSession session,
								     RedirectAttributes ar) {
		
		
		
		int result = inquiryReplyService.deleteInquiryReply(ino);
		if(result > 0) {
			session.setAttribute("aletMsg", "댓글이 성공적으로 삭제되었습니다.");
			
			return "redirect:/rlist.io";
		} else {
			ar.addFlashAttribute("alertMsg", "댓글 삭제에 실패했습니다.");
			return "redirect:/rlist.io";
		}
	}
	
	
	// 첨부파일을 위한 메소드
	public String saveFile(MultipartFile upfile,
						   HttpSession session) {
		
		String originName = upfile.getOriginalFilename();
		
		String currentTime = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());
		
		int ranNum = (int)(Math.random() * 90000 + 10000);
		String ext = originName.substring(originName.lastIndexOf("."));
		
		String changeName = currentTime + ranNum + ext;
		
		String savePath = session.getServletContext().getRealPath("/resources/uploadFiles/inquiry/");
		
		try {
			upfile.transferTo(new File(savePath + changeName));
		} catch (IllegalStateException | IOException e) {
			e.printStackTrace();
		}
		
		return changeName;
	}
}
