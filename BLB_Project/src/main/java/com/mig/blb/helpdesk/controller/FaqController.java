package com.mig.blb.helpdesk.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import com.mig.blb.helpdesk.model.service.NoticeService.NoticeService;

@Controller
public class FaqController {

	// NoticeService 객체 생성
	@Autowired
	private NoticeService noticeService;
	
	// FAQ 페이지 요청
	@GetMapping("Faq.blb")
	public String FAQ() {
				
		return "helpdesk/FAQ";
	}
}
