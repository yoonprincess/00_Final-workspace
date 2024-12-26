package com.mig.blb.member.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.mig.blb.member.model.service.KakaoApi;
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
	
    @Autowired
    private KakaoApi kakaoApi;
    
	
	// 로그인 페이지 요청 
	@GetMapping("loginForm.me")
	public ModelAndView loginForm(ModelAndView mv,
								HttpServletRequest request,
								HttpSession session) {
		
		
		String redirectURL = request.getParameter("redirectURL");
		
		
		if( redirectURL != null) {
			
			session.setAttribute("beforePage", redirectURL);
		}
		
		 String kakaoAuthUrl = "https://kauth.kakao.com/oauth/authorize?client_id=" 
	                + kakaoApi.getKakaoApiKey()  
	                + "&redirect_uri=" + kakaoApi.getKakaoRedirectUri()  
	                + "&response_type=code";    
		
		mv.addObject("kakaoAuthUrl",kakaoAuthUrl);
		
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
			      
			    	mv.setViewName("redirect:/");
			    	
			    } else {
			       
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
		
		 Member loginUser = (Member) session.getAttribute("loginUser");
		 if (loginUser != null) { 
		        String loginType = ((Member) loginUser).getLoginType();
		        if ("kakao".equals(loginType)) {
		        // 카카오 로그아웃 처리
		        String accessToken = (String) session.getAttribute("accessToken");
		        if (accessToken != null) {
		            try {
		                kakaoApi.kakaoLogout(accessToken); 
		            } catch (Exception e) {
		                e.printStackTrace();
		              
		            }
		        }
		    }
		 }
		    // 공통 세션 만료 처리
		    session.removeAttribute("loginUser");
		    session.removeAttribute("accessToken");

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
			
		int result2 = 0; 
		
		if(!d.getPostcode().isEmpty() ) {
				
			d.setMemberId(m.getMemberId()); 
			d.setDeliPhone(m.getPhone()); 
			d.setDeliName(m.getMemberName()); 
			d.setDeliNickname(m.getMemberName());
			result2 = memberService.insertDelivery(d);
		}
		
		if(result > 0 && (result2 > 0 || d.getPostcode().isEmpty())) { 
			
			int result3 = memberService.insertWelcomePoint(m.getMemberId());
			
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
			// 로그인한 사용자가 카카오 계정인지 확인
	        if ("kakao".equals(loginUser.getLoginType())) {
	            // 카카오 계정일 경우 모달 창을 띄울 수 있는 페이지로 이동
	            mv.setViewName("member/deleteKakaoForm");
	        } else {
	            // 일반 계정일 경우 비밀번호 확인 페이지로 이동
	            mv.setViewName("member/deleteForm");
	        }
		
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
			//System.out.println(checkMember);
			int result = memberService.updateMemberPwd(checkMember.getMemberId(), encPwd);
			
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
	
	// 회원정보 수정 요청
	@PostMapping(value = "update.me")
	public ModelAndView updateMember(ModelAndView mv,
	                                 Member m,
	                                 Delivery d,
	                                 HttpSession session,
	                                 String currentPwd,
	                                 String newPwd,
	                                 String ckPwd) {

	    Member loginUser = (Member) session.getAttribute("loginUser");
	    int result = 0; // 기본값 설정
	    int result2 = 0; // 기본값 설정

	    // 1. 비밀번호 변경이 있을 경우
	    if (currentPwd != null && !currentPwd.isEmpty() 
	        && newPwd != null && !newPwd.isEmpty() 
	        && ckPwd != null && !ckPwd.isEmpty()) {
	        
	        if (bcryptPasswordEncoder.matches(currentPwd, loginUser.getMemberPwd())) {
	            // 현재 비밀번호 일치
	            String encPwd = bcryptPasswordEncoder.encode(newPwd);
	            m.setMemberPwd(encPwd);

	            result = memberService.updateMember(m);

	            // 주소 변경 처리
	            if (!d.getPostcode().isEmpty()) {
	                result2 = updateDelivery(d, m);
	            } else {
	                result2 = 1; // 주소 변경이 없더라도 성공 처리
	            }

	            if (result > 0 && result2 > 0) {
	                // 세션 갱신 및 알림 처리
	                loginUser.setMemberPwd(encPwd);
	                session.setAttribute("loginUser", memberService.loginMember(m));
	                session.setAttribute("alertMsg", "회원정보가 수정되었습니다.");
	                Delivery delivery = memberService.selectDefaultDelivery(loginUser.getMemberId());
	                mv.addObject("d", delivery);
	                mv.setViewName("member/updateMemberForm");
	            } else {
	                session.setAttribute("alertMsg", "회원정보 수정 실패..");
	                mv.setViewName("member/updateMemberForm");
	            }
	        } else {
	            // 현재 비밀번호 불일치
	            session.setAttribute("alertMsg", "현재 비밀번호가 잘못되었습니다.");
	            mv.setViewName("member/updateMemberForm");
	        }
	    } else {
	        // 2. 비밀번호 변경이 없는 경우
	        result = memberService.updateMember(m);

	        if (!d.getPostcode().isEmpty()) {
	            result2 = updateDelivery(d, m);
	        } else {
	            result2 = 1; // 주소 변경이 없더라도 성공 처리
	        }

	        if (result > 0 && result2 > 0) {
	            session.setAttribute("loginUser", memberService.loginMember(m));
	            session.setAttribute("alertMsg", "회원정보가 수정되었습니다.");
	            Delivery delivery = memberService.selectDefaultDelivery(loginUser.getMemberId());
	            mv.addObject("d", delivery);
	            mv.setViewName("member/updateMemberForm");
	        } else {
	            session.setAttribute("alertMsg", "회원정보 수정 실패..");
	            mv.setViewName("member/updateMemberForm");
	        }
	    }
	    return mv;
	}

	// 기본주소 변경 메소드
	public int updateDelivery(Delivery d, Member m) {
	    int result = 0;

	    if (!d.getPostcode().isEmpty()) {
	        d.setDeliPhone(m.getPhone());
	        d.setDeliName(m.getMemberName());
	        d.setMemberId(m.getMemberId());
	        d.setDeliNickname(d.getDeliName());
	        d.setDeliDefault("Y");

	        result = memberService.updateDelivery(d);
	    }

	    return result;
	}


	// 관리자페이지 회원정보변경
	@PostMapping("updateAdmin.me")
	@ResponseBody
	public Map<String, Object> updateMemberAdmin(ModelAndView mv,
			 						@RequestBody Member m,                                 
	                                 HttpSession session) {
		
		Member member = new Member();
		member.setMemberId(m.getMemberId());
		member.setGradeName(m.getGradeName());
		member.setStatus(m.getStatus());
		member.setTotalPoints(m.getTotalPoints());
		
		
	    Member loginUser = (Member) session.getAttribute("loginUser");
	    Map<String, Object> response = new HashMap<>(); 
	    int result = memberService.updateAdminMember(member);
	    
	        if (result > 0 ) {
	         
	        	 response.put("success", true);
	        	 response.put("message", "회원정보가 수정되었습니다.");
	      
	     
	        } else {
	        	response.put("success", false);
	        	 response.put("message", "회원정보가 수정실패.");
	        }
	    
	        return response;
	    }
	
	// 관리자페이지 배송지정보변경
		@PostMapping("updateDeliveryAdmin.me")
		@ResponseBody
		public Map<String, Object> updateDeliveryAdmin(ModelAndView mv,
				 						@RequestBody Delivery d,                                 
		                                 HttpSession session) {
			
			Delivery deli = new Delivery();
			deli.setDeliCode(d.getDeliCode());
			deli.setDeliNickname(d.getDeliNickname());
			deli.setDeliDefault(d.getDeliDefault());
			
		    Member loginUser = (Member) session.getAttribute("loginUser");
		    Map<String, Object> response = new HashMap<>(); 
		    int result = memberService.updateDeliveryAdmin(deli);
		    
		        if (result > 0 ) {
		         
		        	 response.put("success", true);
		        	 response.put("message", "회원배송정보가 수정되었습니다.");
		      
		     
		        } else {
		        	response.put("success", false);
		        	 response.put("message", "회원배송정보가 수정실패.");
		        }
		    
		        return response;
		    }
		
		// 배송지 삭제 관리자 요청
		@ResponseBody
		@PostMapping("deleteDeliveryAdmin.me")
		public  Map<String, Object> deleteDeliveryAdmin (ModelAndView mv
										, HttpSession session
										,@RequestBody Delivery d ){
			
			System.out.println(d.getDeliCode());
			Map<String, Object> response = new HashMap<>(); 
			int result = memberService.deleteDelivery(d.getDeliCode());
			
			 if (result > 0 ) {
		         
	        	 response.put("success", true);
	        	 response.put("message", "회원배송정보가 수정되었습니다.");
	      
	     
	        } else {
	        	response.put("success", false);
	        	response.put("message", "회원배송정보가 수정실패.");
	        }
	    
	        return response;
	    }
}








