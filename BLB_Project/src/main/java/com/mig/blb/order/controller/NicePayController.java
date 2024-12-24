package com.mig.blb.order.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.mig.blb.order.model.service.NicePayService;
import com.mig.blb.order.model.service.OrderService;

@RestController
@RequestMapping("/payment")
public class NicePayController {
	
	@Autowired
	private OrderService orderService;

    @Autowired
    private NicePayService nicePayService;

    /**
     * 결제 준비 요청
     */
    @PostMapping("/prepare")
    public ResponseEntity<Map<String, Object>> preparePayment(@RequestBody Map<String, Object> paymentData) {
        try {
            String orderNo = (String) paymentData.get("orderNo");
            int totalAmount = (int) paymentData.get("totalAmount");

            Map<String, Object> response = nicePayService.preparePayment(orderNo, totalAmount);

            return ResponseEntity.ok(response);
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                                 .body(Map.of("message", "결제 준비 중 오류 발생"));
        }
    }

    
    @PostMapping("/success")
    public ResponseEntity<String> handlePaymentSuccess(@RequestBody Map<String, Object> paymentResult) {
        String paymentStatus = (String) paymentResult.get("status");

        if ("success".equalsIgnoreCase(paymentStatus)) {
            return ResponseEntity.ok("결제 성공!");
        } else {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("결제 실패!");
        }
    }
}
