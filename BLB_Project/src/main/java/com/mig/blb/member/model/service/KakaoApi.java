package com.mig.blb.member.model.service;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.HashMap;

import org.slf4j.Logger;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.HttpClientErrorException;
import org.springframework.web.client.RestTemplate;

import com.google.gson.Gson;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.mig.blb.member.model.vo.OAuthToken;

@Service
public class KakaoApi{
		
	@Value("${kakao.api_key}")
	private String kakaoApiKey;

	@Value("${kakao.redirect_uri}")
	private String kakaoRedirectUri;
	
		private static final String KAKAO_API_KEY  = "c52e3719bd1faa0fc5a344a16e296f16";
		private static final String KAKAO_REDIRECT_URL = "http://eden0316.iptime.org/blb/loginKakao.me"; 
		 
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
	    public String getAccessToken(String code) {
	        String accessToken = "";
	        String refreshToken = "";
	        String reqUrl = "https://kauth.kakao.com/oauth/token";

	        try{
	            URL url = new URL(reqUrl);
	            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
	            
	            //필수 헤더 세팅
	            conn.setRequestMethod("POST");
	            conn.setRequestProperty("Content-type", "application/x-www-form-urlencoded;charset=utf-8");
	            conn.setDoOutput(true); //OutputStream으로 POST 데이터를 넘겨주겠다는 옵션.
	            
	            BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));
	            StringBuilder sb = new StringBuilder();
	            
	            //필수 쿼리 파라미터 세팅
	            sb.append("grant_type=authorization_code");
	            sb.append("&client_id=").append("c52e3719bd1faa0fc5a344a16e296f16");
	            sb.append("&redirect_uri=").append("http://eden0316.iptime.org/blb/loginKakao.me");
	            sb.append("&code=").append(code);

	            bw.write(sb.toString());
	            bw.flush();

	            int responseCode = conn.getResponseCode();

	            BufferedReader br;
	            if (responseCode >= 200 && responseCode < 300) {
	                br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
	            } else {
	                br = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
	            }

	            String line = "";
	            StringBuilder responseSb = new StringBuilder();
	            while((line = br.readLine()) != null){
	                responseSb.append(line);
	            }
	            String result = responseSb.toString();

	            JsonParser parser = new JsonParser();
	            JsonElement element = parser.parse(result);
	            accessToken = element.getAsJsonObject().get("access_token").getAsString();
	            refreshToken = element.getAsJsonObject().get("refresh_token").getAsString();

	            br.close();
	            bw.close();
	        }catch (Exception e){
	            e.printStackTrace();
	        }
	        return accessToken;
	    }
	   
	    public HashMap<String, Object> getUserInfo(String accessToken) {
	        HashMap<String, Object> userInfo = new HashMap<>();
	        String reqUrl = "https://kapi.kakao.com/v2/user/me";
	        try{
	            URL url = new URL(reqUrl);
	            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
	            conn.setRequestMethod("POST");
	            conn.setRequestProperty("Authorization", "Bearer " + accessToken);
	            conn.setRequestProperty("Content-type", "application/x-www-form-urlencoded;charset=utf-8");

	            int responseCode = conn.getResponseCode();

	            BufferedReader br;
	            if (responseCode >= 200 && responseCode <= 300) {
	                br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
	            } else {
	                br = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
	            }

	            String line = "";
	            StringBuilder responseSb = new StringBuilder();
	            while((line = br.readLine()) != null){
	                responseSb.append(line);
	            }
	            String result = responseSb.toString();

	            //System.out.println("API Response: " + result);
	            
	            JsonParser parser = new JsonParser();
	            JsonElement element = parser.parse(result);
	            
	            if (element.getAsJsonObject().has("id")) {
	                String snsId = element.getAsJsonObject().get("id").getAsString();
	                userInfo.put("id", snsId);
	            }
	            
	            JsonObject kakaoAccount = element.getAsJsonObject().getAsJsonObject("kakao_account");

	            if (kakaoAccount != null) {
	            	
	                if (kakaoAccount.has("email")) {
	                    String email = kakaoAccount.getAsJsonObject().get("email").getAsString();
	                    userInfo.put("email", email);
	                }

	                if (kakaoAccount.has("name")) {
	                    String name = kakaoAccount.getAsJsonObject().get("name").getAsString();
	                    userInfo.put("name", name);
	                }
	                if (kakaoAccount.has("phone_number")) {
	                    String phoneNumber = kakaoAccount.getAsJsonObject().get("phone_number").getAsString();
	                    userInfo.put("phoneNumber", phoneNumber);
	                }
	                if (kakaoAccount.has("birthyear")) {
	                    String birthyear = kakaoAccount.getAsJsonObject().get("birthyear").getAsString();
	                    userInfo.put("birthyear", birthyear);
	                }
	                if (kakaoAccount.has("birthday")) {
	                    String birthday = kakaoAccount.getAsJsonObject().get("birthday").getAsString();
	                    userInfo.put("birthday", birthday);
	                }
	            }


	            br.close();

	        }catch (Exception e){
	            e.printStackTrace();
	        }
	        return userInfo;
	    } 
	    
	    
	    
	    public void kakaoLogout(String accessToken) {
	        String reqUrl = "https://kapi.kakao.com/v1/user/logout";

	        try{
	            URL url = new URL(reqUrl);
	            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
	            conn.setRequestMethod("POST");
	            conn.setRequestProperty("Authorization", "Bearer " + accessToken);

	            int responseCode = conn.getResponseCode();
	            //System.out.println("responseCode:"+responseCode);
	            BufferedReader br;
	            if (responseCode >= 200 && responseCode <= 300) {
	                br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
	            } else {
	                br = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
	            }

	            String line = "";
	            StringBuilder responseSb = new StringBuilder();
	            while((line = br.readLine()) != null){
	                responseSb.append(line);
	            }
	            String result = responseSb.toString();
	           //System.out.println(result);

	        }catch (Exception e){
	            e.printStackTrace();
	        }
	    }
	    
	    public void kakaoUnlink(String accessToken) {
	        String reqUrl = "https://kapi.kakao.com/v1/user/unlink";

	        try {
	            URL url = new URL(reqUrl);
	            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
	            conn.setRequestMethod("POST");
	            conn.setRequestProperty("Authorization", "Bearer " + accessToken);

	            int responseCode = conn.getResponseCode();
	            //System.out.println("Response Code: " + responseCode);

	            BufferedReader br;
	            if (responseCode >= 200 && responseCode <= 300) {
	                br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
	            } else {
	                br = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
	            }

	            String line = "";
	            StringBuilder responseSb = new StringBuilder();
	            while ((line = br.readLine()) != null) {
	                responseSb.append(line);
	            }
	            br.close();

	            String result = responseSb.toString();
	            //System.out.println("탈퇴 결과: " + result);

	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	    } 
	    
}