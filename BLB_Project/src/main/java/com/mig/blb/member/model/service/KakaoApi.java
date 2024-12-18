package com.mig.blb.member.model.service;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

@Service
public class KakaoApi{
		
		 private String kakaoApiKey = "d58c294c5294590311266a239d715ed4";
		 private String kakaoRedirectUri = "http://localhost/blb/login/oauth2/kakao"; 
		 
		private static final String KAKAO_AUTH_URL = "https://kauth.kakao.com/oauth/authorize";
		private static final String KAKAO_TOKEN_URL = "https://kauth.kakao.com/oauth/token";
		private static final String KAKAO_USER_INFO_URL = "https://kapi.kakao.com/v2/user/me";
	    
	    
		public String getKakaoApiKey() {
	        return kakaoApiKey;
	    }

	    public String getKakaoRedirectUri() {
	        return kakaoRedirectUri;
	    }
		
		
		//인가 코드를 받아서 accessToken을 반환
		public String getAccessToken(String code){
			
		   String url = KAKAO_TOKEN_URL +
                     "?grant_type=authorization_code" +
                     "&client_id=" + kakaoApiKey +
                     "&redirect_uri=" + kakaoRedirectUri +
                     "&code=" + code;

        RestTemplate restTemplate = new RestTemplate();
        HashMap<String, Object> response = restTemplate.postForObject(url, null, HashMap.class);
        return (String) response.get("access_token");
			
		}
	    //accessToken을 받아서 UserInfo 반환
		public HashMap<String, Object> getUserInfo(String accessToken) {
			 String url = KAKAO_USER_INFO_URL;
		        RestTemplate restTemplate = new RestTemplate();
		        return restTemplate.getForObject(url + "?access_token=" + accessToken, HashMap.class);
		
		}
		
	    //accessToken을 받아서 로그아웃 시키는 메서드
		public void kakaoLogout(String accessToken) {
			  String url = "https://kapi.kakao.com/v1/user/logout";
		      RestTemplate restTemplate = new RestTemplate();
		      restTemplate.postForObject(url, null, HashMap.class);
			
		}
	}
