package com.mig.blb.admin;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class AdminController {

	@GetMapping("admin.blb")
	public String admin() {
		
		return "admin/admin";
	}
	
	@GetMapping("adminMember.me")
	public ModelAndView adminMemberList(ModelAndView mv) {
		
		mv.setViewName("admin/admin_member");
		return mv;
	}
	
}
