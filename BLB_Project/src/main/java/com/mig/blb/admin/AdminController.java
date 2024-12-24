package com.mig.blb.admin;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

import com.mig.blb.member.model.service.MemberService;
import com.mig.blb.member.model.vo.Member;




@Controller
public class AdminController {
	
	@Autowired
	private MemberService memberService;
	
	@GetMapping("admin.blb")
	public String admin() {
		
		return "admin/admin";
	}
	
	@GetMapping("adminMember.me")
	public ModelAndView adminMemberList(ModelAndView mv) {
		
		ArrayList<Member> mList = memberService. selectMemberList();
		mv.addObject("mList",mList);
		mv.setViewName("admin/admin_member");
		return mv;
	}
	
}
