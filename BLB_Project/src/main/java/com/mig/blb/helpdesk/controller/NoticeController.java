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
	
		// NoticeService ��ü ���� ������ ����
		@Autowired
		private NoticeService noticeService;
		
		// �������� �����ȸ ��û
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
	
		// �������� �ۼ������� ��û
		@GetMapping("enrollForm.no")
		public ModelAndView enrollForm(ModelAndView mv) {
		
		mv.setViewName("helpdesk/CustomerServiceCenter");
		return mv;
		
		}
		
		// �������� ��� ��û
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
				ar.addFlashAttribute("alertMsg", "�Խñ� ��Ͽ� �����߽��ϴ�. �����ڿ��� �������ּ���.");
				mv.setViewName("redirect:/list.no");
			}
			return mv;
		}
		
		// �������� �������� ��û
		@GetMapping("notice/{noticeNo}")
		public ModelAndView selectNotice(@PathVariable(value = "noticeNo") int nno,
		                                 ModelAndView mv,
		                                 RedirectAttributes ra) {
		    int result = noticeService.increaseCount(nno);
		    if (result > 0) {
		        Notice n = noticeService.selectNotice(nno);
		        mv.addObject("n", n).setViewName("helpdesk/NoticeDetailView");
		    } else {
		        ra.addFlashAttribute("alertMsg", "����ȸ�� �����߽��ϴ�. �����ڿ��� �������ּ���");
		        mv.setViewName("redirect:/list.no"); // ���� �� �̵��� ������ ����
		    }
		    return mv;
		}

		// �������� ���� ��û
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
				session.setAttribute("aletMsg", "�Խñ��� �����Ǿ����ϴ�.");
				
				return "redirect:/list.no";
			} else {
				ar.addFlashAttribute("alertMsg", "�Խñ� ������ �����߽��ϴ�. �������� �������ּ���");
				return "redirect:/list.no";
			}
		}
		
		// �������� ���� ������ ��û
		@PostMapping("updateForm.no")
		public String updateForm(int nno,
								 Model model) {
			Notice n = noticeService.selectNotice(nno);
			
			model.addAttribute("n",n);
			return "notice/noticeUpdateForm";
		}
		
		// �������� ���� ��û
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
				session.setAttribute("alertMsg", "���������� ���������� �����Ǿ����ϴ�.");
				
				return "redirect:/notice/" + n.getNoticeNo();
			} else {
				ar.addFlashAttribute("alertMsg", "�������� ��Ͽ� �����߽��ϴ�. �����ڿ��� �������ּ���.");
				return "redirect:/list.no";
			} 
		}
		
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

