package com.mig.blb.helpdesk.controller;

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
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
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
		
		// 관리자 - 공지사항 전체조회
		@GetMapping("adminList.no")
		public String selectAdminList(@RequestParam(value="cpage", defaultValue="1")int currentPage,
								 		Model model) {
				
				int listCount = noticeService.selectAdminListCount();
				
				int pageLimit = 5;
				int boardLimit = 5;
				
				PageInfo pi = Pagination.getPageInfo(listCount, currentPage, pageLimit, boardLimit);
				ArrayList<Notice> list = noticeService.selectAdminList(pi);
				
				model.addAttribute("list",list);
				model.addAttribute("pi",pi);
				
				
				return "admin/admin_inquiry";
				
				}
		
		// 공지사항 목록 조회 요청
		@GetMapping("list.no")
		public String selectList(@RequestParam(value="cpage", defaultValue="1")int currentPage,
								 @RequestParam(value="searchKeyword", required=false) String searchKeyword,
								 Model model) {
			
			int listCount = noticeService.selectListCount(searchKeyword);
			
			int pageLimit = 5;
			int boardLimit = 5;
			
			PageInfo pi = Pagination.getPageInfo(listCount, currentPage, pageLimit, boardLimit);
			ArrayList<Notice> list = noticeService.selectList(pi,searchKeyword);
			
			model.addAttribute("list",list);
			model.addAttribute("searchKeyword", searchKeyword);
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
		    // 공지사항 조회
		    Notice n = noticeService.selectNotice(nno);
		    ArrayList<NoticeAtt> na = noticeService.selectNoticeAtt(nno);

		    // 이전글 조회
		    Notice previousNotice = noticeService.selectPreviousNotice(nno);

		    // 다음글 조회
		    Notice nextNotice = noticeService.selectNextNotice(nno);

		    // 모델에 데이터 추가
		    mv.addObject("n", n);
		    mv.addObject("na", na);
		    mv.addObject("previousNotice", previousNotice);
		    mv.addObject("nextNotice", nextNotice);

		    // 뷰 이름 설정
		    mv.setViewName("helpdesk/NoticeDetailView");

		    // 디버깅 로그 (선택적)
		    //System.out.println(previousNotice);
		    //System.out.println(nextNotice);

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
		public ModelAndView updateNotice(
		        @RequestParam(value = "nno", defaultValue = "0") int nno, // 기본값을 0으로 설정
		        Notice n,
		        @RequestParam(value = "upfile", required = false) List<MultipartFile> upfile,
		        @RequestParam(value = "deleteFiles", required = false) List<String> deleteFiles,
		        RedirectAttributes ar,
		        HttpSession session,
		        ModelAndView mv) {
			
			// 공지사항 본문 및 제목 수정
		    n.setNoticeNo(nno);
			int result = noticeService.updateNotice(n);
			
			int attResult = 1;

		    // 삭제파일 있는 경우
		    if(deleteFiles != null) {
		    	for(String deleteFileName : deleteFiles) {
		    		
		    		// 실제 파일 삭제
		    		deleteFile(deleteFileName, session);
		    		
		    		// DB 삭제
		    		int resultDel = noticeService.deleteAtt(deleteFileName);
		    		
		    		if(resultDel == 0) {
		    			mv.setViewName("redirect:/notice/" + nno);
		    		}
		    	}
		    	
		    }
		    
		    // 리뷰 저장 성공 시 첨부파일 처리
		    if(result > 0 && upfile != null) {
		    	for(MultipartFile newUpfile : upfile) {
		    		if(!newUpfile.isEmpty()) {
		    			String origFileName = newUpfile.getOriginalFilename();
		    			String saveFileName = saveFile(newUpfile, session);
		    			
		    			// 첨부파일 객체 생성
		    			NoticeAtt na = new NoticeAtt();
		    			na.setOrigFileName(origFileName);
						na.setSaveFileName(saveFileName);
						na.setSavePath("/resources/uploadFiles/notice/");
						na.setNoticeNo(n.getNoticeNo());
						// 첨부파일 데이터 등록
						attResult = attResult * noticeService.updateAtt(na);
		    		}
		    	}
		    }

		    if (result > 0) {
		        ar.addFlashAttribute("message", "공지사항이 성공적으로 수정되었습니다.");
		        mv.setViewName("redirect:/notice/" + nno); // 상세 페이지로 이동
		    } else {
		        ar.addFlashAttribute("message", "공지사항 수정에 실패했습니다.");
		        mv.setViewName("redirect:/errorPage");
		    }

		    return mv;
		}


		// 첨부파일 저장 메소드
		public String saveFile(MultipartFile upfile, HttpSession session) {
			
		    String originName = upfile.getOriginalFilename();
		    
		    String currentTime = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());
		    String ext = originName.substring(originName.lastIndexOf("."));
		    
		    String changeName = currentTime + "_" + UUID.randomUUID() + ext;
		    
		    String savePath = session.getServletContext().getRealPath("/resources/uploadFiles/notice/");
		    
		    try {
				upfile.transferTo(new File(savePath + changeName));
			} catch (IllegalStateException | IOException e) {
				e.printStackTrace();
			}
		    
		    return changeName;
		}

		
		// 첨부파일 삭제 메소드
		public boolean deleteFile(String delfile, HttpSession session) {
			
			String savePath = session.getServletContext().getRealPath("/resources/uploadFiles/notice/");
			
			File delFile = new File(savePath + delfile);
			
			try {
				if(delFile.exists() && delFile.delete()) {
					return true;
				} else {
					return false;
				}
			} catch(Exception e) {
				e.printStackTrace();
				return false;
			}
		}
	}

