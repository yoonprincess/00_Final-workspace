package com.mig.blb.member.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.ModelAndView;

import com.mig.blb.member.model.service.MemberService;
import com.mig.blb.member.model.vo.Delivery;
import com.mig.blb.member.model.vo.Member;

@Controller
public class MyPageController {
	
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private BCryptPasswordEncoder bcryptPasswordEncoder;
	
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
								&& ckPwd != null &&  !ckPwd.isEmpty()) {
				// 비번 변경이 있을 경우 
				System.out.println(m);
				if(bcryptPasswordEncoder.matches(currentPwd, loginUser.getMemberPwd())){
					// 현재비번 매치되면 
					System.out.println("현재비번 잘 작성함!");
					
					String encPwd = bcryptPasswordEncoder.encode(newPwd);
					m.setMemberPwd(encPwd);
					
					
					int result = memberService.updateMember(m);
					int result2 = updateDelivery(d,m);
					if(result > 0 && result2>0) { 
					
						session.setAttribute("alertMsg", "회원정보가 수정되었습니다.");
						
						loginUser.setMemberPwd(encPwd); // 불러온 로그인 정보 비번에도 넣어주고 
						session.setAttribute("loginUser", loginUser); // 갱신된 로그인정보 다시 세션에넣고
						
						Member newMember = memberService.loginMember(m);
						Delivery delivery = memberService.selectDefaultDelivery(loginUser.getMemberId());
						mv.addObject("d", delivery);
						session.setAttribute("loginUser", newMember);
						
						mv.setViewName("member/updateMemberForm"); 
						
						System.out.println("회원정보수정 비번변경포함 완");
					
					}else {
						
						System.out.println("비번변경있는 회원정보수정실패?");
						session.setAttribute("alertMsg", "회원정보 수정 실패..");
						mv.setViewName("member/updateMemberForm");
						
					}
				
				} else{
					// 현재 비번 잘못됨
					
					session.setAttribute("alertMsg", "현재 비밀번호가 잘못되었습니다.");
					mv.setViewName("member/updateMemberForm");
					System.out.println("현재비번잘못?");
				}	
				
			} else {
				// 비번변경없을 경우
				System.out.println("비번뺀 나머지 변경된 정보들 잘 넘어옴? : " + m);
				System.out.println("비번뺀 나머지 변경된 정보들 잘 넘어옴? : " + d);
				
				int result = memberService.updateMember(m);
				
				int result2 = updateDelivery(d,m);
				
				if(result > 0 && result2>0) { 
				
					
					Member newMember = memberService.loginMember(m);
					session.setAttribute("loginUser", newMember);// 정보갱신 	
					
					Delivery delivery = memberService.selectDefaultDelivery(loginUser.getMemberId());
					mv.addObject("d", delivery);
					
					session.setAttribute("alertMsg", "회원정보가 수정되었습니다.");
					mv.setViewName("member/updateMemberForm");
					
					System.out.println("회원정보수정은돼");
				
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
			
			int result = 0;

			 // 로그 추가: Delivery 객체의 값 확인
			if(!d.getPostcode().isEmpty()) {
				
				d.setMemberId(m.getMemberId());
				
				result = memberService.updateDelivery(d);
				System.out.println("DB update result: " + result);
			}
			
			return result;
		}
		
	
				
}
