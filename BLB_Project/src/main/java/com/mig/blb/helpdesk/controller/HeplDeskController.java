package com.mig.blb.helpdesk.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HeplDeskController {

	@GetMapping("Faq.blb")
	public String faqView() {
		return "helpdesk/FAQ";
	}
	
	@GetMapping("Inquiry.blb")
	public String inquiryView() {
		return "helpdesk/Inquiry";
	}
	
	@GetMapping("Notice.blb")
	public String noticeView() {
		return "helpdesk/Notice";
	}
}
