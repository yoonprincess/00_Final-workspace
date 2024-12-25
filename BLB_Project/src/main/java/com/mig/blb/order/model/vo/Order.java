package com.mig.blb.order.model.vo;

import java.sql.Date;
import java.util.ArrayList;

import com.mig.blb.product.model.vo.Product;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@Setter
@Getter
@ToString
public class Order {
//	
//	ORDER_NO	VARCHAR2(30 BYTE)
//	RCVR_NAME	VARCHAR2(20 BYTE)
//	RCVR_PHONE	CHAR(11 BYTE)
//	RCVR_ADDRESS	VARCHAR2(225 BYTE)
//	DLVR_REQ_MESSAGE	VARCHAR2(255 BYTE)
//	DLVR_STATUS	VARCHAR2(20 BYTE)
//	DLVR_FEE	NUMBER
//	DLVR_COMPANY	VARCHAR2(30 BYTE)
//	DISPATCH_DATE	DATE
//	COMPLETE_DATE	DATE
//	ORDER_TOTAL_AMT	NUMBER
//	PAYMENT_CODE	VARCHAR2(30 BYTE)
//	PAYMENT_METHOD	VARCHAR2(30 BYTE)
//	ORDER_DATE	DATE
//	REFUND_DATE	DATE
//	REFUND_REASON	VARCHAR2(225 BYTE)
//	MEMBER_ID	VARCHAR2(20 BYTE)

	private String orderNo;            // 주문 번호
    private String rcvrName;           // 수령인 이름
    private String rcvrPhone;          // 수령인 전화번호
    private String rcvrAddress;        // 수령인 주소
    private String dlvrReqMessage;     // 배송 요청 메시지
    private String dlvrStatus;         // 배송 상태
    private int dlvrFee;               // 배송비
    private String dlvrCompany;        // 배송 회사
    private Date dispatchDate;         // 배송 날짜
    private Date completeDate;         // 배송 완료 날짜
    private int orderTotalAmt;         // 주문 총 금액
    private String paymentCode;        // 결제 코드
    private String paymentMethod;      // 결제 방법
    private Date orderDate;            // 주문 날짜
    private Date refundDate;           // 환불 날짜
    private String refundReason;       // 환불 사유
    private String memberId;           // 회원 ID
    
    private String impUid;
    private String merchantUid;
    private int paidAmount;
    
    // 마이바티스에서 collection 연결용
    private ArrayList<ProductOrder> productOrder; 
    
}
