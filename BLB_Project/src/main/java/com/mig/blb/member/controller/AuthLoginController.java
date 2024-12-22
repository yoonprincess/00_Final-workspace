package com.mig.blb.member.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.mig.blb.member.model.service.KakaoApi;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Controller
public class AuthLoginController {
	
	@Autowired
	private KakaoApi kakaoApi;
	
	@Value("${kakao.api_key}")
	private String kakaoApiKey;

	@Value("${kakao.redirect_uri}")
	private String kakaoRedirectUri;
	
	//  로그인 후 로직
	@RequestMapping("loginKakao.me")
	public String kakaoLogin(@RequestParam(value = "code", required = false) String code) {
		
		String accessToken = kakaoApi.getAccessToken(code);
		System.out.println("code값 잘 넘어왔나? " + code);
		System.out.println("토큰은?"+ accessToken);
		
		Map<String, Object> userInfo = kakaoApi.getUserInfo(accessToken);
		
		String email = (String)userInfo.get("email");
		String name =(String)userInfo.get("name");
		String phoneNumber =(String)userInfo.get("phoneNumber");
		String birthyear =(String)userInfo.get("birthyear");
		String birthday =(String)userInfo.get("birthday");
		
		System.out.println("email:"+ email);
		System.out.println("name:"+ name);
		System.out.println("phoneNumber :"+ phoneNumber);
		System.out.println("birthyear:"+ birthyear);
		System.out.println("birthday :"+ birthday );
		System.out.println("access:"+ accessToken);
		
	
		return "redirect:/";
	
	}
	
}
