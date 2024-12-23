package com.mig.blb.member.controller;


import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
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
		//System.out.println("code값 잘 넘어왔나? " + code);
		//System.out.println("토큰은?"+ accessToken);
		
		Map<String, Object> userInfo = kakaoApi.getUserInfo(accessToken);
		
		String email = (String)userInfo.get("email");
		String snsId = (String)userInfo.get("id");
		String name =(String)userInfo.get("name");
		String phoneNumber =(String)userInfo.get("phoneNumber");
		String phone = phoneNumber.replace("+82 ", "0")  
		        				  .replace("-", "")     
		        				  .replace(" ", "");  
		
		//System.out.println(phone);
		//System.out.println(email);
		//System.out.println(snsId);
		
		String birthyear =(String)userInfo.get("birthyear");
		String birthday =(String)userInfo.get("birthday");
		
		String birthDate = null;
		if (birthyear != null && !birthyear.isEmpty() 
			&& birthday != null && !birthday.isEmpty()) {
			String year = birthyear.substring(2); 
			String month = birthday.substring(0, 2); 
			String day = birthday.substring(2);  
			birthDate = year + "/" + month + "/" + day;
		}
		
		//System.out.println(birthDate);
		
		int result1 = memberService.findSnsId(snsId);
		
		if(result1 > 0 ) { // 카카오 가입이력있을 경우 
			
			Member loginUser = memberService.loginMember(snsId);
			
			if(loginUser != null) {
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
			}else {
				mv.setViewName("member/loginErrorForm");
			}
		
		}else { // 카카오 가입 이력 없을 경우 
				
			Member m = new Member();
			m.setMemberId("kakao_"+snsId);
			m.setMemberName(name);
			m.setEmail(email);
			m.setSnsId(snsId);
			m.setPhone(phone); //+82 10-4773-5572
			m.setLoginType("kakao");
			
			if(birthDate !=null) {
				
				m.setBirthdate(birthDate);
			}
			
			int result2 = memberService.insertKakao(m);
			
			if(result2>0) {
				
				session.setAttribute("alertMsg", "환영합니다-*^^*");
				
				mv.addObject("memberId", m.getMemberId());
				mv.addObject("memberName", m.getMemberName());
				mv.addObject("email", m.getEmail());
				mv.setViewName("member/welcome");
			
			}else {
				session.setAttribute("alertMsg", "회원가입 실패..");
				mv.setViewName("common/errorPage");
			}
		}
		
		//System.out.println("access:"+ accessToken);
	
		return mv;
	
	}
	
}
