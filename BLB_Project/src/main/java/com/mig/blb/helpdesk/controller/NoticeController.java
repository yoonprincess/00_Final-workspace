package com.mig.blb.helpdesk.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

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
import com.mig.blb.helpdesk.model.vo.NoticeAtt;

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
			
			
			return "helpdesk/Notice";
			
		}
	
		// 공지사항 작성 페이지 요청
		@GetMapping("NoticeEnrollForm.no")
		public ModelAndView enrollForm(ModelAndView mv) {
		
		mv.setViewName("helpdesk/NoticeEnrollForm");
		return mv;
		
		}
		
		// 공지사항 작성 요청
		@PostMapping("insert.no")
		public ModelAndView insertNotice(Notice n,
		                                 RedirectAttributes ar,
		                                 MultipartFile[] upfile,
		                                 HttpSession session,
		                                 ModelAndView mv) {

		    // 첨부파일 O
			if(upfile != null && upfile.length >0) {
				ArrayList<NoticeAtt> noticeAtt = new ArrayList<NoticeAtt>(); // NoticeAtt 객체를 담을 리스트
				
				// 첨부파일 처리
				for(int i = 0; i < upfile.length; i++) {
					MultipartFile upfiles = upfile[i];
					if(!upfiles.isEmpty()) {
						
						// 파일저장
						String changeName = saveFile(upfiles, session);
						
						// NoticeAtt 객체 생성 및 첨부파일 정보 설정
						NoticeAtt att = new NoticeAtt();
						att.setOrigFileName(upfiles.getOriginalFilename()); // 원본 파일명
						att.setSaveFileName(changeName); // 저장된 파일명
						
						att.setSavePath("resources/uploadFiles/notice/");
						
						// NoticeAtt 객체 리스트에 추가
						noticeAtt.add(att);
					}
				}
			
				// Notice 객체와 NoticeAtt 리스트를 서비스에 전달
				int result = noticeService.insertNotice(n, noticeAtt); // Notice와 NoticeAtt 리스트를 전달
				
				if(result > 0) {
					mv.setViewName("redirect:/list.no");
				} else {
					mv.setViewName("common/errorPage");
				}
			}
			return mv;
		}



		
		// 공지사항 상세조회 요청
		@GetMapping("notice/{noticeNo}")
		public ModelAndView selectNotice(@PathVariable(value = "noticeNo") int nno,
		                                 ModelAndView mv,
		                                 RedirectAttributes ra) {
		        Notice n = noticeService.selectNotice(nno);
		        ArrayList<NoticeAtt> na = noticeService.selectNoticeAtt(nno);
		        mv.addObject("n", n).setViewName("helpdesk/NoticeDetailView");
		        mv.addObject("na", na).setViewName("helpdesk/NoticeDetailView");
		        //System.out.println(na);
		        // > na 배열에 잘 담겨있음!
		    return mv;
		}

		// 공지사항 삭제 요청
		@PostMapping("NoticeDelete.no")
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
		@PostMapping("NoticeUpdateForm.no")
		public String updateForm(int nno,
								 Model model) {
			Notice n = noticeService.selectNotice(nno);
			ArrayList<NoticeAtt> na = noticeService.selectNoticeAtt(nno);
			
			model.addAttribute("n",n);
			model.addAttribute("na", na);
			return "helpdesk/NoticeUpdateForm";
		}
		
		// 공지사항 수정 요청
		@PostMapping("NoticeUpdate.no")
		public String updateNotice(Notice n,
								   RedirectAttributes ar,
								   MultipartFile[] reupfile,
								   HttpSession session,
								   Model model) {

			if(reupfile != null && reupfile.length > 0) {
			
			int result = noticeService.updateNoticeAtt();
			}
			
			return null;
		}

		
		// 첨부파일을 위한 메소드
		public String saveFile(MultipartFile upfile, HttpSession session) {
		    String originName = upfile.getOriginalFilename();
		    
		    String currentTime = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());
		    int ranNum = (int)(Math.random() * 90000 + 10000);
		    String ext = originName.substring(originName.lastIndexOf("."));
		    String changeName = currentTime + ranNum + ext;
		    String savePath = session.getServletContext().getRealPath("/resources/uploadFiles/notice/");
		    
		    try {
				upfile.transferTo(new File(savePath + changeName));
			} catch (IllegalStateException | IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		    
		    return changeName;
		}

	}

