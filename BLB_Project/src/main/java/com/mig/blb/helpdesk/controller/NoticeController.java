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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.mig.blb.common.model.vo.PageInfo;
import com.mig.blb.common.template.Pagination;
import com.mig.blb.helpdesk.model.service.NoticeService.NoticeService;
import com.mig.blb.helpdesk.model.vo.Notice;

	@Controller
	public class NoticeController {
	
		// NoticeService 객체 생성
		@Autowired
		private NoticeService noticeService;
		
		// 공지사항 목록 조회 요청
		@GetMapping("list.no")
		public String selectList(@RequestParam(value="cpage", defaultValue="1")int currentPage,
								 Model model) {
			
			int listCount = noticeService.selectListCount();
			
			int pageLimit = 5;
			int boardLimit = 5;
			
			PageInfo pi = Pagination.getPageInfo(listCount, currentPage, pageLimit, boardLimit);
			ArrayList<Notice> list = noticeService.selectList(pi);
			
			model.addAttribute("list",list);
			model.addAttribute("pi",pi);
			
			return "helpdesk/CustomerServiceCenter";
			
		}
	
		// 공지사항 작성 페이지 요청
		@GetMapping("enrollForm.no")
		public ModelAndView enrollForm(ModelAndView mv) {
		
		mv.setViewName("helpdesk/CustomerServiceCenter");
		return mv;
		
		}
		
		// 공지사항 등록 요청
		@PostMapping("insert.no")
		public ModelAndView insertNotice(Notice n,
										 RedirectAttributes ar,
										 MultipartFile upfile,
										 HttpSession session,
										 ModelAndView mv) {
			
			if(!upfile.getOriginalFilename().equals("")) {
				
				String changeName = saveFile(upfile, session);
				
				n.setOriginName(upfile.getOriginalFilename());
				n.setChangeName("resources/uploadFiles/" + changeName);
			}
			
			int result = noticeService.insertNotice(n);
			if(result > 0) {
				mv.setViewName("redirect:/list.no");
			} else {
				ar.addFlashAttribute("alertMsg", "공지사항이 성공적으로 등록되었습니다.");
				mv.setViewName("redirect:/list.no");
			}
			return mv;
		}
		
		// 공지사항 상세조회 요청
		@GetMapping("notice/{noticeNo}")
		public ModelAndView selectNotice(@PathVariable(value = "noticeNo") int nno,
		                                 ModelAndView mv,
		                                 RedirectAttributes ra) {
		    int result = noticeService.increaseCount(nno);
		    if (result > 0) {
		        Notice n = noticeService.selectNotice(nno);
		        mv.addObject("n", n).setViewName("helpdesk/NoticeDetailView");
		    } else {
		        ra.addFlashAttribute("alertMsg", "공지사항 상세조회에 실패했습니다.");
		        mv.setViewName("redirect:/list.no"); 
		    }
		    return mv;
		}

		// 공지사항 삭제 요청
		@PostMapping("delete.no")
		public String deleteNotice(int nno,
								   String filePath,
								   Model model,
								   HttpSession session,
								   RedirectAttributes ar) {
			int result = noticeService.deleteNotice(nno);
			if(result > 0) {
				if(!filePath.equals("")) {
					String realPath = session.getServletContext().getRealPath(filePath);
					
					new File(realPath).delete();
				}
				session.setAttribute("aletMsg", "공지사항이 성공적으로 삭제되었습니다.");
				
				return "redirect:/list.no";
			} else {
				ar.addFlashAttribute("alertMsg", "공지사항 삭제에 실패했습니다.");
				return "redirect:/list.no";
			}
		}
		
		// 공지사항 수정 페이지 요청
		@PostMapping("updateForm.no")
		public String updateForm(int nno,
								 Model model) {
			Notice n = noticeService.selectNotice(nno);
			
			model.addAttribute("n",n);
			return "notice/noticeUpdateForm";
		}
		
		// 공지사항 수정 요청
		@PostMapping("update.no")
		public String updateNotice(Notice n,
								   RedirectAttributes ar,
								   MultipartFile reupfile,
								   HttpSession session,
								   Model model) {
			
			if(!reupfile.getOriginalFilename().equals("")) {
				if(n.getOriginName() != null) {
					String realPath = session.getServletContext().getRealPath(n.getChangeName());
					
					new File(realPath).delete();
				}
				
				String changeName = saveFile(reupfile, session);
				n.setOriginName(reupfile.getOriginalFilename());
				n.setChangeName("resources/uploadFiles/" + changeName);
			}
			int result = noticeService.updateNotice(n);
			
			if(result > 0) {
				session.setAttribute("alertMsg", "공지사항이 성공적으로 수정되었습니다.");
				
				return "redirect:/notice/" + n.getNoticeNo();
			} else {
				ar.addFlashAttribute("alertMsg", "공지사항 수정에 실패했습니다.");
				return "redirect:/list.no";
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
			
			String savePath = session.getServletContext().getRealPath("/resources/uploadFiles/");
			
			try {
				upfile.transferTo(new File(savePath + changeName));
			} catch (IllegalStateException | IOException e) {
				e.printStackTrace();
			}
			
			return changeName;
		}
	}

