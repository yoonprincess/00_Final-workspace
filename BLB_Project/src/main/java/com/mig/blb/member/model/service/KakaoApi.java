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

	
		private static final String KAKAO_API_KEY  = "d58c294c5294590311266a239d715ed4";
		private static final String KAKAO_REDIRECT_URL = "http://localhost/blb/loginKakao.me"; 
		 
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
	            sb.append("&client_id=").append("d58c294c5294590311266a239d715ed4");
	            sb.append("&redirect_uri=").append("http://localhost/blb/loginKakao.me");
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
	    
	    /*
	    public OAuthToken getOAuthToken(String code) {
	        String reqUrl = "https://kauth.kakao.com/oauth/token";

	        RestTemplate rt = new RestTemplate();

	        HttpHeaders headers = new HttpHeaders();
	        headers.add("Content-type", "application/x-www-form-urlencoded;charset=utf-8");
	        
	        MultiValueMap<String, String> params = new LinkedMultiValueMap<>();
	        params.add("grant_type", "authorization_code");
	        params.add("client_id", "d58c294c5294590311266a239d715ed4");
	        params.add("redirect_uri","http://localhost:80/blb/loginKakao.me");
	        params.add("code", code);
	        
	        System.out.println(code);
	        System.out.println("Request URL: " + reqUrl);
	        System.out.println("Request Headers: " + headers);
	        System.out.println("Request Params: " + params);

	        HttpEntity<MultiValueMap<String, String>> kakaoTokenRequest = new HttpEntity<>(params, headers);
	        System.out.println(kakaoTokenRequest);
	        try {
		        // Http 요청 및 응답 받기
		        ResponseEntity<String> response = rt.exchange(reqUrl, HttpMethod.POST, kakaoTokenRequest, String.class);
	
		        // 응답 내용 출력
		        String responseBody = response.getBody();
		        System.out.println("Response Status: " + response.getStatusCode());
		        System.out.println("Response Body: " + responseBody);
	
		        // 응답을 OAuthToken 객체로 변환
		        Gson gson = new Gson();
		        OAuthToken oAuthToken = gson.fromJson(responseBody, OAuthToken.class);
		       
		        if (oAuthToken != null && oAuthToken.getAccessToken() != null) {
	                System.out.println("Access Token: " + oAuthToken.getAccessToken());
	            } else {
	                System.err.println("Failed to retrieve access token.");
	            }
		        
		        return oAuthToken;
	        } catch (HttpClientErrorException e) { 
	        	System.err.println("Error Response: " + e.getResponseBodyAsString());
	        	System.err.println("Status Code: " + e.getStatusCode());
	        	System.err.println("Error Message: " + e.getMessage());
	        	e.printStackTrace();
	        	throw e; // 예외 던지기 (원하는 대로 추가 처리 가능)
	        } catch (Exception e) {
            // 그 외의 예외 처리
            System.err.println("Unexpected error occurred.");
            e.printStackTrace();
            throw new RuntimeException("Failed to get OAuth token", e);
	        }
	    }
		*/
	    /*
	    public KakaoProfile getUserInfo(OAuthToken accessToken) {
	        String reqUrl = "https://kapi.kakao.com/v2/user/me";

	        RestTemplate rt = new RestTemplate();

	        //HttpHeader 오브젝트
	        HttpHeaders headers = new HttpHeaders();
	        headers.add("Authorization", "Bearer " + accessToken);
	        headers.add("Content-type", "application/x-www-form-urlencoded;charset=utf-8");

	        //http 헤더(headers)를 가진 엔티티
	        HttpEntity<MultiValueMap<String, String>> kakaoProfileRequest =
	                new HttpEntity<>(headers);

	        //reqUrl로 Http 요청 , POST 방식
	        ResponseEntity<String> response =
	                rt.exchange(reqUrl, HttpMethod.POST, kakaoProfileRequest, String.class);

	        KakaoProfile kakaoProfile = new KakaoProfile(response.getBody());

	        return kakaoProfile;
	    }    
	   */
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

	            System.out.println("API Response: " + result);
	            
	            JsonParser parser = new JsonParser();
	            JsonElement element = parser.parse(result);

	            JsonObject kakaoAccount = element.getAsJsonObject().getAsJsonObject("kakao_account");

	            if (kakaoAccount != null) {
	            	
	            	if (kakaoAccount.has("id")) {
	                    String snsId = kakaoAccount.getAsJsonObject().get("id").getAsString();
	                    userInfo.put("snsId", snsId);
	                }
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
	            System.out.println(responseCode);
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
	           System.out.println(result);

	        }catch (Exception e){
	            e.printStackTrace();
	        }
	    }
}