package com.mig.blb.order.model.service;

import java.util.HashMap;
import java.util.Map;

import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

@Service
public class NicePayService {

    private static final String NICEPAY_API_URL = "https://api.nicepay.co.kr/v1/payments/request";
    private static final String CLIENT_ID = "TC0ONETIME";

    public Map<String, Object> preparePayment(String orderNo, int totalAmount) {
        RestTemplate restTemplate = new RestTemplate();
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);

        Map<String, Object> requestData = new HashMap<>();
        requestData.put("clientId", CLIENT_ID);
        requestData.put("method", "card");
        requestData.put("orderId", orderNo);
        requestData.put("amount", totalAmount);
        requestData.put("goodsName", "나이스페이 테스트 상품");
        requestData.put("returnUrl", "http://localhost:8080/payment/success");

        HttpEntity<Map<String, Object>> requestEntity = new HttpEntity<>(requestData, headers);

        ResponseEntity<Map> response = restTemplate.postForEntity(NICEPAY_API_URL, requestEntity, Map.class);
        if (response.getStatusCode() == HttpStatus.OK) {
            return response.getBody();
        } else {
            throw new RuntimeException("결제 준비 요청 실패");
        }
    }
}

