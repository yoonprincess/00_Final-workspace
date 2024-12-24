package com.mig.blb.admin;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class AdminController {

	@GetMapping("admin.blb")
	public String admin() {
		
		return "admin/admin";
	}
	
}
