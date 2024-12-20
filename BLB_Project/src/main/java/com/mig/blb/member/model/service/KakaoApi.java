package com.mig.blb.member.model.service;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

@Service
public class KakaoApi{
		
		 private String kakaoApiKey = "d58c294c5294590311266a239d715ed4";
		 private String kakaoRedirectUri = "http://localhost/blb/loginKakao.me"; 
		 
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
		
		   System.out.println(code);
		   
		   RestTemplate restTemplate = new RestTemplate();
		   // 헤더 설정
	        HttpHeaders headers = new HttpHeaders();
	        headers.setContentType(MediaType.APPLICATION_FORM_URLENCODED);

	        HttpEntity<String> entity = new HttpEntity<>(null, headers);

	        // POST 요청 보내기
	        ResponseEntity<HashMap> responseEntity = restTemplate.exchange(
	            url, 
	            HttpMethod.POST, 
	            entity, 
	            HashMap.class
	        );

	        // 응답에서 access token 추출
	        HashMap<String, Object> response = responseEntity.getBody();
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
