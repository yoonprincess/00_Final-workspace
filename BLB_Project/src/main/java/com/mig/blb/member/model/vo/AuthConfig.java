package com.mig.blb.member.model.vo;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;
import org.springframework.web.client.RestTemplate;

import com.mig.blb.member.model.service.KakaoApi;

@Configuration
@PropertySource("classpath:application.properties")
public class AuthConfig {

	@Bean
    public KakaoApi kakaoApi() {
        return new KakaoApi();
    }
	
	@Bean
    public RestTemplate restTemplate() {
        return new RestTemplate();
    }
}
