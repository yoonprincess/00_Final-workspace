package com.mig.blb.helpdesk.controller;

import org.springframework.web.bind.annotation.GetMapping;

public class InquiryController {

	@GetMapping("Inquiry.blb")
	public String Inquiry() {
		
		return "helpdesk/Inquiry";
	}
}
