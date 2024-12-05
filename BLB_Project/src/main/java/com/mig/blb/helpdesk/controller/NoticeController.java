package com.mig.blb.helpdesk.controller;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.mig.blb.common.model.vo.PageInfo;
import com.mig.blb.common.template.Pagination;
import com.mig.blb.helpdesk.model.service.NoticeService.NoticeService;
import com.mig.blb.helpdesk.model.vo.Notice;

	@Controller
	public class NoticeController {
	
		@Autowired
		private NoticeService noticeService;
		
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
	

}
