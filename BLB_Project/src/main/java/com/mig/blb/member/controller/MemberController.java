package com.mig.blb.member.controller;

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
	public ModelAndView loginForm(ModelAndView mv,
								HttpServletRequest request,
								HttpSession session) {
		
		// 이전페이지 url 가져오기
		String referer = request.getHeader("Referer");
		
		
		if( referer != null) {
			
			session.setAttribute("beforePage", referer);
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
			
			String referer = (String) session.getAttribute("beforePage");
			
			if(referer != null) {
				mv.setViewName("redirect:"+ referer);
			}else {
				mv.setViewName("redirect:/" );
			}
			
			
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
		
		if(!d.getPostcode().isEmpty()) {
				
			d.setMemberId(m.getMemberId()); // FK 연결
			d.setDeliPhone(m.getPhone()); // FK 연결
			d.setDeliName(m.getMemberName()); // FK 연결
			
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
	
	// 마이페이지 요청 
	@GetMapping("myPage.me")
	public ModelAndView myPage(ModelAndView mv, HttpSession session) {
		
		Member loginUser =(Member)session.getAttribute("loginUser");
		
		if( loginUser != null) {
			mv.setViewName("member/myPage");
		
		}else {
			session.setAttribute("alertMsg", "로그인한 회원만 접근 가능합니다");
			mv.setViewName("/main");
		}
		return mv;
	}
	
	// 회원정보 수정 페이지 요청 
	@GetMapping("updateForm.me")
	public ModelAndView updateMemberForm(ModelAndView mv, HttpSession session) {
		
		Member loginUser =(Member)session.getAttribute("loginUser");
		
		if( loginUser != null) {
			
			Delivery d = memberService.selectDefaultDelivery(loginUser.getMemberId());
			session.setAttribute("d", d);
			
			mv.setViewName("member/updateMemberForm");
			
		}else {
			
			session.setAttribute("alertMsg", "로그인한 회원만 접근 가능합니다");
			mv.setViewName("/main");
		}
				
		return mv;
	}
	
	// 회원정보 수정 요청( 주소정보 X) 
	@PostMapping(value="update.me")	
	public ModelAndView updateMember(ModelAndView mv,
										Member m,
										Delivery d,
										HttpSession session,
										String currentPwd,
										String newPwd,
										String ckPwd) {
			
		Member loginUser =(Member)session.getAttribute("loginUser");
		
		if(currentPwd != null && !currentPwd.isEmpty() 
							&& newPwd != null && !newPwd.isEmpty() 
							&& ckPwd != null && !ckPwd.isEmpty()) {
			
			// 비번 변경이 있을 경우 
			if(bcryptPasswordEncoder.matches(currentPwd, loginUser.getMemberPwd())){
				// 현재비번 매치되면 
				
				String encPwd = bcryptPasswordEncoder.encode(newPwd);
				m.setMemberPwd(encPwd);
						
				int result = memberService.updateMember(m);
				int result2 = updateDelivery(d,m);
				if(result > 0 && result2 > 0) { 
				
					session.setAttribute("alertMsg", "회원정보가 수정되었습니다.");
					
					loginUser.setMemberPwd(encPwd);
					session.setAttribute("loginUser", loginUser);
					mv.setViewName("member/updateMemberForm");
					
					System.out.println("회원정보수정는 돼?");
				
				}else {
				
					session.setAttribute("alertMsg", "회원정보 수정 실패..");
					mv.setViewName("member/updateMemberForm");
					System.out.println("비번변경있는 회원정보수정실패?");
				}
			
			} else{
				// 현재 비번 잘못됨
				session.setAttribute("alertMsg", "현재 비밀번호가 잘못되었습니다.");
				mv.setViewName("member/updateMemberForm");
				System.out.println("현재비번잘못?");
			}	
			
		} else {
			// 비번변경없을 경우
			
			int result = memberService.updateMember(m);
			int result2 = updateDelivery(d,m);
			if(result > 0 && result2 > 0) { 
			
				session.setAttribute("alertMsg", "회원정보가 수정되었습니다.");
				session.setAttribute("loginUser", loginUser);	
				mv.setViewName("member/updateMemberForm");
				
				System.out.println("회원정보수정은돼?");
			
			}else {
			
				session.setAttribute("alertMsg", "회원정보 수정 실패..");
				mv.setViewName("member/updateMemberForm");
				System.out.println(" 비번변경없이 회원정보수정실패?");
			}
		}
		
		return mv;
	}
		
	// 기본주소 변경 메소드 
	public int updateDelivery(Delivery d, Member m) {
		
		int result = 1;

		if(!d.getPostcode().isEmpty()) {
			d.setMemberId(m.getMemberId());
			result = memberService.updateDelivery(d);
		}
		
		return result;
	}
	
	
	// 회원탍퇴페이지 요청 
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
		
	
		
}










