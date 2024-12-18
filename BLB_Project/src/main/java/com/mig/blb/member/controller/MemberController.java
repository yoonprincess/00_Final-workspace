package com.mig.blb.member.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
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
	@RequestMapping("loginForm.me")
	public ModelAndView loginForm(ModelAndView mv,
								HttpServletRequest request,
								HttpSession session) {
		
		// 이전페이지 url 가져오기
		String redirectURL = request.getParameter("redirectURL");
		
		
		if( redirectURL != null) {
			
			session.setAttribute("beforePage", redirectURL);
		}
			
			mv.setViewName("member/loginForm");
		
		return mv;
	}
	
	//로그인
	@PostMapping("login.me")
	public ModelAndView loginMember(Member m,
							ModelAndView mv,
							HttpSession session,
							HttpServletResponse response,
							String saveId,
							HttpServletRequest request) {
		
		
		String method = request.getMethod();
	    if (!"POST".equalsIgnoreCase(method)) {
	        session.setAttribute("alertMsg", "잘못된 접근입니다. 메인페이지로이동합니다");
	        mv.setViewName("redirect:/main");
	        return mv;
	    }
	    
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
			
			String redirectURL = (String) session.getAttribute("beforePage");
			
			if(redirectURL != null) {

			    if ("POST".equalsIgnoreCase(request.getMethod())) {
			        // POST 메서드인 경우 메인 페이지로 이동
			    	mv.setViewName("redirect:/");
			    	
			    } else {
			        // GET 메서드인 경우 redirectURL로 이동
			        mv.setViewName("redirect:" + redirectURL);
			    }
			}else {
				mv.setViewName("redirect:/" );
			}
			
		}else { // 로그인 실패 
			
			mv.setViewName("member/loginErrorForm");
		}
		
		return mv;
	}
	
	//로그아웃 
	@GetMapping("logout.me")
	public String logoutMember(HttpSession session) {
		
		session.removeAttribute("loginUser");
		
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
							Delivery d,
							String email) {
				
		String encPwd = bcryptPasswordEncoder.encode(m.getMemberPwd());
		m.setMemberPwd(encPwd);
		
		int result = memberService.insertMember(m);
			
		int result2 = 0; // Delivery 결과 초기화
		
		if(!d.getPostcode().isEmpty() ) {
				
			d.setMemberId(m.getMemberId()); // FK 연결
			d.setDeliPhone(m.getPhone()); // FK 연결
			d.setDeliName(m.getMemberName()); // FK 연결
			d.setDeliNickname(m.getMemberName());
			result2 = memberService.insertDelivery(d);
		}
		
		if(result > 0 && (result2 > 0 || d.getPostcode().isEmpty())) { 
			
			session.setAttribute("alertMsg", "환영합니다-*^^*");
			mv.addObject("memberId", m.getMemberId());
			mv.addObject("memberName", m.getMemberName());
			mv.addObject("email", m.getEmail());
			mv.setViewName("member/welcome");
			
		}else {
			session.setAttribute("alertMsg", "회원가입 실패..");
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
	
	// 회원탈퇴페이지 요청 
	@GetMapping("deleteForm.me")
	public ModelAndView deleteForm(ModelAndView mv, HttpSession session) {
		
		Member loginUser =(Member)session.getAttribute("loginUser");
		
		if( loginUser != null) {
			mv.setViewName("member/deleteForm");
		
		}else {
			session.setAttribute("alertMsg", "로그인한 회원만 접근 가능합니다");
			mv.setViewName("/main");
		}
		return mv;
	}
	
	// 회원탈퇴
	@PostMapping("delete.me")
	@ResponseBody
	public  Map<String, String> checkPwd(HttpSession session,String checkPwd) {
		
		Member loginUser =(Member)session.getAttribute("loginUser");
		
		Map<String, String> response = new HashMap<>(); 
		   
		if(bcryptPasswordEncoder.matches(checkPwd, loginUser.getMemberPwd())){
			
			int result = memberService.deleteMember(loginUser.getMemberId());
			
			if (result>0) {
				  response.put("result", "탈퇴완료");
				 
				  session.invalidate();
			}else {
				response.put("result", "탈퇴실패");
			}
		
		}else {
			 response.put("result", "비밀번호가 다릅니다. 다시 확인 바랍니다.");
		}
		 return response;
	}
	
	// 아이디찾기페이지 요청 
		@GetMapping("findIdForm.me")
		public ModelAndView findIdForm(ModelAndView mv) {
			
			mv.setViewName("member/findIdForm");
			
			return mv;
		}
		
		// 아이디찾기 요청 (이메일버전)
		@PostMapping("findId.me")
		public ModelAndView findId(ModelAndView mv,	
									String memberName,
									String email,
									HttpSession session) {
			Member m  = new Member (); 
			m.setMemberName(memberName);
			m.setEmail(email);
			
			if((!memberName.isEmpty() && memberName != null)
				&&( !email.isEmpty() && email != null )) {
				
		       String result = memberService.findMemberId(m);
		       if( result != null && !result.isEmpty() ) {
		    	   
					mv.addObject("findIdMember",m);
					mv.addObject("findId", result);
					mv.setViewName("member/findIdForm2");
				
		       } else {
		    	   session.setAttribute("alertMsg", "입력하신 정보로 가입된 회원은 존재하지 않습니다.");
		    	   mv.setViewName("member/findIdForm");
		       }
			}
			return mv;
		}
		

	// 비번찾기페이지 요청 
		@GetMapping("findPwdForm.me")
		public ModelAndView findPwdForm(ModelAndView mv) {
			
			mv.setViewName("member/findPwdForm");
			
			return mv;
		}

	// 비번찾기 확인용 
	@PostMapping("findPwd.me")
	public ModelAndView findPwd(ModelAndView mv,
								HttpSession session,
								String memberId,
								String memberName,
								String email) {
		Member m = new Member();
		m.setMemberName(memberName);
		m.setMemberId(memberId);
		m.setEmail(email);
	
		if((!memberId.isEmpty() && memberId != null) 
				&&(!memberName.isEmpty() && memberName != null)
				&&( !email.isEmpty() && email != null )) {
			
			 
	       int result = memberService.validateMemberData(m);
	       
	       if( result > 0 ) {
				mv.addObject("ckPwdMember",m);
				mv.setViewName("member/findPwdForm2");
			
	       } else {
				
				session.setAttribute("alertMsg", "입력하신 정보로 가입된 회원은 존재하지 않습니다.");
				mv.setViewName("member/findPwdForm");
			}
		
		}
		return mv;
	}
	

	// 새로운 비번 설정 
	@PostMapping("newPwd.me")
	public ModelAndView validatePwd(ModelAndView mv,
						String newPwd,
						String ckMemberId,
						HttpSession session) {
		
		
		// 기존 회원 정보 불러오기 
		//System.out.println(ckMemberId);
		Member checkMember = memberService.checkMember(ckMemberId);
		//System.out.println(checkMember);
		if(checkMember != null) {
			
			String encPwd = bcryptPasswordEncoder.encode(newPwd);
			checkMember.setMemberPwd(encPwd);
			System.out.println(checkMember);
			int result = memberService.updateMember(checkMember);
			
			if(result>0) {
				
				session.setAttribute("alertMsg", "비밀번호 변경되었습니다.");
				mv.setViewName("/main");
				
			
			}else {
				session.setAttribute("alertMsg", "비밀번호 변경실패..");
				System.out.println(newPwd);
				mv.setViewName("/member/findPwdForm2");
			}
		}else {
			session.setAttribute("alertMsg", "기존회원못찾음");
			  mv.setViewName("/member/findPwdForm2");
		}
		
		
		return mv;
	}
	
}








