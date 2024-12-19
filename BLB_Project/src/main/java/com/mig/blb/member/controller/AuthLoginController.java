package com.mig.blb.member.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.mig.blb.member.model.service.KakaoApi;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Controller
public class AuthLoginController {
	
	@Autowired
	private KakaoApi kakaoApi;
	
	// 로그인 페이지로 이동
  @GetMapping("/login")
  
    public String loginForm(Model model) {
        model.addAttribute("kakaoApiKey", kakaoApi.getKakaoApiKey());
        model.addAttribute("redirectUri", kakaoApi.getKakaoRedirectUri());
        return "member/loginForm"; 
    }

	//  로그인 후 로직
	@RequestMapping("/login/oauth2/kakao")
	public String kakaoLogin(@RequestParam String code) {
		
		String accessToken = kakaoApi.getAccessToken(code);
		
		Map<String,Object> memberInfo = kakaoApi.getUserInfo(accessToken);
		
		String email = (String)memberInfo.get("email");
		
		System.out.println("email:"+ email);
		System.out.println("access:"+ accessToken);
		
	
		return "redirect:/main";
	
	}
	
}