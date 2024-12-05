package com.mig.blb.member.controller;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.mig.blb.member.model.service.MemberService;
import com.mig.blb.member.model.vo.Member;

import lombok.extern.slf4j.Slf4j;

@Controller 
@Slf4j 
public class MemberController {
	
	
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private BCryptPasswordEncoder bcryptPasswordEncoder;
		
	// 마이페이지 접속 요청 
	@GetMapping("myPage.me")
	public String myPage() {
				
			return "member/myPage";
	
	}
	
	// 로그인 페이지 요청 
	@GetMapping("loginForm.me")
	public ModelAndView loginForm(ModelAndView mv) {
		mv.setViewName("member/loginForm");
		
		return mv;
	}
	
	//로그인
	@PostMapping("login.me")
	public ModelAndView loginMember(Member m,
							ModelAndView mv,
							HttpSession session,
							HttpServletResponse response) {
		
		Member loginUser = memberService.loginMember(m);
		
		if(loginUser != null &&
				(bcryptPasswordEncoder.matches(m.getMemberPwd(), loginUser.getMemberPwd()))) {
		
			// 로그인 성공 ! 
			session.setAttribute("loginUser", loginUser);
			session.setAttribute("alertMsg", "로그인성공!");
			
			mv.setViewName("redirect:/");
			
		}else { // 로그인 실패 
			mv.addObject("errorMsg","로그인실패!");
			mv.setViewName("common/errorPage");
		}
		
		return mv;
	}
	
	//로그아웃 
	@GetMapping("logout.me")
	public String logoutMember(HttpSession session) {
		
		session.removeAttribute("loginUser");
		session.setAttribute("alertMsg", "로그아웃 성공");
		
		return "redirect:/";
	}
	
	// 회원가입페이지 요청 
	@GetMapping("enrollForm.me")
	public ModelAndView enrollForm(ModelAndView mv) {
		
		mv.setViewName("member/enrollForm");
		
		return mv;
	}
	
	//회원 등록
	@PostMapping("insert.me")
	public ModelAndView insertMember(Member m,
							ModelAndView mv,
							HttpSession session) {
				
		String encPwd = bcryptPasswordEncoder.encode(m.getMemberPwd());
		m.setMemberPwd(encPwd);
		
		
		System.out.println(m);
		
		int result = memberService.insertMember(m);
		
		if(result > 0 ) {
			
			session.setAttribute("alerMsg", "환영합니다-*^^*");
			mv.setViewName("redirect:/");
			
		}else {
			mv.addObject("errorMsg","회원가입실패!");
			mv.setViewName("common/errorPage");
		}
		return mv;
	}
	
	
}










