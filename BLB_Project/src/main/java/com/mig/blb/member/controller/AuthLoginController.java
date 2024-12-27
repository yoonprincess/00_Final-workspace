package com.mig.blb.member.controller;


import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.mig.blb.member.model.service.KakaoApi;
import com.mig.blb.member.model.service.MemberService;
import com.mig.blb.member.model.vo.Member;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Controller
public class AuthLoginController {
	
	@Autowired
	private KakaoApi kakaoApi;
	
	@Autowired
	private MemberService memberService;
	
	@Value("${kakao.api_key}")
	private String kakaoApiKey;

	@Value("${kakao.redirect_uri}")
	private String kakaoRedirectUri;
	
	//  로그인 후 로직
	@RequestMapping("loginKakao.me")
	public ModelAndView kakaoLogin(@RequestParam(value = "code", required = false) String code,
							HttpSession session,
							ModelAndView mv,
							HttpServletRequest request) {
		
		String accessToken = kakaoApi.getAccessToken(code);
		
		Map<String, Object> userInfo = kakaoApi.getUserInfo(accessToken);
		
		String email = (String)userInfo.get("email");
		String snsId = (String)userInfo.get("id");
		String name =(String)userInfo.get("name");
		
		int result1 = memberService.findSnsId(snsId);
		
		if(result1 > 0 ) { // 카카오 가입이력있을 경우 
			
			Member loginUser = memberService.loginMember(snsId);
			
			if(loginUser != null) {
				session.setAttribute("loginUser", loginUser);
				session.setAttribute("accessToken", accessToken);
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
			}else {
				mv.setViewName("member/loginErrorForm");
			}
		
		}else { // 카카오 가입 이력 없을 경우 
			
			Member m = new Member();
			m.setMemberId("kakao_"+snsId);
			m.setMemberName(name);
			m.setEmail(email);
			m.setSnsId(snsId);
			m.setLoginType("kakao");
			
			int result2 = memberService.insertKakao(m);
			
			if(result2>0) {
				int result3 = memberService.insertWelcomePoint(m.getMemberId());
				
				mv.addObject("memberId", m.getMemberId());
				mv.addObject("memberName", m.getMemberName());
				mv.addObject("email", m.getEmail());
				mv.setViewName("member/welcome");
			
			}else {
				session.setAttribute("alertMsg", "회원가입 실패..");
				mv.setViewName("common/errorPage");
			}
		}
		
		return mv;
	
	}
	
	@PostMapping("deleteKakao.me")
	@ResponseBody
	public Map<String, String> deleteAccount(HttpSession session) {
		
		Map<String, String> response = new HashMap<>(); 
		
		 try {
			// 세션에서 액세스 토큰 가져오기
		    String accessToken = (String) session.getAttribute("accessToken");
		   
		    if (accessToken == null || accessToken.isEmpty()) {
	            response.put("result", "카카오 계정 인증이 필요합니다.");
	        }
	
		    // 서비스에서 탈퇴 API 호출
		    kakaoApi.kakaoUnlink(accessToken);
		    
		    
		    // 서비스 DB에서 사용자 정보 삭제 (예: ID, 이메일 등)
		    Member loginUser =(Member)session.getAttribute("loginUser");
		    int result = memberService.deleteMember(loginUser.getMemberId());
	
		   
	
		    if (result>0) {
				  response.put("result", "탈퇴완료");
				  // 세션 초기화
				  session.invalidate();
				 
			}else {
				
				response.put("result", "탈퇴실패");
			}
		
		 } catch (Exception e) {
		        e.printStackTrace();
		        response.put("result", "탈퇴 중 에러 발생");
		 }
		 
	    return response;
	}
	
}
