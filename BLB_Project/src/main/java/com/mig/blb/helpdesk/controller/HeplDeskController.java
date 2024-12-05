package com.mig.blb.helpdesk.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HeplDeskController {

	@GetMapping("Faq.blb")
	public String helpsdeskMain() {
		return "helpdesk/FAQ";
	}
}
