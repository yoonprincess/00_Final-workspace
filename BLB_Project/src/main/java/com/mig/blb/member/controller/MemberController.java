package com.mig.blb.member.controller;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.mig.blb.member.model.service.MemberService;
import com.mig.blb.member.model.vo.Delivery;
import com.mig.blb.member.model.vo.Member;

import lombok.extern.slf4j.Slf4j;

@Controller 
@Slf4j 
public class MemberController {
	
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private BCryptPasswordEncoder bcryptPasswordEncoder;
		
	
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
							HttpServletResponse response,
							String saveId) {
		
		if(saveId != null && saveId.equals("y")) {
			
			Cookie cookie = new Cookie("saveId", m.getMemberId());
			
			cookie.setMaxAge(24 * 60 * 60 * 1); 
			
			response.addCookie(cookie);
			
		} else { 

			Cookie cookie = new Cookie("saveId", m.getMemberId());
			
			cookie.setMaxAge(0);
			
			response.addCookie(cookie);
		}
		
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
	
	//  약관동의 페이지 요청
	@GetMapping("agreement.me")
	public ModelAndView agreement(ModelAndView mv) {
		
		mv.setViewName("member/agreementForm");
		
		return mv;
	}
	
	// 회원가입페이지 요청 
	@PostMapping("enrollForm.me")
	public ModelAndView enrollForm(ModelAndView mv) {
		
		mv.setViewName("member/enrollForm");
		
		return mv;
	}
	
	//회원 등록
	@PostMapping("insert.me")
	@Transactional
	public ModelAndView insertMember(Member m,
							ModelAndView mv,
							HttpSession session,
							Delivery d) {
				
		String encPwd = bcryptPasswordEncoder.encode(m.getMemberPwd());
		m.setMemberPwd(encPwd);
		
		//System.out.println(m);
		
		
		int result = memberService.insertMember(m);
			
		int result2 = 0; // Delivery 결과 초기화
		
		if(!d.getPostcode().isEmpty()) {
				
			d.setMemberId(m.getMemberId()); // FK 연결
			d.setDeliPhone(m.getPhone()); // FK 연결
			d.setDeliName(m.getMemberName()); // FK 연결
			
			//System.out.println(d);
			result2 = memberService.insertDelivery(d);
		}
		
		if(result > 0 && (result2 > 0 || d.getPostcode().isEmpty())) { 
			
			session.setAttribute("alerMsg", "환영합니다-*^^*");
			mv.addObject("memberId", m.getMemberId());
			mv.addObject("memberName", m.getMemberName());
			mv.addObject("email", m.getEmail());
			mv.setViewName("member/welcome");
			
		}else {
			mv.addObject("errorMsg","회원가입실패!");
			mv.setViewName("common/errorPage");
		}
		return mv;
	}
	
	// 아이디 중복체크 요청 
	@ResponseBody
	@GetMapping(value="idCheck.me" , produces="text/html; charset=UTF-8")
	public String idCheck(String checkId) {
		
		int count = memberService.idCheck(checkId);
		
		return (count>0)? "NNN" : "NNY" ;
		
	}
	
	//// 마이페이지 요청 
	@GetMapping("myPage.me")
	public ModelAndView myPage(ModelAndView mv) {
		
		mv.setViewName("member/myPage");
		
		return mv;
	}
	
	
}










